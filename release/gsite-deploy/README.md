# 光何 gsite · Windows 一体化部署包

本目录是一个**自包含**的可运行环境：后端 jar、前端静态站、MySQL、Redis、JRE、nginx 全部内置，
目标服务器**不需要**预装 Java / MySQL / Redis / nginx，也**不需要**联网。

| 内置组件 | 版本 | 位置 |
| --- | --- | --- |
| Java 运行时 | Temurin (OpenJDK) 25.0.4.1+1（JDK 25 LTS；`jre\` 目录即完整 JDK 根目录，含 bin/java.exe） | `jre\` |
| 后端服务 | guanghe-server.jar（Spring Boot 3.5.14，system + infra 共 2 个模块） | `server\` |
| 前端静态站 | admin-vue3（`--mode deploy` 同源相对路径构建，构建于 2026-10-24 11:03） | `nginx\html\` |
| 数据库 | MySQL 8.0.21（社区版，已精简） | `mysql\` |
| 缓存 | Redis 3.0.504（Windows 版） | `redis\` |
| Web 服务器 | nginx 1.31.1 | `nginx\` |
| 初始数据 | `sql\gsite.sql`（59 张：系统/基础设施/演示，含 11 张 QRTZ_ 定时任务表）+ `sql\quartz.sql`（11 张 QRTZ_ 表，DROP+CREATE 幂等重放），实际共 59 张，utf8mb4 / utf8mb4_unicode_ci；`sql\gsite_modules.sql` 已是空占位（业务模块表已并入 `gsite.sql`） | `sql\` |

整机大小约 590 MB。

---

## 零、环境要求

- 64 位 Windows：Server 2012 R2 / 2016 / 2019 / 2022，或 Win10/11；自带 PowerShell 5.1 即可（脚本不依赖 PS7）。
- **内置 `jre\` 必须是 JDK 25 或更高**：后端 jar 由 JDK 25 编译（JDK 25 字节码），JDK 8 运行时连加载都做不到。
  `init.bat` 的体检阶段会读 `jre\bin\java.exe` 的主版本号，低于 25 直接报 `[FAIL]` 并停止，不会把一个注定起不来的包推上线。
  本包当前放的是**完整 Temurin 25 JDK**（`jre\` 即 JDK 根目录，291MB）；换成 Temurin 25 的 JRE 镜像同样可用。
- 内存建议 ≥ 4 GB（后端默认 `-Xmx2048m` + MySQL InnoDB 池 512 M + Redis）；磁盘预留 ≥ 10 GB（数据 + 日志）。
- MySQL 8 依赖 VC++ 2015-2022 运行库：本包**已把 `vcruntime140.dll` / `vcruntime140_1.dll` / `msvcp140.dll` 放进 `mysql\bin`**，
  一般无需另装；只有 Server 2012 R2 这种缺 UCRT 的老系统需要补装系统更新（KB2999226）或 VC++ 运行库。
- 不需要管理员权限即可完成 `init.bat` / `start-all.bat`；只有注册开机自启服务（`install-service.bat`）需要管理员。

## 一、放置位置

1. 把整个 `gsite-deploy` 目录拷到服务器，例如 `D:\gsite-deploy`。
2. **路径中不要有空格、中文、括号**（MySQL 注册服务、nginx、redis 对空格路径的处理容易出问题）。
3. 该目录需要写权限（数据库、日志、临时文件都写在包内）。

## 二、三步上线

### 1）改配置：`config.bat`

只有一个配置文件，改完就保存。默认值：

| 键 | 默认值 | 说明 |
| --- | --- | --- |
| `WEB_PORT` | `80` | **对外访问端口**（nginx），浏览器只用这个 |
| `BACKEND_PORT` | `2000` | 后端端口，只绑 `127.0.0.1`，外部访问不到 |
| `MYSQL_PORT` | `3306` | 只绑 `127.0.0.1` |
| `REDIS_PORT` | `6379` | 只绑 `127.0.0.1` |
| `MYSQL_ROOT_PASSWORD` | `Gsite2026@Root` | **上线前请改成自己的** |
| `MYSQL_APP_USER` / `MYSQL_APP_PASSWORD` | `gsite` / `Gsite2026@Data` | 后端连接用的库账号，**上线前请改** |
| `REDIS_PASSWORD` | 空 | 留空即不启用密码（只监听回环，安全） |
| `JAVA_XMS` / `JAVA_XMX` | `1024m` / `2048m` | 服务器内存充足可上调到 `2048m` / `4096m` |
| `SERVICE_PREFIX` | `GSite` | 注册为 Windows 服务/开机任务时的名字前缀 |

> 密码里不要使用 `& | < > ^ " % '` 这几个字符，批处理解析会出问题。
> 改了端口之类之后，直接 `restart-all.bat` 即可（配置会在每次启动时按 `config.bat` 重新生成）。
> **例外：`MYSQL_APP_PASSWORD` 不能在初始化之后改**，建号语句是 `CREATE USER IF NOT EXISTS`，
> 改了这里后端会连不上 MySQL；确实要改就手工 `ALTER USER 'gsite'@... IDENTIFIED BY ...`，
> 或者 `init.bat -force -yes` 整库重建（会清数据）。`MYSQL_ROOT_PASSWORD` 则每次 `init.bat` 都会重新下发。

### 2）初始化：`init.bat`（双击即可）

分三步：**体检 → 初始化 → 复核**。体检（`-Action preflight`）不改动任何东西，只把下面这些逐条列成
`[ OK ] / [WARN] / [FAIL]`：包内文件是否齐全、放置路径是否干净、磁盘剩余空间、`config.bat` 里的
端口是否合法且互不冲突、内置 mysqld / redis / java 能否在本机跑起来、四个端口有没有被**包外**程序占用。
出现 `[FAIL]` 就当场退出，绝不会往下动。

体检通过后做四件事：生成配置 → 初始化 `mysql\data` → 建库建账号 → 依次导入 `sql\gsite.sql`、
`sql\quartz.sql`、`sql\gsite_modules.sql`（共 452 张表，每份日志落在 `logs\import-*.log`）。
耗时约 1 分钟；数据库已有内容时自动跳过导入，**不会覆盖数据**，所以这个脚本可以随时重跑。

| 命令 | 作用 |
| --- | --- |
| `init.bat` | 体检 + 初始化（只补缺失的部分） |
| `init.bat -start` | 同上，完成后顺手把整套服务拉起来，并打印访问地址 |
| `init.bat -force -yes` | **清空**数据目录与 `gsite` 库，按 `sql\` 下三个脚本重建 |

> 只写 `-force` 不会执行，必须再加 `-yes`，防止手滑清库。

### 3）启动：`start-all.bat`

（第 2 步用了 `init.bat -start` 的话，这一步可以跳过。）

依次拉起 MySQL → Redis → 后端 → nginx，并等待端口就绪，最后打印一张状态表：

```
COMPONENT  SERVICE/TASK   PID     PORT    STATE
mysql      -              1234    3306    LISTENING
...
  admin UI   http://127.0.0.1/
```

四行都是 `LISTENING` 即成功，浏览器访问：

```
http://服务器IP/            ← 就是 WEB_PORT，为 80 时可省略端口
```

初始账号沿用种子数据里的开发账号：全新安装后实测 `admin` / `admin` 可登录（租户默认 `1`）。
**上线前请立刻在「个人中心 → 修改密码」里换掉**，其他内置账号同理，本包不会重置也不会弱化任何口令。

## 三、日常运维

| 双击脚本 | 等价命令 | 作用 |
| --- | --- | --- |
| `init.bat` | `bin\gsite.ps1 -Action preflight` + `-Action init` | 首次上线：体检 + 初始化数据库（可重复运行） |
| — | `-Action preflight` | 只做体检，不改动任何东西，适合交接前让对方先跑一遍 |
| `start-all.bat` | `bin\gsite.ps1 -Action start` | 全部启动并等待就绪 |
| `stop-all.bat` | `-Action stop` | 全部停止（先停 nginx/后端，再停 Redis/MySQL） |
| `restart-all.bat` | `-Action restart` | 全部重启 |
| `status.bat` | `-Action status` | 表格显示四个组件的 PID / 端口 / 状态 |
| — | `-Action health` | 只做端口存活检查，退出码非 0 表示有组件掉线 |
| — | `-Action start -Component backend` | 只操作单个组件（`mysql|redis|backend|nginx|app|all`） |

所有操作都通过 `run\*.pid` 认自己的进程，**不会误杀服务器上其它同名进程**。

### 版本更新怎么做

| 更新内容 | 操作 |
| --- | --- |
| 只换后端 jar | `stop-all.bat` → 覆盖 `server\guanghe-server.jar` → `start-all.bat`（jar 被进程占用，必须先停才能覆盖） |
| 只换后端 jar，不想停数据库 | `bin\gsite.ps1 -Action restart -Component backend`（只重启后端，MySQL / Redis / nginx 不动） |
| 只换前端静态站 | **不需要停服务**：把新构建的 dist 内容覆盖进 `nginx\html\` 即可，用户刷新就是新版本 |
| 改 `config.bat`（端口 / 内存 / profile） | `restart-all.bat`（每次启动都会按 `config.bat` 重新渲染配置） |
| 本次版本带数据库结构变更 | 覆盖程序文件后，手工执行升级 SQL（`init.bat` 只在库为空时导入 seed，**不做增量升级**） |
| 换一整张新版包 | **不要整目录删了重拷**（数据就在 `mysql\data\` 里）；只覆盖 `server\`、`nginx\html\`、`sql\`、`bin\`、`templates\` 等程序文件，或者按 §六 先备份再重建 |

> 更新前先跑一次 §六 的 `mysqldump`，并留一份旧 jar（改名保存即可）便于回滚；
> 更新完用 `status.bat` 看四行是否 `LISTENING`，再用浏览器硬刷新（Ctrl+F5）验证页面。
> 前端入口文件 `index.html` 已设为 `no-cache`（每次回源校验），`/assets/` 下的 hash 文件才是 30 天强缓存，
> 所以覆盖前端后不会出现“旧页面指向已删除的 js 导致白屏”的情况。

## 四、开机自启（可选，需要管理员）

1. 先跑完 `init.bat`（体检 + 初始化）；
2. 右键 **“以管理员身份运行”** `install-service.bat`：
   - `GSite-MySQL`：Windows 服务，自动启动；
   - `GSite-Redis`：Windows 服务（该 Redis 版本支持时），否则退化为开机计划任务；
   - `GSite-App`：开机计划任务（SYSTEM 账户），负责后端 + nginx。
3. 卸载：管理员运行 `uninstall-service.bat`（**不会删数据和日志**）。

注册完成后，`start-all.bat` / `stop-all.bat` 会自动改用 `net start/stop` 和计划任务，不需要重复配置。

## 五、日志与数据位置

| 内容 | 位置 |
| --- | --- |
| 后端业务日志 | `server\logs\guanghe-server.log`（按大小滚动，保留 30 份） |
| MySQL 运行日志 / 慢查询 | `mysql\logs\mysqld.err`、`mysql\logs\slow.log` |
| nginx 访问 / 错误日志 | `nginx\logs\access.log`、`nginx\logs\error.log` |
| 各组件启动输出 | `run\<组件>.out.log`、`run\<组件>.err.log` |
| setup 过程日志 | `logs\` |
| **数据库数据** | `mysql\data\`（唯一需要认真备份的东西） |
| Redis 持久化 | `redis\dump.rdb` |

## 六、备份与恢复

备份（在服务器命令行执行，停止与否都可以，冷备更稳）：

```
mysql\bin\mysqldump.exe --protocol=tcp -h 127.0.0.1 -P 3306 -u root -p ^
  --default-character-set=utf8mb4 --single-transaction --routines --triggers ^
  --databases gsite > gsite-backup.sql
```

恢复：`init.bat` 建好库账号后，用 `mysql -u root -p gsite < gsite-backup.sql` 导入即可。

整机迁移：停服 → 拷贝整个 `gsite-deploy` 目录到新机（路径同样不带空格）→ 新机管理员运行一次
`install-service.bat` → `start-all.bat`。**不需要**重新 `init`。

## 七、常见问题

- **提示 “port 3306 for mysql is taken by ...”**
  说明服务器上已经装着另一个 MySQL（`init.bat` 的体检阶段就会拦下来）。改 `config.bat` 里的 `MYSQL_PORT`
  （比如 `3307`）再跑一次 `init.bat`。本包在检测到端口属于“外人”时会直接退出，
  绝不会去改别人的 root 密码或关掉别人的库。
- **nginx 起不来 / 80 打不开**
  ①`80` 被 IIS、其它 web 或 Hyper-V 保留端口占用（实测会出现 `10013` 权限错误）→ 改 `WEB_PORT=8080`；
  ②改完记得在 **Windows 防火墙** 放行新端口：`netsh advfirewall firewall add rule name=GSite-In dir=in action=allow protocol=TCP localport=8080`。
- **中文乱码？**
  不会。`my.ini` 固定 `character-set-server=utf8mb4` + `collation-server=utf8mb4_unicode_ci`，
  建库语句和三个种子脚本的表也都是 `utf8mb4_unicode_ci`，导入时再带 `--default-character-set=utf8mb4`，
  库/表/连接三层一致。统一排序规则还有一个硬理由：混用 `general_ci` 与 `unicode_ci` 会让跨表
  `JOIN / UNION` 直接报 MySQL 1271。
- **登录后没有“定时任务”页面 / 任务不执行**
  页面是有的，`init.bat` 已经导入 `sql\quartz.sql`（11 张 `QRTZ_*` 表）。任务不跑是因为
  `server\config\application-deploy.yaml` 排除了 `QuartzAutoConfiguration` 且 `auto-startup: false`
  —— 这与开发环境的 `local` 配置完全一致，属于有意为之。要真正启用：删掉那行 exclude，
  并把 `spring.quartz.auto-startup` 改为 `true`、`job-store-type` 改为 `jdbc`，然后重启后端。
- **想直接看 Druid 监控 / Actuator**
  后端只监听 `127.0.0.1`，公网访问不到，这是有意的。Druid 控制台默认关闭，
  `actuator` 只放开 `health,info,metrics`。需要在其它机器上看，就在 `templates\nginx.conf.tpl` 里
  取消 `/admin/`、`/druid/` 两段注释，加上 IP 白名单后重新 `start-all.bat`。
- **上传文件**
  存储配置存在数据库里（后台「基础设施 → 文件管理 → 配置」），换服务器后请按实际磁盘路径重新设置一次。

## 八、安全清单（上线前逐条确认）

- [ ] `config.bat` 中两个 MySQL 密码已改成强口令，并重新运行 `init.bat`（注意 §二 中 `MYSQL_APP_PASSWORD` 的限制）；
- [ ] 系统内置账号（`admin` 等，初始口令 `admin`）已在后台逐个改密，至少改掉所有能登录的启用账号；
- [ ] 只把 `WEB_PORT` 对外，`2000 / 3306 / 6379` 保持只绑回环（默认即如此）；
- [ ] 防火墙入站规则只放行 `WEB_PORT`；
- [ ] `server\config\application-deploy.yaml` 中 `guanghe.security.mock-enable: false` 未被改回 `true`；
- [ ] 开放注册的后果清楚：注册**只建待审批账号**（状态=禁用，不下发 token），必须由管理员在
      「系统管理 → 用户管理」里启用才能登录；该接口强制滑块验证码（不受 `captcha.enable` 开关影响），
      并按来源 IP 限流 5 次 / 10 分钟。不想让人自助注册，就在 `templates\nginx.conf.tpl` 里
      把 `/admin-api/system/auth/register` 拒掉，或让前端不显示注册入口；
- [ ] 生产建议为 `WEB_PORT` 前置 HTTPS（自带证书时改 `templates\nginx.conf.tpl`）。

## 九、配置是怎么生成的

`config.bat`（唯一入口）→ `bin\gsite.ps1` 读取 → 渲染 `templates\*.tpl` 中的 `@KEY@` 占位符 →
生成 `mysql\my.ini`、`redis\redis.conf`、`nginx\conf\nginx.conf`、`server\config\application-deploy.yaml`。
每次 `start`/`launch` 都会重新渲染，所以改完 `config.bat` 直接重启即可生效；
**不要手工编辑这四个生成物**（会被覆盖），需要定制请改 `templates\` 里的模板。

## 十、从源码重建本包（开发者）

本机需有 JDK 25 + Maven + Node（pnpm），在仓库根目录执行：

```
rem 1) 后端 jar（guanghe-server 依赖哪些模块就打哪些，当前 pom 启用 5 个业务模块）
set JAVA_HOME=D:\devTools\jdk\jdk25.0.4
mvn -B -pl guanghe-server -am -Dmaven.test.skip=true package
rem   -> guanghe-server\target\guanghe-server.jar   拷到 server\

rem 2) 前端（guanghe-ui\guanghe-ui-admin-vue3，使用仓库里的 .env.deploy：VITE_BASE_URL 为空 = 同源相对路径）
cd guanghe-ui\guanghe-ui-admin-vue3
node --max_old_space_size=8192 .\node_modules\vite\bin\vite.js build --mode deploy
rem   -> dist-deploy\（由 .env.deploy 的 VITE_OUT_DIR 控制）  清空 nginx\html\ 后整体拷入

rem 3) 种子数据：sql\mysql\gsite.sql + quartz.sql + gsite_modules.sql  拷到 sql\
```

`sql\gsite_org_seed.sql` 是可选脚本（不参与首次初始化），用于把部门 / 岗位 / 角色 / 人员
重置为光何集团的演示数据；执行后所有演示账号的密码仍为 `admin`。

`sql\gsite_cleanup.sql` 也是可选脚本（不参与首次初始化），用于清理各菜单下的测试数据：
已裁剪模块（AI / IoT）的字典、测试短信/邮件/三方登录配置、示例文件存储器、日志与令牌等。

依赖应用（`jre\`、`mysql\`、`redis\`、`nginx\`）从本机 `D:\devTools` 下对应目录拷贝，
其中 `jre\` 取 JDK 25（Temurin 25.0.4.1）的运行时，**不要**再用 JDK 8 的 JRE，
其中 MySQL 只需 `bin\*.dll` + 8 个 exe、`lib\private`、`share`（不需要 `lib\mecab`），
并且**不要**把运维自己 nginx 目录里的证书、私钥、`.htpasswd` 带进包里。
