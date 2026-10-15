#!/bin/bash
# R3: 按 gsite 库的真实白名单过滤 7 份方言 SQL
# 白名单来源：当前库 system_menu（203 条活跃菜单）+ system_dict_type / system_dict_data 的字典类型集合
# 过滤规则：
#   - INSERT INTO system_menu 行：按 VALUES(NNN 的 ID 是否在菜单白名单
#   - INSERT INTO system_dict_type 行：按第 4 个引号段（type）是否在字典白名单
#   - INSERT INTO system_dict_data 行：按第 8 个引号段（dict_type）是否在字典白名单
#   兼容 '..' 与 N'..' 两种引号形式
set -u

MYSQL=/d/devTools/mysql/bin/mysql
export MYSQL_PWD=root
W=/tmp/r3wl
mkdir -p "$W"

# 1. 白名单：菜单 ID（全部未删菜单）
$MYSQL -h127.0.0.1 -uroot -Dgsite -N -B -e "SELECT id FROM system_menu WHERE deleted=0;" | tr -d '\r' > "$W/menu_ids.txt"
# 2. 白名单：字典 type 集合（类型表 + 数据表去重并集）
{ $MYSQL -h127.0.0.1 -uroot -Dgsite -N -B -e "SELECT type FROM system_dict_type WHERE deleted=0;" | tr -d '\r'
  $MYSQL -h127.0.0.1 -uroot -Dgsite -N -B -e "SELECT DISTINCT dict_type FROM system_dict_data WHERE deleted=0;" | tr -d '\r'
} | grep -v '^$' | sort -u > "$W/dict_types.txt"

echo "菜单白名单: $(wc -l < "$W/menu_ids.txt") 个 ID"
echo "字典类型白名单: $(wc -l < "$W/dict_types.txt") 个"
head -3 "$W/menu_ids.txt"; echo "..."; head -5 "$W/dict_types.txt"

# 安全校验：白名单必须非空
[ -s "$W/menu_ids.txt" ] || { echo "FATAL: 菜单白名单为空，中止"; exit 1; }
[ -s "$W/dict_types.txt" ] || { echo "FATAL: 字典白名单为空，中止"; exit 1; }

# 3. 生成白名单串（用 '\t' 分隔的成员集合，awk 判断 in 数组）
FILES="sql/dm/gsite-dm8.sql sql/highgo/gsite.sql sql/kingbase/gsite.sql sql/opengauss/gsite.sql sql/oracle/gsite.sql sql/postgresql/gsite.sql sql/sqlserver/gsite.sql"
for f in $FILES; do
  [ -f "$f" ] || { echo "SKIP(不存在): $f"; continue; }
  IDS_STR=$(tr '\n' ' ' < "$W/menu_ids.txt")
  TYPES_STR=$(tr '\n' ' ' < "$W/dict_types.txt")
  gawk -v MK="$IDS_STR" -v TK="$TYPES_STR" '
    BEGIN { n=split(MK,a," "); for(i=1;i<=n;i++) if(a[i]!="") menu[a[i]]=1
            n=split(TK,b," "); for(i=1;i<=n;i++) if(b[i]!="") dict[b[i]]=1 }
    /^INSERT INTO system_menu/ {
      if (match($0, /VALUES \(([0-9]+)/, m)) { if (m[1] in menu) print; else del++ } else print
      next
    }
    /^INSERT INTO system_dict_type/ {
      nq = split($0, q, /'"'"'/); t = q[4]; sub(/^N/, "", t)
      if (t in dict) print; else del++
      next
    }
    /^INSERT INTO system_dict_data/ {
      nq = split($0, q, /'"'"'/); t = q[8]; sub(/^N/, "", t)
      if (t in dict) print; else del++
      next
    }
    { print }
    END { printf("deleted=%d\n", del+0) }
  ' "$f" > "$f.tmp"
  # 移动前校验：tmp 不能为空
  if [ -s "$f.tmp" ]; then mv "$f.tmp" "$f"; else echo "SKIP(结果为空,保留原文件): $f"; rm -f "$f.tmp"; continue; fi
  echo "done: $f"
done
