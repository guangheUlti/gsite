/*
 Guanghe Database Transfer Tool

 Source Server Type    : MySQL

 Target Server Type    : PostgreSQL

 Date: 2026-05-03 09:41:52
*/


-- ----------------------------
-- Table structure for dual
-- ----------------------------
DROP TABLE IF EXISTS dual;
CREATE TABLE dual
(
    id int2
);

COMMENT ON TABLE dual IS '数据库连接的表';

-- ----------------------------
-- Records of dual
-- ----------------------------
-- @formatter:off
INSERT INTO dual VALUES (1);
-- @formatter:on

-- ----------------------------
-- Table structure for infra_api_access_log
-- ----------------------------
DROP TABLE IF EXISTS infra_api_access_log;
CREATE TABLE infra_api_access_log (
    id int8 NOT NULL,
  trace_id varchar(64) NOT NULL DEFAULT '',
  user_id int8 NOT NULL DEFAULT 0,
  user_type int2 NOT NULL DEFAULT 0,
  application_name varchar(50) NOT NULL,
  request_method varchar(16) NOT NULL DEFAULT '',
  request_url varchar(255) NOT NULL DEFAULT '',
  request_params text NULL,
  response_body text NULL,
  user_ip varchar(50) NOT NULL,
  user_agent varchar(512) NOT NULL,
  operate_module varchar(50) NULL DEFAULT NULL,
  operate_name varchar(50) NULL DEFAULT NULL,
  operate_type int2 NULL DEFAULT 0,
  begin_time timestamp NOT NULL,
  end_time timestamp NOT NULL,
  duration int4 NOT NULL,
  result_code int4 NOT NULL DEFAULT 0,
  result_msg varchar(512) NULL DEFAULT '',
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0,
  tenant_id int8 NOT NULL DEFAULT 0
);

ALTER TABLE infra_api_access_log ADD CONSTRAINT pk_infra_api_access_log PRIMARY KEY (id);

CREATE INDEX idx_infra_api_access_log_01 ON infra_api_access_log (create_time);

COMMENT ON COLUMN infra_api_access_log.id IS '日志主键';
COMMENT ON COLUMN infra_api_access_log.trace_id IS '链路追踪编号';
COMMENT ON COLUMN infra_api_access_log.user_id IS '用户编号';
COMMENT ON COLUMN infra_api_access_log.user_type IS '用户类型';
COMMENT ON COLUMN infra_api_access_log.application_name IS '应用名';
COMMENT ON COLUMN infra_api_access_log.request_method IS '请求方法名';
COMMENT ON COLUMN infra_api_access_log.request_url IS '请求地址';
COMMENT ON COLUMN infra_api_access_log.request_params IS '请求参数';
COMMENT ON COLUMN infra_api_access_log.response_body IS '响应结果';
COMMENT ON COLUMN infra_api_access_log.user_ip IS '用户 IP';
COMMENT ON COLUMN infra_api_access_log.user_agent IS '浏览器 UA';
COMMENT ON COLUMN infra_api_access_log.operate_module IS '操作模块';
COMMENT ON COLUMN infra_api_access_log.operate_name IS '操作名';
COMMENT ON COLUMN infra_api_access_log.operate_type IS '操作分类';
COMMENT ON COLUMN infra_api_access_log.begin_time IS '开始请求时间';
COMMENT ON COLUMN infra_api_access_log.end_time IS '结束请求时间';
COMMENT ON COLUMN infra_api_access_log.duration IS '执行时长';
COMMENT ON COLUMN infra_api_access_log.result_code IS '结果码';
COMMENT ON COLUMN infra_api_access_log.result_msg IS '结果提示';
COMMENT ON COLUMN infra_api_access_log.creator IS '创建者';
COMMENT ON COLUMN infra_api_access_log.create_time IS '创建时间';
COMMENT ON COLUMN infra_api_access_log.updater IS '更新者';
COMMENT ON COLUMN infra_api_access_log.update_time IS '更新时间';
COMMENT ON COLUMN infra_api_access_log.deleted IS '是否删除';
COMMENT ON COLUMN infra_api_access_log.tenant_id IS '租户编号';
COMMENT ON TABLE infra_api_access_log IS 'API 访问日志表';

DROP SEQUENCE IF EXISTS infra_api_access_log_seq;
CREATE SEQUENCE infra_api_access_log_seq
    START 1;

-- ----------------------------
-- Table structure for infra_api_error_log
-- ----------------------------
DROP TABLE IF EXISTS infra_api_error_log;
CREATE TABLE infra_api_error_log (
    id int8 NOT NULL,
  trace_id varchar(64) NOT NULL,
  user_id int8 NOT NULL DEFAULT 0,
  user_type int2 NOT NULL DEFAULT 0,
  application_name varchar(50) NOT NULL,
  request_method varchar(16) NOT NULL,
  request_url varchar(255) NOT NULL,
  request_params varchar(8000) NOT NULL,
  user_ip varchar(50) NOT NULL,
  user_agent varchar(512) NOT NULL,
  exception_time timestamp NOT NULL,
  exception_name varchar(128) NOT NULL DEFAULT '',
  exception_message text NOT NULL,
  exception_root_cause_message text NOT NULL,
  exception_stack_trace text NOT NULL,
  exception_class_name varchar(512) NOT NULL,
  exception_file_name varchar(512) NOT NULL,
  exception_method_name varchar(512) NOT NULL,
  exception_line_number int4 NOT NULL,
  process_status int2 NOT NULL,
  process_time timestamp NULL DEFAULT NULL,
  process_user_id int4 NULL DEFAULT 0,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0,
  tenant_id int8 NOT NULL DEFAULT 0
);

ALTER TABLE infra_api_error_log ADD CONSTRAINT pk_infra_api_error_log PRIMARY KEY (id);

CREATE INDEX idx_infra_api_error_log_01 ON infra_api_error_log (create_time);

COMMENT ON COLUMN infra_api_error_log.id IS '编号';
COMMENT ON COLUMN infra_api_error_log.trace_id IS '链路追踪编号';
COMMENT ON COLUMN infra_api_error_log.user_id IS '用户编号';
COMMENT ON COLUMN infra_api_error_log.user_type IS '用户类型';
COMMENT ON COLUMN infra_api_error_log.application_name IS '应用名';
COMMENT ON COLUMN infra_api_error_log.request_method IS '请求方法名';
COMMENT ON COLUMN infra_api_error_log.request_url IS '请求地址';
COMMENT ON COLUMN infra_api_error_log.request_params IS '请求参数';
COMMENT ON COLUMN infra_api_error_log.user_ip IS '用户 IP';
COMMENT ON COLUMN infra_api_error_log.user_agent IS '浏览器 UA';
COMMENT ON COLUMN infra_api_error_log.exception_time IS '异常发生时间';
COMMENT ON COLUMN infra_api_error_log.exception_name IS '异常名';
COMMENT ON COLUMN infra_api_error_log.exception_message IS '异常导致的消息';
COMMENT ON COLUMN infra_api_error_log.exception_root_cause_message IS '异常导致的根消息';
COMMENT ON COLUMN infra_api_error_log.exception_stack_trace IS '异常的栈轨迹';
COMMENT ON COLUMN infra_api_error_log.exception_class_name IS '异常发生的类全名';
COMMENT ON COLUMN infra_api_error_log.exception_file_name IS '异常发生的类文件';
COMMENT ON COLUMN infra_api_error_log.exception_method_name IS '异常发生的方法名';
COMMENT ON COLUMN infra_api_error_log.exception_line_number IS '异常发生的方法所在行';
COMMENT ON COLUMN infra_api_error_log.process_status IS '处理状态';
COMMENT ON COLUMN infra_api_error_log.process_time IS '处理时间';
COMMENT ON COLUMN infra_api_error_log.process_user_id IS '处理用户编号';
COMMENT ON COLUMN infra_api_error_log.creator IS '创建者';
COMMENT ON COLUMN infra_api_error_log.create_time IS '创建时间';
COMMENT ON COLUMN infra_api_error_log.updater IS '更新者';
COMMENT ON COLUMN infra_api_error_log.update_time IS '更新时间';
COMMENT ON COLUMN infra_api_error_log.deleted IS '是否删除';
COMMENT ON COLUMN infra_api_error_log.tenant_id IS '租户编号';
COMMENT ON TABLE infra_api_error_log IS '系统异常日志';

DROP SEQUENCE IF EXISTS infra_api_error_log_seq;
CREATE SEQUENCE infra_api_error_log_seq
    START 1;

-- ----------------------------
-- Table structure for infra_codegen_column
-- ----------------------------
DROP TABLE IF EXISTS infra_codegen_column;
CREATE TABLE infra_codegen_column (
    id int8 NOT NULL,
  table_id int8 NOT NULL,
  column_name varchar(200) NOT NULL,
  data_type varchar(100) NOT NULL,
  column_comment varchar(500) NOT NULL,
  nullable bool NOT NULL,
  primary_key bool NOT NULL,
  ordinal_position int4 NOT NULL,
  java_type varchar(32) NOT NULL,
  java_field varchar(64) NOT NULL,
  dict_type varchar(200) NULL DEFAULT '',
  example varchar(64) NULL DEFAULT NULL,
  create_operation bool NOT NULL,
  update_operation bool NOT NULL,
  list_operation bool NOT NULL,
  list_operation_condition varchar(32) NOT NULL DEFAULT '=',
  list_operation_result bool NOT NULL,
  html_type varchar(32) NOT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0
);

ALTER TABLE infra_codegen_column ADD CONSTRAINT pk_infra_codegen_column PRIMARY KEY (id);

CREATE INDEX idx_infra_codegen_column_01 ON infra_codegen_column (table_id);

COMMENT ON COLUMN infra_codegen_column.id IS '编号';
COMMENT ON COLUMN infra_codegen_column.table_id IS '表编号';
COMMENT ON COLUMN infra_codegen_column.column_name IS '字段名';
COMMENT ON COLUMN infra_codegen_column.data_type IS '字段类型';
COMMENT ON COLUMN infra_codegen_column.column_comment IS '字段描述';
COMMENT ON COLUMN infra_codegen_column.nullable IS '是否允许为空';
COMMENT ON COLUMN infra_codegen_column.primary_key IS '是否主键';
COMMENT ON COLUMN infra_codegen_column.ordinal_position IS '排序';
COMMENT ON COLUMN infra_codegen_column.java_type IS 'Java 属性类型';
COMMENT ON COLUMN infra_codegen_column.java_field IS 'Java 属性名';
COMMENT ON COLUMN infra_codegen_column.dict_type IS '字典类型';
COMMENT ON COLUMN infra_codegen_column.example IS '数据示例';
COMMENT ON COLUMN infra_codegen_column.create_operation IS '是否为 Create 创建操作的字段';
COMMENT ON COLUMN infra_codegen_column.update_operation IS '是否为 Update 更新操作的字段';
COMMENT ON COLUMN infra_codegen_column.list_operation IS '是否为 List 查询操作的字段';
COMMENT ON COLUMN infra_codegen_column.list_operation_condition IS 'List 查询操作的条件类型';
COMMENT ON COLUMN infra_codegen_column.list_operation_result IS '是否为 List 查询操作的返回字段';
COMMENT ON COLUMN infra_codegen_column.html_type IS '显示类型';
COMMENT ON COLUMN infra_codegen_column.creator IS '创建者';
COMMENT ON COLUMN infra_codegen_column.create_time IS '创建时间';
COMMENT ON COLUMN infra_codegen_column.updater IS '更新者';
COMMENT ON COLUMN infra_codegen_column.update_time IS '更新时间';
COMMENT ON COLUMN infra_codegen_column.deleted IS '是否删除';
COMMENT ON TABLE infra_codegen_column IS '代码生成表字段定义';

DROP SEQUENCE IF EXISTS infra_codegen_column_seq;
CREATE SEQUENCE infra_codegen_column_seq
    START 1;

-- ----------------------------
-- Table structure for infra_codegen_table
-- ----------------------------
DROP TABLE IF EXISTS infra_codegen_table;
CREATE TABLE infra_codegen_table (
    id int8 NOT NULL,
  data_source_config_id int8 NOT NULL,
  scene int2 NOT NULL DEFAULT 1,
  table_name varchar(200) NOT NULL DEFAULT '',
  table_comment varchar(500) NOT NULL DEFAULT '',
  remark varchar(500) NULL DEFAULT NULL,
  module_name varchar(30) NOT NULL,
  business_name varchar(30) NOT NULL,
  class_name varchar(100) NOT NULL DEFAULT '',
  class_comment varchar(50) NOT NULL,
  author varchar(50) NOT NULL,
  template_type int2 NOT NULL DEFAULT 1,
  front_type int2 NOT NULL,
  parent_menu_id int8 NULL DEFAULT NULL,
  master_table_id int8 NULL DEFAULT NULL,
  sub_join_column_id int8 NULL DEFAULT NULL,
  sub_join_many bool NULL DEFAULT NULL,
  tree_parent_column_id int8 NULL DEFAULT NULL,
  tree_name_column_id int8 NULL DEFAULT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0
);

ALTER TABLE infra_codegen_table ADD CONSTRAINT pk_infra_codegen_table PRIMARY KEY (id);

COMMENT ON COLUMN infra_codegen_table.id IS '编号';
COMMENT ON COLUMN infra_codegen_table.data_source_config_id IS '数据源配置的编号';
COMMENT ON COLUMN infra_codegen_table.scene IS '生成场景';
COMMENT ON COLUMN infra_codegen_table.table_name IS '表名称';
COMMENT ON COLUMN infra_codegen_table.table_comment IS '表描述';
COMMENT ON COLUMN infra_codegen_table.remark IS '备注';
COMMENT ON COLUMN infra_codegen_table.module_name IS '模块名';
COMMENT ON COLUMN infra_codegen_table.business_name IS '业务名';
COMMENT ON COLUMN infra_codegen_table.class_name IS '类名称';
COMMENT ON COLUMN infra_codegen_table.class_comment IS '类描述';
COMMENT ON COLUMN infra_codegen_table.author IS '作者';
COMMENT ON COLUMN infra_codegen_table.template_type IS '模板类型';
COMMENT ON COLUMN infra_codegen_table.front_type IS '前端类型';
COMMENT ON COLUMN infra_codegen_table.parent_menu_id IS '父菜单编号';
COMMENT ON COLUMN infra_codegen_table.master_table_id IS '主表的编号';
COMMENT ON COLUMN infra_codegen_table.sub_join_column_id IS '子表关联主表的字段编号';
COMMENT ON COLUMN infra_codegen_table.sub_join_many IS '主表与子表是否一对多';
COMMENT ON COLUMN infra_codegen_table.tree_parent_column_id IS '树表的父字段编号';
COMMENT ON COLUMN infra_codegen_table.tree_name_column_id IS '树表的名字字段编号';
COMMENT ON COLUMN infra_codegen_table.creator IS '创建者';
COMMENT ON COLUMN infra_codegen_table.create_time IS '创建时间';
COMMENT ON COLUMN infra_codegen_table.updater IS '更新者';
COMMENT ON COLUMN infra_codegen_table.update_time IS '更新时间';
COMMENT ON COLUMN infra_codegen_table.deleted IS '是否删除';
COMMENT ON TABLE infra_codegen_table IS '代码生成表定义';

DROP SEQUENCE IF EXISTS infra_codegen_table_seq;
CREATE SEQUENCE infra_codegen_table_seq
    START 1;

-- ----------------------------
-- Table structure for infra_config
-- ----------------------------
DROP TABLE IF EXISTS infra_config;
CREATE TABLE infra_config (
    id int8 NOT NULL,
  category varchar(50) NOT NULL,
  type int2 NOT NULL,
  name varchar(100) NOT NULL DEFAULT '',
  config_key varchar(100) NOT NULL DEFAULT '',
  value varchar(500) NOT NULL DEFAULT '',
  visible bool NOT NULL,
  remark varchar(500) NULL DEFAULT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0
);

ALTER TABLE infra_config ADD CONSTRAINT pk_infra_config PRIMARY KEY (id);

CREATE INDEX idx_infra_config_01 ON infra_config (config_key);

COMMENT ON COLUMN infra_config.id IS '参数主键';
COMMENT ON COLUMN infra_config.category IS '参数分组';
COMMENT ON COLUMN infra_config.type IS '参数类型';
COMMENT ON COLUMN infra_config.name IS '参数名称';
COMMENT ON COLUMN infra_config.config_key IS '参数键名';
COMMENT ON COLUMN infra_config.value IS '参数键值';
COMMENT ON COLUMN infra_config.visible IS '是否可见';
COMMENT ON COLUMN infra_config.remark IS '备注';
COMMENT ON COLUMN infra_config.creator IS '创建者';
COMMENT ON COLUMN infra_config.create_time IS '创建时间';
COMMENT ON COLUMN infra_config.updater IS '更新者';
COMMENT ON COLUMN infra_config.update_time IS '更新时间';
COMMENT ON COLUMN infra_config.deleted IS '是否删除';
COMMENT ON TABLE infra_config IS '参数配置表';

-- ----------------------------
-- Records of infra_config
-- ----------------------------
-- @formatter:off
BEGIN;
INSERT INTO infra_config (id, category, type, name, config_key, value, visible, remark, creator, create_time, updater, update_time, deleted) VALUES (2, 'biz', 1, '用户管理-账号初始密码', 'system.user.init-password', '123456', '0', '初始化密码 123456', 'admin', '2021-01-05 17:03:48', '1', '2024-07-20 17:22:47', '0');
INSERT INTO infra_config (id, category, type, name, config_key, value, visible, remark, creator, create_time, updater, update_time, deleted) VALUES (7, 'url', 2, 'MySQL 监控的地址', 'url.druid', '', '1', '', '1', '2023-04-07 13:41:16', '1', '2023-04-07 14:33:38', '0');
INSERT INTO infra_config (id, category, type, name, config_key, value, visible, remark, creator, create_time, updater, update_time, deleted) VALUES (8, 'url', 2, 'SkyWalking 监控的地址', 'url.skywalking', '', '1', '', '1', '2023-04-07 13:41:16', '1', '2023-04-07 14:57:03', '0');
INSERT INTO infra_config (id, category, type, name, config_key, value, visible, remark, creator, create_time, updater, update_time, deleted) VALUES (9, 'url', 2, 'Spring Boot Admin 监控的地址', 'url.spring-boot-admin', '', '1', '', '1', '2023-04-07 13:41:16', '1', '2023-04-07 14:52:07', '0');
INSERT INTO infra_config (id, category, type, name, config_key, value, visible, remark, creator, create_time, updater, update_time, deleted) VALUES (10, 'url', 2, 'Swagger 接口文档的地址', 'url.swagger', '', '1', '', '1', '2023-04-07 13:41:16', '1', '2023-04-07 14:59:00', '0');
INSERT INTO infra_config (id, category, type, name, config_key, value, visible, remark, creator, create_time, updater, update_time, deleted) VALUES (12, 'test2', 2, 'test3', 'test4', 'test5', '1', 'test6', '1', '2023-12-03 09:55:16', '1', '2025-04-06 21:00:09', '0');
INSERT INTO infra_config (id, category, type, name, config_key, value, visible, remark, creator, create_time, updater, update_time, deleted) VALUES (13, '用户管理-账号初始密码', 2, '用户管理-注册开关', 'system.user.register-enabled', 'true', '0', '', '1', '2025-04-26 17:23:41', '1', '2025-04-26 17:23:41', '0');
COMMIT;
-- @formatter:on

DROP SEQUENCE IF EXISTS infra_config_seq;
CREATE SEQUENCE infra_config_seq
    START 14;

-- ----------------------------
-- Table structure for infra_data_source_config
-- ----------------------------
DROP TABLE IF EXISTS infra_data_source_config;
CREATE TABLE infra_data_source_config (
    id int8 NOT NULL,
  name varchar(100) NOT NULL DEFAULT '',
  url varchar(1024) NOT NULL,
  username varchar(255) NOT NULL,
  password varchar(255) NOT NULL DEFAULT '',
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0
);

ALTER TABLE infra_data_source_config ADD CONSTRAINT pk_infra_data_source_config PRIMARY KEY (id);

COMMENT ON COLUMN infra_data_source_config.id IS '主键编号';
COMMENT ON COLUMN infra_data_source_config.name IS '参数名称';
COMMENT ON COLUMN infra_data_source_config.url IS '数据源连接';
COMMENT ON COLUMN infra_data_source_config.username IS '用户名';
COMMENT ON COLUMN infra_data_source_config.password IS '密码';
COMMENT ON COLUMN infra_data_source_config.creator IS '创建者';
COMMENT ON COLUMN infra_data_source_config.create_time IS '创建时间';
COMMENT ON COLUMN infra_data_source_config.updater IS '更新者';
COMMENT ON COLUMN infra_data_source_config.update_time IS '更新时间';
COMMENT ON COLUMN infra_data_source_config.deleted IS '是否删除';
COMMENT ON TABLE infra_data_source_config IS '数据源配置表';

DROP SEQUENCE IF EXISTS infra_data_source_config_seq;
CREATE SEQUENCE infra_data_source_config_seq
    START 1;

-- ----------------------------
-- Table structure for infra_file
-- ----------------------------
DROP TABLE IF EXISTS infra_file;
CREATE TABLE infra_file (
    id int8 NOT NULL,
  config_id int8 NULL DEFAULT NULL,
  name varchar(256) NULL DEFAULT NULL,
  path varchar(512) NOT NULL,
  url varchar(1024) NOT NULL,
  type varchar(128) NULL DEFAULT NULL,
  size int4 NOT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0
);

ALTER TABLE infra_file ADD CONSTRAINT pk_infra_file PRIMARY KEY (id);

COMMENT ON COLUMN infra_file.id IS '文件编号';
COMMENT ON COLUMN infra_file.config_id IS '配置编号';
COMMENT ON COLUMN infra_file.name IS '文件名';
COMMENT ON COLUMN infra_file.path IS '文件路径';
COMMENT ON COLUMN infra_file.url IS '文件 URL';
COMMENT ON COLUMN infra_file.type IS '文件类型';
COMMENT ON COLUMN infra_file.size IS '文件大小';
COMMENT ON COLUMN infra_file.creator IS '创建者';
COMMENT ON COLUMN infra_file.create_time IS '创建时间';
COMMENT ON COLUMN infra_file.updater IS '更新者';
COMMENT ON COLUMN infra_file.update_time IS '更新时间';
COMMENT ON COLUMN infra_file.deleted IS '是否删除';
COMMENT ON TABLE infra_file IS '文件表';

DROP SEQUENCE IF EXISTS infra_file_seq;
CREATE SEQUENCE infra_file_seq
    START 1;

-- ----------------------------
-- Table structure for infra_file_config
-- ----------------------------
DROP TABLE IF EXISTS infra_file_config;
CREATE TABLE infra_file_config (
    id int8 NOT NULL,
  name varchar(63) NOT NULL,
  storage int2 NOT NULL,
  remark varchar(255) NULL DEFAULT NULL,
  master bool NOT NULL,
  config varchar(4096) NOT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0
);

ALTER TABLE infra_file_config ADD CONSTRAINT pk_infra_file_config PRIMARY KEY (id);

COMMENT ON COLUMN infra_file_config.id IS '编号';
COMMENT ON COLUMN infra_file_config.name IS '配置名';
COMMENT ON COLUMN infra_file_config.storage IS '存储器';
COMMENT ON COLUMN infra_file_config.remark IS '备注';
COMMENT ON COLUMN infra_file_config.master IS '是否为主配置';
COMMENT ON COLUMN infra_file_config.config IS '存储配置';
COMMENT ON COLUMN infra_file_config.creator IS '创建者';
COMMENT ON COLUMN infra_file_config.create_time IS '创建时间';
COMMENT ON COLUMN infra_file_config.updater IS '更新者';
COMMENT ON COLUMN infra_file_config.update_time IS '更新时间';
COMMENT ON COLUMN infra_file_config.deleted IS '是否删除';
COMMENT ON TABLE infra_file_config IS '文件配置表';

-- ----------------------------
-- Records of infra_file_config
-- ----------------------------
-- @formatter:off
BEGIN;
INSERT INTO infra_file_config (id, name, storage, remark, master, config, creator, create_time, updater, update_time, deleted) VALUES (4, '数据库（示例）', 1, '我是数据库', '0', '{"@class":"guanghe.gsite.module.infra.framework.file.core.client.db.DBFileClientConfig","domain":"http://127.0.0.1:2000"}', '1', '2022-03-15 23:56:24', '1', '2025-11-24 20:57:14', '0');
INSERT INTO infra_file_config (id, name, storage, remark, master, config, creator, create_time, updater, update_time, deleted) VALUES (22, '七牛存储器（示例）', 20, '请换成你自己的密钥！！！', '1', '{"@class":"guanghe.gsite.module.infra.framework.file.core.client.s3.S3FileClientConfig","endpoint":"s3.cn-south-1.qiniucs.com","domain":"http://127.0.0.1:9000/gsite","bucket":"gsite","accessKey":"请填写你的AccessKey","accessSecret":"请填写你的AccessSecret","enablePathStyleAccess":false,"enablePublicAccess":true}', '1', '2024-01-13 22:11:12', '1', '2025-11-24 20:57:14', '0');
INSERT INTO infra_file_config (id, name, storage, remark, master, config, creator, create_time, updater, update_time, deleted) VALUES (24, '腾讯云存储（示例）', 20, '请换成你的密钥！！！', '0', '{"@class":"guanghe.gsite.module.infra.framework.file.core.client.s3.S3FileClientConfig","endpoint":"https://cos.ap-shanghai.myqcloud.com","domain":"https://github.com/guangheUlti/gsite","bucket":"gsite-cos-demo","accessKey":"请填写你的AccessKey","accessSecret":"请填写你的AccessSecret","enablePathStyleAccess":false,"enablePublicAccess":true}', '1', '2024-11-09 16:03:22', '1', '2025-11-24 20:57:14', '0');
INSERT INTO infra_file_config (id, name, storage, remark, master, config, creator, create_time, updater, update_time, deleted) VALUES (25, '阿里云存储（示例）', 20, '', '0', '{"@class":"guanghe.gsite.module.infra.framework.file.core.client.s3.S3FileClientConfig","endpoint":"oss-cn-beijing.aliyuncs.com","domain":"https://github.com/guangheUlti/gsite","bucket":"gsite-oss-demo","accessKey":"请填写你的AccessKey","accessSecret":"请填写你的AccessSecret","enablePathStyleAccess":false,"enablePublicAccess":true}', '1', '2024-11-09 16:47:08', '1', '2025-11-24 20:57:14', '0');
INSERT INTO infra_file_config (id, name, storage, remark, master, config, creator, create_time, updater, update_time, deleted) VALUES (26, '火山云存储（示例）', 20, '', '0', '{"@class":"guanghe.gsite.module.infra.framework.file.core.client.s3.S3FileClientConfig","endpoint":"tos-s3-cn-beijing.volces.com","domain":null,"bucket":"guanghe","accessKey":"请填写你的AccessKey","accessSecret":"请填写你的AccessSecret","enablePathStyleAccess":false,"enablePublicAccess":true}', '1', '2024-11-09 16:56:42', '1', '2025-11-24 20:57:14', '0');
INSERT INTO infra_file_config (id, name, storage, remark, master, config, creator, create_time, updater, update_time, deleted) VALUES (27, '华为云存储（示例）', 20, '', '0', '{"@class":"guanghe.gsite.module.infra.framework.file.core.client.s3.S3FileClientConfig","endpoint":"obs.cn-east-3.myhuaweicloud.com","domain":"","bucket":"guanghe","accessKey":"请填写你的AccessKey","accessSecret":"请填写你的AccessSecret","enablePathStyleAccess":false,"enablePublicAccess":true}', '1', '2024-11-09 17:18:41', '1', '2025-11-24 20:57:14', '0');
INSERT INTO infra_file_config (id, name, storage, remark, master, config, creator, create_time, updater, update_time, deleted) VALUES (28, 'MinIO 存储（示例）', 20, '', '0', '{"@class":"guanghe.gsite.module.infra.framework.file.core.client.s3.S3FileClientConfig","endpoint":"http://127.0.0.1:9000","domain":"http://127.0.0.1:9000/gsite","bucket":"guanghe","accessKey":"请填写你的AccessKey","accessSecret":"请填写你的AccessSecret","enablePathStyleAccess":false,"enablePublicAccess":true}', '1', '2024-11-09 17:43:10', '1', '2025-11-24 20:57:14', '0');
INSERT INTO infra_file_config (id, name, storage, remark, master, config, creator, create_time, updater, update_time, deleted) VALUES (29, '本地存储（示例）', 10, 'mac/linux 使用 /，windows 使用 \', '0', '{"@class":"guanghe.gsite.module.infra.framework.file.core.client.local.LocalFileClientConfig","basePath":"/Users/guanghe/tmp/file","domain":"http://127.0.0.1:2000"}', '1', '2025-05-02 11:25:45', '1', '2025-11-24 20:57:14', '0');
INSERT INTO infra_file_config (id, name, storage, remark, master, config, creator, create_time, updater, update_time, deleted) VALUES (30, 'SFTP 存储（示例）', 12, '', '0', '{"@class":"guanghe.gsite.module.infra.framework.file.core.client.sftp.SftpFileClientConfig","basePath":"/upload","domain":"http://127.0.0.1:2000","host":"127.0.0.1","port":2222,"username":"foo","password":"pass"}', '1', '2025-05-02 16:34:10', '1', '2025-11-24 20:57:14', '0');
INSERT INTO infra_file_config (id, name, storage, remark, master, config, creator, create_time, updater, update_time, deleted) VALUES (34, '七牛云存储【私有】（示例）', 20, '请换成你自己的密钥！！！', '0', '{"@class":"guanghe.gsite.module.infra.framework.file.core.client.s3.S3FileClientConfig","endpoint":"s3.cn-south-1.qiniucs.com","domain":"http://127.0.0.1:9000","bucket":"gsite-private","accessKey":"请填写你的AccessKey","accessSecret":"请填写你的AccessSecret","enablePathStyleAccess":false,"enablePublicAccess":false}', '1', '2025-08-17 21:22:00', '1', '2025-11-24 20:57:14', '0');
INSERT INTO infra_file_config (id, name, storage, remark, master, config, creator, create_time, updater, update_time, deleted) VALUES (35, '1', 20, '1', '0', '{"@class":"guanghe.gsite.module.infra.framework.file.core.client.s3.S3FileClientConfig","endpoint":"http://www.baidu.com","domain":"http://www.xxx.com","bucket":"1","accessKey":"请填写你的AccessKey","accessSecret":"请填写你的AccessSecret","enablePathStyleAccess":false,"enablePublicAccess":false,"region":"1"}', '1', '2025-10-02 14:32:12', '1', '2025-11-29 15:59:39', '0');
COMMIT;
-- @formatter:on

DROP SEQUENCE IF EXISTS infra_file_config_seq;
CREATE SEQUENCE infra_file_config_seq
    START 36;

-- ----------------------------
-- Table structure for infra_file_content
-- ----------------------------
DROP TABLE IF EXISTS infra_file_content;
CREATE TABLE infra_file_content (
    id int8 NOT NULL,
  config_id int8 NOT NULL,
  path varchar(512) NOT NULL,
  content bytea NOT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0
);

ALTER TABLE infra_file_content ADD CONSTRAINT pk_infra_file_content PRIMARY KEY (id);

CREATE INDEX idx_infra_file_content_01 ON infra_file_content (config_id, path);

COMMENT ON COLUMN infra_file_content.id IS '编号';
COMMENT ON COLUMN infra_file_content.config_id IS '配置编号';
COMMENT ON COLUMN infra_file_content.path IS '文件路径';
COMMENT ON COLUMN infra_file_content.content IS '文件内容';
COMMENT ON COLUMN infra_file_content.creator IS '创建者';
COMMENT ON COLUMN infra_file_content.create_time IS '创建时间';
COMMENT ON COLUMN infra_file_content.updater IS '更新者';
COMMENT ON COLUMN infra_file_content.update_time IS '更新时间';
COMMENT ON COLUMN infra_file_content.deleted IS '是否删除';
COMMENT ON TABLE infra_file_content IS '文件表';

DROP SEQUENCE IF EXISTS infra_file_content_seq;
CREATE SEQUENCE infra_file_content_seq
    START 1;

-- ----------------------------
-- Table structure for infra_job
-- ----------------------------
DROP TABLE IF EXISTS infra_job;
CREATE TABLE infra_job (
    id int8 NOT NULL,
  name varchar(32) NOT NULL,
  status int2 NOT NULL,
  handler_name varchar(64) NOT NULL,
  handler_param varchar(255) NULL DEFAULT NULL,
  cron_expression varchar(32) NOT NULL,
  retry_count int4 NOT NULL DEFAULT 0,
  retry_interval int4 NOT NULL DEFAULT 0,
  monitor_timeout int4 NOT NULL DEFAULT 0,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0
);

ALTER TABLE infra_job ADD CONSTRAINT pk_infra_job PRIMARY KEY (id);

COMMENT ON COLUMN infra_job.id IS '任务编号';
COMMENT ON COLUMN infra_job.name IS '任务名称';
COMMENT ON COLUMN infra_job.status IS '任务状态';
COMMENT ON COLUMN infra_job.handler_name IS '处理器的名字';
COMMENT ON COLUMN infra_job.handler_param IS '处理器的参数';
COMMENT ON COLUMN infra_job.cron_expression IS 'CRON 表达式';
COMMENT ON COLUMN infra_job.retry_count IS '重试次数';
COMMENT ON COLUMN infra_job.retry_interval IS '重试间隔';
COMMENT ON COLUMN infra_job.monitor_timeout IS '监控超时时间';
COMMENT ON COLUMN infra_job.creator IS '创建者';
COMMENT ON COLUMN infra_job.create_time IS '创建时间';
COMMENT ON COLUMN infra_job.updater IS '更新者';
COMMENT ON COLUMN infra_job.update_time IS '更新时间';
COMMENT ON COLUMN infra_job.deleted IS '是否删除';
COMMENT ON TABLE infra_job IS '定时任务表';

-- ----------------------------
-- Records of infra_job
-- ----------------------------
-- @formatter:off
BEGIN;
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (5, '支付通知 Job', 2, 'payNotifyJob', NULL, '* * * * * ?', 0, 0, 0, '1', '2021-10-27 08:34:42', '1', '2024-09-12 13:32:48', '0');
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (17, '支付订单同步 Job', 2, 'payOrderSyncJob', NULL, '0 0/1 * * * ?', 0, 0, 0, '1', '2023-07-22 14:36:26', '1', '2023-07-22 15:39:08', '0');
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (18, '支付订单过期 Job', 2, 'payOrderExpireJob', NULL, '0 0/1 * * * ?', 0, 0, 0, '1', '2023-07-22 15:36:23', '1', '2023-07-22 15:39:54', '0');
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (19, '退款订单的同步 Job', 2, 'payRefundSyncJob', NULL, '0 0/1 * * * ?', 0, 0, 0, '1', '2023-07-23 21:03:44', '1', '2023-07-23 21:09:00', '0');
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (21, 'Mall 交易订单的自动过期 Job', 2, 'tradeOrderAutoCancelJob', '', '0 * * * * ?', 3, 0, 0, '1', '2023-09-25 23:43:26', '1', '2025-10-02 11:08:34', '0');
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (22, 'Mall 交易订单的自动收货 Job', 2, 'tradeOrderAutoReceiveJob', '', '0 * * * * ?', 3, 0, 0, '1', '2023-09-26 19:23:53', '1', '2025-10-02 11:08:36', '0');
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (23, 'Mall 交易订单的自动评论 Job', 2, 'tradeOrderAutoCommentJob', '', '0 * * * * ?', 3, 0, 0, '1', '2023-09-26 23:38:29', '1', '2025-10-02 11:08:38', '0');
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (24, 'Mall 佣金解冻 Job', 2, 'brokerageRecordUnfreezeJob', '', '0 * * * * ?', 3, 0, 0, '1', '2023-09-28 22:01:46', '1', '2025-10-02 11:08:04', '0');
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (25, '访问日志清理 Job', 2, 'accessLogCleanJob', '', '0 0 0 * * ?', 3, 0, 0, '1', '2023-10-03 10:59:41', '1', '2023-10-03 11:01:10', '0');
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (26, '错误日志清理 Job', 2, 'errorLogCleanJob', '', '0 0 0 * * ?', 3, 0, 0, '1', '2023-10-03 11:00:43', '1', '2023-10-03 11:01:12', '0');
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (27, '任务日志清理 Job', 2, 'jobLogCleanJob', '', '0 0 0 * * ?', 3, 0, 0, '1', '2023-10-03 11:01:33', '1', '2024-09-12 13:40:34', '0');
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (33, 'demoJob', 2, 'demoJob', '', '0 * * * * ?', 1, 1, 0, '1', '2024-10-27 19:38:46', '1', '2025-05-10 18:13:54', '0');
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (35, '转账订单的同步 Job', 2, 'payTransferSyncJob', '', '0 * * * * ?', 0, 0, 0, '1', '2025-05-10 17:35:54', '1', '2025-05-10 18:13:52', '0');
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (36, 'IoT 设备离线检查 Job', 2, 'iotDeviceOfflineCheckJob', '', '0 * * * * ?', 0, 0, 0, '1', '2025-07-03 23:48:44', '"1"', '2025-07-03 23:48:47', '0');
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (37, 'IoT OTA 升级推送 Job', 2, 'iotOtaUpgradeJob', '', '0 * * * * ?', 0, 0, 0, '1', '2025-07-03 23:49:07', '"1"', '2025-07-03 23:49:13', '0');
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (38, 'Mall 拼团过期 Job', 2, 'combinationRecordExpireJob', '', '0 * * * * ?', 0, 0, 0, '1', '2025-10-02 11:07:11', '1', '2025-10-02 11:07:14', '0');
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (39, 'Mall 优惠券过期 Job', 2, 'couponExpireJob', '', '0 * * * * ?', 0, 0, 0, '1', '2025-10-02 11:07:34', '1', '2025-10-02 11:07:37', '0');
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (40, 'Mall 商品统计 Job', 2, 'productStatisticsJob', '', '0 0 0 * * ?', 0, 0, 0, '1', '2025-11-22 18:51:25', '1', '2025-11-22 18:56:21', '0');
COMMIT;
-- @formatter:on

DROP SEQUENCE IF EXISTS infra_job_seq;
CREATE SEQUENCE infra_job_seq
    START 41;

-- ----------------------------
-- Table structure for infra_job_log
-- ----------------------------
DROP TABLE IF EXISTS infra_job_log;
CREATE TABLE infra_job_log (
    id int8 NOT NULL,
  job_id int8 NOT NULL,
  handler_name varchar(64) NOT NULL,
  handler_param varchar(255) NULL DEFAULT NULL,
  execute_index int2 NOT NULL DEFAULT 1,
  begin_time timestamp NOT NULL,
  end_time timestamp NULL DEFAULT NULL,
  duration int4 NULL DEFAULT NULL,
  status int2 NOT NULL,
  result varchar(4000) NULL DEFAULT '',
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0
);

ALTER TABLE infra_job_log ADD CONSTRAINT pk_infra_job_log PRIMARY KEY (id);

CREATE INDEX idx_infra_job_log_01 ON infra_job_log (job_id);
CREATE INDEX idx_infra_job_log_02 ON infra_job_log (create_time);

COMMENT ON COLUMN infra_job_log.id IS '日志编号';
COMMENT ON COLUMN infra_job_log.job_id IS '任务编号';
COMMENT ON COLUMN infra_job_log.handler_name IS '处理器的名字';
COMMENT ON COLUMN infra_job_log.handler_param IS '处理器的参数';
COMMENT ON COLUMN infra_job_log.execute_index IS '第几次执行';
COMMENT ON COLUMN infra_job_log.begin_time IS '开始执行时间';
COMMENT ON COLUMN infra_job_log.end_time IS '结束执行时间';
COMMENT ON COLUMN infra_job_log.duration IS '执行时长';
COMMENT ON COLUMN infra_job_log.status IS '任务状态';
COMMENT ON COLUMN infra_job_log.result IS '结果数据';
COMMENT ON COLUMN infra_job_log.creator IS '创建者';
COMMENT ON COLUMN infra_job_log.create_time IS '创建时间';
COMMENT ON COLUMN infra_job_log.updater IS '更新者';
COMMENT ON COLUMN infra_job_log.update_time IS '更新时间';
COMMENT ON COLUMN infra_job_log.deleted IS '是否删除';
COMMENT ON TABLE infra_job_log IS '定时任务日志表';

DROP SEQUENCE IF EXISTS infra_job_log_seq;
CREATE SEQUENCE infra_job_log_seq
    START 1;

-- ----------------------------
-- Table structure for system_dept
-- ----------------------------
DROP TABLE IF EXISTS system_dept;
CREATE TABLE system_dept (
    id int8 NOT NULL,
  name varchar(30) NOT NULL DEFAULT '',
  parent_id int8 NOT NULL DEFAULT 0,
  sort int4 NOT NULL DEFAULT 0,
  leader_user_id int8 NULL DEFAULT NULL,
  phone varchar(11) NULL DEFAULT NULL,
  email varchar(50) NULL DEFAULT NULL,
  status int2 NOT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0,
  tenant_id int8 NOT NULL DEFAULT 0
);

ALTER TABLE system_dept ADD CONSTRAINT pk_system_dept PRIMARY KEY (id);

COMMENT ON COLUMN system_dept.id IS '部门id';
COMMENT ON COLUMN system_dept.name IS '部门名称';
COMMENT ON COLUMN system_dept.parent_id IS '父部门id';
COMMENT ON COLUMN system_dept.sort IS '显示顺序';
COMMENT ON COLUMN system_dept.leader_user_id IS '负责人';
COMMENT ON COLUMN system_dept.phone IS '联系电话';
COMMENT ON COLUMN system_dept.email IS '邮箱';
COMMENT ON COLUMN system_dept.status IS '部门状态（0正常 1停用）';
COMMENT ON COLUMN system_dept.creator IS '创建者';
COMMENT ON COLUMN system_dept.create_time IS '创建时间';
COMMENT ON COLUMN system_dept.updater IS '更新者';
COMMENT ON COLUMN system_dept.update_time IS '更新时间';
COMMENT ON COLUMN system_dept.deleted IS '是否删除';
COMMENT ON COLUMN system_dept.tenant_id IS '租户编号';
COMMENT ON TABLE system_dept IS '部门表';

-- ----------------------------
-- Records of system_dept
-- ----------------------------
-- @formatter:off
BEGIN;
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (100, '光何', 0, 0, 1, '15888888888', 'ry@qq.com', 0, 'admin', '2021-01-05 17:03:47', '1', '2026-01-04 18:01:12', '0', 1);
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (101, '深圳总公司', 100, 1, 104, '15888888888', 'ry@qq.com', 0, 'admin', '2021-01-05 17:03:47', '1', '2025-03-29 15:49:55', '0', 1);
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (102, '长沙分公司', 100, 2, NULL, '15888888888', 'ry@qq.com', 0, 'admin', '2021-01-05 17:03:47', '', '2021-12-15 05:01:40', '0', 1);
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (103, '研发部门', 101, 1, 104, '15888888888', 'ry@qq.com', 0, 'admin', '2021-01-05 17:03:47', '1', '2026-01-04 18:01:24', '0', 1);
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (104, '市场部门', 101, 2, NULL, '15888888888', 'ry@qq.com', 0, 'admin', '2021-01-05 17:03:47', '', '2021-12-15 05:01:38', '0', 1);
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (105, '测试部门', 101, 3, NULL, '15888888888', 'ry@qq.com', 0, 'admin', '2021-01-05 17:03:47', '1', '2022-05-16 20:25:15', '0', 1);
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (106, '财务部门', 101, 4,NULL, '15888888888', 'ry@qq.com', 0, 'admin', '2021-01-05 17:03:47', '103', '2022-01-15 21:32:22', '0', 1);
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (107, '运维部门', 101, 5, 1, '15888888888', 'ry@qq.com', 0, 'admin', '2021-01-05 17:03:47', '1', '2023-12-02 09:28:22', '0', 1);
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (108, '市场部门', 102, 1, NULL, '15888888888', 'ry@qq.com', 0, 'admin', '2021-01-05 17:03:47', '1', '2022-02-16 08:35:45', '0', 1);
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (109, '财务部门', 102, 2, NULL, '15888888888', 'ry@qq.com', 0, 'admin', '2021-01-05 17:03:47', '', '2021-12-15 05:01:29', '0', 1);
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (110, '新部门', 0, 1, NULL, NULL, NULL, 0, '110', '2022-02-23 20:46:30', '110', '2022-02-23 20:46:30', '0', 121);
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (111, '顶级部门', 0, 1, NULL, NULL, NULL, 0, '113', '2022-03-07 21:44:50', '113', '2022-03-07 21:44:50', '0', 122);
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (112, '产品部门', 101, 100, 1, NULL, NULL, 1, '1', '2023-12-02 09:45:13', '1', '2023-12-02 09:45:31', '0', 1);
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (113, '支持部门', 102, 3, 104, NULL, NULL, 1, '1', '2023-12-02 09:47:38', '1', '2025-03-29 15:00:56', '0', 1);
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (116, '某个子部门', 0, 1, NULL, NULL, NULL, 0, '1', '2025-12-08 14:51:12', '1', '2025-12-08 14:51:12', '0', 1);
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (117, '某个子部门 2', 0, 2, NULL, NULL, NULL, 0, '1', '2025-12-08 14:51:25', '1', '2025-12-08 14:51:25', '0', 1);
COMMIT;
-- @formatter:on

DROP SEQUENCE IF EXISTS system_dept_seq;
CREATE SEQUENCE system_dept_seq
    START 118;

-- ----------------------------
-- Table structure for system_dict_data
-- ----------------------------
DROP TABLE IF EXISTS system_dict_data;
CREATE TABLE system_dict_data (
    id int8 NOT NULL,
  sort int4 NOT NULL DEFAULT 0,
  label varchar(100) NOT NULL DEFAULT '',
  value varchar(100) NOT NULL DEFAULT '',
  dict_type varchar(100) NOT NULL DEFAULT '',
  status int2 NOT NULL DEFAULT 0,
  color_type varchar(100) NULL DEFAULT '',
  css_class varchar(100) NULL DEFAULT '',
  remark varchar(500) NULL DEFAULT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0
);

ALTER TABLE system_dict_data ADD CONSTRAINT pk_system_dict_data PRIMARY KEY (id);

COMMENT ON COLUMN system_dict_data.id IS '字典编码';
COMMENT ON COLUMN system_dict_data.sort IS '字典排序';
COMMENT ON COLUMN system_dict_data.label IS '字典标签';
COMMENT ON COLUMN system_dict_data.value IS '字典键值';
COMMENT ON COLUMN system_dict_data.dict_type IS '字典类型';
COMMENT ON COLUMN system_dict_data.status IS '状态（0正常 1停用）';
COMMENT ON COLUMN system_dict_data.color_type IS '颜色类型';
COMMENT ON COLUMN system_dict_data.css_class IS 'css 样式';
COMMENT ON COLUMN system_dict_data.remark IS '备注';
COMMENT ON COLUMN system_dict_data.creator IS '创建者';
COMMENT ON COLUMN system_dict_data.create_time IS '创建时间';
COMMENT ON COLUMN system_dict_data.updater IS '更新者';
COMMENT ON COLUMN system_dict_data.update_time IS '更新时间';
COMMENT ON COLUMN system_dict_data.deleted IS '是否删除';
COMMENT ON TABLE system_dict_data IS '字典数据表';

-- ----------------------------
-- Records of system_dict_data
-- ----------------------------
-- @formatter:off
BEGIN;
COMMIT;
-- @formatter:on

DROP SEQUENCE IF EXISTS system_dict_data_seq;
CREATE SEQUENCE system_dict_data_seq
    START 3449;

-- ----------------------------
-- Table structure for system_dict_type
-- ----------------------------
DROP TABLE IF EXISTS system_dict_type;
CREATE TABLE system_dict_type (
    id int8 NOT NULL,
  name varchar(100) NOT NULL DEFAULT '',
  type varchar(100) NOT NULL DEFAULT '',
  status int2 NOT NULL DEFAULT 0,
  remark varchar(500) NULL DEFAULT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0,
  deleted_time timestamp NULL DEFAULT NULL
);

ALTER TABLE system_dict_type ADD CONSTRAINT pk_system_dict_type PRIMARY KEY (id);

COMMENT ON COLUMN system_dict_type.id IS '字典主键';
COMMENT ON COLUMN system_dict_type.name IS '字典名称';
COMMENT ON COLUMN system_dict_type.type IS '字典类型';
COMMENT ON COLUMN system_dict_type.status IS '状态（0正常 1停用）';
COMMENT ON COLUMN system_dict_type.remark IS '备注';
COMMENT ON COLUMN system_dict_type.creator IS '创建者';
COMMENT ON COLUMN system_dict_type.create_time IS '创建时间';
COMMENT ON COLUMN system_dict_type.updater IS '更新者';
COMMENT ON COLUMN system_dict_type.update_time IS '更新时间';
COMMENT ON COLUMN system_dict_type.deleted IS '是否删除';
COMMENT ON COLUMN system_dict_type.deleted_time IS '删除时间';
COMMENT ON TABLE system_dict_type IS '字典类型表';

-- ----------------------------
-- Records of system_dict_type
-- ----------------------------
-- @formatter:off
BEGIN;
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1, '用户性别', 'system_user_sex', 0, NULL, 'admin', '2021-01-05 17:03:48', '1', '2022-05-16 20:29:32', '0', NULL);
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (6, '参数类型', 'infra_config_type', 0, NULL, 'admin', '2021-01-05 17:03:48', '', '2022-02-01 16:36:54', '0', NULL);
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (7, '通知类型', 'system_notice_type', 0, NULL, 'admin', '2021-01-05 17:03:48', '', '2022-02-01 16:35:26', '0', NULL);
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (9, '操作类型', 'infra_operate_type', 0, NULL, 'admin', '2021-01-05 17:03:48', '1', '2024-03-14 12:44:01', '0', NULL);
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (10, '系统状态', 'common_status', 0, NULL, 'admin', '2021-01-05 17:03:48', '', '2022-02-01 16:21:28', '0', NULL);
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (11, 'Boolean 是否类型', 'infra_boolean_string', 0, 'boolean 转是否', '', '2021-01-19 03:20:08', '', '2022-02-01 16:37:10', '0', NULL);
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (104, '登陆结果', 'system_login_result', 0, '登陆结果', '', '2021-01-18 06:17:11', '', '2022-02-01 16:36:00', '0', NULL);
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (106, '代码生成模板类型', 'infra_codegen_template_type', 0, NULL, '', '2021-02-05 07:08:06', '1', '2022-05-16 20:26:50', '0', NULL);
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (107, '定时任务状态', 'infra_job_status', 0, NULL, '', '2021-02-07 07:44:16', '', '2022-02-01 16:51:11', '0', NULL);
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (108, '定时任务日志状态', 'infra_job_log_status', 0, NULL, '', '2021-02-08 10:03:51', '', '2022-02-01 16:50:43', '0', NULL);
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (109, '用户类型', 'user_type', 0, NULL, '', '2021-02-26 00:15:51', '', '2021-02-26 00:15:51', '0', NULL);
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (110, 'API 异常数据的处理状态', 'infra_api_error_log_process_status', 0, NULL, '', '2021-02-26 07:07:01', '', '2022-02-01 16:50:53', '0', NULL);
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (111, '短信渠道编码', 'system_sms_channel_code', 0, NULL, '1', '2021-04-05 01:04:50', '1', '2022-02-16 02:09:08', '0', NULL);
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (112, '短信模板的类型', 'system_sms_template_type', 0, NULL, '1', '2021-04-05 21:50:43', '1', '2022-02-01 16:35:06', '0', NULL);
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (113, '短信发送状态', 'system_sms_send_status', 0, NULL, '1', '2021-04-11 20:18:03', '1', '2022-02-01 16:35:09', '0', NULL);
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (114, '短信接收状态', 'system_sms_receive_status', 0, NULL, '1', '2021-04-11 20:27:14', '1', '2022-02-01 16:35:14', '0', NULL);
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (116, '登陆日志的类型', 'system_login_type', 0, '登陆日志的类型', '1', '2021-10-06 00:50:46', '1', '2022-02-01 16:35:56', '0', NULL);
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (144, '代码生成的场景枚举', 'infra_codegen_scene', 0, '代码生成的场景枚举', '1', '2022-02-02 13:14:45', '1', '2022-03-10 16:33:46', '0', NULL);
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (145, '角色类型', 'system_role_type', 0, '角色类型', '1', '2022-02-16 13:01:46', '1', '2022-02-16 13:01:46', '0', NULL);
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (146, '文件存储器', 'infra_file_storage', 0, '文件存储器', '1', '2022-03-15 00:24:38', '1', '2022-03-15 00:24:38', '0', NULL);
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (147, 'OAuth 2.0 授权类型', 'system_oauth2_grant_type', 0, 'OAuth 2.0 授权类型（模式）', '1', '2022-05-12 00:20:52', '1', '2022-05-11 16:25:49', '0', NULL);
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (160, '终端', 'terminal', 0, '终端', '1', '2022-12-10 10:50:50', '1', '2022-12-10 10:53:11', '0', NULL);
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (166, '邮件发送状态', 'system_mail_send_status', 0, '邮件发送状态', '1', '2023-01-26 09:53:13', '1', '2023-01-26 09:53:13', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (167, '站内信模版的类型', 'system_notify_template_type', 0, '站内信模版的类型', '1', '2023-01-28 10:35:10', '1', '2023-01-28 10:35:10', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (168, '代码生成的前端类型', 'infra_codegen_front_type', 0, '', '1', '2023-04-12 23:57:52', '1', '2023-04-12 23:57:52', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (601, '社交类型', 'system_social_type', 0, '', '1', '2023-11-04 13:03:54', '1', '2023-11-04 13:03:54', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (611, 'ERP 库存明细的业务类型', 'erp_stock_record_biz_type', 0, 'ERP 库存明细的业务类型', '1', '2024-02-05 18:07:02', '1', '2024-02-05 18:07:02', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (612, 'ERP 审批状态', 'erp_audit_status', 0, '', '1', '2024-02-06 00:00:07', '1', '2024-02-06 00:00:07', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (616, '时间间隔', 'date_interval', 0, '', '1', '2024-03-29 22:50:09', '1', '2024-03-29 22:50:09', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (620, 'AI 模型平台', 'ai_platform', 0, '', '1', '2024-05-09 22:27:38', '1', '2024-05-09 22:27:38', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (621, 'AI 绘画状态', 'ai_image_status', 0, '', '1', '2024-06-26 20:51:23', '1', '2024-06-26 20:51:23', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (622, 'AI 音乐状态', 'ai_music_status', 0, '', '1', '2024-06-27 22:45:07', '1', '2024-06-28 00:56:27', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (623, 'AI 音乐生成模式', 'ai_generate_mode', 0, '', '1', '2024-06-27 22:46:21', '1', '2024-06-28 01:22:29', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (624, '写作语气', 'ai_write_tone', 0, '', '1', '2024-07-07 15:19:02', '1', '2024-07-07 15:19:02', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (625, '写作语言', 'ai_write_language', 0, '', '1', '2024-07-07 15:18:52', '1', '2024-07-07 15:18:52', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (626, '写作长度', 'ai_write_length', 0, '', '1', '2024-07-07 15:18:41', '1', '2024-07-07 15:18:41', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (627, '写作格式', 'ai_write_format', 0, '', '1', '2024-07-07 15:14:34', '1', '2024-07-07 15:14:34', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (628, 'AI 写作类型', 'ai_write_type', 0, '', '1', '2024-07-10 21:25:29', '1', '2024-07-10 21:25:29', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (640, 'AI 模型类型', 'ai_model_type', 0, '', '1', '2025-03-03 12:24:07', '1', '2025-03-03 12:24:07', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1001, 'IoT 产品设备类型', 'iot_product_device_type', 0, '', '1', '2024-08-10 11:54:30', '1', '2025-03-17 09:25:08', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1002, 'IoT 产品状态', 'iot_product_status', 0, '', '1', '2024-08-10 12:06:09', '1', '2025-03-17 09:25:10', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1004, 'IoT 联网方式', 'iot_net_type', 0, '', '1', '2024-09-06 22:04:13', '1', '2025-03-17 09:25:14', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1006, 'IoT 设备状态', 'iot_device_state', 0, '', '1', '2024-09-21 08:12:55', '1', '2025-03-17 09:25:19', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1007, 'IoT 物模型功能类型', 'iot_thing_model_type', 0, '', '1', '2024-09-29 20:02:36', '1', '2025-03-17 09:25:24', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1011, 'IoT 物模型单位', 'iot_thing_model_unit', 0, '', '1', '2024-12-25 17:36:46', '1', '2025-03-17 09:25:35', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1013, 'IoT 数据流转目的的类型枚举', 'iot_data_sink_type_enum', 0, '', '1', '2025-03-09 12:39:36', '1', '2025-06-24 12:45:24', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1014, 'IoT 场景流转的触发类型枚举', 'iot_rule_scene_trigger_type_enum', 0, '', '1', '2025-03-20 14:59:44', '1', '2025-03-20 14:59:44', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1015, 'IoT 设备消息类型枚举', 'iot_device_message_type_enum', 0, '', '1', '2025-03-20 15:01:15', '1', '2025-03-20 15:01:15', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1016, 'IoT 规则场景的触发类型枚举', 'iot_rule_scene_action_type_enum', 0, '', '1', '2025-03-28 15:26:54', '1', '2025-03-28 15:29:13', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (2001, 'IoT 告警级别', 'iot_alert_level', 0, '', '1', '2025-06-27 20:30:57', '1', '2025-06-27 20:30:57', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (2002, 'IoT 告警', 'iot_alert_receive_type', 0, '', '1', '2025-06-27 22:49:19', '1', '2025-06-27 22:49:19', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (2003, 'IoT 固件设备范围', 'iot_ota_task_device_scope', 0, '', '1', '2025-07-02 09:42:49', '1', '2025-07-02 09:42:49', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (2004, 'IoT 固件升级任务状态', 'iot_ota_task_status', 0, '', '1', '2025-07-02 09:43:43', '1', '2025-07-02 09:43:43', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (2005, 'IoT 固件升级记录状态', 'iot_ota_task_record_status', 0, '', '1', '2025-07-02 09:45:02', '1', '2025-07-02 09:45:02', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (2007, 'AI MCP 客户端名字', 'ai_mcp_client_name', 0, '', '1', '2025-08-28 13:57:40', '1', '2025-08-28 13:57:40', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (2008, 'IoT 协议类型', 'iot_protocol_type', 0, 'IoT 设备接入协议类型', '1', '2026-02-04 00:31:33', '1', '2026-02-04 00:31:33', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (2009, 'IoT 序列化类型', 'iot_serialize_type', 0, 'IoT 设备消息序列化类型', '1', '2026-02-04 00:33:16', '1', '2026-02-04 00:33:16', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (2010, 'IoT Modbus 工作模式', 'iot_modbus_mode', 0, 'Modbus 设备数据采集模式', '1', '2025-06-12 22:55:46', '1', '2025-06-12 22:55:46', '0', '1970-01-01 00:00:00');
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (2011, 'IoT Modbus 帧格式', 'iot_modbus_frame_format', 0, 'Modbus 数据帧协议格式', '1', '2025-06-12 22:55:46', '1', '2025-06-12 22:55:46', '0', '1970-01-01 00:00:00');
COMMIT;
-- @formatter:on

DROP SEQUENCE IF EXISTS system_dict_type_seq;
CREATE SEQUENCE system_dict_type_seq
    START 2139;

-- ----------------------------
-- Table structure for system_login_log
-- ----------------------------
DROP TABLE IF EXISTS system_login_log;
CREATE TABLE system_login_log (
    id int8 NOT NULL,
  log_type int8 NOT NULL,
  trace_id varchar(64) NOT NULL DEFAULT '',
  user_id int8 NOT NULL DEFAULT 0,
  user_type int2 NOT NULL DEFAULT 0,
  username varchar(50) NOT NULL DEFAULT '',
  result int2 NOT NULL,
  user_ip varchar(50) NOT NULL,
  user_agent varchar(512) NOT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0,
  tenant_id int8 NOT NULL DEFAULT 0
);

ALTER TABLE system_login_log ADD CONSTRAINT pk_system_login_log PRIMARY KEY (id);

CREATE INDEX idx_system_login_log_01 ON system_login_log (username);
CREATE INDEX idx_system_login_log_02 ON system_login_log (create_time);

COMMENT ON COLUMN system_login_log.id IS '访问ID';
COMMENT ON COLUMN system_login_log.log_type IS '日志类型';
COMMENT ON COLUMN system_login_log.trace_id IS '链路追踪编号';
COMMENT ON COLUMN system_login_log.user_id IS '用户编号';
COMMENT ON COLUMN system_login_log.user_type IS '用户类型';
COMMENT ON COLUMN system_login_log.username IS '用户账号';
COMMENT ON COLUMN system_login_log.result IS '登陆结果';
COMMENT ON COLUMN system_login_log.user_ip IS '用户 IP';
COMMENT ON COLUMN system_login_log.user_agent IS '浏览器 UA';
COMMENT ON COLUMN system_login_log.creator IS '创建者';
COMMENT ON COLUMN system_login_log.create_time IS '创建时间';
COMMENT ON COLUMN system_login_log.updater IS '更新者';
COMMENT ON COLUMN system_login_log.update_time IS '更新时间';
COMMENT ON COLUMN system_login_log.deleted IS '是否删除';
COMMENT ON COLUMN system_login_log.tenant_id IS '租户编号';
COMMENT ON TABLE system_login_log IS '系统访问记录';

DROP SEQUENCE IF EXISTS system_login_log_seq;
CREATE SEQUENCE system_login_log_seq
    START 1;

-- ----------------------------
-- Table structure for system_mail_account
-- ----------------------------
DROP TABLE IF EXISTS system_mail_account;
CREATE TABLE system_mail_account (
    id int8 NOT NULL,
  mail varchar(255) NOT NULL,
  username varchar(255) NOT NULL,
  password varchar(255) NOT NULL,
  host varchar(255) NOT NULL,
  port int4 NOT NULL,
  ssl_enable bool NOT NULL DEFAULT '0',
  starttls_enable bool NOT NULL DEFAULT '0',
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0
);

ALTER TABLE system_mail_account ADD CONSTRAINT pk_system_mail_account PRIMARY KEY (id);

COMMENT ON COLUMN system_mail_account.id IS '主键';
COMMENT ON COLUMN system_mail_account.mail IS '邮箱';
COMMENT ON COLUMN system_mail_account.username IS '用户名';
COMMENT ON COLUMN system_mail_account.password IS '密码';
COMMENT ON COLUMN system_mail_account.host IS 'SMTP 服务器域名';
COMMENT ON COLUMN system_mail_account.port IS 'SMTP 服务器端口';
COMMENT ON COLUMN system_mail_account.ssl_enable IS '是否开启 SSL';
COMMENT ON COLUMN system_mail_account.starttls_enable IS '是否开启 STARTTLS';
COMMENT ON COLUMN system_mail_account.creator IS '创建者';
COMMENT ON COLUMN system_mail_account.create_time IS '创建时间';
COMMENT ON COLUMN system_mail_account.updater IS '更新者';
COMMENT ON COLUMN system_mail_account.update_time IS '更新时间';
COMMENT ON COLUMN system_mail_account.deleted IS '是否删除';
COMMENT ON TABLE system_mail_account IS '邮箱账号表';

-- ----------------------------
-- Records of system_mail_account
-- ----------------------------
-- @formatter:off
BEGIN;
INSERT INTO system_mail_account (id, mail, username, password, host, port, ssl_enable, starttls_enable, creator, create_time, updater, update_time, deleted) VALUES (1, '7684413@qq.com', '7684413@qq.com', '1234576', '127.0.0.1', 8080, '0', '0', '1', '2023-01-25 17:39:52', '1', '2025-04-04 16:34:40', '0');
INSERT INTO system_mail_account (id, mail, username, password, host, port, ssl_enable, starttls_enable, creator, create_time, updater, update_time, deleted) VALUES (2, 'ydym_test@163.com', 'ydym_test@163.com', 'WBZTEINMIFVRYSOE', 'smtp.163.com', 465, '1', '0', '1', '2023-01-26 01:26:03', '1', '2025-12-20 18:09:32', '0');
INSERT INTO system_mail_account (id, mail, username, password, host, port, ssl_enable, starttls_enable, creator, create_time, updater, update_time, deleted) VALUES (3, '76854114@qq.com', '3335', '11234', 'guanghe1.cn', 466, '0', '0', '1', '2023-01-27 15:06:38', '1', '2023-01-27 07:08:36', '1');
INSERT INTO system_mail_account (id, mail, username, password, host, port, ssl_enable, starttls_enable, creator, create_time, updater, update_time, deleted) VALUES (4, '7685413x@qq.com', '2', '3', '4', 5, '1', '0', '1', '2023-04-12 23:05:06', '1', '2023-04-12 15:05:11', '1');
COMMIT;
-- @formatter:on

DROP SEQUENCE IF EXISTS system_mail_account_seq;
CREATE SEQUENCE system_mail_account_seq
    START 5;

-- ----------------------------
-- Table structure for system_mail_log
-- ----------------------------
DROP TABLE IF EXISTS system_mail_log;
CREATE TABLE system_mail_log (
    id int8 NOT NULL,
  user_id int8 NULL DEFAULT NULL,
  user_type int2 NULL DEFAULT NULL,
  to_mails varchar(1024) NOT NULL,
  cc_mails varchar(1024) NULL DEFAULT NULL,
  bcc_mails varchar(1024) NULL DEFAULT NULL,
  account_id int8 NOT NULL,
  from_mail varchar(255) NOT NULL,
  template_id int8 NOT NULL,
  template_code varchar(63) NOT NULL,
  template_nickname varchar(255) NULL DEFAULT NULL,
  template_title varchar(255) NOT NULL,
  template_content text NOT NULL,
  template_params varchar(255) NOT NULL,
  send_status int2 NOT NULL DEFAULT 0,
  send_time timestamp NULL DEFAULT NULL,
  send_message_id varchar(255) NULL DEFAULT NULL,
  send_exception varchar(4096) NULL DEFAULT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0
);

ALTER TABLE system_mail_log ADD CONSTRAINT pk_system_mail_log PRIMARY KEY (id);

COMMENT ON COLUMN system_mail_log.id IS '编号';
COMMENT ON COLUMN system_mail_log.user_id IS '用户编号';
COMMENT ON COLUMN system_mail_log.user_type IS '用户类型';
COMMENT ON COLUMN system_mail_log.to_mails IS '接收邮箱地址';
COMMENT ON COLUMN system_mail_log.cc_mails IS '抄送邮箱地址';
COMMENT ON COLUMN system_mail_log.bcc_mails IS '密送邮箱地址';
COMMENT ON COLUMN system_mail_log.account_id IS '邮箱账号编号';
COMMENT ON COLUMN system_mail_log.from_mail IS '发送邮箱地址';
COMMENT ON COLUMN system_mail_log.template_id IS '模板编号';
COMMENT ON COLUMN system_mail_log.template_code IS '模板编码';
COMMENT ON COLUMN system_mail_log.template_nickname IS '模版发送人名称';
COMMENT ON COLUMN system_mail_log.template_title IS '邮件标题';
COMMENT ON COLUMN system_mail_log.template_content IS '邮件内容';
COMMENT ON COLUMN system_mail_log.template_params IS '邮件参数';
COMMENT ON COLUMN system_mail_log.send_status IS '发送状态';
COMMENT ON COLUMN system_mail_log.send_time IS '发送时间';
COMMENT ON COLUMN system_mail_log.send_message_id IS '发送返回的消息 ID';
COMMENT ON COLUMN system_mail_log.send_exception IS '发送异常';
COMMENT ON COLUMN system_mail_log.creator IS '创建者';
COMMENT ON COLUMN system_mail_log.create_time IS '创建时间';
COMMENT ON COLUMN system_mail_log.updater IS '更新者';
COMMENT ON COLUMN system_mail_log.update_time IS '更新时间';
COMMENT ON COLUMN system_mail_log.deleted IS '是否删除';
COMMENT ON TABLE system_mail_log IS '邮件日志表';

DROP SEQUENCE IF EXISTS system_mail_log_seq;
CREATE SEQUENCE system_mail_log_seq
    START 1;

-- ----------------------------
-- Table structure for system_mail_template
-- ----------------------------
DROP TABLE IF EXISTS system_mail_template;
CREATE TABLE system_mail_template (
    id int8 NOT NULL,
  name varchar(63) NOT NULL,
  code varchar(63) NOT NULL,
  account_id int8 NOT NULL,
  nickname varchar(255) NULL DEFAULT NULL,
  title varchar(255) NOT NULL,
  content varchar(10240) NOT NULL,
  params varchar(255) NOT NULL,
  status int2 NOT NULL,
  remark varchar(255) NULL DEFAULT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0
);

ALTER TABLE system_mail_template ADD CONSTRAINT pk_system_mail_template PRIMARY KEY (id);

COMMENT ON COLUMN system_mail_template.id IS '编号';
COMMENT ON COLUMN system_mail_template.name IS '模板名称';
COMMENT ON COLUMN system_mail_template.code IS '模板编码';
COMMENT ON COLUMN system_mail_template.account_id IS '发送的邮箱账号编号';
COMMENT ON COLUMN system_mail_template.nickname IS '发送人名称';
COMMENT ON COLUMN system_mail_template.title IS '模板标题';
COMMENT ON COLUMN system_mail_template.content IS '模板内容';
COMMENT ON COLUMN system_mail_template.params IS '参数数组';
COMMENT ON COLUMN system_mail_template.status IS '开启状态';
COMMENT ON COLUMN system_mail_template.remark IS '备注';
COMMENT ON COLUMN system_mail_template.creator IS '创建者';
COMMENT ON COLUMN system_mail_template.create_time IS '创建时间';
COMMENT ON COLUMN system_mail_template.updater IS '更新者';
COMMENT ON COLUMN system_mail_template.update_time IS '更新时间';
COMMENT ON COLUMN system_mail_template.deleted IS '是否删除';
COMMENT ON TABLE system_mail_template IS '邮件模版表';

-- ----------------------------
-- Records of system_mail_template
-- ----------------------------
-- @formatter:off
BEGIN;
INSERT INTO system_mail_template (id, name, code, account_id, nickname, title, content, params, status, remark, creator, create_time, updater, update_time, deleted) VALUES (13, '后台用户短信登录', 'admin-sms-login', 1, '奥特曼', '你猜我猜', '<p>您的验证码是{code}，名字是{name}</p>', '["code","name"]', 0, '3', '1', '2021-10-11 08:10:00', '1', '2023-12-02 19:51:14', '0');
INSERT INTO system_mail_template (id, name, code, account_id, nickname, title, content, params, status, remark, creator, create_time, updater, update_time, deleted) VALUES (14, '测试模版', 'test_01', 2, '光何', '一个标题', '<p>你是 {key01} 吗？</p><p><br></p><p>是的话，赶紧 {key02} 一下！</p>', '["key01","key02"]', 0, NULL, '1', '2023-01-26 01:27:40', '1', '2025-07-26 21:48:45', '0');
INSERT INTO system_mail_template (id, name, code, account_id, nickname, title, content, params, status, remark, creator, create_time, updater, update_time, deleted) VALUES (15, '3', '2', 2, '7', '4', '<p>45</p>', '[]', 1, '80', '1', '2023-01-27 15:50:35', '1', '2025-07-26 21:47:49', '1');
COMMIT;
-- @formatter:on

DROP SEQUENCE IF EXISTS system_mail_template_seq;
CREATE SEQUENCE system_mail_template_seq
    START 16;

-- ----------------------------
-- Table structure for system_menu
-- ----------------------------
DROP TABLE IF EXISTS system_menu;
CREATE TABLE system_menu (
    id int8 NOT NULL,
  name varchar(50) NOT NULL,
  permission varchar(100) NOT NULL DEFAULT '',
  type int2 NOT NULL,
  sort int4 NOT NULL DEFAULT 0,
  parent_id int8 NOT NULL DEFAULT 0,
  path varchar(200) NULL DEFAULT '',
  icon varchar(100) NULL DEFAULT '#',
  component varchar(255) NULL DEFAULT NULL,
  component_name varchar(255) NULL DEFAULT NULL,
  status int2 NOT NULL DEFAULT 0,
  visible bool NOT NULL DEFAULT '1',
  keep_alive bool NOT NULL DEFAULT '1',
  always_show bool NOT NULL DEFAULT '1',
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0
);

ALTER TABLE system_menu ADD CONSTRAINT pk_system_menu PRIMARY KEY (id);

COMMENT ON COLUMN system_menu.id IS '菜单ID';
COMMENT ON COLUMN system_menu.name IS '菜单名称';
COMMENT ON COLUMN system_menu.permission IS '权限标识';
COMMENT ON COLUMN system_menu.type IS '菜单类型';
COMMENT ON COLUMN system_menu.sort IS '显示顺序';
COMMENT ON COLUMN system_menu.parent_id IS '父菜单ID';
COMMENT ON COLUMN system_menu.path IS '路由地址';
COMMENT ON COLUMN system_menu.icon IS '菜单图标';
COMMENT ON COLUMN system_menu.component IS '组件路径';
COMMENT ON COLUMN system_menu.component_name IS '组件名';
COMMENT ON COLUMN system_menu.status IS '菜单状态';
COMMENT ON COLUMN system_menu.visible IS '是否可见';
COMMENT ON COLUMN system_menu.keep_alive IS '是否缓存';
COMMENT ON COLUMN system_menu.always_show IS '是否总是显示';
COMMENT ON COLUMN system_menu.creator IS '创建者';
COMMENT ON COLUMN system_menu.create_time IS '创建时间';
COMMENT ON COLUMN system_menu.updater IS '更新者';
COMMENT ON COLUMN system_menu.update_time IS '更新时间';
COMMENT ON COLUMN system_menu.deleted IS '是否删除';
COMMENT ON TABLE system_menu IS '菜单权限表';

-- ----------------------------
-- Records of system_menu
-- ----------------------------
-- @formatter:off
BEGIN;
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1, '系统管理', '', 1, 10, 0, '/system', 'ep:tools', NULL, NULL, 0, '1', '1', '1', 'admin', '2021-01-05 17:03:48', '1', '2025-03-15 21:30:27', '0');
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2, '基础设施', '', 1, 20, 0, '/infra', 'ep:monitor', NULL, NULL, 0, '1', '1', '1', 'admin', '2021-01-05 17:03:48', '1', '2024-03-01 08:28:40', '0');
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (100, '用户管理', 'system:user:list', 2, 1, 1, 'user', 'ep:avatar', 'system/user/index', 'SystemUser', 0, '1', '1', '1', 'admin', '2021-01-05 17:03:48', '1', '2026-01-01 18:43:01', '0');
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (101, '角色管理', '', 2, 2, 1, 'role', 'ep:user', 'system/role/index', 'SystemRole', 0, '1', '1', '1', 'admin', '2021-01-05 17:03:48', '1', '2026-01-05 19:30:33', '0');
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (102, '菜单管理', '', 2, 3, 1, 'menu', 'ep:menu', 'system/menu/index', 'SystemMenu', 0, '1', '1', '1', 'admin', '2021-01-05 17:03:48', '1', '2024-02-29 01:03:50', '0');
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (103, '部门管理', '', 2, 4, 1, 'dept', 'fa:address-card', 'system/dept/index', 'SystemDept', 0, '1', '1', '1', 'admin', '2021-01-05 17:03:48', '1', '2024-02-29 01:06:28', '0');
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (104, '岗位管理', '', 2, 5, 1, 'post', 'fa:address-book-o', 'system/post/index', 'SystemPost', 0, '1', '1', '1', 'admin', '2021-01-05 17:03:48', '1', '2024-02-29 01:06:39', '0');
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (105, '字典管理', '', 2, 6, 1, 'dict', 'ep:collection', 'system/dict/index', 'SystemDictType', 0, '1', '1', '1', 'admin', '2021-01-05 17:03:48', '1', '2024-02-29 01:07:12', '0');
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (106, '配置管理', '', 2, 8, 2, 'config', 'fa:connectdevelop', 'infra/config/index', 'InfraConfig', 0, '1', '1', '1', 'admin', '2021-01-05 17:03:48', '1', '2024-04-23 00:02:45', '0');
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (107, '通知公告', '', 2, 4, 2739, 'notice', 'ep:takeaway-box', 'system/notice/index', 'SystemNotice', 0, '1', '1', '1', 'admin', '2021-01-05 17:03:48', '1', '2024-04-22 23:56:17', '0');
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (108, '审计日志', '', 1, 9, 1, 'log', 'ep:document-copy', '', NULL, 0, '1', '1', '1', 'admin', '2021-01-05 17:03:48', '1', '2024-02-29 01:08:30', '0');
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (109, '令牌管理', '', 2, 2, 1261, 'token', 'fa:key', 'system/oauth2/token/index', 'SystemTokenClient', 0, '1', '1', '1', 'admin', '2021-01-05 17:03:48', '1', '2024-02-29 01:13:48', '0');
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (110, '定时任务', '', 2, 7, 2, 'job', 'fa-solid:tasks', 'infra/job/index', 'InfraJob', 0, '1', '1', '1', 'admin', '2021-01-05 17:03:48', '1', '2024-02-29 08:57:36', '0');
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (111, 'MySQL 监控', '', 2, 1, 2740, 'druid', 'fa-solid:box', 'infra/druid/index', 'InfraDruid', 0, '1', '1', '1', 'admin', '2021-01-05 17:03:48', '1', '2024-04-23 00:05:58', '0');
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (112, 'Java 监控', '', 2, 3, 2740, 'admin-server', 'ep:coffee-cup', 'infra/server/index', 'InfraAdminServer', 0, '1', '1', '1', 'admin', '2021-01-05 17:03:48', '1', '2024-04-23 00:06:57', '0');
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (113, 'Redis 监控', '', 2, 2, 2740, 'redis', 'fa:reddit-square', 'infra/redis/index', 'InfraRedis', 0, '1', '1', '1', 'admin', '2021-01-05 17:03:48', '1', '2024-04-23 00:06:09', '0');
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2027, 'Banner创建', 'promotion:banner:create', 3, 2, 2025, '', '', '', '', 0, '1', '1', '1', '', '2022-08-01 14:56:14', '1', '2023-10-24 20:20:23', '0');
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2028, 'Banner更新', 'promotion:banner:update', 3, 3, 2025, '', '', '', '', 0, '1', '1', '1', '', '2022-08-01 14:56:14', '1', '2023-10-24 20:20:28', '0');
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2029, 'Banner删除', 'promotion:banner:delete', 3, 4, 2025, '', '', '', '', 0, '1', '1', '1', '', '2022-08-01 14:56:14', '1', '2023-10-24 20:20:36', '0');
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2030, '营销中心', '', 1, 70, 2362, 'promotion', 'ep:present', NULL, NULL, 0, '1', '1', '1', '1', '2022-10-31 21:25:09', '1', '2023-09-30 11:54:27', '0');
COMMIT;
-- @formatter:on

DROP SEQUENCE IF EXISTS system_menu_seq;
CREATE SEQUENCE system_menu_seq
    START 5986;

-- ----------------------------
-- Table structure for system_notice
-- ----------------------------
DROP TABLE IF EXISTS system_notice;
CREATE TABLE system_notice (
    id int8 NOT NULL,
  title varchar(50) NOT NULL,
  content text NOT NULL,
  type int2 NOT NULL,
  status int2 NOT NULL DEFAULT 0,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0,
  tenant_id int8 NOT NULL DEFAULT 0
);

ALTER TABLE system_notice ADD CONSTRAINT pk_system_notice PRIMARY KEY (id);

COMMENT ON COLUMN system_notice.id IS '公告ID';
COMMENT ON COLUMN system_notice.title IS '公告标题';
COMMENT ON COLUMN system_notice.content IS '公告内容';
COMMENT ON COLUMN system_notice.type IS '公告类型（1通知 2公告）';
COMMENT ON COLUMN system_notice.status IS '公告状态（0正常 1关闭）';
COMMENT ON COLUMN system_notice.creator IS '创建者';
COMMENT ON COLUMN system_notice.create_time IS '创建时间';
COMMENT ON COLUMN system_notice.updater IS '更新者';
COMMENT ON COLUMN system_notice.update_time IS '更新时间';
COMMENT ON COLUMN system_notice.deleted IS '是否删除';
COMMENT ON COLUMN system_notice.tenant_id IS '租户编号';
COMMENT ON TABLE system_notice IS '通知公告表';

-- ----------------------------
-- Records of system_notice
-- ----------------------------
-- @formatter:off
BEGIN;
INSERT INTO system_notice (id, title, content, type, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1, '光何的公众', '<p>新版本内容133222</p>', 1, 0, 'admin', '2021-01-05 17:03:48', '"1"', '2025-08-31 09:38:22', '0', 1);
INSERT INTO system_notice (id, title, content, type, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2, '系统例行维护通知', '<p>系统将于每周日凌晨 02:00 - 04:00 进行例行维护，请提前保存好数据。</p>', 2, 1, 'admin', '2021-01-05 17:03:48', '1', '2025-04-18 23:56:40', '0', 1);
INSERT INTO system_notice (id, title, content, type, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4, '我是测试标题', '<p>哈哈哈哈123</p>', 1, 0, '110', '2022-02-22 01:01:25', '110', '2022-02-22 01:01:46', '0', 121);
COMMIT;
-- @formatter:on

DROP SEQUENCE IF EXISTS system_notice_seq;
CREATE SEQUENCE system_notice_seq
    START 5;

-- ----------------------------
-- Table structure for system_notify_message
-- ----------------------------
DROP TABLE IF EXISTS system_notify_message;
CREATE TABLE system_notify_message (
    id int8 NOT NULL,
  user_id int8 NOT NULL,
  user_type int2 NOT NULL,
  template_id int8 NOT NULL,
  template_code varchar(64) NOT NULL,
  template_nickname varchar(63) NOT NULL,
  template_content varchar(1024) NOT NULL,
  template_type int4 NOT NULL,
  template_params varchar(255) NOT NULL,
  read_status bool NOT NULL,
  read_time timestamp NULL DEFAULT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0,
  tenant_id int8 NOT NULL DEFAULT 0
);

ALTER TABLE system_notify_message ADD CONSTRAINT pk_system_notify_message PRIMARY KEY (id);

CREATE INDEX idx_system_notify_message_01 ON system_notify_message (user_id, user_type, read_status);

COMMENT ON COLUMN system_notify_message.id IS '用户ID';
COMMENT ON COLUMN system_notify_message.user_id IS '用户id';
COMMENT ON COLUMN system_notify_message.user_type IS '用户类型';
COMMENT ON COLUMN system_notify_message.template_id IS '模版编号';
COMMENT ON COLUMN system_notify_message.template_code IS '模板编码';
COMMENT ON COLUMN system_notify_message.template_nickname IS '模版发送人名称';
COMMENT ON COLUMN system_notify_message.template_content IS '模版内容';
COMMENT ON COLUMN system_notify_message.template_type IS '模版类型';
COMMENT ON COLUMN system_notify_message.template_params IS '模版参数';
COMMENT ON COLUMN system_notify_message.read_status IS '是否已读';
COMMENT ON COLUMN system_notify_message.read_time IS '阅读时间';
COMMENT ON COLUMN system_notify_message.creator IS '创建者';
COMMENT ON COLUMN system_notify_message.create_time IS '创建时间';
COMMENT ON COLUMN system_notify_message.updater IS '更新者';
COMMENT ON COLUMN system_notify_message.update_time IS '更新时间';
COMMENT ON COLUMN system_notify_message.deleted IS '是否删除';
COMMENT ON COLUMN system_notify_message.tenant_id IS '租户编号';
COMMENT ON TABLE system_notify_message IS '站内信消息表';

-- ----------------------------
-- Records of system_notify_message
-- ----------------------------
-- @formatter:off
BEGIN;
INSERT INTO system_notify_message (id, user_id, user_type, template_id, template_code, template_nickname, template_content, template_type, template_params, read_status, read_time, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2, 1, 2, 1, 'test', '123', '我是 1，我开始 2 了', 1, '{"name":"1","what":"2"}', '1', '2025-12-15 21:24:36', '1', '2023-01-28 11:44:08', '1', '2025-12-15 21:24:36', '0', 1);
INSERT INTO system_notify_message (id, user_id, user_type, template_id, template_code, template_nickname, template_content, template_type, template_params, read_status, read_time, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3, 1, 2, 1, 'test', '123', '我是 1，我开始 2 了', 1, '{"name":"1","what":"2"}', '1', '2025-12-15 21:24:36', '1', '2023-01-28 11:45:04', '1', '2025-12-15 21:24:36', '0', 1);
INSERT INTO system_notify_message (id, user_id, user_type, template_id, template_code, template_nickname, template_content, template_type, template_params, read_status, read_time, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4, 103, 2, 2, 'register', '系统消息', '你好，欢迎 哈哈 加入大家庭！', 2, '{"name":"哈哈"}', '0', NULL, '1', '2023-01-28 21:02:20', '1', '2023-01-28 21:02:20', '0', 1);
INSERT INTO system_notify_message (id, user_id, user_type, template_id, template_code, template_nickname, template_content, template_type, template_params, read_status, read_time, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5, 1, 2, 1, 'test', '123', '我是 光何，我开始 写代码 了', 1, '{"name":"光何","what":"写代码"}', '1', '2025-12-08 17:25:28', '1', '2023-01-28 22:21:42', '1', '2025-12-08 17:25:28', '0', 1);
INSERT INTO system_notify_message (id, user_id, user_type, template_id, template_code, template_nickname, template_content, template_type, template_params, read_status, read_time, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6, 1, 2, 1, 'test', '123', '我是 光何，我开始 写代码 了', 1, '{"name":"光何","what":"写代码"}', '1', '2025-12-08 17:25:30', '1', '2023-01-28 22:22:07', '1', '2025-12-08 17:25:30', '0', 1);
INSERT INTO system_notify_message (id, user_id, user_type, template_id, template_code, template_nickname, template_content, template_type, template_params, read_status, read_time, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (7, 1, 2, 1, 'test', '123', '我是 2，我开始 3 了', 1, '{"name":"2","what":"3"}', '1', '2025-12-08 17:25:22', '1', '2023-01-28 23:45:21', '1', '2025-12-08 17:25:22', '0', 1);
INSERT INTO system_notify_message (id, user_id, user_type, template_id, template_code, template_nickname, template_content, template_type, template_params, read_status, read_time, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (8, 1, 2, 2, 'register', '系统消息', '你好，欢迎 123 加入大家庭！', 2, '{"name":"123"}', '1', '2025-12-08 16:46:01', '1', '2023-01-28 23:50:21', '1', '2025-12-08 16:46:01', '0', 1);
INSERT INTO system_notify_message (id, user_id, user_type, template_id, template_code, template_nickname, template_content, template_type, template_params, read_status, read_time, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (9, 247, 1, 4, 'brokerage_withdraw_audit_approve', 'system', '您在2023-09-28 08:35:46提现￥0.09元的申请已通过审核', 2, '{"reason":null,"createTime":"2023-09-28 08:35:46","price":"0.09"}', '0', NULL, '1', '2023-09-28 16:36:22', '1', '2023-09-28 16:36:22', '0', 1);
INSERT INTO system_notify_message (id, user_id, user_type, template_id, template_code, template_nickname, template_content, template_type, template_params, read_status, read_time, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (10, 247, 1, 4, 'brokerage_withdraw_audit_approve', 'system', '您在2023-09-30 20:59:40提现￥1.00元的申请已通过审核', 2, '{"reason":null,"createTime":"2023-09-30 20:59:40","price":"1.00"}', '0', NULL, '1', '2023-10-03 12:11:34', '1', '2023-10-03 12:11:34', '0', 1);
COMMIT;
-- @formatter:on

DROP SEQUENCE IF EXISTS system_notify_message_seq;
CREATE SEQUENCE system_notify_message_seq
    START 11;

-- ----------------------------
-- Table structure for system_notify_template
-- ----------------------------
DROP TABLE IF EXISTS system_notify_template;
CREATE TABLE system_notify_template (
    id int8 NOT NULL,
  name varchar(63) NOT NULL,
  code varchar(64) NOT NULL,
  nickname varchar(255) NOT NULL,
  content varchar(1024) NOT NULL,
  type int2 NOT NULL,
  params varchar(255) NULL DEFAULT NULL,
  status int2 NOT NULL,
  remark varchar(255) NULL DEFAULT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0
);

ALTER TABLE system_notify_template ADD CONSTRAINT pk_system_notify_template PRIMARY KEY (id);

COMMENT ON COLUMN system_notify_template.id IS '主键';
COMMENT ON COLUMN system_notify_template.name IS '模板名称';
COMMENT ON COLUMN system_notify_template.code IS '模版编码';
COMMENT ON COLUMN system_notify_template.nickname IS '发送人名称';
COMMENT ON COLUMN system_notify_template.content IS '模版内容';
COMMENT ON COLUMN system_notify_template.type IS '类型';
COMMENT ON COLUMN system_notify_template.params IS '参数数组';
COMMENT ON COLUMN system_notify_template.status IS '状态';
COMMENT ON COLUMN system_notify_template.remark IS '备注';
COMMENT ON COLUMN system_notify_template.creator IS '创建者';
COMMENT ON COLUMN system_notify_template.create_time IS '创建时间';
COMMENT ON COLUMN system_notify_template.updater IS '更新者';
COMMENT ON COLUMN system_notify_template.update_time IS '更新时间';
COMMENT ON COLUMN system_notify_template.deleted IS '是否删除';
COMMENT ON TABLE system_notify_template IS '站内信模板表';

DROP SEQUENCE IF EXISTS system_notify_template_seq;
CREATE SEQUENCE system_notify_template_seq
    START 1;

-- ----------------------------
-- Table structure for system_oauth2_access_token
-- ----------------------------
DROP TABLE IF EXISTS system_oauth2_access_token;
CREATE TABLE system_oauth2_access_token (
    id int8 NOT NULL,
  user_id int8 NOT NULL,
  user_type int2 NOT NULL,
  user_info varchar(512) NOT NULL,
  access_token varchar(255) NOT NULL,
  refresh_token varchar(32) NOT NULL,
  client_id varchar(255) NOT NULL,
  scopes varchar(255) NULL DEFAULT NULL,
  expires_time timestamp NOT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0,
  tenant_id int8 NOT NULL DEFAULT 0
);

ALTER TABLE system_oauth2_access_token ADD CONSTRAINT pk_system_oauth2_access_token PRIMARY KEY (id);

CREATE INDEX idx_system_oauth2_access_token_01 ON system_oauth2_access_token (access_token);
CREATE INDEX idx_system_oauth2_access_token_02 ON system_oauth2_access_token (refresh_token);

COMMENT ON COLUMN system_oauth2_access_token.id IS '编号';
COMMENT ON COLUMN system_oauth2_access_token.user_id IS '用户编号';
COMMENT ON COLUMN system_oauth2_access_token.user_type IS '用户类型';
COMMENT ON COLUMN system_oauth2_access_token.user_info IS '用户信息';
COMMENT ON COLUMN system_oauth2_access_token.access_token IS '访问令牌';
COMMENT ON COLUMN system_oauth2_access_token.refresh_token IS '刷新令牌';
COMMENT ON COLUMN system_oauth2_access_token.client_id IS '客户端编号';
COMMENT ON COLUMN system_oauth2_access_token.scopes IS '授权范围';
COMMENT ON COLUMN system_oauth2_access_token.expires_time IS '过期时间';
COMMENT ON COLUMN system_oauth2_access_token.creator IS '创建者';
COMMENT ON COLUMN system_oauth2_access_token.create_time IS '创建时间';
COMMENT ON COLUMN system_oauth2_access_token.updater IS '更新者';
COMMENT ON COLUMN system_oauth2_access_token.update_time IS '更新时间';
COMMENT ON COLUMN system_oauth2_access_token.deleted IS '是否删除';
COMMENT ON COLUMN system_oauth2_access_token.tenant_id IS '租户编号';
COMMENT ON TABLE system_oauth2_access_token IS 'OAuth2 访问令牌';

DROP SEQUENCE IF EXISTS system_oauth2_access_token_seq;
CREATE SEQUENCE system_oauth2_access_token_seq
    START 1;

-- ----------------------------
-- Table structure for system_oauth2_approve
-- ----------------------------
DROP TABLE IF EXISTS system_oauth2_approve;
CREATE TABLE system_oauth2_approve (
    id int8 NOT NULL,
  user_id int8 NOT NULL,
  user_type int2 NOT NULL,
  client_id varchar(255) NOT NULL,
  scope varchar(255) NOT NULL DEFAULT '',
  approved bool NOT NULL DEFAULT '0',
  expires_time timestamp NOT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0,
  tenant_id int8 NOT NULL DEFAULT 0
);

ALTER TABLE system_oauth2_approve ADD CONSTRAINT pk_system_oauth2_approve PRIMARY KEY (id);

CREATE INDEX idx_system_oauth2_approve_01 ON system_oauth2_approve (user_id, user_type, client_id);

COMMENT ON COLUMN system_oauth2_approve.id IS '编号';
COMMENT ON COLUMN system_oauth2_approve.user_id IS '用户编号';
COMMENT ON COLUMN system_oauth2_approve.user_type IS '用户类型';
COMMENT ON COLUMN system_oauth2_approve.client_id IS '客户端编号';
COMMENT ON COLUMN system_oauth2_approve.scope IS '授权范围';
COMMENT ON COLUMN system_oauth2_approve.approved IS '是否接受';
COMMENT ON COLUMN system_oauth2_approve.expires_time IS '过期时间';
COMMENT ON COLUMN system_oauth2_approve.creator IS '创建者';
COMMENT ON COLUMN system_oauth2_approve.create_time IS '创建时间';
COMMENT ON COLUMN system_oauth2_approve.updater IS '更新者';
COMMENT ON COLUMN system_oauth2_approve.update_time IS '更新时间';
COMMENT ON COLUMN system_oauth2_approve.deleted IS '是否删除';
COMMENT ON COLUMN system_oauth2_approve.tenant_id IS '租户编号';
COMMENT ON TABLE system_oauth2_approve IS 'OAuth2 批准表';

DROP SEQUENCE IF EXISTS system_oauth2_approve_seq;
CREATE SEQUENCE system_oauth2_approve_seq
    START 1;

-- ----------------------------
-- Table structure for system_oauth2_client
-- ----------------------------
DROP TABLE IF EXISTS system_oauth2_client;
CREATE TABLE system_oauth2_client (
    id int8 NOT NULL,
  client_id varchar(255) NOT NULL,
  secret varchar(255) NOT NULL,
  name varchar(255) NOT NULL,
  logo varchar(255) NOT NULL,
  description varchar(255) NULL DEFAULT NULL,
  status int2 NOT NULL,
  access_token_validity_seconds int4 NOT NULL,
  refresh_token_validity_seconds int4 NOT NULL,
  redirect_uris varchar(255) NOT NULL,
  authorized_grant_types varchar(255) NOT NULL,
  scopes varchar(255) NULL DEFAULT NULL,
  auto_approve_scopes varchar(255) NULL DEFAULT NULL,
  authorities varchar(255) NULL DEFAULT NULL,
  resource_ids varchar(255) NULL DEFAULT NULL,
  additional_information varchar(4096) NULL DEFAULT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0
);

ALTER TABLE system_oauth2_client ADD CONSTRAINT pk_system_oauth2_client PRIMARY KEY (id);

CREATE INDEX idx_system_oauth2_client_01 ON system_oauth2_client (client_id);

COMMENT ON COLUMN system_oauth2_client.id IS '编号';
COMMENT ON COLUMN system_oauth2_client.client_id IS '客户端编号';
COMMENT ON COLUMN system_oauth2_client.secret IS '客户端密钥';
COMMENT ON COLUMN system_oauth2_client.name IS '应用名';
COMMENT ON COLUMN system_oauth2_client.logo IS '应用图标';
COMMENT ON COLUMN system_oauth2_client.description IS '应用描述';
COMMENT ON COLUMN system_oauth2_client.status IS '状态';
COMMENT ON COLUMN system_oauth2_client.access_token_validity_seconds IS '访问令牌的有效期';
COMMENT ON COLUMN system_oauth2_client.refresh_token_validity_seconds IS '刷新令牌的有效期';
COMMENT ON COLUMN system_oauth2_client.redirect_uris IS '可重定向的 URI 地址';
COMMENT ON COLUMN system_oauth2_client.authorized_grant_types IS '授权类型';
COMMENT ON COLUMN system_oauth2_client.scopes IS '授权范围';
COMMENT ON COLUMN system_oauth2_client.auto_approve_scopes IS '自动通过的授权范围';
COMMENT ON COLUMN system_oauth2_client.authorities IS '权限';
COMMENT ON COLUMN system_oauth2_client.resource_ids IS '资源';
COMMENT ON COLUMN system_oauth2_client.additional_information IS '附加信息';
COMMENT ON COLUMN system_oauth2_client.creator IS '创建者';
COMMENT ON COLUMN system_oauth2_client.create_time IS '创建时间';
COMMENT ON COLUMN system_oauth2_client.updater IS '更新者';
COMMENT ON COLUMN system_oauth2_client.update_time IS '更新时间';
COMMENT ON COLUMN system_oauth2_client.deleted IS '是否删除';
COMMENT ON TABLE system_oauth2_client IS 'OAuth2 客户端表';

-- ----------------------------
-- Records of system_oauth2_client
-- ----------------------------
-- @formatter:off
BEGIN;
INSERT INTO system_oauth2_client (id, client_id, secret, name, logo, description, status, access_token_validity_seconds, refresh_token_validity_seconds, redirect_uris, authorized_grant_types, scopes, auto_approve_scopes, authorities, resource_ids, additional_information, creator, create_time, updater, update_time, deleted) VALUES (1, 'default', 'admin123', '光何', '/logo.png', '我是描述', 0, 1800, 2592000, '["https://github.com/guangheUlti/gsite","https://github.com/guangheUlti/gsite"]', '["password","authorization_code","implicit","refresh_token","client_credentials"]', '["user.read","user.write"]', '[]', '["user.read","user.write"]', '[]', '{}', '1', '2022-05-11 21:47:12', '1', '2025-12-07 20:07:09', '0');
INSERT INTO system_oauth2_client (id, client_id, secret, name, logo, description, status, access_token_validity_seconds, refresh_token_validity_seconds, redirect_uris, authorized_grant_types, scopes, auto_approve_scopes, authorities, resource_ids, additional_information, creator, create_time, updater, update_time, deleted) VALUES (40, 'test', 'test2', 'biubiu', '/logo.png', '啦啦啦啦', 0, 1800, 43200, '["https://github.com/guangheUlti/gsite"]', '["password","authorization_code","implicit"]', '["user_info","projects"]', '["user_info"]', '[]', '[]', '{}', '1', '2022-05-12 00:28:20', '1', '2025-12-27 18:04:44', '0');
INSERT INTO system_oauth2_client (id, client_id, secret, name, logo, description, status, access_token_validity_seconds, refresh_token_validity_seconds, redirect_uris, authorized_grant_types, scopes, auto_approve_scopes, authorities, resource_ids, additional_information, creator, create_time, updater, update_time, deleted) VALUES (41, 'guanghe-sso-demo-by-code', 'test', '基于授权码模式，如何实现 SSO 单点登录？', '/logo.png', NULL, 0, 1800, 43200, '["http://127.0.0.1:18080"]', '["authorization_code","refresh_token"]', '["user.read","user.write"]', '[]', '[]', '[]', NULL, '1', '2022-09-29 13:28:31', '1', '2025-05-02 18:32:30', '0');
INSERT INTO system_oauth2_client (id, client_id, secret, name, logo, description, status, access_token_validity_seconds, refresh_token_validity_seconds, redirect_uris, authorized_grant_types, scopes, auto_approve_scopes, authorities, resource_ids, additional_information, creator, create_time, updater, update_time, deleted) VALUES (42, 'guanghe-sso-demo-by-password', 'test', '基于密码模式，如何实现 SSO 单点登录？', '/logo.png', NULL, 0, 1800, 43200, '["http://127.0.0.1:18080"]', '["password","refresh_token"]', '["user.read","user.write"]', '[]', '[]', '[]', NULL, '1', '2022-10-04 17:40:16', '1', '2025-10-25 10:49:40', '0');
COMMIT;
-- @formatter:on

DROP SEQUENCE IF EXISTS system_oauth2_client_seq;
CREATE SEQUENCE system_oauth2_client_seq
    START 43;

-- ----------------------------
-- Table structure for system_oauth2_code
-- ----------------------------
DROP TABLE IF EXISTS system_oauth2_code;
CREATE TABLE system_oauth2_code (
    id int8 NOT NULL,
  user_id int8 NOT NULL,
  user_type int2 NOT NULL,
  code varchar(32) NOT NULL,
  client_id varchar(255) NOT NULL,
  scopes varchar(255) NULL DEFAULT '',
  expires_time timestamp NOT NULL,
  redirect_uri varchar(255) NULL DEFAULT NULL,
  state varchar(255) NOT NULL DEFAULT '',
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0,
  tenant_id int8 NOT NULL DEFAULT 0
);

ALTER TABLE system_oauth2_code ADD CONSTRAINT pk_system_oauth2_code PRIMARY KEY (id);

CREATE INDEX idx_system_oauth2_code_01 ON system_oauth2_code (code);

COMMENT ON COLUMN system_oauth2_code.id IS '编号';
COMMENT ON COLUMN system_oauth2_code.user_id IS '用户编号';
COMMENT ON COLUMN system_oauth2_code.user_type IS '用户类型';
COMMENT ON COLUMN system_oauth2_code.code IS '授权码';
COMMENT ON COLUMN system_oauth2_code.client_id IS '客户端编号';
COMMENT ON COLUMN system_oauth2_code.scopes IS '授权范围';
COMMENT ON COLUMN system_oauth2_code.expires_time IS '过期时间';
COMMENT ON COLUMN system_oauth2_code.redirect_uri IS '可重定向的 URI 地址';
COMMENT ON COLUMN system_oauth2_code.state IS '状态';
COMMENT ON COLUMN system_oauth2_code.creator IS '创建者';
COMMENT ON COLUMN system_oauth2_code.create_time IS '创建时间';
COMMENT ON COLUMN system_oauth2_code.updater IS '更新者';
COMMENT ON COLUMN system_oauth2_code.update_time IS '更新时间';
COMMENT ON COLUMN system_oauth2_code.deleted IS '是否删除';
COMMENT ON COLUMN system_oauth2_code.tenant_id IS '租户编号';
COMMENT ON TABLE system_oauth2_code IS 'OAuth2 授权码表';

DROP SEQUENCE IF EXISTS system_oauth2_code_seq;
CREATE SEQUENCE system_oauth2_code_seq
    START 1;

-- ----------------------------
-- Table structure for system_oauth2_refresh_token
-- ----------------------------
DROP TABLE IF EXISTS system_oauth2_refresh_token;
CREATE TABLE system_oauth2_refresh_token (
    id int8 NOT NULL,
  user_id int8 NOT NULL,
  refresh_token varchar(32) NOT NULL,
  user_type int2 NOT NULL,
  client_id varchar(255) NOT NULL,
  scopes varchar(255) NULL DEFAULT NULL,
  expires_time timestamp NOT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0,
  tenant_id int8 NOT NULL DEFAULT 0
);

ALTER TABLE system_oauth2_refresh_token ADD CONSTRAINT pk_system_oauth2_refresh_token PRIMARY KEY (id);

CREATE INDEX idx_system_oauth2_refresh_token_01 ON system_oauth2_refresh_token (refresh_token);

COMMENT ON COLUMN system_oauth2_refresh_token.id IS '编号';
COMMENT ON COLUMN system_oauth2_refresh_token.user_id IS '用户编号';
COMMENT ON COLUMN system_oauth2_refresh_token.refresh_token IS '刷新令牌';
COMMENT ON COLUMN system_oauth2_refresh_token.user_type IS '用户类型';
COMMENT ON COLUMN system_oauth2_refresh_token.client_id IS '客户端编号';
COMMENT ON COLUMN system_oauth2_refresh_token.scopes IS '授权范围';
COMMENT ON COLUMN system_oauth2_refresh_token.expires_time IS '过期时间';
COMMENT ON COLUMN system_oauth2_refresh_token.creator IS '创建者';
COMMENT ON COLUMN system_oauth2_refresh_token.create_time IS '创建时间';
COMMENT ON COLUMN system_oauth2_refresh_token.updater IS '更新者';
COMMENT ON COLUMN system_oauth2_refresh_token.update_time IS '更新时间';
COMMENT ON COLUMN system_oauth2_refresh_token.deleted IS '是否删除';
COMMENT ON COLUMN system_oauth2_refresh_token.tenant_id IS '租户编号';
COMMENT ON TABLE system_oauth2_refresh_token IS 'OAuth2 刷新令牌';

DROP SEQUENCE IF EXISTS system_oauth2_refresh_token_seq;
CREATE SEQUENCE system_oauth2_refresh_token_seq
    START 1;

-- ----------------------------
-- Table structure for system_operate_log
-- ----------------------------
DROP TABLE IF EXISTS system_operate_log;
CREATE TABLE system_operate_log (
    id int8 NOT NULL,
  trace_id varchar(64) NOT NULL DEFAULT '',
  user_id int8 NOT NULL,
  user_type int2 NOT NULL DEFAULT 0,
  type varchar(50) NOT NULL,
  sub_type varchar(50) NOT NULL,
  biz_id int8 NOT NULL,
  action varchar(2000) NOT NULL DEFAULT '',
  success bool NOT NULL DEFAULT '1',
  extra varchar(2000) NOT NULL DEFAULT '',
  request_method varchar(16) NULL DEFAULT '',
  request_url varchar(255) NULL DEFAULT '',
  user_ip varchar(50) NULL DEFAULT NULL,
  user_agent varchar(512) NULL DEFAULT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0,
  tenant_id int8 NOT NULL DEFAULT 0
);

ALTER TABLE system_operate_log ADD CONSTRAINT pk_system_operate_log PRIMARY KEY (id);

CREATE INDEX idx_system_operate_log_01 ON system_operate_log (user_id);
CREATE INDEX idx_system_operate_log_02 ON system_operate_log (create_time);

COMMENT ON COLUMN system_operate_log.id IS '日志主键';
COMMENT ON COLUMN system_operate_log.trace_id IS '链路追踪编号';
COMMENT ON COLUMN system_operate_log.user_id IS '用户编号';
COMMENT ON COLUMN system_operate_log.user_type IS '用户类型';
COMMENT ON COLUMN system_operate_log.type IS '操作模块类型';
COMMENT ON COLUMN system_operate_log.sub_type IS '操作名';
COMMENT ON COLUMN system_operate_log.biz_id IS '操作数据模块编号';
COMMENT ON COLUMN system_operate_log.action IS '操作内容';
COMMENT ON COLUMN system_operate_log.success IS '操作结果';
COMMENT ON COLUMN system_operate_log.extra IS '拓展字段';
COMMENT ON COLUMN system_operate_log.request_method IS '请求方法名';
COMMENT ON COLUMN system_operate_log.request_url IS '请求地址';
COMMENT ON COLUMN system_operate_log.user_ip IS '用户 IP';
COMMENT ON COLUMN system_operate_log.user_agent IS '浏览器 UA';
COMMENT ON COLUMN system_operate_log.creator IS '创建者';
COMMENT ON COLUMN system_operate_log.create_time IS '创建时间';
COMMENT ON COLUMN system_operate_log.updater IS '更新者';
COMMENT ON COLUMN system_operate_log.update_time IS '更新时间';
COMMENT ON COLUMN system_operate_log.deleted IS '是否删除';
COMMENT ON COLUMN system_operate_log.tenant_id IS '租户编号';
COMMENT ON TABLE system_operate_log IS '操作日志记录 V2 版本';

DROP SEQUENCE IF EXISTS system_operate_log_seq;
CREATE SEQUENCE system_operate_log_seq
    START 1;

-- ----------------------------
-- Table structure for system_post
-- ----------------------------
DROP TABLE IF EXISTS system_post;
CREATE TABLE system_post (
    id int8 NOT NULL,
  code varchar(64) NOT NULL,
  name varchar(50) NOT NULL,
  sort int4 NOT NULL,
  status int2 NOT NULL,
  remark varchar(500) NULL DEFAULT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0,
  tenant_id int8 NOT NULL DEFAULT 0
);

ALTER TABLE system_post ADD CONSTRAINT pk_system_post PRIMARY KEY (id);

COMMENT ON COLUMN system_post.id IS '岗位ID';
COMMENT ON COLUMN system_post.code IS '岗位编码';
COMMENT ON COLUMN system_post.name IS '岗位名称';
COMMENT ON COLUMN system_post.sort IS '显示顺序';
COMMENT ON COLUMN system_post.status IS '状态（0正常 1停用）';
COMMENT ON COLUMN system_post.remark IS '备注';
COMMENT ON COLUMN system_post.creator IS '创建者';
COMMENT ON COLUMN system_post.create_time IS '创建时间';
COMMENT ON COLUMN system_post.updater IS '更新者';
COMMENT ON COLUMN system_post.update_time IS '更新时间';
COMMENT ON COLUMN system_post.deleted IS '是否删除';
COMMENT ON COLUMN system_post.tenant_id IS '租户编号';
COMMENT ON TABLE system_post IS '岗位信息表';

-- ----------------------------
-- Records of system_post
-- ----------------------------
-- @formatter:off
BEGIN;
INSERT INTO system_post (id, code, name, sort, status, remark, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2, 'se', '项目经理', 2, 0, '', 'admin', '2021-01-05 17:03:48', '1', '2025-12-15 22:38:43', '0', 1);
INSERT INTO system_post (id, code, name, sort, status, remark, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4, 'user', '普通员工', 4, 0, '111222', 'admin', '2021-01-05 17:03:48', '1', '2025-03-24 21:32:40', '0', 1);
INSERT INTO system_post (id, code, name, sort, status, remark, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5, 'HR', '人力资源', 5, 0, '`', '1', '2024-03-24 20:45:40', '1', '2025-03-29 19:08:10', '0', 1);
INSERT INTO system_post (id, code, name, sort, status, remark, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (7, 'test', '测试', 10, 0, NULL, '1', '2025-09-02 08:45:57', '1', '2025-09-02 08:45:57', '0', 1);
COMMIT;
-- @formatter:on

DROP SEQUENCE IF EXISTS system_post_seq;
CREATE SEQUENCE system_post_seq
    START 8;

-- ----------------------------
-- Table structure for system_role
-- ----------------------------
DROP TABLE IF EXISTS system_role;
CREATE TABLE system_role (
    id int8 NOT NULL,
  name varchar(30) NOT NULL,
  code varchar(100) NOT NULL,
  sort int4 NOT NULL,
  data_scope int2 NOT NULL DEFAULT 1,
  data_scope_dept_ids varchar(500) NOT NULL DEFAULT '',
  status int2 NOT NULL,
  type int2 NOT NULL,
  remark varchar(500) NULL DEFAULT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0,
  tenant_id int8 NOT NULL DEFAULT 0
);

ALTER TABLE system_role ADD CONSTRAINT pk_system_role PRIMARY KEY (id);

COMMENT ON COLUMN system_role.id IS '角色ID';
COMMENT ON COLUMN system_role.name IS '角色名称';
COMMENT ON COLUMN system_role.code IS '角色权限字符串';
COMMENT ON COLUMN system_role.sort IS '显示顺序';
COMMENT ON COLUMN system_role.data_scope IS '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）';
COMMENT ON COLUMN system_role.data_scope_dept_ids IS '数据范围(指定部门数组)';
COMMENT ON COLUMN system_role.status IS '角色状态（0正常 1停用）';
COMMENT ON COLUMN system_role.type IS '角色类型';
COMMENT ON COLUMN system_role.remark IS '备注';
COMMENT ON COLUMN system_role.creator IS '创建者';
COMMENT ON COLUMN system_role.create_time IS '创建时间';
COMMENT ON COLUMN system_role.updater IS '更新者';
COMMENT ON COLUMN system_role.update_time IS '更新时间';
COMMENT ON COLUMN system_role.deleted IS '是否删除';
COMMENT ON COLUMN system_role.tenant_id IS '租户编号';
COMMENT ON TABLE system_role IS '角色信息表';

-- ----------------------------
-- Records of system_role
-- ----------------------------
-- @formatter:off
BEGIN;
INSERT INTO system_role (id, name, code, sort, data_scope, data_scope_dept_ids, status, type, remark, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1, '超级管理员', 'super_admin', 1, 1, '', 0, 1, '超级管理员', 'admin', '2021-01-05 17:03:48', '', '2022-02-22 05:08:21', '0', 1);
INSERT INTO system_role (id, name, code, sort, data_scope, data_scope_dept_ids, status, type, remark, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2, '普通角色', 'common', 2, 2, '', 0, 1, '普通角色', 'admin', '2021-01-05 17:03:48', '', '2022-02-22 05:08:20', '0', 1);
INSERT INTO system_role (id, name, code, sort, data_scope, data_scope_dept_ids, status, type, remark, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (109, '租户管理员', 'tenant_admin', 0, 1, '', 0, 1, '系统自动生成', '1', '2022-02-22 00:56:14', '1', '2022-02-22 00:56:14', '0', 121);
INSERT INTO system_role (id, name, code, sort, data_scope, data_scope_dept_ids, status, type, remark, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (111, '租户管理员', 'tenant_admin', 0, 1, '', 0, 1, '系统自动生成', '1', '2022-03-07 21:37:58', '1', '2022-03-07 21:37:58', '0', 122);
INSERT INTO system_role (id, name, code, sort, data_scope, data_scope_dept_ids, status, type, remark, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (155, '测试数据权限1', 'test-dp', 4, 2, '[112,100,102,103,104,105,107,108]', 0, 2, '1111', '1', '2025-03-31 14:58:06', '1', '2025-12-04 23:29:40', '0', 1);
COMMIT;
-- @formatter:on

DROP SEQUENCE IF EXISTS system_role_seq;
CREATE SEQUENCE system_role_seq
    START 156;

-- ----------------------------
-- Table structure for system_role_menu
-- ----------------------------
DROP TABLE IF EXISTS system_role_menu;
CREATE TABLE system_role_menu (
    id int8 NOT NULL,
  role_id int8 NOT NULL,
  menu_id int8 NOT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0,
  tenant_id int8 NOT NULL DEFAULT 0
);

ALTER TABLE system_role_menu ADD CONSTRAINT pk_system_role_menu PRIMARY KEY (id);

CREATE INDEX idx_system_role_menu_01 ON system_role_menu (role_id);

COMMENT ON COLUMN system_role_menu.id IS '自增编号';
COMMENT ON COLUMN system_role_menu.role_id IS '角色ID';
COMMENT ON COLUMN system_role_menu.menu_id IS '菜单ID';
COMMENT ON COLUMN system_role_menu.creator IS '创建者';
COMMENT ON COLUMN system_role_menu.create_time IS '创建时间';
COMMENT ON COLUMN system_role_menu.updater IS '更新者';
COMMENT ON COLUMN system_role_menu.update_time IS '更新时间';
COMMENT ON COLUMN system_role_menu.deleted IS '是否删除';
COMMENT ON COLUMN system_role_menu.tenant_id IS '租户编号';
COMMENT ON TABLE system_role_menu IS '角色和菜单关联表';

-- ----------------------------
-- Records of system_role_menu
-- ----------------------------
-- @formatter:off
BEGIN;
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (263, 109, 1, '1', '2022-02-22 00:56:14', '1', '2022-02-22 00:56:14', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (434, 2, 1, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (454, 2, 1093, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (455, 2, 1094, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (460, 2, 1100, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (467, 2, 1107, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (476, 2, 1117, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (477, 2, 100, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (478, 2, 101, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (479, 2, 102, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (480, 2, 1126, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (481, 2, 103, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (483, 2, 104, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (485, 2, 105, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (488, 2, 107, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (490, 2, 108, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (492, 2, 109, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (498, 2, 1138, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (523, 2, 1224, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (524, 2, 1225, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (541, 2, 500, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (543, 2, 501, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (675, 2, 2, '1', '2022-02-22 13:16:57', '1', '2022-02-22 13:16:57', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (689, 2, 1077, '1', '2022-02-22 13:16:57', '1', '2022-02-22 13:16:57', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (690, 2, 1078, '1', '2022-02-22 13:16:57', '1', '2022-02-22 13:16:57', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (692, 2, 1083, '1', '2022-02-22 13:16:57', '1', '2022-02-22 13:16:57', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (693, 2, 1084, '1', '2022-02-22 13:16:57', '1', '2022-02-22 13:16:57', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (699, 2, 1090, '1', '2022-02-22 13:16:57', '1', '2022-02-22 13:16:57', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (703, 2, 106, '1', '2022-02-22 13:16:57', '1', '2022-02-22 13:16:57', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (704, 2, 110, '1', '2022-02-22 13:16:57', '1', '2022-02-22 13:16:57', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (705, 2, 111, '1', '2022-02-22 13:16:57', '1', '2022-02-22 13:16:57', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (706, 2, 112, '1', '2022-02-22 13:16:57', '1', '2022-02-22 13:16:57', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (707, 2, 113, '1', '2022-02-22 13:16:57', '1', '2022-02-22 13:16:57', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1296, 110, 1, '110', '2022-02-23 00:23:55', '110', '2022-02-23 00:23:55', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1578, 111, 1, '1', '2022-03-07 21:37:58', '1', '2022-03-07 21:37:58', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1729, 109, 100, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1730, 109, 101, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1731, 109, 1063, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1732, 109, 1064, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1733, 109, 1001, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1734, 109, 1065, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1735, 109, 1002, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1736, 109, 1003, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1737, 109, 1004, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1738, 109, 1005, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1739, 109, 1006, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1740, 109, 1007, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1741, 109, 1008, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1742, 109, 1009, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1743, 109, 1010, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1744, 109, 1011, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1745, 109, 1012, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1746, 111, 100, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1747, 111, 101, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1748, 111, 1063, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1749, 111, 1064, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1750, 111, 1001, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1751, 111, 1065, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1752, 111, 1002, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1753, 111, 1003, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1754, 111, 1004, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1755, 111, 1005, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1756, 111, 1006, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1757, 111, 1007, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1758, 111, 1008, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1759, 111, 1009, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1760, 111, 1010, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1761, 111, 1011, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1762, 111, 1012, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1763, 109, 100, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1764, 109, 101, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1765, 109, 1063, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1766, 109, 1064, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1767, 109, 1001, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1768, 109, 1065, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1769, 109, 1002, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1770, 109, 1003, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1771, 109, 1004, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1772, 109, 1005, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1773, 109, 1006, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1774, 109, 1007, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1775, 109, 1008, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1776, 109, 1009, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1777, 109, 1010, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1778, 109, 1011, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1779, 109, 1012, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1780, 111, 100, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1781, 111, 101, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1782, 111, 1063, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1783, 111, 1064, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1784, 111, 1001, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1785, 111, 1065, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1786, 111, 1002, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1787, 111, 1003, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1788, 111, 1004, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1789, 111, 1005, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1790, 111, 1006, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1791, 111, 1007, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1792, 111, 1008, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1793, 111, 1009, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1794, 111, 1010, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1795, 111, 1011, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1796, 111, 1012, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1797, 109, 100, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1798, 109, 101, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1799, 109, 1063, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1800, 109, 1064, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1801, 109, 1001, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1802, 109, 1065, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1803, 109, 1002, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1804, 109, 1003, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1805, 109, 1004, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1806, 109, 1005, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1807, 109, 1006, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1808, 109, 1007, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1809, 109, 1008, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1810, 109, 1009, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1811, 109, 1010, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1812, 109, 1011, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1813, 109, 1012, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1814, 111, 100, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1815, 111, 101, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1816, 111, 1063, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1817, 111, 1064, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1818, 111, 1001, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1819, 111, 1065, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1820, 111, 1002, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1821, 111, 1003, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1822, 111, 1004, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1823, 111, 1005, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1824, 111, 1006, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1825, 111, 1007, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1826, 111, 1008, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1827, 111, 1009, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1828, 111, 1010, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1829, 111, 1011, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1830, 111, 1012, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1831, 109, 103, '1', '2022-09-21 22:43:23', '1', '2022-09-21 22:43:23', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1832, 109, 1017, '1', '2022-09-21 22:43:23', '1', '2022-09-21 22:43:23', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1833, 109, 1018, '1', '2022-09-21 22:43:23', '1', '2022-09-21 22:43:23', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1834, 109, 1019, '1', '2022-09-21 22:43:23', '1', '2022-09-21 22:43:23', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1835, 109, 1020, '1', '2022-09-21 22:43:23', '1', '2022-09-21 22:43:23', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1836, 111, 103, '1', '2022-09-21 22:43:24', '1', '2022-09-21 22:43:24', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1837, 111, 1017, '1', '2022-09-21 22:43:24', '1', '2022-09-21 22:43:24', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1838, 111, 1018, '1', '2022-09-21 22:43:24', '1', '2022-09-21 22:43:24', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1839, 111, 1019, '1', '2022-09-21 22:43:24', '1', '2022-09-21 22:43:24', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1840, 111, 1020, '1', '2022-09-21 22:43:24', '1', '2022-09-21 22:43:24', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1841, 109, 1036, '1', '2022-09-21 22:48:13', '1', '2022-09-21 22:48:13', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1842, 109, 1037, '1', '2022-09-21 22:48:13', '1', '2022-09-21 22:48:13', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1843, 109, 1038, '1', '2022-09-21 22:48:13', '1', '2022-09-21 22:48:13', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1844, 109, 1039, '1', '2022-09-21 22:48:13', '1', '2022-09-21 22:48:13', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1845, 109, 107, '1', '2022-09-21 22:48:13', '1', '2022-09-21 22:48:13', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1846, 111, 1036, '1', '2022-09-21 22:48:13', '1', '2022-09-21 22:48:13', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1847, 111, 1037, '1', '2022-09-21 22:48:13', '1', '2022-09-21 22:48:13', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1848, 111, 1038, '1', '2022-09-21 22:48:13', '1', '2022-09-21 22:48:13', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1849, 111, 1039, '1', '2022-09-21 22:48:13', '1', '2022-09-21 22:48:13', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1850, 111, 107, '1', '2022-09-21 22:48:13', '1', '2022-09-21 22:48:13', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1991, 2, 1024, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1992, 2, 1025, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1993, 2, 1026, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1994, 2, 1027, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1995, 2, 1028, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1996, 2, 1029, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1997, 2, 1030, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1998, 2, 1031, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1999, 2, 1032, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2000, 2, 1033, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2001, 2, 1034, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2002, 2, 1035, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2003, 2, 1036, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2004, 2, 1037, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2005, 2, 1038, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2006, 2, 1039, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2007, 2, 1040, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2008, 2, 1042, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2009, 2, 1043, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2010, 2, 1045, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2011, 2, 1046, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2012, 2, 1048, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2013, 2, 1050, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2014, 2, 1051, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2015, 2, 1052, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2016, 2, 1053, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2017, 2, 1054, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2018, 2, 1056, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2019, 2, 1057, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2020, 2, 1058, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2021, 2, 2083, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2022, 2, 1059, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2023, 2, 1060, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2024, 2, 1063, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2025, 2, 1064, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2026, 2, 1065, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2027, 2, 1066, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2028, 2, 1067, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2029, 2, 1070, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2034, 2, 1075, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2036, 2, 1082, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2037, 2, 1085, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2038, 2, 1086, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2039, 2, 1087, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2040, 2, 1088, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2041, 2, 1089, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2042, 2, 1091, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2043, 2, 1092, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2044, 2, 1095, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2045, 2, 1096, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2046, 2, 1097, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2047, 2, 1098, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2048, 2, 1101, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2049, 2, 1102, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2050, 2, 1103, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2051, 2, 1104, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2052, 2, 1105, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2053, 2, 1106, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2054, 2, 1108, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2055, 2, 1109, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2061, 2, 1127, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2062, 2, 1128, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2063, 2, 1129, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2064, 2, 1130, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2066, 2, 1132, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2067, 2, 1133, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2068, 2, 1134, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2069, 2, 1135, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2070, 2, 1136, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2071, 2, 1137, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2072, 2, 114, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2073, 2, 1139, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2074, 2, 115, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2075, 2, 1140, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2076, 2, 116, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2077, 2, 1141, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2078, 2, 1142, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2079, 2, 1143, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2080, 2, 1150, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2081, 2, 1161, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2082, 2, 1162, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2086, 2, 1166, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2087, 2, 1173, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2088, 2, 1174, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2092, 2, 1178, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2099, 2, 1226, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2100, 2, 1227, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2101, 2, 1228, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2102, 2, 1229, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2103, 2, 1237, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2104, 2, 1238, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2105, 2, 1239, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2106, 2, 1240, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2107, 2, 1241, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2108, 2, 1242, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2109, 2, 1243, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2116, 2, 1254, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2117, 2, 1255, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2118, 2, 1256, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2119, 2, 1257, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2120, 2, 1258, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2121, 2, 1259, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2122, 2, 1260, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2123, 2, 1261, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2124, 2, 1263, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2125, 2, 1264, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2126, 2, 1265, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2127, 2, 1266, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2128, 2, 1267, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2129, 2, 1001, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2130, 2, 1002, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2131, 2, 1003, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2132, 2, 1004, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2133, 2, 1005, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2134, 2, 1006, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2135, 2, 1007, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2136, 2, 1008, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2137, 2, 1009, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2138, 2, 1010, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2139, 2, 1011, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2140, 2, 1012, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2141, 2, 1013, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2143, 2, 1015, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2145, 2, 1017, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2146, 2, 1018, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2147, 2, 1019, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2148, 2, 1020, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2149, 2, 1021, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2150, 2, 1022, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2151, 2, 1023, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2152, 2, 1281, '1', '2023-01-25 08:42:58', '1', '2023-01-25 08:42:58', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2153, 2, 1282, '1', '2023-01-25 08:42:58', '1', '2023-01-25 08:42:58', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2154, 2, 2000, '1', '2023-01-25 08:42:58', '1', '2023-01-25 08:42:58', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2155, 2, 2002, '1', '2023-01-25 08:42:58', '1', '2023-01-25 08:42:58', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2156, 2, 2003, '1', '2023-01-25 08:42:58', '1', '2023-01-25 08:42:58', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2157, 2, 2004, '1', '2023-01-25 08:42:58', '1', '2023-01-25 08:42:58', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2158, 2, 2005, '1', '2023-01-25 08:42:58', '1', '2023-01-25 08:42:58', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2159, 2, 2006, '1', '2023-01-25 08:42:58', '1', '2023-01-25 08:42:58', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2160, 2, 2008, '1', '2023-01-25 08:42:58', '1', '2023-01-25 08:42:58', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2161, 2, 2009, '1', '2023-01-25 08:42:58', '1', '2023-01-25 08:42:58', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2162, 2, 2010, '1', '2023-01-25 08:42:58', '1', '2023-01-25 08:42:58', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2163, 2, 2011, '1', '2023-01-25 08:42:58', '1', '2023-01-25 08:42:58', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2164, 2, 2012, '1', '2023-01-25 08:42:58', '1', '2023-01-25 08:42:58', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2170, 2, 2019, '1', '2023-01-25 08:42:58', '1', '2023-01-25 08:42:58', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2171, 2, 2020, '1', '2023-01-25 08:42:58', '1', '2023-01-25 08:42:58', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2172, 2, 2021, '1', '2023-01-25 08:42:58', '1', '2023-01-25 08:42:58', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2173, 2, 2022, '1', '2023-01-25 08:42:58', '1', '2023-01-25 08:42:58', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2174, 2, 2023, '1', '2023-01-25 08:42:58', '1', '2023-01-25 08:42:58', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2175, 2, 2025, '1', '2023-01-25 08:42:58', '1', '2023-01-25 08:42:58', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2177, 2, 2027, '1', '2023-01-25 08:42:58', '1', '2023-01-25 08:42:58', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2178, 2, 2028, '1', '2023-01-25 08:42:58', '1', '2023-01-25 08:42:58', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2179, 2, 2029, '1', '2023-01-25 08:42:58', '1', '2023-01-25 08:42:58', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2180, 2, 2014, '1', '2023-01-25 08:43:12', '1', '2023-01-25 08:43:12', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2181, 2, 2015, '1', '2023-01-25 08:43:12', '1', '2023-01-25 08:43:12', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2182, 2, 2016, '1', '2023-01-25 08:43:12', '1', '2023-01-25 08:43:12', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2183, 2, 2017, '1', '2023-01-25 08:43:12', '1', '2023-01-25 08:43:12', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2184, 2, 2018, '1', '2023-01-25 08:43:12', '1', '2023-01-25 08:43:12', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2929, 109, 1224, '1', '2023-12-02 23:19:40', '1', '2023-12-02 23:19:40', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2930, 109, 1225, '1', '2023-12-02 23:19:40', '1', '2023-12-02 23:19:40', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2931, 109, 1226, '1', '2023-12-02 23:19:40', '1', '2023-12-02 23:19:40', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2932, 109, 1227, '1', '2023-12-02 23:19:40', '1', '2023-12-02 23:19:40', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2933, 109, 1228, '1', '2023-12-02 23:19:40', '1', '2023-12-02 23:19:40', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2934, 109, 1229, '1', '2023-12-02 23:19:40', '1', '2023-12-02 23:19:40', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2935, 109, 1138, '1', '2023-12-02 23:19:40', '1', '2023-12-02 23:19:40', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2936, 109, 1139, '1', '2023-12-02 23:19:40', '1', '2023-12-02 23:19:40', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2937, 109, 1140, '1', '2023-12-02 23:19:40', '1', '2023-12-02 23:19:40', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2938, 109, 1141, '1', '2023-12-02 23:19:40', '1', '2023-12-02 23:19:40', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2939, 109, 1142, '1', '2023-12-02 23:19:40', '1', '2023-12-02 23:19:40', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2940, 109, 1143, '1', '2023-12-02 23:19:40', '1', '2023-12-02 23:19:40', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2941, 111, 1224, '1', '2023-12-02 23:19:40', '1', '2023-12-02 23:19:40', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2942, 111, 1225, '1', '2023-12-02 23:19:40', '1', '2023-12-02 23:19:40', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2943, 111, 1226, '1', '2023-12-02 23:19:40', '1', '2023-12-02 23:19:40', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2944, 111, 1227, '1', '2023-12-02 23:19:40', '1', '2023-12-02 23:19:40', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2945, 111, 1228, '1', '2023-12-02 23:19:40', '1', '2023-12-02 23:19:40', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2946, 111, 1229, '1', '2023-12-02 23:19:40', '1', '2023-12-02 23:19:40', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2947, 111, 1138, '1', '2023-12-02 23:19:40', '1', '2023-12-02 23:19:40', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2948, 111, 1139, '1', '2023-12-02 23:19:40', '1', '2023-12-02 23:19:40', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2949, 111, 1140, '1', '2023-12-02 23:19:40', '1', '2023-12-02 23:19:40', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2950, 111, 1141, '1', '2023-12-02 23:19:40', '1', '2023-12-02 23:19:40', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2951, 111, 1142, '1', '2023-12-02 23:19:40', '1', '2023-12-02 23:19:40', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2952, 111, 1143, '1', '2023-12-02 23:19:40', '1', '2023-12-02 23:19:40', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2993, 109, 2, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2994, 109, 1031, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2995, 109, 1032, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2996, 109, 1033, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2997, 109, 1034, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2998, 109, 1035, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2999, 109, 1050, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3000, 109, 1051, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3001, 109, 1052, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3002, 109, 1053, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3003, 109, 1054, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3004, 109, 1056, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3005, 109, 1057, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3006, 109, 1058, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3007, 109, 1059, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3008, 109, 1060, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3009, 109, 1066, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3010, 109, 1067, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3011, 109, 1070, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3012, 109, 1075, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3014, 109, 1077, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3015, 109, 1078, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3016, 109, 1082, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3017, 109, 1083, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3018, 109, 1084, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3019, 109, 1085, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3020, 109, 1086, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3021, 109, 1087, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3022, 109, 1088, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3023, 109, 1089, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3024, 109, 1090, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3025, 109, 1091, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3026, 109, 1092, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3027, 109, 106, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3028, 109, 110, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3029, 109, 111, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3030, 109, 112, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3031, 109, 113, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3032, 109, 114, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3033, 109, 115, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3034, 109, 116, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3035, 109, 2472, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3036, 109, 2478, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3037, 109, 2479, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3038, 109, 2480, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3039, 109, 2481, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3040, 109, 2482, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3041, 109, 2483, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3042, 109, 2484, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3043, 109, 2485, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3044, 109, 2486, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3045, 109, 2487, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3046, 109, 2488, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3047, 109, 2489, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3048, 109, 2490, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3049, 109, 2491, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3050, 109, 2492, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3051, 109, 2493, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3052, 109, 2494, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3053, 109, 2495, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3054, 109, 2497, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3055, 109, 1237, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3056, 109, 1238, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3057, 109, 1239, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3058, 109, 1240, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3059, 109, 1241, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3060, 109, 1242, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3061, 109, 1243, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3062, 109, 2525, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3063, 109, 1255, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3064, 109, 1256, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3065, 109, 1257, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3066, 109, 1258, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3067, 109, 1259, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3068, 109, 1260, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3069, 111, 2, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3070, 111, 1031, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3071, 111, 1032, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3072, 111, 1033, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3073, 111, 1034, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3074, 111, 1035, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3075, 111, 1050, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3076, 111, 1051, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3077, 111, 1052, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3078, 111, 1053, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3079, 111, 1054, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3080, 111, 1056, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3081, 111, 1057, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3082, 111, 1058, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3083, 111, 1059, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3084, 111, 1060, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3085, 111, 1066, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3086, 111, 1067, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3087, 111, 1070, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3088, 111, 1075, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3090, 111, 1077, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3091, 111, 1078, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3092, 111, 1082, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3093, 111, 1083, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3094, 111, 1084, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3095, 111, 1085, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3096, 111, 1086, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3097, 111, 1087, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3098, 111, 1088, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3099, 111, 1089, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3100, 111, 1090, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3101, 111, 1091, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3102, 111, 1092, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3103, 111, 106, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3104, 111, 110, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3105, 111, 111, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3106, 111, 112, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3107, 111, 113, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3108, 111, 114, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3109, 111, 115, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3110, 111, 116, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3111, 111, 2472, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3112, 111, 2478, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3113, 111, 2479, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3114, 111, 2480, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3115, 111, 2481, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3116, 111, 2482, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3117, 111, 2483, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3118, 111, 2484, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3119, 111, 2485, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3120, 111, 2486, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3121, 111, 2487, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3122, 111, 2488, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3123, 111, 2489, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3124, 111, 2490, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3125, 111, 2491, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3126, 111, 2492, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3127, 111, 2493, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3128, 111, 2494, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3129, 111, 2495, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3130, 111, 2497, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3131, 111, 1237, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3132, 111, 1238, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3133, 111, 1239, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3134, 111, 1240, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3135, 111, 1241, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3136, 111, 1242, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3137, 111, 1243, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3138, 111, 2525, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3139, 111, 1255, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3140, 111, 1256, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3141, 111, 1257, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3142, 111, 1258, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3143, 111, 1259, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3144, 111, 1260, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3221, 109, 102, '1', '2023-12-30 11:42:36', '1', '2023-12-30 11:42:36', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3222, 109, 1013, '1', '2023-12-30 11:42:36', '1', '2023-12-30 11:42:36', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3223, 109, 1014, '1', '2023-12-30 11:42:36', '1', '2023-12-30 11:42:36', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3224, 109, 1015, '1', '2023-12-30 11:42:36', '1', '2023-12-30 11:42:36', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3225, 109, 1016, '1', '2023-12-30 11:42:36', '1', '2023-12-30 11:42:36', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3226, 111, 102, '1', '2023-12-30 11:42:36', '1', '2023-12-30 11:42:36', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3227, 111, 1013, '1', '2023-12-30 11:42:36', '1', '2023-12-30 11:42:36', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3228, 111, 1014, '1', '2023-12-30 11:42:36', '1', '2023-12-30 11:42:36', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3229, 111, 1015, '1', '2023-12-30 11:42:36', '1', '2023-12-30 11:42:36', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3230, 111, 1016, '1', '2023-12-30 11:42:36', '1', '2023-12-30 11:42:36', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5779, 2, 2739, '1', '2024-07-07 20:39:38', '1', '2024-07-07 20:39:38', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5780, 2, 2740, '1', '2024-07-07 20:39:38', '1', '2024-07-07 20:39:38', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5781, 2, 2758, '1', '2024-07-07 20:39:38', '1', '2024-07-07 20:39:38', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5782, 2, 2759, '1', '2024-07-07 20:39:38', '1', '2024-07-07 20:39:38', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5783, 2, 2362, '1', '2024-07-07 20:39:38', '1', '2024-07-07 20:39:38', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5784, 2, 2387, '1', '2024-07-07 20:39:38', '1', '2024-07-07 20:39:38', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5785, 2, 2030, '1', '2024-07-07 20:39:38', '1', '2024-07-07 20:39:38', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5789, 109, 2739, '1', '2024-07-13 22:37:24', '1', '2024-07-13 22:37:24', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5790, 109, 2740, '1', '2024-07-13 22:37:24', '1', '2024-07-13 22:37:24', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5791, 111, 2739, '1', '2024-07-13 22:37:24', '1', '2024-07-13 22:37:24', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5792, 111, 2740, '1', '2024-07-13 22:37:24', '1', '2024-07-13 22:37:24', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6053, 155, 4000, '1', '2025-04-01 13:48:26', '1', '2025-04-01 13:48:26', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6097, 155, 4050, '1', '2025-04-01 13:48:26', '1', '2025-04-01 13:48:26', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6104, 155, 4032, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6105, 155, 4033, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6106, 155, 4034, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6107, 155, 4035, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6108, 155, 4036, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6109, 155, 4037, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6110, 155, 4038, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6111, 155, 4039, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6112, 155, 4040, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6113, 155, 4041, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6114, 155, 4042, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6115, 155, 4043, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6116, 155, 4044, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6117, 155, 4045, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6119, 155, 4001, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6120, 155, 4002, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6121, 155, 4003, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6122, 155, 4004, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6123, 155, 4005, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6124, 155, 4006, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6125, 155, 4007, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6126, 155, 4008, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6127, 155, 4009, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6128, 155, 4010, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6129, 155, 4011, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6130, 155, 4012, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6131, 155, 4013, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6132, 155, 4014, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6133, 155, 4015, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6134, 155, 4016, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6135, 155, 4017, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6136, 155, 4018, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6137, 155, 4031, '1', '2025-04-01 13:49:30', '1', '2025-04-01 13:49:30', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6139, 109, 1117, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6140, 109, 1126, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6141, 109, 1127, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6142, 109, 1128, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6143, 109, 1129, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6144, 109, 1130, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6145, 109, 1132, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6146, 109, 1133, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6147, 109, 1134, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6148, 109, 1135, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6149, 109, 1136, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6150, 109, 1137, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6151, 109, 2161, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6152, 109, 1150, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6153, 109, 1161, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6154, 109, 1162, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6155, 109, 1166, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6156, 109, 1173, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6157, 109, 1174, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6158, 109, 1178, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6159, 109, 2745, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6160, 109, 2746, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6161, 109, 2747, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6162, 109, 2748, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6163, 109, 2301, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6164, 109, 2302, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6165, 109, 5011, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6166, 109, 5012, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6167, 109, 2549, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6168, 109, 2550, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6169, 109, 2551, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6170, 109, 2552, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6171, 109, 2553, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6172, 109, 2554, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6173, 109, 2555, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6174, 109, 2556, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6175, 109, 2557, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6176, 109, 2558, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6177, 109, 2559, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6178, 111, 1117, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6179, 111, 1126, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6180, 111, 1127, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6181, 111, 1128, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6182, 111, 1129, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6183, 111, 1130, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6184, 111, 1132, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6185, 111, 1133, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6186, 111, 1134, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6187, 111, 1135, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6188, 111, 1136, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6189, 111, 1137, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6190, 111, 2161, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6191, 111, 1150, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6192, 111, 1161, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6193, 111, 1162, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6194, 111, 1166, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6195, 111, 1173, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6196, 111, 1174, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6197, 111, 1178, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6198, 111, 2745, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6199, 111, 2746, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6200, 111, 2747, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6201, 111, 2748, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6202, 111, 2301, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6203, 111, 2302, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6204, 111, 5011, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6205, 111, 5012, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6206, 111, 2549, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6207, 111, 2550, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6208, 111, 2551, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6209, 111, 2552, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6210, 111, 2553, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6211, 111, 2554, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6212, 111, 2555, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6213, 111, 2556, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6214, 111, 2557, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6215, 111, 2558, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6216, 111, 2559, '1', '2025-09-06 20:52:12', '1', '2025-09-06 20:52:12', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6217, 109, 2756, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6218, 109, 2757, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6219, 109, 2262, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6220, 109, 2275, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6221, 109, 2276, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6222, 109, 2277, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6223, 109, 2281, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6224, 109, 2282, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6225, 109, 2283, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6226, 109, 2284, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6227, 109, 2285, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6228, 109, 2287, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6229, 109, 2288, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6230, 109, 2293, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6231, 109, 2294, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6232, 109, 2297, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6233, 109, 2300, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6234, 109, 2317, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6235, 109, 2318, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6236, 109, 2319, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6237, 109, 2320, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6238, 109, 2321, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6239, 109, 2322, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6240, 109, 2323, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6241, 109, 2324, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6242, 109, 2325, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6243, 109, 2326, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6244, 109, 2327, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6245, 109, 2328, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6246, 109, 2329, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6247, 109, 2330, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6248, 109, 2331, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6249, 109, 2332, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6250, 109, 2333, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6251, 109, 2334, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6252, 109, 2335, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6253, 109, 2363, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6254, 109, 2364, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6255, 111, 2756, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6256, 111, 2757, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6257, 111, 2262, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6258, 111, 2275, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6259, 111, 2276, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6260, 111, 2277, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6261, 111, 2281, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6262, 111, 2282, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6263, 111, 2283, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6264, 111, 2284, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6265, 111, 2285, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6266, 111, 2287, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6267, 111, 2288, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6268, 111, 2293, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6269, 111, 2294, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6270, 111, 2297, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6271, 111, 2300, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6272, 111, 2317, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6273, 111, 2318, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6274, 111, 2319, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6275, 111, 2320, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6276, 111, 2321, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6277, 111, 2322, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6278, 111, 2323, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6279, 111, 2324, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6280, 111, 2325, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6281, 111, 2326, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6282, 111, 2327, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6283, 111, 2328, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6284, 111, 2329, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6285, 111, 2330, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6286, 111, 2331, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6287, 111, 2332, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6288, 111, 2333, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6289, 111, 2334, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6290, 111, 2335, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6291, 111, 2363, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6292, 111, 2364, '1', '2025-09-06 20:52:25', '1', '2025-09-06 20:52:25', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6352, 1, 5720, '1', '2026-02-19 04:24:53', '1', '2026-02-19 04:24:53', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6353, 1, 5721, '1', '2026-02-19 04:24:53', '1', '2026-02-19 04:24:53', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6354, 1, 5722, '1', '2026-02-19 04:24:53', '1', '2026-02-19 04:24:53', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6355, 1, 5723, '1', '2026-02-19 04:24:53', '1', '2026-02-19 04:24:53', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6356, 1, 5724, '1', '2026-02-19 04:24:53', '1', '2026-02-19 04:24:53', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6357, 1, 5725, '1', '2026-02-19 04:24:53', '1', '2026-02-19 04:24:53', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6358, 1, 5811, '', '2026-03-30 03:11:59', '', '2026-03-30 03:11:59', '0', 0);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6359, 1, 5811, '', '2026-03-30 03:13:05', '', '2026-03-30 03:13:05', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6360, 2, 5811, '', '2026-03-30 03:13:05', '', '2026-03-30 03:13:05', '0', 1);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6362, 109, 5811, '', '2026-03-30 03:13:05', '', '2026-03-30 03:13:05', '0', 121);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6363, 111, 5811, '', '2026-03-30 03:13:05', '', '2026-03-30 03:13:05', '0', 122);
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6364, 155, 5811, '', '2026-03-30 03:13:05', '', '2026-03-30 03:13:05', '0', 1);
COMMIT;
-- @formatter:on

DROP SEQUENCE IF EXISTS system_role_menu_seq;
CREATE SEQUENCE system_role_menu_seq
    START 6365;

-- ----------------------------
-- Table structure for system_sms_channel
-- ----------------------------
DROP TABLE IF EXISTS system_sms_channel;
CREATE TABLE system_sms_channel (
    id int8 NOT NULL,
  signature varchar(12) NOT NULL,
  code varchar(63) NOT NULL,
  status int2 NOT NULL,
  remark varchar(255) NULL DEFAULT NULL,
  api_key varchar(128) NOT NULL,
  api_secret varchar(128) NULL DEFAULT NULL,
  callback_url varchar(255) NULL DEFAULT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0
);

ALTER TABLE system_sms_channel ADD CONSTRAINT pk_system_sms_channel PRIMARY KEY (id);

COMMENT ON COLUMN system_sms_channel.id IS '编号';
COMMENT ON COLUMN system_sms_channel.signature IS '短信签名';
COMMENT ON COLUMN system_sms_channel.code IS '渠道编码';
COMMENT ON COLUMN system_sms_channel.status IS '开启状态';
COMMENT ON COLUMN system_sms_channel.remark IS '备注';
COMMENT ON COLUMN system_sms_channel.api_key IS '短信 API 的账号';
COMMENT ON COLUMN system_sms_channel.api_secret IS '短信 API 的秘钥';
COMMENT ON COLUMN system_sms_channel.callback_url IS '短信发送回调 URL';
COMMENT ON COLUMN system_sms_channel.creator IS '创建者';
COMMENT ON COLUMN system_sms_channel.create_time IS '创建时间';
COMMENT ON COLUMN system_sms_channel.updater IS '更新者';
COMMENT ON COLUMN system_sms_channel.update_time IS '更新时间';
COMMENT ON COLUMN system_sms_channel.deleted IS '是否删除';
COMMENT ON TABLE system_sms_channel IS '短信渠道';

-- ----------------------------
-- Records of system_sms_channel
-- ----------------------------
-- @formatter:off
BEGIN;
INSERT INTO system_sms_channel (id, signature, code, status, remark, api_key, api_secret, callback_url, creator, create_time, updater, update_time, deleted) VALUES (2, 'Ballcat', 'ALIYUN', 0, '你要改哦，只有我可以用！！！！', 'your-aliyun-access-key-id', 'your-aliyun-access-key-secret', NULL, '', '2021-03-31 11:53:10', '1', '2024-08-04 08:53:26', '0');
INSERT INTO system_sms_channel (id, signature, code, status, remark, api_key, api_secret, callback_url, creator, create_time, updater, update_time, deleted) VALUES (4, '测试渠道', 'DEBUG_DING_TALK', 0, '123', 'your-dingtalk-webhook-access-token', 'your-dingtalk-webhook-secret', NULL, '1', '2021-04-13 00:23:14', '1', '2022-03-27 20:29:49', '0');
INSERT INTO system_sms_channel (id, signature, code, status, remark, api_key, api_secret, callback_url, creator, create_time, updater, update_time, deleted) VALUES (7, 'mock腾讯云', 'TENCENT', 0, '123', '1 2', '2 3', '', '1', '2024-09-30 08:53:45', '1', '2025-12-20 11:30:18', '0');
COMMIT;
-- @formatter:on

DROP SEQUENCE IF EXISTS system_sms_channel_seq;
CREATE SEQUENCE system_sms_channel_seq
    START 8;

-- ----------------------------
-- Table structure for system_sms_code
-- ----------------------------
DROP TABLE IF EXISTS system_sms_code;
CREATE TABLE system_sms_code (
    id int8 NOT NULL,
  mobile varchar(11) NOT NULL,
  code varchar(6) NOT NULL,
  create_ip varchar(15) NOT NULL,
  scene int2 NOT NULL,
  today_index int2 NOT NULL,
  used int2 NOT NULL,
  used_time timestamp NULL DEFAULT NULL,
  used_ip varchar(255) NULL DEFAULT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0,
  tenant_id int8 NOT NULL DEFAULT 0
);

ALTER TABLE system_sms_code ADD CONSTRAINT pk_system_sms_code PRIMARY KEY (id);

CREATE INDEX idx_system_sms_code_01 ON system_sms_code (mobile);

COMMENT ON COLUMN system_sms_code.id IS '编号';
COMMENT ON COLUMN system_sms_code.mobile IS '手机号';
COMMENT ON COLUMN system_sms_code.code IS '验证码';
COMMENT ON COLUMN system_sms_code.create_ip IS '创建 IP';
COMMENT ON COLUMN system_sms_code.scene IS '发送场景';
COMMENT ON COLUMN system_sms_code.today_index IS '今日发送的第几条';
COMMENT ON COLUMN system_sms_code.used IS '是否使用';
COMMENT ON COLUMN system_sms_code.used_time IS '使用时间';
COMMENT ON COLUMN system_sms_code.used_ip IS '使用 IP';
COMMENT ON COLUMN system_sms_code.creator IS '创建者';
COMMENT ON COLUMN system_sms_code.create_time IS '创建时间';
COMMENT ON COLUMN system_sms_code.updater IS '更新者';
COMMENT ON COLUMN system_sms_code.update_time IS '更新时间';
COMMENT ON COLUMN system_sms_code.deleted IS '是否删除';
COMMENT ON COLUMN system_sms_code.tenant_id IS '租户编号';
COMMENT ON TABLE system_sms_code IS '手机验证码';

DROP SEQUENCE IF EXISTS system_sms_code_seq;
CREATE SEQUENCE system_sms_code_seq
    START 1;

-- ----------------------------
-- Table structure for system_sms_log
-- ----------------------------
DROP TABLE IF EXISTS system_sms_log;
CREATE TABLE system_sms_log (
    id int8 NOT NULL,
  channel_id int8 NOT NULL,
  channel_code varchar(63) NOT NULL,
  template_id int8 NOT NULL,
  template_code varchar(63) NOT NULL,
  template_type int2 NOT NULL,
  template_content varchar(255) NOT NULL,
  template_params varchar(255) NOT NULL,
  api_template_id varchar(63) NOT NULL,
  mobile varchar(11) NOT NULL,
  user_id int8 NULL DEFAULT NULL,
  user_type int2 NULL DEFAULT NULL,
  send_status int2 NOT NULL DEFAULT 0,
  send_time timestamp NULL DEFAULT NULL,
  api_send_code varchar(63) NULL DEFAULT NULL,
  api_send_msg varchar(255) NULL DEFAULT NULL,
  api_request_id varchar(255) NULL DEFAULT NULL,
  api_serial_no varchar(255) NULL DEFAULT NULL,
  receive_status int2 NOT NULL DEFAULT 0,
  receive_time timestamp NULL DEFAULT NULL,
  api_receive_code varchar(63) NULL DEFAULT NULL,
  api_receive_msg varchar(255) NULL DEFAULT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0
);

ALTER TABLE system_sms_log ADD CONSTRAINT pk_system_sms_log PRIMARY KEY (id);

COMMENT ON COLUMN system_sms_log.id IS '编号';
COMMENT ON COLUMN system_sms_log.channel_id IS '短信渠道编号';
COMMENT ON COLUMN system_sms_log.channel_code IS '短信渠道编码';
COMMENT ON COLUMN system_sms_log.template_id IS '模板编号';
COMMENT ON COLUMN system_sms_log.template_code IS '模板编码';
COMMENT ON COLUMN system_sms_log.template_type IS '短信类型';
COMMENT ON COLUMN system_sms_log.template_content IS '短信内容';
COMMENT ON COLUMN system_sms_log.template_params IS '短信参数';
COMMENT ON COLUMN system_sms_log.api_template_id IS '短信 API 的模板编号';
COMMENT ON COLUMN system_sms_log.mobile IS '手机号';
COMMENT ON COLUMN system_sms_log.user_id IS '用户编号';
COMMENT ON COLUMN system_sms_log.user_type IS '用户类型';
COMMENT ON COLUMN system_sms_log.send_status IS '发送状态';
COMMENT ON COLUMN system_sms_log.send_time IS '发送时间';
COMMENT ON COLUMN system_sms_log.api_send_code IS '短信 API 发送结果的编码';
COMMENT ON COLUMN system_sms_log.api_send_msg IS '短信 API 发送失败的提示';
COMMENT ON COLUMN system_sms_log.api_request_id IS '短信 API 发送返回的唯一请求 ID';
COMMENT ON COLUMN system_sms_log.api_serial_no IS '短信 API 发送返回的序号';
COMMENT ON COLUMN system_sms_log.receive_status IS '接收状态';
COMMENT ON COLUMN system_sms_log.receive_time IS '接收时间';
COMMENT ON COLUMN system_sms_log.api_receive_code IS 'API 接收结果的编码';
COMMENT ON COLUMN system_sms_log.api_receive_msg IS 'API 接收结果的说明';
COMMENT ON COLUMN system_sms_log.creator IS '创建者';
COMMENT ON COLUMN system_sms_log.create_time IS '创建时间';
COMMENT ON COLUMN system_sms_log.updater IS '更新者';
COMMENT ON COLUMN system_sms_log.update_time IS '更新时间';
COMMENT ON COLUMN system_sms_log.deleted IS '是否删除';
COMMENT ON TABLE system_sms_log IS '短信日志';

DROP SEQUENCE IF EXISTS system_sms_log_seq;
CREATE SEQUENCE system_sms_log_seq
    START 1;

-- ----------------------------
-- Table structure for system_sms_template
-- ----------------------------
DROP TABLE IF EXISTS system_sms_template;
CREATE TABLE system_sms_template (
    id int8 NOT NULL,
  type int2 NOT NULL,
  status int2 NOT NULL,
  code varchar(63) NOT NULL,
  name varchar(63) NOT NULL,
  content varchar(255) NOT NULL,
  params varchar(255) NOT NULL,
  remark varchar(255) NULL DEFAULT NULL,
  api_template_id varchar(63) NOT NULL,
  channel_id int8 NOT NULL,
  channel_code varchar(63) NOT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0
);

ALTER TABLE system_sms_template ADD CONSTRAINT pk_system_sms_template PRIMARY KEY (id);

COMMENT ON COLUMN system_sms_template.id IS '编号';
COMMENT ON COLUMN system_sms_template.type IS '模板类型';
COMMENT ON COLUMN system_sms_template.status IS '开启状态';
COMMENT ON COLUMN system_sms_template.code IS '模板编码';
COMMENT ON COLUMN system_sms_template.name IS '模板名称';
COMMENT ON COLUMN system_sms_template.content IS '模板内容';
COMMENT ON COLUMN system_sms_template.params IS '参数数组';
COMMENT ON COLUMN system_sms_template.remark IS '备注';
COMMENT ON COLUMN system_sms_template.api_template_id IS '短信 API 的模板编号';
COMMENT ON COLUMN system_sms_template.channel_id IS '短信渠道编号';
COMMENT ON COLUMN system_sms_template.channel_code IS '短信渠道编码';
COMMENT ON COLUMN system_sms_template.creator IS '创建者';
COMMENT ON COLUMN system_sms_template.create_time IS '创建时间';
COMMENT ON COLUMN system_sms_template.updater IS '更新者';
COMMENT ON COLUMN system_sms_template.update_time IS '更新时间';
COMMENT ON COLUMN system_sms_template.deleted IS '是否删除';
COMMENT ON TABLE system_sms_template IS '短信模板';

-- ----------------------------
-- Records of system_sms_template
-- ----------------------------
-- @formatter:off
BEGIN;
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (2, 1, 0, 'test_01', '测试验证码短信', '正在进行登录操作{operation}，您的验证码是{code}', '["operation","code"]', '测试备注', '4383920', 4, 'DEBUG_DING_TALK', '', '2021-03-31 10:49:38', '1', '2024-08-18 11:57:18', '0');
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (3, 1, 0, 'test_02', '公告通知', '您的验证码{code}，该验证码5分钟内有效，请勿泄漏于他人！', '["code"]', NULL, 'SMS_207945135', 2, 'ALIYUN', '', '2021-03-31 11:56:30', '1', '2021-04-10 01:22:02', '0');
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (6, 3, 0, 'test-01', '测试模板', '哈哈哈 {name}', '["name"]', 'f哈哈哈', '4383920', 4, 'DEBUG_DING_TALK', '1', '2021-04-10 01:07:21', '1', '2024-08-18 11:57:07', '0');
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (7, 3, 0, 'test-04', '测试下', '老鸡{name}，牛逼{code}', '["name","code"]', '哈哈哈哈', 'suibian', 7, 'DEBUG_DING_TALK', '1', '2021-04-13 00:29:53', '1', '2024-09-30 00:56:24', '0');
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (8, 1, 0, 'user-sms-login', '前台用户短信登录', '您的验证码是{code}', '["code"]', NULL, '4372216', 4, 'DEBUG_DING_TALK', '1', '2021-10-11 08:10:00', '1', '2024-08-18 11:57:06', '0');
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (12, 2, 0, 'demo', '演示模板', '我就是测试一下下', '[]', NULL, 'biubiubiu', 4, 'DEBUG_DING_TALK', '1', '2022-04-10 23:22:49', '1', '2024-08-18 11:57:04', '0');
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (14, 1, 0, 'user-update-mobile', '会员用户 - 修改手机', '您的验证码{code}，该验证码 5 分钟内有效，请勿泄漏于他人！', '["code"]', '', 'null', 4, 'DEBUG_DING_TALK', '1', '2023-08-19 18:58:01', '1', '2023-08-19 11:34:04', '0');
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (15, 1, 0, 'user-update-password', '会员用户 - 修改密码', '您的验证码{code}，该验证码 5 分钟内有效，请勿泄漏于他人！', '["code"]', '', 'null', 4, 'DEBUG_DING_TALK', '1', '2023-08-19 18:58:01', '1', '2023-08-19 11:34:18', '0');
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (16, 1, 0, 'user-reset-password', '会员用户 - 重置密码', '您的验证码{code}，该验证码 5 分钟内有效，请勿泄漏于他人！', '["code"]', '', 'null', 4, 'DEBUG_DING_TALK', '1', '2023-08-19 18:58:01', '1', '2023-12-02 22:35:27', '0');
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (18, 1, 0, 'admin-reset-password', '后台用户 - 忘记密码', '您的验证码{code}，该验证码 5 分钟内有效，请勿泄漏于他人！', '["code"]', '', 'null', 4, 'DEBUG_DING_TALK', '1', '2025-03-16 14:19:34', '1', '2025-03-16 14:19:45', '0');
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (19, 1, 0, 'admin-sms-login', '后台用户短信登录', '您的验证码是{code}', '["code"]', '', '4372216', 4, 'DEBUG_DING_TALK', '1', '2025-04-08 09:36:03', '1', '2025-04-08 09:36:17', '0');
COMMIT;
-- @formatter:on

DROP SEQUENCE IF EXISTS system_sms_template_seq;
CREATE SEQUENCE system_sms_template_seq
    START 20;

-- ----------------------------
-- Table structure for system_social_client
-- ----------------------------
DROP TABLE IF EXISTS system_social_client;
CREATE TABLE system_social_client (
    id int8 NOT NULL,
  name varchar(255) NOT NULL,
  social_type int2 NOT NULL,
  user_type int2 NOT NULL,
  client_id varchar(255) NOT NULL,
  client_secret varchar(255) NOT NULL,
  agent_id varchar(255) NULL DEFAULT NULL,
  public_key varchar(2048) NULL DEFAULT NULL,
  status int2 NOT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0,
  tenant_id int8 NOT NULL DEFAULT 0
);

ALTER TABLE system_social_client ADD CONSTRAINT pk_system_social_client PRIMARY KEY (id);

COMMENT ON COLUMN system_social_client.id IS '编号';
COMMENT ON COLUMN system_social_client.name IS '应用名';
COMMENT ON COLUMN system_social_client.social_type IS '社交平台的类型';
COMMENT ON COLUMN system_social_client.user_type IS '用户类型';
COMMENT ON COLUMN system_social_client.client_id IS '客户端编号';
COMMENT ON COLUMN system_social_client.client_secret IS '客户端密钥';
COMMENT ON COLUMN system_social_client.agent_id IS '代理编号';
COMMENT ON COLUMN system_social_client.public_key IS 'publicKey 公钥';
COMMENT ON COLUMN system_social_client.status IS '状态';
COMMENT ON COLUMN system_social_client.creator IS '创建者';
COMMENT ON COLUMN system_social_client.create_time IS '创建时间';
COMMENT ON COLUMN system_social_client.updater IS '更新者';
COMMENT ON COLUMN system_social_client.update_time IS '更新时间';
COMMENT ON COLUMN system_social_client.deleted IS '是否删除';
COMMENT ON COLUMN system_social_client.tenant_id IS '租户编号';
COMMENT ON TABLE system_social_client IS '社交客户端表';

-- ----------------------------
-- Records of system_social_client
-- ----------------------------
-- @formatter:off
BEGIN;
INSERT INTO system_social_client (id, name, social_type, user_type, client_id, client_secret, agent_id, public_key, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1, '钉钉', 20, 2, '<scrubbed-dingtalk-client-id>', '<scrubbed-dingtalk-secret>', NULL, NULL, 0, '', '2023-10-18 11:21:18', '1', '2023-12-20 21:28:26', '1', 1);
INSERT INTO system_social_client (id, name, social_type, user_type, client_id, client_secret, agent_id, public_key, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2, '钉钉（王土豆）', 20, 2, 'dingtsu9hpepjkbmthhw', 'FP_bnSq_HAHKCSncmJjw5hxhnzs6vaVDSZZn3egj6rdqTQ_hu5tQVJyLMpgCakdP', NULL, NULL, 0, '', '2023-10-18 11:21:18', '', '2023-12-20 21:28:26', '1', 121);
INSERT INTO system_social_client (id, name, social_type, user_type, client_id, client_secret, agent_id, public_key, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3, '微信公众号', 31, 1, '<scrubbed-wx-mp-appid-legacy>', '<scrubbed-wx-mp-secret-legacy>', NULL, NULL, 0, '', '2023-10-18 16:07:46', '1', '2023-12-20 21:28:23', '1', 1);
INSERT INTO system_social_client (id, name, social_type, user_type, client_id, client_secret, agent_id, public_key, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (43, '微信小程序', 34, 1, '<scrubbed-wx-miniapp-appid-legacy>', '<scrubbed-wx-miniapp-secret-legacy>', NULL, NULL, 0, '', '2023-10-19 13:37:41', '1', '2023-12-20 21:28:25', '1', 1);
INSERT INTO system_social_client (id, name, social_type, user_type, client_id, client_secret, agent_id, public_key, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (44, '1', 10, 1, '2', '3', NULL, NULL, 0, '1', '2025-04-06 20:36:28', '1', '2025-04-06 20:43:12', '1', 1);
INSERT INTO system_social_client (id, name, social_type, user_type, client_id, client_secret, agent_id, public_key, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (45, '1', 10, 1, '2', '3', NULL, NULL, 1, '1', '2025-09-06 20:26:15', '1', '2025-09-06 20:27:55', '1', 1);
INSERT INTO system_social_client (id, name, social_type, user_type, client_id, client_secret, agent_id, public_key, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (46, '1', 10, 1, '2', '3', NULL, NULL, 0, '1', '2025-11-29 16:04:23', '1', '2025-11-29 16:04:26', '1', 1);
INSERT INTO system_social_client (id, name, social_type, user_type, client_id, client_secret, agent_id, public_key, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (47, '123', 10, 1, '1', '2', '3', NULL, 0, '1', '2025-12-21 10:27:02', '1', '2025-12-21 10:27:20', '1', 1);
COMMIT;
-- @formatter:on

DROP SEQUENCE IF EXISTS system_social_client_seq;
CREATE SEQUENCE system_social_client_seq
    START 48;

-- ----------------------------
-- Table structure for system_social_user
-- ----------------------------
DROP TABLE IF EXISTS system_social_user;
CREATE TABLE system_social_user (
    id int8 NOT NULL,
  type int2 NOT NULL,
  openid varchar(32) NOT NULL,
  token varchar(256) NULL DEFAULT NULL,
  raw_token_info varchar(1024) NOT NULL,
  nickname varchar(32) NOT NULL,
  avatar varchar(255) NULL DEFAULT NULL,
  raw_user_info varchar(1024) NOT NULL,
  code varchar(256) NOT NULL,
  state varchar(256) NULL DEFAULT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0,
  tenant_id int8 NOT NULL DEFAULT 0
);

ALTER TABLE system_social_user ADD CONSTRAINT pk_system_social_user PRIMARY KEY (id);

CREATE INDEX idx_system_social_user_01 ON system_social_user (type, openid);
CREATE INDEX idx_system_social_user_02 ON system_social_user (type, code, state);

COMMENT ON COLUMN system_social_user.id IS '主键(自增策略)';
COMMENT ON COLUMN system_social_user.type IS '社交平台的类型';
COMMENT ON COLUMN system_social_user.openid IS '社交 openid';
COMMENT ON COLUMN system_social_user.token IS '社交 token';
COMMENT ON COLUMN system_social_user.raw_token_info IS '原始 Token 数据，一般是 JSON 格式';
COMMENT ON COLUMN system_social_user.nickname IS '用户昵称';
COMMENT ON COLUMN system_social_user.avatar IS '用户头像';
COMMENT ON COLUMN system_social_user.raw_user_info IS '原始用户数据，一般是 JSON 格式';
COMMENT ON COLUMN system_social_user.code IS '最后一次的认证 code';
COMMENT ON COLUMN system_social_user.state IS '最后一次的认证 state';
COMMENT ON COLUMN system_social_user.creator IS '创建者';
COMMENT ON COLUMN system_social_user.create_time IS '创建时间';
COMMENT ON COLUMN system_social_user.updater IS '更新者';
COMMENT ON COLUMN system_social_user.update_time IS '更新时间';
COMMENT ON COLUMN system_social_user.deleted IS '是否删除';
COMMENT ON COLUMN system_social_user.tenant_id IS '租户编号';
COMMENT ON TABLE system_social_user IS '社交用户表';

DROP SEQUENCE IF EXISTS system_social_user_seq;
CREATE SEQUENCE system_social_user_seq
    START 1;

-- ----------------------------
-- Table structure for system_social_user_bind
-- ----------------------------
DROP TABLE IF EXISTS system_social_user_bind;
CREATE TABLE system_social_user_bind (
    id int8 NOT NULL,
  user_id int8 NOT NULL,
  user_type int2 NOT NULL,
  social_type int2 NOT NULL,
  social_user_id int8 NOT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0,
  tenant_id int8 NOT NULL DEFAULT 0
);

ALTER TABLE system_social_user_bind ADD CONSTRAINT pk_system_social_user_bind PRIMARY KEY (id);

CREATE INDEX idx_system_social_user_bind_01 ON system_social_user_bind (user_type, social_user_id);

COMMENT ON COLUMN system_social_user_bind.id IS '主键(自增策略)';
COMMENT ON COLUMN system_social_user_bind.user_id IS '用户编号';
COMMENT ON COLUMN system_social_user_bind.user_type IS '用户类型';
COMMENT ON COLUMN system_social_user_bind.social_type IS '社交平台的类型';
COMMENT ON COLUMN system_social_user_bind.social_user_id IS '社交用户的编号';
COMMENT ON COLUMN system_social_user_bind.creator IS '创建者';
COMMENT ON COLUMN system_social_user_bind.create_time IS '创建时间';
COMMENT ON COLUMN system_social_user_bind.updater IS '更新者';
COMMENT ON COLUMN system_social_user_bind.update_time IS '更新时间';
COMMENT ON COLUMN system_social_user_bind.deleted IS '是否删除';
COMMENT ON COLUMN system_social_user_bind.tenant_id IS '租户编号';
COMMENT ON TABLE system_social_user_bind IS '社交绑定表';

DROP SEQUENCE IF EXISTS system_social_user_bind_seq;
CREATE SEQUENCE system_social_user_bind_seq
    START 1;

-- ----------------------------
-- Table structure for system_tenant
-- ----------------------------
DROP TABLE IF EXISTS system_tenant;
CREATE TABLE system_tenant (
    id int8 NOT NULL,
  name varchar(30) NOT NULL,
  contact_user_id int8 NULL DEFAULT NULL,
  contact_name varchar(30) NOT NULL,
  contact_mobile varchar(500) NULL DEFAULT NULL,
  status int2 NOT NULL DEFAULT 0,
  websites varchar(1024) NULL DEFAULT '',
  package_id int8 NOT NULL,
  expire_time timestamp NOT NULL,
  account_count int4 NOT NULL,
  creator varchar(64) NOT NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0
);

ALTER TABLE system_tenant ADD CONSTRAINT pk_system_tenant PRIMARY KEY (id);

COMMENT ON COLUMN system_tenant.id IS '租户编号';
COMMENT ON COLUMN system_tenant.name IS '租户名';
COMMENT ON COLUMN system_tenant.contact_user_id IS '联系人的用户编号';
COMMENT ON COLUMN system_tenant.contact_name IS '联系人';
COMMENT ON COLUMN system_tenant.contact_mobile IS '联系手机';
COMMENT ON COLUMN system_tenant.status IS '租户状态';
COMMENT ON COLUMN system_tenant.websites IS '绑定域名数组';
COMMENT ON COLUMN system_tenant.package_id IS '租户套餐编号';
COMMENT ON COLUMN system_tenant.expire_time IS '过期时间';
COMMENT ON COLUMN system_tenant.account_count IS '账号数量';
COMMENT ON COLUMN system_tenant.creator IS '创建者';
COMMENT ON COLUMN system_tenant.create_time IS '创建时间';
COMMENT ON COLUMN system_tenant.updater IS '更新者';
COMMENT ON COLUMN system_tenant.update_time IS '更新时间';
COMMENT ON COLUMN system_tenant.deleted IS '是否删除';
COMMENT ON TABLE system_tenant IS '租户表';

-- ----------------------------
-- Records of system_tenant
-- ----------------------------
-- @formatter:off
BEGIN;
INSERT INTO system_tenant (id, name, contact_user_id, contact_name, contact_mobile, status, websites, package_id, expire_time, account_count, creator, create_time, updater, update_time, deleted) VALUES (1, '光何', NULL, '光何', '17321315478', 0, '127.0.0.1:3000', 0, '2099-02-19 17:14:16', 9999, '1', '2021-01-05 17:03:47', '1', '2025-08-19 05:18:41', '0');
INSERT INTO system_tenant (id, name, contact_user_id, contact_name, contact_mobile, status, websites, package_id, expire_time, account_count, creator, create_time, updater, update_time, deleted) VALUES (121, '小租户', 110, '小王2', '15601691300', 0, '', 111, '2026-07-10 00:00:00', 30, '1', '2022-02-22 00:56:14', '1', '2025-08-19 21:19:29', '0');
INSERT INTO system_tenant (id, name, contact_user_id, contact_name, contact_mobile, status, websites, package_id, expire_time, account_count, creator, create_time, updater, update_time, deleted) VALUES (122, '测试租户', 113, '光何', '15601691300', 0, '', 111, '2023-04-29 00:00:00', 50, '1', '2022-03-07 21:37:58', '1', '2025-12-21 09:50:00', '0');
COMMIT;
-- @formatter:on

DROP SEQUENCE IF EXISTS system_tenant_seq;
CREATE SEQUENCE system_tenant_seq
    START 123;

-- ----------------------------
-- Table structure for system_tenant_package
-- ----------------------------
DROP TABLE IF EXISTS system_tenant_package;
CREATE TABLE system_tenant_package (
    id int8 NOT NULL,
  name varchar(30) NOT NULL,
  status int2 NOT NULL DEFAULT 0,
  remark varchar(256) NULL DEFAULT '',
  menu_ids varchar(4096) NOT NULL,
  creator varchar(64) NOT NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0
);

ALTER TABLE system_tenant_package ADD CONSTRAINT pk_system_tenant_package PRIMARY KEY (id);

COMMENT ON COLUMN system_tenant_package.id IS '套餐编号';
COMMENT ON COLUMN system_tenant_package.name IS '套餐名';
COMMENT ON COLUMN system_tenant_package.status IS '租户状态（0正常 1停用）';
COMMENT ON COLUMN system_tenant_package.remark IS '备注';
COMMENT ON COLUMN system_tenant_package.menu_ids IS '关联的菜单编号';
COMMENT ON COLUMN system_tenant_package.creator IS '创建者';
COMMENT ON COLUMN system_tenant_package.create_time IS '创建时间';
COMMENT ON COLUMN system_tenant_package.updater IS '更新者';
COMMENT ON COLUMN system_tenant_package.update_time IS '更新时间';
COMMENT ON COLUMN system_tenant_package.deleted IS '是否删除';
COMMENT ON TABLE system_tenant_package IS '租户套餐表';

-- ----------------------------
-- Records of system_tenant_package
-- ----------------------------
-- @formatter:off
BEGIN;
INSERT INTO system_tenant_package (id, name, status, remark, menu_ids, creator, create_time, updater, update_time, deleted) VALUES (111, '普通套餐', 0, '小功能', '[1,2,5,1031,1032,1033,1034,1035,1036,1037,1038,1039,1050,1051,1052,1053,1054,1056,1057,1058,1059,1060,1063,1064,1065,1066,1067,1070,1075,1077,1078,1082,1083,1084,1085,1086,1087,1088,1089,1090,1091,1092,1117,1118,1119,1120,100,101,102,1126,103,1127,1128,1129,106,1130,107,1132,1133,110,1134,111,1135,112,1136,113,1137,2161,114,1138,1139,115,1140,116,1141,1142,1143,1150,1161,1162,1166,1173,1174,2713,2714,1178,2715,2716,2717,2718,2720,2721,1185,2722,1186,1187,2723,1188,2724,1189,2725,1190,2726,1191,2727,1192,2728,2729,1193,1194,2730,1195,2731,2732,1197,2733,1198,2734,1199,2735,1200,1201,1202,2739,2740,1207,1208,1209,2745,1210,2746,1211,2747,1212,2748,1213,1215,1216,1217,1218,1219,1220,2756,1221,2757,1222,1224,1225,1226,1227,1228,1229,1237,1238,2262,1239,1240,1241,1242,1243,2275,2276,2277,1255,1256,1257,2281,1258,2282,1259,2283,1260,2284,2285,2287,2288,2293,2294,2297,2300,2301,2302,2317,2318,2319,2320,2321,2322,2323,2324,2325,2326,2327,2328,2329,2330,2331,2332,2333,2334,2335,2363,2364,5011,5012,2472,2478,2479,2480,2481,2482,2483,2484,2485,2486,2487,2488,2489,2490,2491,2492,2493,2494,2495,2497,2525,1001,1002,1003,1004,1005,1006,1007,1008,1009,1010,1011,1012,1013,2549,1014,2550,1015,2551,1016,2552,1017,2553,1018,2554,1019,2555,1020,2556,2557,2558,2559]', '1', '2022-02-22 00:54:00', '1', '2025-09-06 20:52:25', '0');
COMMIT;
-- @formatter:on

DROP SEQUENCE IF EXISTS system_tenant_package_seq;
CREATE SEQUENCE system_tenant_package_seq
    START 112;

-- ----------------------------
-- Table structure for system_user_post
-- ----------------------------
DROP TABLE IF EXISTS system_user_post;
CREATE TABLE system_user_post (
    id int8 NOT NULL,
  user_id int8 NOT NULL DEFAULT 0,
  post_id int8 NOT NULL DEFAULT 0,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0,
  tenant_id int8 NOT NULL DEFAULT 0
);

ALTER TABLE system_user_post ADD CONSTRAINT pk_system_user_post PRIMARY KEY (id);

COMMENT ON COLUMN system_user_post.id IS 'id';
COMMENT ON COLUMN system_user_post.user_id IS '用户ID';
COMMENT ON COLUMN system_user_post.post_id IS '岗位ID';
COMMENT ON COLUMN system_user_post.creator IS '创建者';
COMMENT ON COLUMN system_user_post.create_time IS '创建时间';
COMMENT ON COLUMN system_user_post.updater IS '更新者';
COMMENT ON COLUMN system_user_post.update_time IS '更新时间';
COMMENT ON COLUMN system_user_post.deleted IS '是否删除';
COMMENT ON COLUMN system_user_post.tenant_id IS '租户编号';
COMMENT ON TABLE system_user_post IS '用户岗位表';

-- ----------------------------
-- Records of system_user_post
-- ----------------------------
-- @formatter:off
BEGIN;
INSERT INTO system_user_post (id, user_id, post_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (112, 1, 1, 'admin', '2022-05-02 07:25:24', 'admin', '2022-05-02 07:25:24', '0', 1);
INSERT INTO system_user_post (id, user_id, post_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (113, 100, 1, 'admin', '2022-05-02 07:25:24', 'admin', '2022-05-02 07:25:24', '0', 1);
INSERT INTO system_user_post (id, user_id, post_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (115, 104, 1, '1', '2022-05-16 19:36:28', '1', '2022-05-16 19:36:28', '0', 1);
INSERT INTO system_user_post (id, user_id, post_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (116, 117, 2, '1', '2022-07-09 17:40:26', '1', '2022-07-09 17:40:26', '0', 1);
INSERT INTO system_user_post (id, user_id, post_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (117, 118, 1, '1', '2022-07-09 17:44:44', '1', '2022-07-09 17:44:44', '0', 1);
INSERT INTO system_user_post (id, user_id, post_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (119, 114, 5, '1', '2024-03-24 20:45:51', '1', '2024-03-24 20:45:51', '0', 1);
INSERT INTO system_user_post (id, user_id, post_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (125, 1, 2, '1', '2024-07-13 22:31:39', '1', '2024-07-13 22:31:39', '0', 1);
INSERT INTO system_user_post (id, user_id, post_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (128, 139, 2, '1', '2025-12-05 21:43:27', '1', '2025-12-05 21:43:27', '0', 1);
INSERT INTO system_user_post (id, user_id, post_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (129, 139, 4, '1', '2025-12-05 21:43:27', '1', '2025-12-05 21:43:27', '0', 1);
COMMIT;
-- @formatter:on

DROP SEQUENCE IF EXISTS system_user_post_seq;
CREATE SEQUENCE system_user_post_seq
    START 130;

-- ----------------------------
-- Table structure for system_user_role
-- ----------------------------
DROP TABLE IF EXISTS system_user_role;
CREATE TABLE system_user_role (
    id int8 NOT NULL,
  user_id int8 NOT NULL,
  role_id int8 NOT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0,
  tenant_id int8 NOT NULL DEFAULT 0
);

ALTER TABLE system_user_role ADD CONSTRAINT pk_system_user_role PRIMARY KEY (id);

CREATE INDEX idx_system_user_role_01 ON system_user_role (user_id);

COMMENT ON COLUMN system_user_role.id IS '自增编号';
COMMENT ON COLUMN system_user_role.user_id IS '用户ID';
COMMENT ON COLUMN system_user_role.role_id IS '角色ID';
COMMENT ON COLUMN system_user_role.creator IS '创建者';
COMMENT ON COLUMN system_user_role.create_time IS '创建时间';
COMMENT ON COLUMN system_user_role.updater IS '更新者';
COMMENT ON COLUMN system_user_role.update_time IS '更新时间';
COMMENT ON COLUMN system_user_role.deleted IS '是否删除';
COMMENT ON COLUMN system_user_role.tenant_id IS '租户编号';
COMMENT ON TABLE system_user_role IS '用户和角色关联表';

-- ----------------------------
-- Records of system_user_role
-- ----------------------------
-- @formatter:off
BEGIN;
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1, 1, 1, '', '2022-01-11 13:19:45', '', '2022-05-12 12:35:17', '0', 1);
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2, 2, 2, '', '2022-01-11 13:19:45', '', '2022-05-12 12:35:13', '0', 1);
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5, 100, 1, '', '2022-01-11 13:19:45', '', '2022-05-12 12:35:12', '0', 1);
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6, 100, 2, '', '2022-01-11 13:19:45', '', '2022-05-12 12:35:11', '0', 1);
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (14, 110, 109, '1', '2022-02-22 00:56:14', '1', '2022-02-22 00:56:14', '0', 121);
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (15, 111, 110, '110', '2022-02-23 13:14:38', '110', '2022-02-23 13:14:38', '0', 121);
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (18, 1, 2, '1', '2022-05-12 20:39:29', '1', '2022-05-12 20:39:29', '0', 1);
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (35, 112, 1, '1', '2024-03-15 20:00:24', '1', '2024-03-15 20:00:24', '0', 1);
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (36, 118, 1, '1', '2024-03-17 09:12:08', '1', '2024-03-17 09:12:08', '0', 1);
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (46, 117, 1, '1', '2024-10-02 10:16:11', '1', '2024-10-02 10:16:11', '0', 1);
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (47, 104, 2, '1', '2025-01-04 10:40:33', '1', '2025-01-04 10:40:33', '0', 1);
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (48, 100, 155, '1', '2025-04-04 10:41:14', '1', '2025-04-04 10:41:14', '0', 1);
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (49, 142, 1, '1', '2025-07-23 09:11:42', '1', '2025-07-23 09:11:42', '0', 1);
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (50, 142, 2, '1', '2025-10-07 20:50:37', '1', '2025-10-07 20:50:37', '0', 1);
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (51, 139, 1, '1', '2025-12-05 22:36:57', '1', '2025-12-05 22:36:57', '0', 1);
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (52, 139, 2, '1', '2025-12-05 22:37:00', '1', '2025-12-05 22:37:00', '0', 1);
COMMIT;
-- @formatter:on

DROP SEQUENCE IF EXISTS system_user_role_seq;
CREATE SEQUENCE system_user_role_seq
    START 55;

-- ----------------------------
-- Table structure for system_users
-- ----------------------------
DROP TABLE IF EXISTS system_users;
CREATE TABLE system_users (
    id int8 NOT NULL,
  username varchar(30) NOT NULL,
  password varchar(100) NOT NULL DEFAULT '',
  nickname varchar(30) NOT NULL,
  remark varchar(500) NULL DEFAULT NULL,
  dept_id int8 NULL DEFAULT NULL,
  post_ids varchar(255) NULL DEFAULT NULL,
  email varchar(50) NULL DEFAULT '',
  mobile varchar(11) NULL DEFAULT '',
  sex int2 NULL DEFAULT 0,
  avatar varchar(512) NULL DEFAULT '',
  status int2 NOT NULL DEFAULT 0,
  login_ip varchar(50) NULL DEFAULT '',
  login_date timestamp NULL DEFAULT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0,
  tenant_id int8 NOT NULL DEFAULT 0
);

ALTER TABLE system_users ADD CONSTRAINT pk_system_users PRIMARY KEY (id);

CREATE INDEX idx_system_users_01 ON system_users (username);
CREATE INDEX idx_system_users_02 ON system_users (mobile);
CREATE INDEX idx_system_users_03 ON system_users (email);
CREATE INDEX idx_system_users_04 ON system_users (dept_id);

COMMENT ON COLUMN system_users.id IS '用户ID';
COMMENT ON COLUMN system_users.username IS '用户账号';
COMMENT ON COLUMN system_users.password IS '密码';
COMMENT ON COLUMN system_users.nickname IS '用户昵称';
COMMENT ON COLUMN system_users.remark IS '备注';
COMMENT ON COLUMN system_users.dept_id IS '部门ID';
COMMENT ON COLUMN system_users.post_ids IS '岗位编号数组';
COMMENT ON COLUMN system_users.email IS '用户邮箱';
COMMENT ON COLUMN system_users.mobile IS '手机号码';
COMMENT ON COLUMN system_users.sex IS '用户性别';
COMMENT ON COLUMN system_users.avatar IS '头像地址';
COMMENT ON COLUMN system_users.status IS '帐号状态（0正常 1停用）';
COMMENT ON COLUMN system_users.login_ip IS '最后登录IP';
COMMENT ON COLUMN system_users.login_date IS '最后登录时间';
COMMENT ON COLUMN system_users.creator IS '创建者';
COMMENT ON COLUMN system_users.create_time IS '创建时间';
COMMENT ON COLUMN system_users.updater IS '更新者';
COMMENT ON COLUMN system_users.update_time IS '更新时间';
COMMENT ON COLUMN system_users.deleted IS '是否删除';
COMMENT ON COLUMN system_users.tenant_id IS '租户编号';
COMMENT ON TABLE system_users IS '用户信息表';

-- ----------------------------
-- Records of system_users
-- ----------------------------
-- @formatter:off
BEGIN;
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1, 'admin', '$2a$04$vlw8UX2rAtD5E24PSD1zbec8ON6QE4UzjEk8tdSoyaBnXhUmiK/pu', '光何', '管理员', 103, '[1,2]', '18903378092@163.com', '18818260272', 1, NULL, 0, '0:0:0:0:0:0:0:1', '2026-04-17 08:47:40', 'admin', '2021-01-05 17:03:47', NULL, '2026-04-17 08:47:40', '0', 1);
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (100, 'guanghe', '$2a$04$UEHS4wOH/P/1wSEzwQSwWOC7C3Dg1LZwqHFBTB5jL2WnSRSWK4mca', '光何', '不要吓我', 104, '[1]', 'guanghe@example.com', '15601691300', 1, NULL, 0, '0:0:0:0:0:0:0:1', '2025-12-15 21:47:26', '', '2021-01-07 09:07:17', NULL, '2025-12-15 21:47:26', '0', 1);
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (104, 'test', '$2a$04$2OaMD47grEy5aesBSoC9DOrYxok0mVEhR7DI/l/VWyLkrS6czhFlO', '测试号', NULL, 107, '[1,2]', '111@qq.com', '15601691200', 1, NULL, 0, '0:0:0:0:0:0:0:1', '2026-01-04 18:09:54', '', '2021-01-21 02:13:53', NULL, '2026-01-04 18:09:54', '0', 1);
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (107, 'admin107', '$2a$10$dYOOBKMO93v/.ReCqzyFg.o67Tqk.bbc2bhrpyBGkIw9aypCtr2pm', '光何', NULL, NULL, NULL, '', '15601691300', 0, NULL, 0, '', NULL, '1', '2022-02-20 22:59:33', '1', '2025-04-21 14:23:08', '0', 118);
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (108, 'admin108', '$2a$10$y6mfvKoNYL1GXWak8nYwVOH.kCWqjactkzdoIDgiKl93WN3Ejg.Lu', '光何', NULL, NULL, NULL, '', '15601691300', 0, NULL, 0, '', NULL, '1', '2022-02-20 23:00:50', '1', '2025-04-21 14:23:08', '0', 119);
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (109, 'admin109', '$2a$10$JAqvH0tEc0I7dfDVBI7zyuB4E3j.uH6daIjV53.vUS6PknFkDJkuK', '光何', NULL, NULL, NULL, '', '15601691300', 0, NULL, 0, '', NULL, '1', '2022-02-20 23:11:50', '1', '2025-04-21 14:23:08', '0', 120);
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (110, 'admin110', '$2a$10$mRMIYLDtRHlf6.9ipiqH1.Z.bh/R9dO9d5iHiGYPigi6r5KOoR2Wm', '小王', NULL, NULL, NULL, '', '15601691300', 0, NULL, 0, '0:0:0:0:0:0:0:1', '2024-07-20 22:23:17', '1', '2022-02-22 00:56:14', NULL, '2025-04-21 14:23:08', '0', 121);
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (111, 'test', '$2a$04$2OaMD47grEy5aesBSoC9DOrYxok0mVEhR7DI/l/VWyLkrS6czhFlO', '测试用户', NULL, NULL, '[]', '', '', 0, NULL, 0, '0:0:0:0:0:0:0:1', '2023-12-30 11:42:17', '110', '2022-02-23 13:14:33', NULL, '2025-04-21 14:23:08', '0', 121);
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (112, 'newobject', '$2a$04$dB0z8Q819fJWz0hbaLe6B.VfHCjYgWx6LFfET5lyz3JwcqlyCkQ4C', '新对象', NULL, 100, '[]', '', '15601691235', 1, NULL, 0, '0:0:0:0:0:0:0:1', '2024-03-16 23:11:38', '1', '2022-02-23 19:08:03', NULL, '2025-04-21 14:23:08', '0', 1);
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (117, 'admin123', '$2a$04$sEtimsHu9YCkYY4/oqElHem2Ijc9ld20eYO6lN.g/21NfLUTDLB9W', '测试号02', '1111', 100, '[2]', '', '15601691234', 1, NULL, 0, '0:0:0:0:0:0:0:1', '2024-10-02 10:16:20', '1', '2022-07-09 17:40:26', '1', '2025-05-14 09:56:04', '0', 1);
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (118, 'goudan', '$2a$04$3suGZjnA6rM5bErf38u1felbgqbsPHGdRG3l9NkxPCEt2ah9Y6aJi', '狗蛋', NULL, 103, '[1]', '', '15601691239', 1, NULL, 0, '0:0:0:0:0:0:0:1', '2025-11-23 15:28:25', '1', '2022-07-09 17:44:43', NULL, '2025-11-23 15:28:25', '0', 1);
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (139, 'wwbwwb', '$2a$04$FJLIyg8lbPytP29pbZaiU.LesJvCsYfEaHqQfB0pGQhK3e9BeZmLy', '小秃头', '123', 108, '[2,4]', '', '', 1, NULL, 0, '0:0:0:0:0:0:0:1', '2024-09-10 21:03:58', NULL, '2024-09-10 21:03:58', '1', '2025-12-15 22:38:15', '0', 1);
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (141, 'admin1', '$2a$04$oj6F6d7HrZ70kYVD3TNzEu.m3TPUzajOVuC66zdKna8KRerK1FmVa', '新用户', NULL, NULL, NULL, '', '', 0, '', 0, '0:0:0:0:0:0:0:1', '2025-04-08 13:09:07', '1', '2025-04-08 13:09:07', '1', '2025-05-14 19:11:48', '0', 1);
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (142, 'test01', '$2a$04$4bCYWZkjxxOC4QE0LY2M9uEEKWeJbLfs489NFtQoyidL5I0FndRaO', 'test01', '', NULL, '[]', '', '19021719925', 1, '', 0, '0:0:0:0:0:0:0:1', '2025-07-29 19:47:17', '1', '2025-07-09 21:07:10', NULL, '2025-12-02 13:23:11', '0', 1);
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (143, 'a00001', '$2a$04$GhVHFviOw/SsTmiQtifHJesDYFlHMeGK7OWh7aGCCjGGVCmbHVAwa', 'a00001', NULL, 104, NULL, '', '', 0, '', 0, '0:0:0:0:0:0:0:1', '2025-12-01 16:10:13', NULL, '2025-12-01 16:10:13', '1', '2025-12-05 21:34:05', '0', 1);
COMMIT;
-- @formatter:on

DROP SEQUENCE IF EXISTS system_users_seq;
CREATE SEQUENCE system_users_seq
    START 145;

-- ----------------------------
-- Table structure for guanghe_demo01_contact
-- ----------------------------
DROP TABLE IF EXISTS guanghe_demo01_contact;
CREATE TABLE guanghe_demo01_contact (
    id int8 NOT NULL,
  name varchar(100) NOT NULL DEFAULT '',
  sex int2 NOT NULL,
  birthday timestamp NOT NULL,
  description varchar(255) NOT NULL,
  avatar varchar(512) NULL DEFAULT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0,
  tenant_id int8 NOT NULL DEFAULT 0
);

ALTER TABLE guanghe_demo01_contact ADD CONSTRAINT pk_guanghe_demo01_contact PRIMARY KEY (id);

COMMENT ON COLUMN guanghe_demo01_contact.id IS '编号';
COMMENT ON COLUMN guanghe_demo01_contact.name IS '名字';
COMMENT ON COLUMN guanghe_demo01_contact.sex IS '性别';
COMMENT ON COLUMN guanghe_demo01_contact.birthday IS '出生年';
COMMENT ON COLUMN guanghe_demo01_contact.description IS '简介';
COMMENT ON COLUMN guanghe_demo01_contact.avatar IS '头像';
COMMENT ON COLUMN guanghe_demo01_contact.creator IS '创建者';
COMMENT ON COLUMN guanghe_demo01_contact.create_time IS '创建时间';
COMMENT ON COLUMN guanghe_demo01_contact.updater IS '更新者';
COMMENT ON COLUMN guanghe_demo01_contact.update_time IS '更新时间';
COMMENT ON COLUMN guanghe_demo01_contact.deleted IS '是否删除';
COMMENT ON COLUMN guanghe_demo01_contact.tenant_id IS '租户编号';
COMMENT ON TABLE guanghe_demo01_contact IS '示例联系人表';

-- ----------------------------
-- Records of guanghe_demo01_contact
-- ----------------------------
-- @formatter:off
BEGIN;
INSERT INTO guanghe_demo01_contact (id, name, sex, birthday, description, avatar, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1, '土豆', 2, '2023-11-07 00:00:00', '<p>天蚕土豆！呀</p>', 'http://127.0.0.1:2000/admin-api/infra/file/4/get/46f8fa1a37db3f3960d8910ff2fe3962ab3b2db87cf2f8ccb4dc8145b8bdf237.jpeg', '1', '2023-11-15 23:34:30', '1', '2023-11-15 23:47:39', '0', 1);
COMMIT;
-- @formatter:on

DROP SEQUENCE IF EXISTS guanghe_demo01_contact_seq;
CREATE SEQUENCE guanghe_demo01_contact_seq
    START 2;

-- ----------------------------
-- Table structure for guanghe_demo02_category
-- ----------------------------
DROP TABLE IF EXISTS guanghe_demo02_category;
CREATE TABLE guanghe_demo02_category (
    id int8 NOT NULL,
  name varchar(100) NOT NULL DEFAULT '',
  parent_id int8 NOT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0,
  tenant_id int8 NOT NULL DEFAULT 0
);

ALTER TABLE guanghe_demo02_category ADD CONSTRAINT pk_guanghe_demo02_category PRIMARY KEY (id);

COMMENT ON COLUMN guanghe_demo02_category.id IS '编号';
COMMENT ON COLUMN guanghe_demo02_category.name IS '名字';
COMMENT ON COLUMN guanghe_demo02_category.parent_id IS '父级编号';
COMMENT ON COLUMN guanghe_demo02_category.creator IS '创建者';
COMMENT ON COLUMN guanghe_demo02_category.create_time IS '创建时间';
COMMENT ON COLUMN guanghe_demo02_category.updater IS '更新者';
COMMENT ON COLUMN guanghe_demo02_category.update_time IS '更新时间';
COMMENT ON COLUMN guanghe_demo02_category.deleted IS '是否删除';
COMMENT ON COLUMN guanghe_demo02_category.tenant_id IS '租户编号';
COMMENT ON TABLE guanghe_demo02_category IS '示例分类表';

-- ----------------------------
-- Records of guanghe_demo02_category
-- ----------------------------
-- @formatter:off
BEGIN;
INSERT INTO guanghe_demo02_category (id, name, parent_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1, '土豆', 0, '1', '2023-11-15 23:34:30', '1', '2023-11-16 20:24:23', '0', 1);
INSERT INTO guanghe_demo02_category (id, name, parent_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2, '番茄', 0, '1', '2023-11-16 20:24:00', '1', '2023-11-16 20:24:15', '0', 1);
INSERT INTO guanghe_demo02_category (id, name, parent_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3, '怪怪', 0, '1', '2023-11-16 20:24:32', '1', '2023-11-16 20:24:32', '0', 1);
INSERT INTO guanghe_demo02_category (id, name, parent_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4, '小番茄', 2, '1', '2023-11-16 20:24:39', '1', '2023-11-16 20:24:39', '0', 1);
INSERT INTO guanghe_demo02_category (id, name, parent_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5, '大番茄', 2, '1', '2023-11-16 20:24:46', '1', '2023-11-16 20:24:46', '0', 1);
INSERT INTO guanghe_demo02_category (id, name, parent_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6, '11', 3, '1', '2023-11-24 19:29:34', '1', '2023-11-24 19:29:34', '0', 1);
INSERT INTO guanghe_demo02_category (id, name, parent_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (7, '1', 0, '1', '2025-10-01 09:19:20', '1', '2025-10-01 09:19:20', '0', 1);
COMMIT;
-- @formatter:on

DROP SEQUENCE IF EXISTS guanghe_demo02_category_seq;
CREATE SEQUENCE guanghe_demo02_category_seq
    START 8;

-- ----------------------------
-- Table structure for guanghe_demo03_course
-- ----------------------------
DROP TABLE IF EXISTS guanghe_demo03_course;
CREATE TABLE guanghe_demo03_course (
    id int8 NOT NULL,
  student_id int8 NOT NULL,
  name varchar(100) NOT NULL DEFAULT '',
  score int2 NOT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0,
  tenant_id int8 NOT NULL DEFAULT 0
);

ALTER TABLE guanghe_demo03_course ADD CONSTRAINT pk_guanghe_demo03_course PRIMARY KEY (id);

COMMENT ON COLUMN guanghe_demo03_course.id IS '编号';
COMMENT ON COLUMN guanghe_demo03_course.student_id IS '学生编号';
COMMENT ON COLUMN guanghe_demo03_course.name IS '名字';
COMMENT ON COLUMN guanghe_demo03_course.score IS '分数';
COMMENT ON COLUMN guanghe_demo03_course.creator IS '创建者';
COMMENT ON COLUMN guanghe_demo03_course.create_time IS '创建时间';
COMMENT ON COLUMN guanghe_demo03_course.updater IS '更新者';
COMMENT ON COLUMN guanghe_demo03_course.update_time IS '更新时间';
COMMENT ON COLUMN guanghe_demo03_course.deleted IS '是否删除';
COMMENT ON COLUMN guanghe_demo03_course.tenant_id IS '租户编号';
COMMENT ON TABLE guanghe_demo03_course IS '学生课程表';

-- ----------------------------
-- Records of guanghe_demo03_course
-- ----------------------------
-- @formatter:off
BEGIN;
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2, 2, '语文', 66, '1', '2023-11-16 23:21:49', '1', '2024-09-17 10:55:30', '1', 1);
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3, 2, '数学', 22, '1', '2023-11-16 23:21:49', '1', '2024-09-17 10:55:30', '1', 1);
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6, 5, '体育', 23, '1', '2023-11-16 23:22:46', '1', '2023-11-16 15:44:40', '1', 1);
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (7, 5, '计算机', 11, '1', '2023-11-16 23:22:46', '1', '2023-11-16 15:44:40', '1', 1);
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (8, 5, '体育', 23, '1', '2023-11-16 23:22:46', '1', '2023-11-16 15:47:09', '1', 1);
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (9, 5, '计算机', 11, '1', '2023-11-16 23:22:46', '1', '2023-11-16 15:47:09', '1', 1);
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (10, 5, '体育', 23, '1', '2023-11-16 23:22:46', '1', '2024-09-17 10:55:28', '1', 1);
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (11, 5, '计算机', 11, '1', '2023-11-16 23:22:46', '1', '2024-09-17 10:55:28', '1', 1);
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (12, 2, '电脑', 33, '1', '2023-11-17 00:20:42', '1', '2023-11-16 16:20:45', '1', 1);
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (13, 9, '滑雪', 12, '1', '2023-11-17 13:13:20', '1', '2024-09-17 10:55:26', '1', 1);
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (14, 9, '滑雪', 12, '1', '2023-11-17 13:13:20', '1', '2024-09-17 10:55:49', '1', 1);
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (15, 5, '体育', 23, '1', '2023-11-16 23:22:46', '1', '2024-09-17 18:55:29', '0', 1);
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (16, 5, '计算机', 11, '1', '2023-11-16 23:22:46', '1', '2024-09-17 18:55:29', '0', 1);
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (17, 2, '语文', 66, '1', '2023-11-16 23:21:49', '1', '2024-09-17 18:55:31', '0', 1);
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (18, 2, '数学', 22, '1', '2023-11-16 23:21:49', '1', '2024-09-17 18:55:31', '0', 1);
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (19, 9, '滑雪', 12, '1', '2023-11-17 13:13:20', '1', '2025-04-19 02:49:03', '1', 1);
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (20, 9, '滑雪', 12, '1', '2023-11-17 13:13:20', '1', '2025-04-19 10:49:04', '0', 1);
COMMIT;
-- @formatter:on

DROP SEQUENCE IF EXISTS guanghe_demo03_course_seq;
CREATE SEQUENCE guanghe_demo03_course_seq
    START 21;

-- ----------------------------
-- Table structure for guanghe_demo03_grade
-- ----------------------------
DROP TABLE IF EXISTS guanghe_demo03_grade;
CREATE TABLE guanghe_demo03_grade (
    id int8 NOT NULL,
  student_id int8 NOT NULL,
  name varchar(100) NOT NULL DEFAULT '',
  teacher varchar(255) NOT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0,
  tenant_id int8 NOT NULL DEFAULT 0
);

ALTER TABLE guanghe_demo03_grade ADD CONSTRAINT pk_guanghe_demo03_grade PRIMARY KEY (id);

COMMENT ON COLUMN guanghe_demo03_grade.id IS '编号';
COMMENT ON COLUMN guanghe_demo03_grade.student_id IS '学生编号';
COMMENT ON COLUMN guanghe_demo03_grade.name IS '名字';
COMMENT ON COLUMN guanghe_demo03_grade.teacher IS '班主任';
COMMENT ON COLUMN guanghe_demo03_grade.creator IS '创建者';
COMMENT ON COLUMN guanghe_demo03_grade.create_time IS '创建时间';
COMMENT ON COLUMN guanghe_demo03_grade.updater IS '更新者';
COMMENT ON COLUMN guanghe_demo03_grade.update_time IS '更新时间';
COMMENT ON COLUMN guanghe_demo03_grade.deleted IS '是否删除';
COMMENT ON COLUMN guanghe_demo03_grade.tenant_id IS '租户编号';
COMMENT ON TABLE guanghe_demo03_grade IS '学生班级表';

-- ----------------------------
-- Records of guanghe_demo03_grade
-- ----------------------------
-- @formatter:off
BEGIN;
INSERT INTO guanghe_demo03_grade (id, student_id, name, teacher, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (7, 2, '三年 2 班', '周杰伦', '1', '2023-11-16 23:21:49', '1', '2024-09-17 18:55:31', '0', 1);
INSERT INTO guanghe_demo03_grade (id, student_id, name, teacher, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (8, 5, '华为', '遥遥领先', '1', '2023-11-16 23:22:46', '1', '2024-09-17 18:55:29', '0', 1);
INSERT INTO guanghe_demo03_grade (id, student_id, name, teacher, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (9, 9, '小图', '小娃111', '1', '2023-11-17 13:10:23', '1', '2025-04-19 10:49:04', '0', 1);
COMMIT;
-- @formatter:on

DROP SEQUENCE IF EXISTS guanghe_demo03_grade_seq;
CREATE SEQUENCE guanghe_demo03_grade_seq
    START 10;

-- ----------------------------
-- Table structure for guanghe_demo03_student
-- ----------------------------
DROP TABLE IF EXISTS guanghe_demo03_student;
CREATE TABLE guanghe_demo03_student (
    id int8 NOT NULL,
  name varchar(100) NOT NULL DEFAULT '',
  sex int2 NOT NULL,
  birthday timestamp NOT NULL,
  description varchar(255) NOT NULL,
  creator varchar(64) NULL DEFAULT '',
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updater varchar(64) NULL DEFAULT '',
  update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  deleted int2 NOT NULL DEFAULT 0,
  tenant_id int8 NOT NULL DEFAULT 0
);

ALTER TABLE guanghe_demo03_student ADD CONSTRAINT pk_guanghe_demo03_student PRIMARY KEY (id);

COMMENT ON COLUMN guanghe_demo03_student.id IS '编号';
COMMENT ON COLUMN guanghe_demo03_student.name IS '名字';
COMMENT ON COLUMN guanghe_demo03_student.sex IS '性别';
COMMENT ON COLUMN guanghe_demo03_student.birthday IS '出生日期';
COMMENT ON COLUMN guanghe_demo03_student.description IS '简介';
COMMENT ON COLUMN guanghe_demo03_student.creator IS '创建者';
COMMENT ON COLUMN guanghe_demo03_student.create_time IS '创建时间';
COMMENT ON COLUMN guanghe_demo03_student.updater IS '更新者';
COMMENT ON COLUMN guanghe_demo03_student.update_time IS '更新时间';
COMMENT ON COLUMN guanghe_demo03_student.deleted IS '是否删除';
COMMENT ON COLUMN guanghe_demo03_student.tenant_id IS '租户编号';
COMMENT ON TABLE guanghe_demo03_student IS '学生表';

-- ----------------------------
-- Records of guanghe_demo03_student
-- ----------------------------
-- @formatter:off
BEGIN;
INSERT INTO guanghe_demo03_student (id, name, sex, birthday, description, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2, '小白', 1, '2023-11-16 00:00:00', '<p>厉害</p>', '1', '2023-11-16 23:21:49', '1', '2024-09-17 18:55:31', '0', 1);
INSERT INTO guanghe_demo03_student (id, name, sex, birthday, description, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5, '大黑', 2, '2023-11-13 00:00:00', '<p>你在教我做事?</p>', '1', '2023-11-16 23:22:46', '1', '2024-09-17 18:55:29', '0', 1);
INSERT INTO guanghe_demo03_student (id, name, sex, birthday, description, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (9, '小花', 1, '2023-11-07 00:00:00', '<p>哈哈哈</p>', '1', '2023-11-17 00:04:47', '1', '2025-04-19 10:49:04', '0', 1);
COMMIT;
-- @formatter:on

DROP SEQUENCE IF EXISTS guanghe_demo03_student_seq;
CREATE SEQUENCE guanghe_demo03_student_seq
    START 10;
deleted=2021
