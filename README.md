# gsite

光何快速开发平台（gsite）——基于 Spring Boot 多模块架构的后台管理系统脚手架，提供管理后台与用户 App 的全部后端能力：权限、租户、字典、文件、任务、代码生成、操作日志、消息、工作流等。

* 仓库地址：<https://github.com/guangheUlti/gsite>
* 联系邮箱：18903378092@163.com
* 详细启动说明（可打印版）：`doc/gsite-startup.pdf`
* 历史功能清单：`doc/README-original.md`

## 技术栈

| 分类 | 选型 |
|---|---|
| 语言 / 运行时 | Java 8（`java.version=1.8`，另有 JDK17/21 分支能力） |
| 框架 | Spring Boot 2.7.18、Spring Security、Spring MVC |
| 持久层 | MySQL + MyBatis-Plus + Druid，支持主从与多数据源 |
| 缓存 / 消息 | Redis + Redisson；消息可选 Event / Redis / RabbitMQ / Kafka / RocketMQ |
| 权限 | Token + 多租户（SaaS）+ 按钮级权限 + 数据权限 |
| 其他 | Flowable 工作流、Swagger/Knife4j 接口文档、Quartz 定时任务、EasyExcel |
| 兼容数据库 | MySQL、Oracle、PostgreSQL、SQL Server、MariaDB、达梦 DM、KingBase、OpenGauss、HighGo、DB2 |

## 目录结构

```
gsite/
├── guanghe-dependencies/          Maven 依赖版本统一管理（BOM）
├── guanghe-framework/             15 个 Spring Boot Starter（web/security/mybatis/redis/mq/
│                                  job/excel/monitor/protection/tenant/ip/data-permission/
│                                  websocket/common/test）
├── guanghe-server/                启动入口，产出可执行 jar
├── guanghe-module-system/         系统功能：用户、部门、角色、菜单、租户、字典、短信、邮件、OAuth2
├── guanghe-module-infra/          基础设施：代码生成、文件、定时任务、数据源、API 日志、监控
├── guanghe-module-{member,bpm,pay,mall,crm,erp,wms,mes,hrm,fms,im,ai,iot,mp,report}/
│                                  业务模块（默认注释未启用，按需开启）
├── guanghe-ui/guanghe-ui-admin-vue3/  前端接口定义片段（完整管理后台为独立仓库）
├── sql/<方言>/gsite*.sql          建库脚本（MySQL / Oracle / PG / 达梦 / 人大金仓 等）
├── script/                        docker、docker-compose、jenkins、idea 配置等
└── doc/                           启动说明（HTML + PDF）、历史功能清单
```

## 快速开始

依赖：JDK 8、Maven 3.x、MySQL 8、Redis。三步启动（完整命令与排错见 `doc/gsite-startup.pdf`）：

```bash
# ① MySQL（读取 D:\devTools\mysql\my.ini，或双击该目录 start.bat）
mysqld --console

# ② Redis
redis-server.exe redis.windows.conf

# ③ 后端（profile 默认 local，端口 48080，约 12 秒启动）
mvn -B -T1C clean install -DskipTests          # 首次或代码变更后
java -jar guanghe-server/target/guanghe-server.jar --spring.profiles.active=local
```

首次使用需建库导数据：

```bash
mysql -h 127.0.0.1 -uroot -proot -e "CREATE DATABASE IF NOT EXISTS gsite DEFAULT CHARACTER SET utf8mb4;"
mysql -h 127.0.0.1 -uroot -proot gsite < sql/mysql/gsite.sql
mysql -h 127.0.0.1 -uroot -proot gsite < sql/mysql/quartz.sql
```

## 访问地址

| 用途 | 地址 |
|---|---|
| 接口文档（Knife4j，主入口） | http://127.0.0.1:48080/doc.html |
| OpenAPI JSON | http://127.0.0.1:48080/v3/api-docs |
| Druid 连接池监控 | http://127.0.0.1:48080/druid/index.html |
| 业务 API 前缀 | http://127.0.0.1:48080/admin-api/... |

管理后台界面由独立的前端仓库提供，本仓库只含后端服务与前端接口定义片段。

## 账号

| 账号 | 密码 | 说明 |
|---|---|---|
| admin | admin | 超级管理员，租户 `1`（租户名"光何"） |
| guanghe | guanghe | 演示账号（system_users id=100） |
| yuanma | yuanma | 演示账号 |
| test | test | 演示账号 |

调用接口需带请求头 `tenant-id: 1`；`local` 环境已关闭图形验证码，方便联调。

## 配置要点

* 自定义配置统一在 `guanghe.*` 前缀下（security、swagger、web、codegen、tenant、sms-code、pay、iot、ai 等），见 `guanghe-server/src/main/resources/application.yaml`。
* 分环境配置：`application-local.yaml`（本机开发）、`application-dev.yaml`。数据源、Redis 地址均在此处。
* 代码生成：`guanghe.codegen.base-package` 取自 `guanghe.info.base-package`（`guanghe.gsite`），生成的前后端代码、SQL、单测一键可得。
* 模块开关：根 `pom.xml` 的 `<modules>` 中按需取消注释，随后 `mvn clean install` 生效；数据库脚本已包含全部模块的表结构。

## 许可与说明

仓库暂未放置 LICENSE 文件，`doc/README-original.md` 为迁移前的功能清单存档（含历史模块说明）。需要补充开源协议或整理提交历史时，可另行处理。
