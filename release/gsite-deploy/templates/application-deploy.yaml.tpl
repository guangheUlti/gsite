# ===========================================================================
# Spring Boot configuration of the GSite deploy package (profile: deploy)
# generated from templates\application-deploy.yaml.tpl by gsite.ps1
# edit config.bat and re-run init.bat instead of changing this file.
# Loaded from backend\config\, which wins over the copy inside the jar.
# ===========================================================================

server:
  port: @BACKEND_PORT@
  # the front-end is served by nginx on the same host, which proxies /admin-api
  # to this loopback address; nothing is exposed to the network directly
  address: 127.0.0.1

--- #################### datasource / redis ####################

spring:
  autoconfigure:
    exclude:
      # use dynamic-datasource-spring-boot-starter instead of the Druid starter
      - com.alibaba.druid.spring.boot.autoconfigure.DruidDataSourceAutoConfigure
      # the seed schema has no QRTZ_* tables, so the scheduler stays disabled
      # (identical to the development environment). To enable the job module:
      # import the Quartz tables into @MYSQL_DB@ and drop the next line.
      - org.springframework.boot.autoconfigure.quartz.QuartzAutoConfiguration
      - org.springframework.ai.vectorstore.qdrant.autoconfigure.QdrantVectorStoreAutoConfiguration
      - org.springframework.ai.vectorstore.milvus.autoconfigure.MilvusVectorStoreAutoConfiguration
  datasource:
    druid:
      web-stat-filter:
        enabled: true
      stat-view-servlet:
        enabled: false # set to true plus a login user below when you really need the console
        allow: 127.0.0.1
        url-pattern: /druid/*
        login-username:
        login-password:
      filter:
        stat:
          enabled: true
          log-slow-sql: true
          slow-sql-millis: 500
          merge-sql: true
        wall:
          config:
            multi-statement-allow: true
    dynamic:
      druid:
        initial-size: 5
        min-idle: 5
        max-active: 50
        max-wait: 60000
        time-between-eviction-runs-millis: 60000
        min-evictable-idle-time-millis: 600000
        max-evictable-idle-time-millis: 1800000
        validation-query: SELECT 1 FROM DUAL
        test-while-idle: true
        test-on-borrow: false
        test-on-return: false
        pool-prepared-statements: true
        max-pool-prepared-statement-per-connection-size: 20
      primary: master
      datasource:
        master:
          url: jdbc:mysql://127.0.0.1:@MYSQL_PORT@/@MYSQL_DB@?useSSL=false&serverTimezone=Asia/Shanghai&allowPublicKeyRetrieval=true&nullCatalogMeansCurrent=true&rewriteBatchedStatements=true
          username: @MYSQL_APP_USER@
          password: "@MYSQL_APP_PASSWORD@"
        slave:
          lazy: true
          url: jdbc:mysql://127.0.0.1:@MYSQL_PORT@/@MYSQL_DB@?useSSL=false&serverTimezone=Asia/Shanghai&allowPublicKeyRetrieval=true&rewriteBatchedStatements=true&nullCatalogMeansCurrent=true
          username: @MYSQL_APP_USER@
          password: "@MYSQL_APP_PASSWORD@"

  redis:
    host: 127.0.0.1
    port: @REDIS_PORT@
    database: 0
    @REDIS_PASSWORD_LINE@

--- #################### job / mq (kept for the autoconfiguration, no external broker) ####################

spring:
  quartz:
    auto-startup: false
    scheduler-name: schedulerName
    job-store-type: memory
    wait-for-jobs-to-complete-on-shutdown: true
    properties:
      org:
        quartz:
          scheduler:
            instanceName: schedulerName
            instanceId: AUTO
          threadPool:
            threadCount: 10
            threadPriority: 5
            class: org.quartz.simpl.SimpleThreadPool
    jdbc:
      initialize-schema: NEVER

--- #################### mq ####################

rocketmq:
  name-server: 127.0.0.1:9876

spring:
  rabbitmq:
    host: 127.0.0.1
    port: 5672
    username: guest
    password: guest
  kafka:
    bootstrap-servers: 127.0.0.1:9092

--- #################### protection ####################

lock4j:
  acquire-timeout: 3000
  expire: 30000

--- #################### monitoring ####################

management:
  endpoints:
    web:
      base-path: /actuator
      exposure:
        include: health,info,metrics # do not expose env/heapdump on a server
  endpoint:
    health:
      show-details: never

spring:
  boot:
    admin:
      client:
        url: http://127.0.0.1:@BACKEND_PORT@/${spring.boot.admin.context-path}
        instance:
          service-host-type: IP
        username: admin
        password: admin
      context-path: /admin
      frame-ancestors: "'self' localhost 127.0.0.1"

# log file: backend\logs\gsite-server.log (rolling daily + 10MB, kept 30 days)
logging:
  file:
    name: ./logs/${spring.application.name}.log
  level:
    root: info
    guanghe.gsite.module.system: info
    guanghe.gsite.module.infra: info
    # keep the SQL logging off in production, it is very chatty
    guanghe.gsite.module.infra.dal.mysql.logger.ApiErrorLogMapper: info
    guanghe.gsite.module.infra.dal.mysql.job.JobLogMapper: info
    guanghe.gsite.module.infra.dal.mysql.file.FileConfigMapper: info

debug: false

--- #################### weixin / social login (demo credentials, keep as is) ####################

wx:
  mp:
    app-id: wxf56b1542b9e85f8a
    secret: 496379dcef1ba869e9234de8d598cfd3
    config-storage:
      type: RedisTemplate
      key-prefix: wx
      http-client-type: HttpComponents
  miniapp:
    appid: wxc4598c446f8a9cb3
    secret: 4a1a04e07f6a4a0751b39c3064a92c8b
    config-storage:
      type: RedisTemplate
      key-prefix: wa
      http-client-type: HttpComponents

--- #################### application specific ####################

guanghe:
  # must stay in sync with VITE_APP_CAPTCHA_ENABLE of the packed front-end (false)
  captcha:
    enable: false
  security:
    mock-enable: false # never enable in production: a mock token bypasses the login
  access-log:
    enable: true
  demo: false
  wxa-code:
    env-version: release
  wxa-subscribe-message:
    miniprogram-state: formal
  tencent-lbs-key: TVDBZ-TDILD-4ON4B-PFDZA-RNLKH-VVF6E
  system-update:
    backend-jar-path: ../backend/guanghe-server.jar
    frontend-dir: ../nginx/html
    backup-dir: ../backend/backup
    max-upload-size-mb: 500
    java-command: ../jre/bin/java.exe
    jvm-args: "-Xms@JAVA_XMS@ -Xmx@JAVA_XMX@ -Dfile.encoding=UTF-8 -Duser.timezone=Asia/Shanghai -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=./logs"
    spring-args: "--spring.profiles.active=@SPRING_PROFILE@ --server.port=@BACKEND_PORT@ --spring.config.additional-location=file:./config/"

justauth:
  enabled: true
  type:
    DINGTALK:
      client-id: dingvrnreaje3yqvzhxg
      client-secret: i8E6iZyDvZj51JIb0tYsYfVQYOks9Cq1lgryEjFRqC79P3iJcrxEwT6Qk2QvLrLI
      ignore-check-redirect-uri: true
    WECHAT_ENTERPRISE:
      client-id: wwd411c69a39ad2e54
      client-secret: 1wTb7hYxnpT2TUbIeHGXGo7T0odav1ic10mLdyyATOw
      agent-id: 1000004
      ignore-check-redirect-uri: true
    WECHAT_MINI_PROGRAM:
      client-id: ${wx.miniapp.appid}
      client-secret: ${wx.miniapp.secret}
      ignore-check-redirect-uri: true
      ignore-check-state: true
    WECHAT_MP:
      client-id: ${wx.mp.app-id}
      client-secret: ${wx.mp.secret}
      ignore-check-redirect-uri: true
    ALIPAY:
      client-id: xx
      client-secret: xx
      alipay-public-key: xx
      ignore-check-redirect-uri: true
      ignore-check-state: true
  cache:
    type: REDIS
    prefix: 'social_auth_state:'
    timeout: 24h
