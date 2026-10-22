# 光何企业管理平台（gsite）

基于 Spring Boot 3.5 + Vue 3 + JDK 25 的企业级后台管理系统，内置 2 个模块，覆盖系统管理、基础设施等场景。

- 仓库地址：<https://github.com/guangheUlti/gsite>
- 联系邮箱：18903378092@163.com

## 技术栈

| 分类 | 选型 | 版本 |
|---|---|---|
| 语言 | Java | 25 |
| 后端框架 | Spring Boot | 3.5.14 |
| 安全 | Spring Security + Token | 6.5.10 |
| ORM | MyBatis-Plus | 3.5.16 |
| 连接池 | Druid + Dynamic Datasource | 1.2.28 / 4.5.0 |
| 缓存 | Redis + Redisson | 5.0+ / 4.6.1 |
| 接口文档 | Springdoc (Knife4j) | 2.8.13 / 4.5.0 |
| 前端 | Vue 3 + Element Plus + Vite | 3.5.34 / 2.13.7 / 8.1.4 |
| 构建 | Maven / pnpm | 3.x / ≥8.6 |
| 兼容数据库 | MySQL、Oracle、PostgreSQL、SQL Server、达梦、人大金仓、OpenGauss、HighGo、DB2 | |

## 架构概览

```
浏览器
  │  http://<host>:<WEB_PORT>
  ▼
nginx（静态资源 + /admin-api 反向代理）
  ├─ nginx/html/        前端打包产物（Vite 构建，同源请求）
  └─ 127.0.0.1:2000     Spring Boot 内嵌 Tomcat
          │
          ├─ guanghe-module-system   系统管理（用户/角色/菜单/部门/字典/日志…）
          ├─ guanghe-module-infra    基础设施（代码生成/文件/定时任务/API 日志…）
          ├─ guanghe-framework       15 个基础组件（web / security / mybatis / redis / 租户 …）
          ├─ MySQL 8   业务数据
          └─ Redis     会话、缓存、分布式锁
```

- 前端所有请求走相对路径 `/admin-api/`，由 nginx 转发到后端，因此部署到任意 IP / 域名都无需重新打包，也不存在跨域问题。
- 后端只监听回环地址，对外仅暴露 nginx 端口。

## 已启用模块

以下 2 个模块已在当前构建中启用并通过验证：

| 模块 | 说明 |
|---|---|
| **系统管理** | 用户、角色、菜单、部门、岗位、字典、短信、邮件、站内信、OAuth2、日志 |
| **基础设施** | 代码生成、文件存储、定时任务、API 日志、数据库文档、WebSocket、系统更新 |

### 未启用 / 已裁剪模块

| 模块 | 原因 |
|---|---|
| AI 大模型 | 已物理移除（源码删除，启用需 JDK 17+，可从上游找回） |
| IoT 物联网 | 已物理移除（源码删除，启用需 TDengine，可从上游找回） |
| CMS 内容管理 | 无后端/前端代码实现 |
| 支付系统 | 已按精简方案物理移除（含支付宝/微信对接、支付订单） |
| 商城系统 | 已按精简方案物理移除（商品 / 营销 / 交易 / 统计四个子模块） |
| ERP | 已按精简方案物理移除 |
| WMS | 已按精简方案物理移除 |
| BPM 工作流 | 已按精简方案物理移除 |
| CRM 客户管理 | 已按精简方案物理移除 |
| HRM 人力资源 | 已按精简方案物理移除 |
| MES 生产制造 | 已按精简方案物理移除 |
| FMS 财务管理 | 已按精简方案物理移除 |
| 公众号（MP） | 已按精简方案物理移除 |
| 会员中心 | 已按精简方案物理移除 |
| IM 即时通讯 | 已按精简方案物理移除 |
| 数据报表 | 已按精简方案物理移除（含 JimuReport 与 GoView） |

如需启用 AI / IoT 模块，请安装所需中间件后从上游先同步回模块源码。

## 目录结构

```
gsite/
├── guanghe-dependencies/              Maven BOM 依赖版本管理
├── guanghe-framework/                 15 个基础组件（web / security / mybatis / redis / 租户 …）
├── guanghe-server/                    启动入口（可执行 jar）
├── guanghe-module-system/             系统管理
├── guanghe-module-infra/              基础设施
├── guanghe-ui/guanghe-ui-admin-vue3/  前端管理后台（Vue 3 + Element Plus）
├── sql/<方言>/gsite*.sql              建库脚本（MySQL/Oracle/PG/达梦/金仓等）
│   └── mysql/  gsite.sql（核心表+初始数据）
│               quartz.sql（定时任务）  gsite_modules.sql（空占位：业务模块表已并入 gsite.sql）
├── script/                            开发与运维脚本（docker / jenkins / shell 等）
├── release/gsite-deploy/              Windows 一体化部署包（见下方说明）
├── docs/                              设计与迁移文档（JDK 25 升级、模块裁剪记录等）
└── .freebuff/                         本地开发/排查用的临时产物（已 git 忽略，不参与构建）
```

## 快速开始

### 开发环境

前置条件：**JDK 25**（必须，低于 25 无法编译）、Maven 3.x、MySQL 8、Redis 5.0+、Node ≥ 20.19 + pnpm ≥ 8.6

> **JDK 版本是硬约束**：本主干已升级到 Java 25 + Spring Boot 3.5（`javax.*` → `jakarta.*`），
> 用 JDK 8/11/17/21 执行 `mvn` 会直接构建失败。JDK 25 选 Temurin 25.0.4.1 LTS：
> `set JAVA_HOME=D:\devTools\jdk\jdk25.0.4`，并确认 `mvn -v` 的 `Java version` 为 25。
> 迁移细节见 [docs/JDK25升级方案.md](docs/JDK25升级方案.md)。

启动顺序固定为：**① MySQL → ② Redis → ③ 后端 → ④ 前端**。

```bash
# ① 首次建库（只需做一次，三个脚本都要导入）
mysql -h 127.0.0.1 -uroot -proot -e "CREATE DATABASE IF NOT EXISTS gsite DEFAULT CHARACTER SET utf8mb4;"
mysql -h 127.0.0.1 -uroot -proot --default-character-set=utf8mb4 gsite < sql/mysql/gsite.sql
mysql -h 127.0.0.1 -uroot -proot --default-character-set=utf8mb4 gsite < sql/mysql/quartz.sql
mysql -h 127.0.0.1 -uroot -proot --default-character-set=utf8mb4 gsite < sql/mysql/gsite_modules.sql
# 导入后共 59 张表（含 11 张 QRTZ_ 定时任务表；quartz.sql 是 DROP+CREATE 的幂等重放）

# ② 启动 MySQL（或双击 D:\devTools\mysql\start.bat）
cd /d D:\devTools\mysql && bin\mysqld.exe --console
# 验证：bin\mysqladmin.exe -h 127.0.0.1 -uroot -proot ping → mysqld is alive

# ③ 启动 Redis（或双击 D:\devTools\redis\start.bat）
cd /d D:\devTools\redis && redis-server.exe redis.conf
# 验证：redis-cli.exe ping → PONG

# ④ 构建（仅首次或代码变更后）
set JAVA_HOME=D:\devTools\jdk\jdk25.0.4
mvn -B -T1C clean install -DskipTests

# ⑤ 启动后端（端口 2000，约 30 秒）
java -jar guanghe-server/target/guanghe-server.jar --spring.profiles.active=local
# 看到 "Started GuangheServerApplication in XX seconds" 即成功

# ⑥ 启动前端（另开终端，端口 8000，请求直连后端 2000）
cd guanghe-ui/guanghe-ui-admin-vue3
pnpm install
pnpm dev
```

**停止服务：**
- 后端 / Redis：关闭终端窗口或 Ctrl+C；也可用 `stop.bat`
- MySQL 建议优雅关闭：`bin\mysqladmin.exe -h 127.0.0.1 -uroot -proot shutdown`

### 生产部署（Windows 一体化包）

`release/gsite-deploy/`（可打包为 `release/gsite-deploy.zip`）是自包含部署包，内置 JRE + MySQL + Redis + nginx，无需预装任何软件：

1. 解压到目标服务器（路径不含空格/中文）
2. 编辑 `config.bat` 修改端口和密码（默认：Web 80、后端 2000、MySQL 3306、Redis 6379）
3. 双击 `init.bat` 完成初始化
4. 双击 `start-all.bat` 启动全部服务，`stop-all.bat` 停止，`status.bat` 查看状态

> **内置 JRE 必须是 JDK 25**：后端 jar 由 JDK 25 编译，JDK 8 运行时无法启动。
> `init.bat` 的体检阶段会校验 `jre\bin\java.exe` 的主版本号，低于 25 直接报错并指出替换方式。
> 升级后的包请把 `jre\` 换成 Temurin 25 JRE，详见 [release/gsite-deploy/README.md](release/gsite-deploy/README.md)。

### 部署包前端重新构建

前端产物需使用仓库内的 `.env.deploy`（`VITE_BASE_URL` 为空 = 同源相对路径）：

```bash
cd guanghe-ui/guanghe-ui-admin-vue3
node --max_old_space_size=8192 ./node_modules/vite/bin/vite.js build --mode deploy
# 产物在 dist-deploy/，清空 release/gsite-deploy/nginx/html/ 后整体拷入
```

## 访问地址

| 用途 | 地址 |
|---|---|
| 管理后台 | http://127.0.0.1 （nginx 代理） |
| 前端开发服务器 | http://127.0.0.1:8000 （`pnpm dev`，仅开发时使用） |
| 接口文档（Knife4j） | http://127.0.0.1:2000/doc.html |
| OpenAPI JSON | http://127.0.0.1:2000/v3/api-docs |
| Druid 连接池监控 | http://127.0.0.1:2000/druid/index.html |
| API 前缀 | `/admin-api/` |

### 端口规划

| 项目 | 后端端口 | 前端端口 | 配置位置 |
|---|---|---|---|
| **gsite（本项目）** | 2000 | 8000（`VITE_PORT=8000`） | `guanghe-server/src/main/resources/application-*.yaml` 的 `server.port`、`guanghe-ui/guanghe-ui-admin-vue3/.env` 的 `VITE_PORT` |

> - 2000 是本项目后端 Spring Boot 内嵌 Tomcat 的监听端口。端口只由应用配置决定，并非 Java 程序固定占用。
> - 部署包里的端口由 `release/gsite-deploy/config.bat` 的 `BACKEND_PORT` / `WEB_PORT` 决定，启动时渲染进后端与 nginx 配置。
> - 同机原部署的 gfs 项目（fs-admin 后端 2000 / fs-ui 前端 8000）已停用，其端口由本项目沿用；同时启动两者会冲突。

## 默认账号

| 账号 | 密码 | 说明 |
|---|---|---|
| admin | admin | 超级管理员 |

> 首次部署后请及时修改默认密码。

## 配置说明

- 核心配置：`guanghe-server/src/main/resources/application.yaml`
- 本地开发：`application-local.yaml`
- 生产部署：由 `release/gsite-deploy/templates/` 模板在启动时自动生成
- 模块开关：从上游 guangheUlti/gsite 同步模块源码后，在根 `pom.xml` 和 `guanghe-server/pom.xml` 中登记即可启用

> **安全提醒**：`local` 环境开启了 Mock 模式（`guanghe.security.mock-enable: true`），Druid 监控台未设密码。本机开发无碍，**对外部署前必须关闭 Mock 并设置 Druid 账号密码**。
>
> **MySQL 字符集**：建议 `my.ini` 中使用 `character-set-server=utf8mb4` + `collation-server=utf8mb4_unicode_ci`，避免 emoji 等 4 字节字符存储失败。业务表需统一为 `utf8mb4_unicode_ci`：混用排序规则会让跨表 `JOIN` / `UNION` 报 `Illegal mix of collations`（历史待检清单即为一例）。
>
> **其他方言**：`gsite_modules.sql` 目前仅提供 MySQL 版。Oracle / PostgreSQL / 达梦 / 金仓 / OpenGauss / HighGo / SQL Server 下，业务模块表尚未转换，对应菜单会因缺表报错，需先按 `sql/<方言>/gsite.sql` 的语法转换后再使用。

## 许可

本项目基于 MIT License 开源。
