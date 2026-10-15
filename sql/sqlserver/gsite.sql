/*
 Guanghe Database Transfer Tool

 Source Server Type    : MySQL

 Target Server Type    : Microsoft SQL Server

 Date: 2026-05-03 09:41:52
*/


-- ----------------------------
-- Table structure for dual
-- ----------------------------
DROP TABLE IF EXISTS dual
GO
CREATE TABLE dual
(
  id int
)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'数据库连接的表',
    'SCHEMA', N'dbo',
    'TABLE', N'dual'
GO

-- ----------------------------
-- Records of dual
-- ----------------------------
-- @formatter:off
INSERT INTO dual VALUES (1)
GO
-- @formatter:on

-- ----------------------------
-- Table structure for infra_api_access_log
-- ----------------------------
DROP TABLE IF EXISTS infra_api_access_log
GO
CREATE TABLE infra_api_access_log (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    trace_id nvarchar(64) DEFAULT '' NOT NULL,
    user_id bigint DEFAULT 0 NOT NULL,
    user_type tinyint DEFAULT 0 NOT NULL,
    application_name nvarchar(50)  NOT NULL,
    request_method nvarchar(16) DEFAULT '' NOT NULL,
    request_url nvarchar(255) DEFAULT '' NOT NULL,
    request_params nvarchar(max)  NULL,
    response_body nvarchar(max)  NULL,
    user_ip nvarchar(50)  NOT NULL,
    user_agent nvarchar(512)  NOT NULL,
    operate_module nvarchar(50) DEFAULT NULL NULL,
    operate_name nvarchar(50) DEFAULT NULL NULL,
    operate_type tinyint DEFAULT 0 NULL,
    begin_time datetime2  NOT NULL,
    end_time datetime2  NOT NULL,
    duration int  NOT NULL,
    result_code int DEFAULT 0 NOT NULL,
    result_msg nvarchar(512) DEFAULT '' NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL,
    tenant_id bigint DEFAULT 0 NOT NULL
)
GO

CREATE INDEX idx_infra_api_access_log_01 ON infra_api_access_log (create_time)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'日志主键',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_access_log',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'链路追踪编号',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_access_log',
    'COLUMN', N'trace_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_access_log',
    'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户类型',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_access_log',
    'COLUMN', N'user_type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'应用名',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_access_log',
    'COLUMN', N'application_name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'请求方法名',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_access_log',
    'COLUMN', N'request_method'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'请求地址',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_access_log',
    'COLUMN', N'request_url'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'请求参数',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_access_log',
    'COLUMN', N'request_params'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'响应结果',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_access_log',
    'COLUMN', N'response_body'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户 IP',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_access_log',
    'COLUMN', N'user_ip'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'浏览器 UA',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_access_log',
    'COLUMN', N'user_agent'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'操作模块',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_access_log',
    'COLUMN', N'operate_module'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'操作名',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_access_log',
    'COLUMN', N'operate_name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'操作分类',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_access_log',
    'COLUMN', N'operate_type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'开始请求时间',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_access_log',
    'COLUMN', N'begin_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'结束请求时间',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_access_log',
    'COLUMN', N'end_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'执行时长',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_access_log',
    'COLUMN', N'duration'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'结果码',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_access_log',
    'COLUMN', N'result_code'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'结果提示',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_access_log',
    'COLUMN', N'result_msg'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_access_log',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_access_log',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_access_log',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_access_log',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_access_log',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_access_log',
    'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'API 访问日志表',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_access_log'
GO

-- ----------------------------
-- Table structure for infra_api_error_log
-- ----------------------------
DROP TABLE IF EXISTS infra_api_error_log
GO
CREATE TABLE infra_api_error_log (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    trace_id nvarchar(64)  NOT NULL,
    user_id bigint DEFAULT 0 NOT NULL,
    user_type tinyint DEFAULT 0 NOT NULL,
    application_name nvarchar(50)  NOT NULL,
    request_method nvarchar(16)  NOT NULL,
    request_url nvarchar(255)  NOT NULL,
    request_params nvarchar(4000)  NOT NULL,
    user_ip nvarchar(50)  NOT NULL,
    user_agent nvarchar(512)  NOT NULL,
    exception_time datetime2  NOT NULL,
    exception_name nvarchar(128) DEFAULT '' NOT NULL,
    exception_message nvarchar(max)  NOT NULL,
    exception_root_cause_message nvarchar(max)  NOT NULL,
    exception_stack_trace nvarchar(max)  NOT NULL,
    exception_class_name nvarchar(512)  NOT NULL,
    exception_file_name nvarchar(512)  NOT NULL,
    exception_method_name nvarchar(512)  NOT NULL,
    exception_line_number int  NOT NULL,
    process_status tinyint  NOT NULL,
    process_time datetime2 DEFAULT NULL NULL,
    process_user_id int DEFAULT 0 NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL,
    tenant_id bigint DEFAULT 0 NOT NULL
)
GO

CREATE INDEX idx_infra_api_error_log_01 ON infra_api_error_log (create_time)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'编号',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_error_log',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'链路追踪编号',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_error_log',
    'COLUMN', N'trace_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_error_log',
    'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户类型',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_error_log',
    'COLUMN', N'user_type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'应用名',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_error_log',
    'COLUMN', N'application_name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'请求方法名',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_error_log',
    'COLUMN', N'request_method'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'请求地址',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_error_log',
    'COLUMN', N'request_url'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'请求参数',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_error_log',
    'COLUMN', N'request_params'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户 IP',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_error_log',
    'COLUMN', N'user_ip'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'浏览器 UA',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_error_log',
    'COLUMN', N'user_agent'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'异常发生时间',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_error_log',
    'COLUMN', N'exception_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'异常名',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_error_log',
    'COLUMN', N'exception_name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'异常导致的消息',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_error_log',
    'COLUMN', N'exception_message'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'异常导致的根消息',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_error_log',
    'COLUMN', N'exception_root_cause_message'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'异常的栈轨迹',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_error_log',
    'COLUMN', N'exception_stack_trace'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'异常发生的类全名',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_error_log',
    'COLUMN', N'exception_class_name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'异常发生的类文件',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_error_log',
    'COLUMN', N'exception_file_name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'异常发生的方法名',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_error_log',
    'COLUMN', N'exception_method_name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'异常发生的方法所在行',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_error_log',
    'COLUMN', N'exception_line_number'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'处理状态',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_error_log',
    'COLUMN', N'process_status'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'处理时间',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_error_log',
    'COLUMN', N'process_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'处理用户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_error_log',
    'COLUMN', N'process_user_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_error_log',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_error_log',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_error_log',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_error_log',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_error_log',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_error_log',
    'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'系统异常日志',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_api_error_log'
GO

-- ----------------------------
-- Table structure for infra_codegen_column
-- ----------------------------
DROP TABLE IF EXISTS infra_codegen_column
GO
CREATE TABLE infra_codegen_column (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    table_id bigint  NOT NULL,
    column_name nvarchar(200)  NOT NULL,
    data_type nvarchar(100)  NOT NULL,
    column_comment nvarchar(500)  NOT NULL,
    nullable varchar(1)  NOT NULL,
    primary_key varchar(1)  NOT NULL,
    ordinal_position int  NOT NULL,
    java_type nvarchar(32)  NOT NULL,
    java_field nvarchar(64)  NOT NULL,
    dict_type nvarchar(200) DEFAULT '' NULL,
    example nvarchar(64) DEFAULT NULL NULL,
    create_operation varchar(1)  NOT NULL,
    update_operation varchar(1)  NOT NULL,
    list_operation varchar(1)  NOT NULL,
    list_operation_condition nvarchar(32) DEFAULT '=' NOT NULL,
    list_operation_result varchar(1)  NOT NULL,
    html_type nvarchar(32)  NOT NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL
)
GO

CREATE INDEX idx_infra_codegen_column_01 ON infra_codegen_column (table_id)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'编号',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_column',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'表编号',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_column',
    'COLUMN', N'table_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'字段名',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_column',
    'COLUMN', N'column_name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'字段类型',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_column',
    'COLUMN', N'data_type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'字段描述',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_column',
    'COLUMN', N'column_comment'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否允许为空',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_column',
    'COLUMN', N'nullable'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否主键',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_column',
    'COLUMN', N'primary_key'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'排序',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_column',
    'COLUMN', N'ordinal_position'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'Java 属性类型',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_column',
    'COLUMN', N'java_type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'Java 属性名',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_column',
    'COLUMN', N'java_field'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'字典类型',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_column',
    'COLUMN', N'dict_type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'数据示例',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_column',
    'COLUMN', N'example'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否为 Create 创建操作的字段',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_column',
    'COLUMN', N'create_operation'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否为 Update 更新操作的字段',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_column',
    'COLUMN', N'update_operation'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否为 List 查询操作的字段',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_column',
    'COLUMN', N'list_operation'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'List 查询操作的条件类型',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_column',
    'COLUMN', N'list_operation_condition'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否为 List 查询操作的返回字段',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_column',
    'COLUMN', N'list_operation_result'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'显示类型',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_column',
    'COLUMN', N'html_type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_column',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_column',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_column',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_column',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_column',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'代码生成表字段定义',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_column'
GO

-- ----------------------------
-- Table structure for infra_codegen_table
-- ----------------------------
DROP TABLE IF EXISTS infra_codegen_table
GO
CREATE TABLE infra_codegen_table (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    data_source_config_id bigint  NOT NULL,
    scene tinyint DEFAULT 1 NOT NULL,
    table_name nvarchar(200) DEFAULT '' NOT NULL,
    table_comment nvarchar(500) DEFAULT '' NOT NULL,
    remark nvarchar(500) DEFAULT NULL NULL,
    module_name nvarchar(30)  NOT NULL,
    business_name nvarchar(30)  NOT NULL,
    class_name nvarchar(100) DEFAULT '' NOT NULL,
    class_comment nvarchar(50)  NOT NULL,
    author nvarchar(50)  NOT NULL,
    template_type tinyint DEFAULT 1 NOT NULL,
    front_type tinyint  NOT NULL,
    parent_menu_id bigint DEFAULT NULL NULL,
    master_table_id bigint DEFAULT NULL NULL,
    sub_join_column_id bigint DEFAULT NULL NULL,
    sub_join_many varchar(1) DEFAULT NULL NULL,
    tree_parent_column_id bigint DEFAULT NULL NULL,
    tree_name_column_id bigint DEFAULT NULL NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL
)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'编号',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_table',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'数据源配置的编号',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_table',
    'COLUMN', N'data_source_config_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'生成场景',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_table',
    'COLUMN', N'scene'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'表名称',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_table',
    'COLUMN', N'table_name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'表描述',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_table',
    'COLUMN', N'table_comment'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'备注',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_table',
    'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'模块名',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_table',
    'COLUMN', N'module_name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'业务名',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_table',
    'COLUMN', N'business_name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'类名称',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_table',
    'COLUMN', N'class_name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'类描述',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_table',
    'COLUMN', N'class_comment'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'作者',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_table',
    'COLUMN', N'author'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'模板类型',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_table',
    'COLUMN', N'template_type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'前端类型',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_table',
    'COLUMN', N'front_type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'父菜单编号',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_table',
    'COLUMN', N'parent_menu_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'主表的编号',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_table',
    'COLUMN', N'master_table_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'子表关联主表的字段编号',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_table',
    'COLUMN', N'sub_join_column_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'主表与子表是否一对多',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_table',
    'COLUMN', N'sub_join_many'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'树表的父字段编号',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_table',
    'COLUMN', N'tree_parent_column_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'树表的名字字段编号',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_table',
    'COLUMN', N'tree_name_column_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_table',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_table',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_table',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_table',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_table',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'代码生成表定义',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_codegen_table'
GO

-- ----------------------------
-- Table structure for infra_config
-- ----------------------------
DROP TABLE IF EXISTS infra_config
GO
CREATE TABLE infra_config (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    category nvarchar(50)  NOT NULL,
    type tinyint  NOT NULL,
    name nvarchar(100) DEFAULT '' NOT NULL,
    config_key nvarchar(100) DEFAULT '' NOT NULL,
    value nvarchar(500) DEFAULT '' NOT NULL,
    visible varchar(1)  NOT NULL,
    remark nvarchar(500) DEFAULT NULL NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL
)
GO

CREATE INDEX idx_infra_config_01 ON infra_config (config_key)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'参数主键',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_config',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'参数分组',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_config',
    'COLUMN', N'category'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'参数类型',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_config',
    'COLUMN', N'type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'参数名称',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_config',
    'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'参数键名',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_config',
    'COLUMN', N'config_key'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'参数键值',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_config',
    'COLUMN', N'value'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否可见',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_config',
    'COLUMN', N'visible'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'备注',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_config',
    'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_config',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_config',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_config',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_config',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_config',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'参数配置表',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_config'
GO

-- ----------------------------
-- Records of infra_config
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT infra_config ON
GO
INSERT INTO infra_config (id, category, type, name, config_key, value, visible, remark, creator, create_time, updater, update_time, deleted) VALUES (2, N'biz', 1, N'用户管理-账号初始密码', N'system.user.init-password', N'123456', N'0', N'初始化密码 123456', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-07-20 17:22:47', N'0')
GO
INSERT INTO infra_config (id, category, type, name, config_key, value, visible, remark, creator, create_time, updater, update_time, deleted) VALUES (7, N'url', 2, N'MySQL 监控的地址', N'url.druid', N'', N'1', N'', N'1', N'2023-04-07 13:41:16', N'1', N'2023-04-07 14:33:38', N'0')
GO
INSERT INTO infra_config (id, category, type, name, config_key, value, visible, remark, creator, create_time, updater, update_time, deleted) VALUES (8, N'url', 2, N'SkyWalking 监控的地址', N'url.skywalking', N'', N'1', N'', N'1', N'2023-04-07 13:41:16', N'1', N'2023-04-07 14:57:03', N'0')
GO
INSERT INTO infra_config (id, category, type, name, config_key, value, visible, remark, creator, create_time, updater, update_time, deleted) VALUES (9, N'url', 2, N'Spring Boot Admin 监控的地址', N'url.spring-boot-admin', N'', N'1', N'', N'1', N'2023-04-07 13:41:16', N'1', N'2023-04-07 14:52:07', N'0')
GO
INSERT INTO infra_config (id, category, type, name, config_key, value, visible, remark, creator, create_time, updater, update_time, deleted) VALUES (10, N'url', 2, N'Swagger 接口文档的地址', N'url.swagger', N'', N'1', N'', N'1', N'2023-04-07 13:41:16', N'1', N'2023-04-07 14:59:00', N'0')
GO
INSERT INTO infra_config (id, category, type, name, config_key, value, visible, remark, creator, create_time, updater, update_time, deleted) VALUES (12, N'test2', 2, N'test3', N'test4', N'test5', N'1', N'test6', N'1', N'2023-12-03 09:55:16', N'1', N'2025-04-06 21:00:09', N'0')
GO
INSERT INTO infra_config (id, category, type, name, config_key, value, visible, remark, creator, create_time, updater, update_time, deleted) VALUES (13, N'用户管理-账号初始密码', 2, N'用户管理-注册开关', N'system.user.register-enabled', N'true', N'0', N'', N'1', N'2025-04-26 17:23:41', N'1', N'2025-04-26 17:23:41', N'0')
GO
SET IDENTITY_INSERT infra_config OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for infra_data_source_config
-- ----------------------------
DROP TABLE IF EXISTS infra_data_source_config
GO
CREATE TABLE infra_data_source_config (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    name nvarchar(100) DEFAULT '' NOT NULL,
    url nvarchar(1024)  NOT NULL,
    username nvarchar(255)  NOT NULL,
    password nvarchar(255) DEFAULT '' NOT NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL
)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'主键编号',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_data_source_config',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'参数名称',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_data_source_config',
    'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'数据源连接',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_data_source_config',
    'COLUMN', N'url'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户名',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_data_source_config',
    'COLUMN', N'username'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'密码',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_data_source_config',
    'COLUMN', N'password'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_data_source_config',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_data_source_config',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_data_source_config',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_data_source_config',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_data_source_config',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'数据源配置表',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_data_source_config'
GO

-- ----------------------------
-- Table structure for infra_file
-- ----------------------------
DROP TABLE IF EXISTS infra_file
GO
CREATE TABLE infra_file (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    config_id bigint DEFAULT NULL NULL,
    name nvarchar(256) DEFAULT NULL NULL,
    path nvarchar(512)  NOT NULL,
    url nvarchar(1024)  NOT NULL,
    type nvarchar(128) DEFAULT NULL NULL,
    size int  NOT NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL
)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'文件编号',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'配置编号',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file',
    'COLUMN', N'config_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'文件名',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file',
    'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'文件路径',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file',
    'COLUMN', N'path'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'文件 URL',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file',
    'COLUMN', N'url'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'文件类型',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file',
    'COLUMN', N'type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'文件大小',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file',
    'COLUMN', N'size'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'文件表',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file'
GO

-- ----------------------------
-- Table structure for infra_file_config
-- ----------------------------
DROP TABLE IF EXISTS infra_file_config
GO
CREATE TABLE infra_file_config (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    name nvarchar(63)  NOT NULL,
    storage tinyint  NOT NULL,
    remark nvarchar(255) DEFAULT NULL NULL,
    master varchar(1)  NOT NULL,
    config nvarchar(4000)  NOT NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL
)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'编号',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file_config',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'配置名',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file_config',
    'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'存储器',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file_config',
    'COLUMN', N'storage'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'备注',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file_config',
    'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否为主配置',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file_config',
    'COLUMN', N'master'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'存储配置',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file_config',
    'COLUMN', N'config'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file_config',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file_config',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file_config',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file_config',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file_config',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'文件配置表',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file_config'
GO

-- ----------------------------
-- Records of infra_file_config
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT infra_file_config ON
GO
INSERT INTO infra_file_config (id, name, storage, remark, master, config, creator, create_time, updater, update_time, deleted) VALUES (4, N'数据库（示例）', 1, N'我是数据库', N'0', N'{"@class":"guanghe.gsite.module.infra.framework.file.core.client.db.DBFileClientConfig","domain":"http://127.0.0.1:2000"}', N'1', N'2022-03-15 23:56:24', N'1', N'2025-11-24 20:57:14', N'0')
GO
INSERT INTO infra_file_config (id, name, storage, remark, master, config, creator, create_time, updater, update_time, deleted) VALUES (22, N'七牛存储器（示例）', 20, N'请换成你自己的密钥！！！', N'1', N'{"@class":"guanghe.gsite.module.infra.framework.file.core.client.s3.S3FileClientConfig","endpoint":"s3.cn-south-1.qiniucs.com","domain":"http://127.0.0.1:9000/gsite","bucket":"gsite","accessKey":"请填写你的AccessKey","accessSecret":"请填写你的AccessSecret","enablePathStyleAccess":false,"enablePublicAccess":true}', N'1', N'2024-01-13 22:11:12', N'1', N'2025-11-24 20:57:14', N'0')
GO
INSERT INTO infra_file_config (id, name, storage, remark, master, config, creator, create_time, updater, update_time, deleted) VALUES (24, N'腾讯云存储（示例）', 20, N'请换成你的密钥！！！', N'0', N'{"@class":"guanghe.gsite.module.infra.framework.file.core.client.s3.S3FileClientConfig","endpoint":"https://cos.ap-shanghai.myqcloud.com","domain":"https://github.com/guangheUlti/gsite","bucket":"gsite-cos-demo","accessKey":"请填写你的AccessKey","accessSecret":"请填写你的AccessSecret","enablePathStyleAccess":false,"enablePublicAccess":true}', N'1', N'2024-11-09 16:03:22', N'1', N'2025-11-24 20:57:14', N'0')
GO
INSERT INTO infra_file_config (id, name, storage, remark, master, config, creator, create_time, updater, update_time, deleted) VALUES (25, N'阿里云存储（示例）', 20, N'', N'0', N'{"@class":"guanghe.gsite.module.infra.framework.file.core.client.s3.S3FileClientConfig","endpoint":"oss-cn-beijing.aliyuncs.com","domain":"https://github.com/guangheUlti/gsite","bucket":"gsite-oss-demo","accessKey":"请填写你的AccessKey","accessSecret":"请填写你的AccessSecret","enablePathStyleAccess":false,"enablePublicAccess":true}', N'1', N'2024-11-09 16:47:08', N'1', N'2025-11-24 20:57:14', N'0')
GO
INSERT INTO infra_file_config (id, name, storage, remark, master, config, creator, create_time, updater, update_time, deleted) VALUES (26, N'火山云存储（示例）', 20, N'', N'0', N'{"@class":"guanghe.gsite.module.infra.framework.file.core.client.s3.S3FileClientConfig","endpoint":"tos-s3-cn-beijing.volces.com","domain":null,"bucket":"guanghe","accessKey":"请填写你的AccessKey","accessSecret":"请填写你的AccessSecret","enablePathStyleAccess":false,"enablePublicAccess":true}', N'1', N'2024-11-09 16:56:42', N'1', N'2025-11-24 20:57:14', N'0')
GO
INSERT INTO infra_file_config (id, name, storage, remark, master, config, creator, create_time, updater, update_time, deleted) VALUES (27, N'华为云存储（示例）', 20, N'', N'0', N'{"@class":"guanghe.gsite.module.infra.framework.file.core.client.s3.S3FileClientConfig","endpoint":"obs.cn-east-3.myhuaweicloud.com","domain":"","bucket":"guanghe","accessKey":"请填写你的AccessKey","accessSecret":"请填写你的AccessSecret","enablePathStyleAccess":false,"enablePublicAccess":true}', N'1', N'2024-11-09 17:18:41', N'1', N'2025-11-24 20:57:14', N'0')
GO
INSERT INTO infra_file_config (id, name, storage, remark, master, config, creator, create_time, updater, update_time, deleted) VALUES (28, N'MinIO 存储（示例）', 20, N'', N'0', N'{"@class":"guanghe.gsite.module.infra.framework.file.core.client.s3.S3FileClientConfig","endpoint":"http://127.0.0.1:9000","domain":"http://127.0.0.1:9000/gsite","bucket":"guanghe","accessKey":"请填写你的AccessKey","accessSecret":"请填写你的AccessSecret","enablePathStyleAccess":false,"enablePublicAccess":true}', N'1', N'2024-11-09 17:43:10', N'1', N'2025-11-24 20:57:14', N'0')
GO
INSERT INTO infra_file_config (id, name, storage, remark, master, config, creator, create_time, updater, update_time, deleted) VALUES (29, N'本地存储（示例）', 10, N'mac/linux 使用 /，windows 使用 \\', N'0', N'{"@class":"guanghe.gsite.module.infra.framework.file.core.client.local.LocalFileClientConfig","basePath":"/Users/guanghe/tmp/file","domain":"http://127.0.0.1:2000"}', N'1', N'2025-05-02 11:25:45', N'1', N'2025-11-24 20:57:14', N'0')
GO
INSERT INTO infra_file_config (id, name, storage, remark, master, config, creator, create_time, updater, update_time, deleted) VALUES (30, N'SFTP 存储（示例）', 12, N'', N'0', N'{"@class":"guanghe.gsite.module.infra.framework.file.core.client.sftp.SftpFileClientConfig","basePath":"/upload","domain":"http://127.0.0.1:2000","host":"127.0.0.1","port":2222,"username":"foo","password":"pass"}', N'1', N'2025-05-02 16:34:10', N'1', N'2025-11-24 20:57:14', N'0')
GO
INSERT INTO infra_file_config (id, name, storage, remark, master, config, creator, create_time, updater, update_time, deleted) VALUES (34, N'七牛云存储【私有】（示例）', 20, N'请换成你自己的密钥！！！', N'0', N'{"@class":"guanghe.gsite.module.infra.framework.file.core.client.s3.S3FileClientConfig","endpoint":"s3.cn-south-1.qiniucs.com","domain":"http://127.0.0.1:9000","bucket":"gsite-private","accessKey":"请填写你的AccessKey","accessSecret":"请填写你的AccessSecret","enablePathStyleAccess":false,"enablePublicAccess":false}', N'1', N'2025-08-17 21:22:00', N'1', N'2025-11-24 20:57:14', N'0')
GO
INSERT INTO infra_file_config (id, name, storage, remark, master, config, creator, create_time, updater, update_time, deleted) VALUES (35, N'1', 20, N'1', N'0', N'{"@class":"guanghe.gsite.module.infra.framework.file.core.client.s3.S3FileClientConfig","endpoint":"http://www.baidu.com","domain":"http://www.xxx.com","bucket":"1","accessKey":"请填写你的AccessKey","accessSecret":"请填写你的AccessSecret","enablePathStyleAccess":false,"enablePublicAccess":false,"region":"1"}', N'1', N'2025-10-02 14:32:12', N'1', N'2025-11-29 15:59:39', N'0')
GO
SET IDENTITY_INSERT infra_file_config OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for infra_file_content
-- ----------------------------
DROP TABLE IF EXISTS infra_file_content
GO
CREATE TABLE infra_file_content (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    config_id bigint  NOT NULL,
    path nvarchar(512)  NOT NULL,
    content varbinary(max)  NOT NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL
)
GO

CREATE INDEX idx_infra_file_content_01 ON infra_file_content (config_id, path)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'编号',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file_content',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'配置编号',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file_content',
    'COLUMN', N'config_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'文件路径',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file_content',
    'COLUMN', N'path'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'文件内容',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file_content',
    'COLUMN', N'content'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file_content',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file_content',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file_content',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file_content',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file_content',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'文件表',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_file_content'
GO

-- ----------------------------
-- Table structure for infra_job
-- ----------------------------
DROP TABLE IF EXISTS infra_job
GO
CREATE TABLE infra_job (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    name nvarchar(32)  NOT NULL,
    status tinyint  NOT NULL,
    handler_name nvarchar(64)  NOT NULL,
    handler_param nvarchar(255) DEFAULT NULL NULL,
    cron_expression nvarchar(32)  NOT NULL,
    retry_count int DEFAULT 0 NOT NULL,
    retry_interval int DEFAULT 0 NOT NULL,
    monitor_timeout int DEFAULT 0 NOT NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL
)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'任务编号',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_job',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'任务名称',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_job',
    'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'任务状态',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_job',
    'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'处理器的名字',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_job',
    'COLUMN', N'handler_name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'处理器的参数',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_job',
    'COLUMN', N'handler_param'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'CRON 表达式',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_job',
    'COLUMN', N'cron_expression'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'重试次数',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_job',
    'COLUMN', N'retry_count'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'重试间隔',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_job',
    'COLUMN', N'retry_interval'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'监控超时时间',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_job',
    'COLUMN', N'monitor_timeout'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_job',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_job',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_job',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_job',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_job',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'定时任务表',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_job'
GO

-- ----------------------------
-- Records of infra_job
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT infra_job ON
GO
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (5, N'支付通知 Job', 2, N'payNotifyJob', NULL, N'* * * * * ?', 0, 0, 0, N'1', N'2021-10-27 08:34:42', N'1', N'2024-09-12 13:32:48', N'0')
GO
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (17, N'支付订单同步 Job', 2, N'payOrderSyncJob', NULL, N'0 0/1 * * * ?', 0, 0, 0, N'1', N'2023-07-22 14:36:26', N'1', N'2023-07-22 15:39:08', N'0')
GO
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (18, N'支付订单过期 Job', 2, N'payOrderExpireJob', NULL, N'0 0/1 * * * ?', 0, 0, 0, N'1', N'2023-07-22 15:36:23', N'1', N'2023-07-22 15:39:54', N'0')
GO
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (19, N'退款订单的同步 Job', 2, N'payRefundSyncJob', NULL, N'0 0/1 * * * ?', 0, 0, 0, N'1', N'2023-07-23 21:03:44', N'1', N'2023-07-23 21:09:00', N'0')
GO
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (21, N'Mall 交易订单的自动过期 Job', 2, N'tradeOrderAutoCancelJob', N'', N'0 * * * * ?', 3, 0, 0, N'1', N'2023-09-25 23:43:26', N'1', N'2025-10-02 11:08:34', N'0')
GO
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (22, N'Mall 交易订单的自动收货 Job', 2, N'tradeOrderAutoReceiveJob', N'', N'0 * * * * ?', 3, 0, 0, N'1', N'2023-09-26 19:23:53', N'1', N'2025-10-02 11:08:36', N'0')
GO
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (23, N'Mall 交易订单的自动评论 Job', 2, N'tradeOrderAutoCommentJob', N'', N'0 * * * * ?', 3, 0, 0, N'1', N'2023-09-26 23:38:29', N'1', N'2025-10-02 11:08:38', N'0')
GO
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (24, N'Mall 佣金解冻 Job', 2, N'brokerageRecordUnfreezeJob', N'', N'0 * * * * ?', 3, 0, 0, N'1', N'2023-09-28 22:01:46', N'1', N'2025-10-02 11:08:04', N'0')
GO
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (25, N'访问日志清理 Job', 2, N'accessLogCleanJob', N'', N'0 0 0 * * ?', 3, 0, 0, N'1', N'2023-10-03 10:59:41', N'1', N'2023-10-03 11:01:10', N'0')
GO
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (26, N'错误日志清理 Job', 2, N'errorLogCleanJob', N'', N'0 0 0 * * ?', 3, 0, 0, N'1', N'2023-10-03 11:00:43', N'1', N'2023-10-03 11:01:12', N'0')
GO
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (27, N'任务日志清理 Job', 2, N'jobLogCleanJob', N'', N'0 0 0 * * ?', 3, 0, 0, N'1', N'2023-10-03 11:01:33', N'1', N'2024-09-12 13:40:34', N'0')
GO
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (33, N'demoJob', 2, N'demoJob', N'', N'0 * * * * ?', 1, 1, 0, N'1', N'2024-10-27 19:38:46', N'1', N'2025-05-10 18:13:54', N'0')
GO
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (35, N'转账订单的同步 Job', 2, N'payTransferSyncJob', N'', N'0 * * * * ?', 0, 0, 0, N'1', N'2025-05-10 17:35:54', N'1', N'2025-05-10 18:13:52', N'0')
GO
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (36, N'IoT 设备离线检查 Job', 2, N'iotDeviceOfflineCheckJob', N'', N'0 * * * * ?', 0, 0, 0, N'1', N'2025-07-03 23:48:44', N'"1"', N'2025-07-03 23:48:47', N'0')
GO
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (37, N'IoT OTA 升级推送 Job', 2, N'iotOtaUpgradeJob', N'', N'0 * * * * ?', 0, 0, 0, N'1', N'2025-07-03 23:49:07', N'"1"', N'2025-07-03 23:49:13', N'0')
GO
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (38, N'Mall 拼团过期 Job', 2, N'combinationRecordExpireJob', N'', N'0 * * * * ?', 0, 0, 0, N'1', N'2025-10-02 11:07:11', N'1', N'2025-10-02 11:07:14', N'0')
GO
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (39, N'Mall 优惠券过期 Job', 2, N'couponExpireJob', N'', N'0 * * * * ?', 0, 0, 0, N'1', N'2025-10-02 11:07:34', N'1', N'2025-10-02 11:07:37', N'0')
GO
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (40, N'Mall 商品统计 Job', 2, N'productStatisticsJob', N'', N'0 0 0 * * ?', 0, 0, 0, N'1', N'2025-11-22 18:51:25', N'1', N'2025-11-22 18:56:21', N'0')
GO
SET IDENTITY_INSERT infra_job OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for infra_job_log
-- ----------------------------
DROP TABLE IF EXISTS infra_job_log
GO
CREATE TABLE infra_job_log (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    job_id bigint  NOT NULL,
    handler_name nvarchar(64)  NOT NULL,
    handler_param nvarchar(255) DEFAULT NULL NULL,
    execute_index tinyint DEFAULT 1 NOT NULL,
    begin_time datetime2  NOT NULL,
    end_time datetime2 DEFAULT NULL NULL,
    duration int DEFAULT NULL NULL,
    status tinyint  NOT NULL,
    result nvarchar(4000) DEFAULT '' NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL
)
GO

CREATE INDEX idx_infra_job_log_01 ON infra_job_log (job_id)
GO
CREATE INDEX idx_infra_job_log_02 ON infra_job_log (create_time)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'日志编号',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_job_log',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'任务编号',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_job_log',
    'COLUMN', N'job_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'处理器的名字',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_job_log',
    'COLUMN', N'handler_name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'处理器的参数',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_job_log',
    'COLUMN', N'handler_param'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'第几次执行',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_job_log',
    'COLUMN', N'execute_index'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'开始执行时间',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_job_log',
    'COLUMN', N'begin_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'结束执行时间',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_job_log',
    'COLUMN', N'end_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'执行时长',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_job_log',
    'COLUMN', N'duration'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'任务状态',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_job_log',
    'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'结果数据',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_job_log',
    'COLUMN', N'result'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_job_log',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_job_log',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_job_log',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_job_log',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_job_log',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'定时任务日志表',
    'SCHEMA', N'dbo',
    'TABLE', N'infra_job_log'
GO

-- ----------------------------
-- Table structure for system_dept
-- ----------------------------
DROP TABLE IF EXISTS system_dept
GO
CREATE TABLE system_dept (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    name nvarchar(30) DEFAULT '' NOT NULL,
    parent_id bigint DEFAULT 0 NOT NULL,
    sort int DEFAULT 0 NOT NULL,
    leader_user_id bigint DEFAULT NULL NULL,
    phone nvarchar(11) DEFAULT NULL NULL,
    email nvarchar(50) DEFAULT NULL NULL,
    status tinyint  NOT NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL,
    tenant_id bigint DEFAULT 0 NOT NULL
)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'部门id',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dept',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'部门名称',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dept',
    'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'父部门id',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dept',
    'COLUMN', N'parent_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'显示顺序',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dept',
    'COLUMN', N'sort'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'负责人',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dept',
    'COLUMN', N'leader_user_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'联系电话',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dept',
    'COLUMN', N'phone'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'邮箱',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dept',
    'COLUMN', N'email'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'部门状态（0正常 1停用）',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dept',
    'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dept',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dept',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dept',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dept',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dept',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dept',
    'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'部门表',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dept'
GO

-- ----------------------------
-- Records of system_dept
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_dept ON
GO
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (100, N'光何', 0, 0, 1, N'15888888888', N'ry@qq.com', 0, N'admin', N'2021-01-05 17:03:47', N'1', N'2026-01-04 18:01:12', N'0', 1)
GO
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (101, N'深圳总公司', 100, 1, 104, N'15888888888', N'ry@qq.com', 0, N'admin', N'2021-01-05 17:03:47', N'1', N'2025-03-29 15:49:55', N'0', 1)
GO
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (102, N'长沙分公司', 100, 2, NULL, N'15888888888', N'ry@qq.com', 0, N'admin', N'2021-01-05 17:03:47', N'', N'2021-12-15 05:01:40', N'0', 1)
GO
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (103, N'研发部门', 101, 1, 104, N'15888888888', N'ry@qq.com', 0, N'admin', N'2021-01-05 17:03:47', N'1', N'2026-01-04 18:01:24', N'0', 1)
GO
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (104, N'市场部门', 101, 2, NULL, N'15888888888', N'ry@qq.com', 0, N'admin', N'2021-01-05 17:03:47', N'', N'2021-12-15 05:01:38', N'0', 1)
GO
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (105, N'测试部门', 101, 3, NULL, N'15888888888', N'ry@qq.com', 0, N'admin', N'2021-01-05 17:03:47', N'1', N'2022-05-16 20:25:15', N'0', 1)
GO
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (106, N'财务部门', 101, 4, NULL, N'15888888888', N'ry@qq.com', 0, N'admin', N'2021-01-05 17:03:47', N'admin', N'2022-01-15 21:32:22', N'0', 1)
GO
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (107, N'运维部门', 101, 5, 1, N'15888888888', N'ry@qq.com', 0, N'admin', N'2021-01-05 17:03:47', N'1', N'2023-12-02 09:28:22', N'0', 1)
GO
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (108, N'市场部门', 102, 1, NULL, N'15888888888', N'ry@qq.com', 0, N'admin', N'2021-01-05 17:03:47', N'1', N'2022-02-16 08:35:45', N'0', 1)
GO
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (109, N'财务部门', 102, 2, NULL, N'15888888888', N'ry@qq.com', 0, N'admin', N'2021-01-05 17:03:47', N'', N'2021-12-15 05:01:29', N'0', 1)
GO
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (110, N'新部门', 0, 1, NULL, NULL, NULL, 0, N'110', N'2022-02-23 20:46:30', N'110', N'2022-02-23 20:46:30', N'0', 121)
GO
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (111, N'顶级部门', 0, 1, NULL, NULL, NULL, 0, N'113', N'2022-03-07 21:44:50', N'113', N'2022-03-07 21:44:50', N'0', 122)
GO
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (112, N'产品部门', 101, 100, 1, NULL, NULL, 1, N'1', N'2023-12-02 09:45:13', N'1', N'2023-12-02 09:45:31', N'0', 1)
GO
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (113, N'支持部门', 102, 3, 104, NULL, NULL, 1, N'1', N'2023-12-02 09:47:38', N'1', N'2025-03-29 15:00:56', N'0', 1)
GO
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (116, N'某个子部门', 0, 1, NULL, NULL, NULL, 0, N'1', N'2025-12-08 14:51:12', N'1', N'2025-12-08 14:51:12', N'0', 1)
GO
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (117, N'某个子部门 2', 0, 2, NULL, NULL, NULL, 0, N'1', N'2025-12-08 14:51:25', N'1', N'2025-12-08 14:51:25', N'0', 1)
GO
SET IDENTITY_INSERT system_dept OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_dict_data
-- ----------------------------
DROP TABLE IF EXISTS system_dict_data
GO
CREATE TABLE system_dict_data (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    sort int DEFAULT 0 NOT NULL,
    label nvarchar(100) DEFAULT '' NOT NULL,
    value nvarchar(100) DEFAULT '' NOT NULL,
    dict_type nvarchar(100) DEFAULT '' NOT NULL,
    status tinyint DEFAULT 0 NOT NULL,
    color_type nvarchar(100) DEFAULT '' NULL,
    css_class nvarchar(100) DEFAULT '' NULL,
    remark nvarchar(500) DEFAULT NULL NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL
)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'字典编码',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dict_data',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'字典排序',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dict_data',
    'COLUMN', N'sort'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'字典标签',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dict_data',
    'COLUMN', N'label'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'字典键值',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dict_data',
    'COLUMN', N'value'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'字典类型',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dict_data',
    'COLUMN', N'dict_type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'状态（0正常 1停用）',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dict_data',
    'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'颜色类型',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dict_data',
    'COLUMN', N'color_type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'css 样式',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dict_data',
    'COLUMN', N'css_class'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'备注',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dict_data',
    'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dict_data',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dict_data',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dict_data',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dict_data',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dict_data',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'字典数据表',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dict_data'
GO

-- ----------------------------
-- Records of system_dict_data
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_dict_data ON
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
SET IDENTITY_INSERT system_dict_data OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_dict_type
-- ----------------------------
DROP TABLE IF EXISTS system_dict_type
GO
CREATE TABLE system_dict_type (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    name nvarchar(100) DEFAULT '' NOT NULL,
    type nvarchar(100) DEFAULT '' NOT NULL,
    status tinyint DEFAULT 0 NOT NULL,
    remark nvarchar(500) DEFAULT NULL NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL,
    deleted_time datetime2 DEFAULT NULL NULL
)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'字典主键',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dict_type',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'字典名称',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dict_type',
    'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'字典类型',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dict_type',
    'COLUMN', N'type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'状态（0正常 1停用）',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dict_type',
    'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'备注',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dict_type',
    'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dict_type',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dict_type',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dict_type',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dict_type',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dict_type',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'删除时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dict_type',
    'COLUMN', N'deleted_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'字典类型表',
    'SCHEMA', N'dbo',
    'TABLE', N'system_dict_type'
GO

-- ----------------------------
-- Records of system_dict_type
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_dict_type ON
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1, N'用户性别', N'system_user_sex', 0, NULL, N'admin', N'2021-01-05 17:03:48', N'1', N'2022-05-16 20:29:32', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (6, N'参数类型', N'infra_config_type', 0, NULL, N'admin', N'2021-01-05 17:03:48', N'', N'2022-02-01 16:36:54', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (7, N'通知类型', N'system_notice_type', 0, NULL, N'admin', N'2021-01-05 17:03:48', N'', N'2022-02-01 16:35:26', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (9, N'操作类型', N'infra_operate_type', 0, NULL, N'admin', N'2021-01-05 17:03:48', N'1', N'2024-03-14 12:44:01', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (10, N'系统状态', N'common_status', 0, NULL, N'admin', N'2021-01-05 17:03:48', N'', N'2022-02-01 16:21:28', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (11, N'Boolean 是否类型', N'infra_boolean_string', 0, N'boolean 转是否', N'', N'2021-01-19 03:20:08', N'', N'2022-02-01 16:37:10', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (104, N'登陆结果', N'system_login_result', 0, N'登陆结果', N'', N'2021-01-18 06:17:11', N'', N'2022-02-01 16:36:00', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (106, N'代码生成模板类型', N'infra_codegen_template_type', 0, NULL, N'', N'2021-02-05 07:08:06', N'1', N'2022-05-16 20:26:50', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (107, N'定时任务状态', N'infra_job_status', 0, NULL, N'', N'2021-02-07 07:44:16', N'', N'2022-02-01 16:51:11', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (108, N'定时任务日志状态', N'infra_job_log_status', 0, NULL, N'', N'2021-02-08 10:03:51', N'', N'2022-02-01 16:50:43', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (109, N'用户类型', N'user_type', 0, NULL, N'', N'2021-02-26 00:15:51', N'', N'2021-02-26 00:15:51', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (110, N'API 异常数据的处理状态', N'infra_api_error_log_process_status', 0, NULL, N'', N'2021-02-26 07:07:01', N'', N'2022-02-01 16:50:53', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (111, N'短信渠道编码', N'system_sms_channel_code', 0, NULL, N'1', N'2021-04-05 01:04:50', N'1', N'2022-02-16 02:09:08', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (112, N'短信模板的类型', N'system_sms_template_type', 0, NULL, N'1', N'2021-04-05 21:50:43', N'1', N'2022-02-01 16:35:06', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (113, N'短信发送状态', N'system_sms_send_status', 0, NULL, N'1', N'2021-04-11 20:18:03', N'1', N'2022-02-01 16:35:09', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (114, N'短信接收状态', N'system_sms_receive_status', 0, NULL, N'1', N'2021-04-11 20:27:14', N'1', N'2022-02-01 16:35:14', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (116, N'登陆日志的类型', N'system_login_type', 0, N'登陆日志的类型', N'1', N'2021-10-06 00:50:46', N'1', N'2022-02-01 16:35:56', N'0', NULL)
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (144, N'代码生成的场景枚举', N'infra_codegen_scene', 0, N'代码生成的场景枚举', N'1', N'2022-02-02 13:14:45', N'1', N'2022-03-10 16:33:46', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (145, N'角色类型', N'system_role_type', 0, N'角色类型', N'1', N'2022-02-16 13:01:46', N'1', N'2022-02-16 13:01:46', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (146, N'文件存储器', N'infra_file_storage', 0, N'文件存储器', N'1', N'2022-03-15 00:24:38', N'1', N'2022-03-15 00:24:38', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (147, N'OAuth 2.0 授权类型', N'system_oauth2_grant_type', 0, N'OAuth 2.0 授权类型（模式）', N'1', N'2022-05-12 00:20:52', N'1', N'2022-05-11 16:25:49', N'0', NULL)
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (160, N'终端', N'terminal', 0, N'终端', N'1', N'2022-12-10 10:50:50', N'1', N'2022-12-10 10:53:11', N'0', NULL)
GO
GO
GO
GO
GO
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (166, N'邮件发送状态', N'system_mail_send_status', 0, N'邮件发送状态', N'1', N'2023-01-26 09:53:13', N'1', N'2023-01-26 09:53:13', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (167, N'站内信模版的类型', N'system_notify_template_type', 0, N'站内信模版的类型', N'1', N'2023-01-28 10:35:10', N'1', N'2023-01-28 10:35:10', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (168, N'代码生成的前端类型', N'infra_codegen_front_type', 0, N'', N'1', N'2023-04-12 23:57:52', N'1', N'2023-04-12 23:57:52', N'0', N'1970-01-01 00:00:00')
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (601, N'社交类型', N'system_social_type', 0, N'', N'1', N'2023-11-04 13:03:54', N'1', N'2023-11-04 13:03:54', N'0', N'1970-01-01 00:00:00')
GO
GO
GO
GO
GO
GO
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (611, N'ERP 库存明细的业务类型', N'erp_stock_record_biz_type', 0, N'ERP 库存明细的业务类型', N'1', N'2024-02-05 18:07:02', N'1', N'2024-02-05 18:07:02', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (612, N'ERP 审批状态', N'erp_audit_status', 0, N'', N'1', N'2024-02-06 00:00:07', N'1', N'2024-02-06 00:00:07', N'0', N'1970-01-01 00:00:00')
GO
GO
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (616, N'时间间隔', N'date_interval', 0, N'', N'1', N'2024-03-29 22:50:09', N'1', N'2024-03-29 22:50:09', N'0', N'1970-01-01 00:00:00')
GO
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (620, N'AI 模型平台', N'ai_platform', 0, N'', N'1', N'2024-05-09 22:27:38', N'1', N'2024-05-09 22:27:38', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (621, N'AI 绘画状态', N'ai_image_status', 0, N'', N'1', N'2024-06-26 20:51:23', N'1', N'2024-06-26 20:51:23', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (622, N'AI 音乐状态', N'ai_music_status', 0, N'', N'1', N'2024-06-27 22:45:07', N'1', N'2024-06-28 00:56:27', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (623, N'AI 音乐生成模式', N'ai_generate_mode', 0, N'', N'1', N'2024-06-27 22:46:21', N'1', N'2024-06-28 01:22:29', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (624, N'写作语气', N'ai_write_tone', 0, N'', N'1', N'2024-07-07 15:19:02', N'1', N'2024-07-07 15:19:02', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (625, N'写作语言', N'ai_write_language', 0, N'', N'1', N'2024-07-07 15:18:52', N'1', N'2024-07-07 15:18:52', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (626, N'写作长度', N'ai_write_length', 0, N'', N'1', N'2024-07-07 15:18:41', N'1', N'2024-07-07 15:18:41', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (627, N'写作格式', N'ai_write_format', 0, N'', N'1', N'2024-07-07 15:14:34', N'1', N'2024-07-07 15:14:34', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (628, N'AI 写作类型', N'ai_write_type', 0, N'', N'1', N'2024-07-10 21:25:29', N'1', N'2024-07-10 21:25:29', N'0', N'1970-01-01 00:00:00')
GO
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (640, N'AI 模型类型', N'ai_model_type', 0, N'', N'1', N'2025-03-03 12:24:07', N'1', N'2025-03-03 12:24:07', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1001, N'IoT 产品设备类型', N'iot_product_device_type', 0, N'', N'1', N'2024-08-10 11:54:30', N'1', N'2025-03-17 09:25:08', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1002, N'IoT 产品状态', N'iot_product_status', 0, N'', N'1', N'2024-08-10 12:06:09', N'1', N'2025-03-17 09:25:10', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1004, N'IoT 联网方式', N'iot_net_type', 0, N'', N'1', N'2024-09-06 22:04:13', N'1', N'2025-03-17 09:25:14', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1006, N'IoT 设备状态', N'iot_device_state', 0, N'', N'1', N'2024-09-21 08:12:55', N'1', N'2025-03-17 09:25:19', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1007, N'IoT 物模型功能类型', N'iot_thing_model_type', 0, N'', N'1', N'2024-09-29 20:02:36', N'1', N'2025-03-17 09:25:24', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1011, N'IoT 物模型单位', N'iot_thing_model_unit', 0, N'', N'1', N'2024-12-25 17:36:46', N'1', N'2025-03-17 09:25:35', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1013, N'IoT 数据流转目的的类型枚举', N'iot_data_sink_type_enum', 0, N'', N'1', N'2025-03-09 12:39:36', N'1', N'2025-06-24 12:45:24', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1014, N'IoT 场景流转的触发类型枚举', N'iot_rule_scene_trigger_type_enum', 0, N'', N'1', N'2025-03-20 14:59:44', N'1', N'2025-03-20 14:59:44', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1015, N'IoT 设备消息类型枚举', N'iot_device_message_type_enum', 0, N'', N'1', N'2025-03-20 15:01:15', N'1', N'2025-03-20 15:01:15', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1016, N'IoT 规则场景的触发类型枚举', N'iot_rule_scene_action_type_enum', 0, N'', N'1', N'2025-03-28 15:26:54', N'1', N'2025-03-28 15:29:13', N'0', N'1970-01-01 00:00:00')
GO
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (2001, N'IoT 告警级别', N'iot_alert_level', 0, N'', N'1', N'2025-06-27 20:30:57', N'1', N'2025-06-27 20:30:57', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (2002, N'IoT 告警', N'iot_alert_receive_type', 0, N'', N'1', N'2025-06-27 22:49:19', N'1', N'2025-06-27 22:49:19', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (2003, N'IoT 固件设备范围', N'iot_ota_task_device_scope', 0, N'', N'1', N'2025-07-02 09:42:49', N'1', N'2025-07-02 09:42:49', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (2004, N'IoT 固件升级任务状态', N'iot_ota_task_status', 0, N'', N'1', N'2025-07-02 09:43:43', N'1', N'2025-07-02 09:43:43', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (2005, N'IoT 固件升级记录状态', N'iot_ota_task_record_status', 0, N'', N'1', N'2025-07-02 09:45:02', N'1', N'2025-07-02 09:45:02', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (2007, N'AI MCP 客户端名字', N'ai_mcp_client_name', 0, N'', N'1', N'2025-08-28 13:57:40', N'1', N'2025-08-28 13:57:40', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (2008, N'IoT 协议类型', N'iot_protocol_type', 0, N'IoT 设备接入协议类型', N'1', N'2026-02-04 00:31:33', N'1', N'2026-02-04 00:31:33', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (2009, N'IoT 序列化类型', N'iot_serialize_type', 0, N'IoT 设备消息序列化类型', N'1', N'2026-02-04 00:33:16', N'1', N'2026-02-04 00:33:16', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (2010, N'IoT Modbus 工作模式', N'iot_modbus_mode', 0, N'Modbus 设备数据采集模式', N'1', N'2025-06-12 22:55:46', N'1', N'2025-06-12 22:55:46', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (2011, N'IoT Modbus 帧格式', N'iot_modbus_frame_format', 0, N'Modbus 数据帧协议格式', N'1', N'2025-06-12 22:55:46', N'1', N'2025-06-12 22:55:46', N'0', N'1970-01-01 00:00:00')
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
SET IDENTITY_INSERT system_dict_type OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_login_log
-- ----------------------------
DROP TABLE IF EXISTS system_login_log
GO
CREATE TABLE system_login_log (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    log_type bigint  NOT NULL,
    trace_id nvarchar(64) DEFAULT '' NOT NULL,
    user_id bigint DEFAULT 0 NOT NULL,
    user_type tinyint DEFAULT 0 NOT NULL,
    username nvarchar(50) DEFAULT '' NOT NULL,
    result tinyint  NOT NULL,
    user_ip nvarchar(50)  NOT NULL,
    user_agent nvarchar(512)  NOT NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL,
    tenant_id bigint DEFAULT 0 NOT NULL
)
GO

CREATE INDEX idx_system_login_log_01 ON system_login_log (username)
GO
CREATE INDEX idx_system_login_log_02 ON system_login_log (create_time)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'访问ID',
    'SCHEMA', N'dbo',
    'TABLE', N'system_login_log',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'日志类型',
    'SCHEMA', N'dbo',
    'TABLE', N'system_login_log',
    'COLUMN', N'log_type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'链路追踪编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_login_log',
    'COLUMN', N'trace_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_login_log',
    'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户类型',
    'SCHEMA', N'dbo',
    'TABLE', N'system_login_log',
    'COLUMN', N'user_type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户账号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_login_log',
    'COLUMN', N'username'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'登陆结果',
    'SCHEMA', N'dbo',
    'TABLE', N'system_login_log',
    'COLUMN', N'result'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户 IP',
    'SCHEMA', N'dbo',
    'TABLE', N'system_login_log',
    'COLUMN', N'user_ip'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'浏览器 UA',
    'SCHEMA', N'dbo',
    'TABLE', N'system_login_log',
    'COLUMN', N'user_agent'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_login_log',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_login_log',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_login_log',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_login_log',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_login_log',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_login_log',
    'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'系统访问记录',
    'SCHEMA', N'dbo',
    'TABLE', N'system_login_log'
GO

-- ----------------------------
-- Table structure for system_mail_account
-- ----------------------------
DROP TABLE IF EXISTS system_mail_account
GO
CREATE TABLE system_mail_account (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    mail nvarchar(255)  NOT NULL,
    username nvarchar(255)  NOT NULL,
    password nvarchar(255)  NOT NULL,
    host nvarchar(255)  NOT NULL,
    port int  NOT NULL,
    ssl_enable varchar(1) DEFAULT '0' NOT NULL,
    starttls_enable varchar(1) DEFAULT '0' NOT NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL
)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'主键',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_account',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'邮箱',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_account',
    'COLUMN', N'mail'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户名',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_account',
    'COLUMN', N'username'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'密码',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_account',
    'COLUMN', N'password'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'SMTP 服务器域名',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_account',
    'COLUMN', N'host'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'SMTP 服务器端口',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_account',
    'COLUMN', N'port'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否开启 SSL',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_account',
    'COLUMN', N'ssl_enable'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否开启 STARTTLS',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_account',
    'COLUMN', N'starttls_enable'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_account',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_account',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_account',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_account',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_account',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'邮箱账号表',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_account'
GO

-- ----------------------------
-- Records of system_mail_account
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_mail_account ON
GO
INSERT INTO system_mail_account (id, mail, username, password, host, port, ssl_enable, starttls_enable, creator, create_time, updater, update_time, deleted) VALUES (1, N'7684413@qq.com', N'7684413@qq.com', N'1234576', N'127.0.0.1', 8080, N'0', N'0', N'1', N'2023-01-25 17:39:52', N'1', N'2025-04-04 16:34:40', N'0')
GO
INSERT INTO system_mail_account (id, mail, username, password, host, port, ssl_enable, starttls_enable, creator, create_time, updater, update_time, deleted) VALUES (2, N'ydym_test@163.com', N'ydym_test@163.com', N'WBZTEINMIFVRYSOE', N'smtp.163.com', 465, N'1', N'0', N'1', N'2023-01-26 01:26:03', N'1', N'2025-12-20 18:09:32', N'0')
GO
INSERT INTO system_mail_account (id, mail, username, password, host, port, ssl_enable, starttls_enable, creator, create_time, updater, update_time, deleted) VALUES (3, N'76854114@qq.com', N'3335', N'11234', N'guanghe1.cn', 466, N'0', N'0', N'1', N'2023-01-27 15:06:38', N'1', N'2023-01-27 07:08:36', N'1')
GO
INSERT INTO system_mail_account (id, mail, username, password, host, port, ssl_enable, starttls_enable, creator, create_time, updater, update_time, deleted) VALUES (4, N'7685413x@qq.com', N'2', N'3', N'4', 5, N'1', N'0', N'1', N'2023-04-12 23:05:06', N'1', N'2023-04-12 15:05:11', N'1')
GO
SET IDENTITY_INSERT system_mail_account OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_mail_log
-- ----------------------------
DROP TABLE IF EXISTS system_mail_log
GO
CREATE TABLE system_mail_log (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    user_id bigint DEFAULT NULL NULL,
    user_type tinyint DEFAULT NULL NULL,
    to_mails nvarchar(1024)  NOT NULL,
    cc_mails nvarchar(1024) DEFAULT NULL NULL,
    bcc_mails nvarchar(1024) DEFAULT NULL NULL,
    account_id bigint  NOT NULL,
    from_mail nvarchar(255)  NOT NULL,
    template_id bigint  NOT NULL,
    template_code nvarchar(63)  NOT NULL,
    template_nickname nvarchar(255) DEFAULT NULL NULL,
    template_title nvarchar(255)  NOT NULL,
    template_content nvarchar(max)  NOT NULL,
    template_params nvarchar(255)  NOT NULL,
    send_status tinyint DEFAULT 0 NOT NULL,
    send_time datetime2 DEFAULT NULL NULL,
    send_message_id nvarchar(255) DEFAULT NULL NULL,
    send_exception nvarchar(4000) DEFAULT NULL NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL
)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_log',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_log',
    'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户类型',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_log',
    'COLUMN', N'user_type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'接收邮箱地址',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_log',
    'COLUMN', N'to_mails'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'抄送邮箱地址',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_log',
    'COLUMN', N'cc_mails'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'密送邮箱地址',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_log',
    'COLUMN', N'bcc_mails'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'邮箱账号编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_log',
    'COLUMN', N'account_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'发送邮箱地址',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_log',
    'COLUMN', N'from_mail'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'模板编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_log',
    'COLUMN', N'template_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'模板编码',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_log',
    'COLUMN', N'template_code'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'模版发送人名称',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_log',
    'COLUMN', N'template_nickname'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'邮件标题',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_log',
    'COLUMN', N'template_title'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'邮件内容',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_log',
    'COLUMN', N'template_content'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'邮件参数',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_log',
    'COLUMN', N'template_params'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'发送状态',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_log',
    'COLUMN', N'send_status'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'发送时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_log',
    'COLUMN', N'send_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'发送返回的消息 ID',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_log',
    'COLUMN', N'send_message_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'发送异常',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_log',
    'COLUMN', N'send_exception'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_log',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_log',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_log',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_log',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_log',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'邮件日志表',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_log'
GO

-- ----------------------------
-- Table structure for system_mail_template
-- ----------------------------
DROP TABLE IF EXISTS system_mail_template
GO
CREATE TABLE system_mail_template (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    name nvarchar(63)  NOT NULL,
    code nvarchar(63)  NOT NULL,
    account_id bigint  NOT NULL,
    nickname nvarchar(255) DEFAULT NULL NULL,
    title nvarchar(255)  NOT NULL,
    content nvarchar(4000)  NOT NULL,
    params nvarchar(255)  NOT NULL,
    status tinyint  NOT NULL,
    remark nvarchar(255) DEFAULT NULL NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL
)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_template',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'模板名称',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_template',
    'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'模板编码',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_template',
    'COLUMN', N'code'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'发送的邮箱账号编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_template',
    'COLUMN', N'account_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'发送人名称',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_template',
    'COLUMN', N'nickname'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'模板标题',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_template',
    'COLUMN', N'title'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'模板内容',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_template',
    'COLUMN', N'content'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'参数数组',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_template',
    'COLUMN', N'params'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'开启状态',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_template',
    'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'备注',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_template',
    'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_template',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_template',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_template',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_template',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_template',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'邮件模版表',
    'SCHEMA', N'dbo',
    'TABLE', N'system_mail_template'
GO

-- ----------------------------
-- Records of system_mail_template
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_mail_template ON
GO
INSERT INTO system_mail_template (id, name, code, account_id, nickname, title, content, params, status, remark, creator, create_time, updater, update_time, deleted) VALUES (13, N'后台用户短信登录', N'admin-sms-login', 1, N'奥特曼', N'你猜我猜', N'<p>您的验证码是{code}，名字是{name}</p>', N'["code","name"]', 0, N'3', N'1', N'2021-10-11 08:10:00', N'1', N'2023-12-02 19:51:14', N'0')
GO
INSERT INTO system_mail_template (id, name, code, account_id, nickname, title, content, params, status, remark, creator, create_time, updater, update_time, deleted) VALUES (14, N'测试模版', N'test_01', 2, N'光何', N'一个标题', N'<p>你是 {key01} 吗？</p><p><br></p><p>是的话，赶紧 {key02} 一下！</p>', N'["key01","key02"]', 0, NULL, N'1', N'2023-01-26 01:27:40', N'1', N'2025-07-26 21:48:45', N'0')
GO
INSERT INTO system_mail_template (id, name, code, account_id, nickname, title, content, params, status, remark, creator, create_time, updater, update_time, deleted) VALUES (15, N'3', N'2', 2, N'7', N'4', N'<p>45</p>', N'[]', 1, N'80', N'1', N'2023-01-27 15:50:35', N'1', N'2025-07-26 21:47:49', N'1')
GO
SET IDENTITY_INSERT system_mail_template OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_menu
-- ----------------------------
DROP TABLE IF EXISTS system_menu
GO
CREATE TABLE system_menu (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    name nvarchar(50)  NOT NULL,
    permission nvarchar(100) DEFAULT '' NOT NULL,
    type tinyint  NOT NULL,
    sort int DEFAULT 0 NOT NULL,
    parent_id bigint DEFAULT 0 NOT NULL,
    path nvarchar(200) DEFAULT '' NULL,
    icon nvarchar(100) DEFAULT '#' NULL,
    component nvarchar(255) DEFAULT NULL NULL,
    component_name nvarchar(255) DEFAULT NULL NULL,
    status tinyint DEFAULT 0 NOT NULL,
    visible varchar(1) DEFAULT '1' NOT NULL,
    keep_alive varchar(1) DEFAULT '1' NOT NULL,
    always_show varchar(1) DEFAULT '1' NOT NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL
)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'菜单ID',
    'SCHEMA', N'dbo',
    'TABLE', N'system_menu',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'菜单名称',
    'SCHEMA', N'dbo',
    'TABLE', N'system_menu',
    'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'权限标识',
    'SCHEMA', N'dbo',
    'TABLE', N'system_menu',
    'COLUMN', N'permission'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'菜单类型',
    'SCHEMA', N'dbo',
    'TABLE', N'system_menu',
    'COLUMN', N'type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'显示顺序',
    'SCHEMA', N'dbo',
    'TABLE', N'system_menu',
    'COLUMN', N'sort'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'父菜单ID',
    'SCHEMA', N'dbo',
    'TABLE', N'system_menu',
    'COLUMN', N'parent_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'路由地址',
    'SCHEMA', N'dbo',
    'TABLE', N'system_menu',
    'COLUMN', N'path'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'菜单图标',
    'SCHEMA', N'dbo',
    'TABLE', N'system_menu',
    'COLUMN', N'icon'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'组件路径',
    'SCHEMA', N'dbo',
    'TABLE', N'system_menu',
    'COLUMN', N'component'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'组件名',
    'SCHEMA', N'dbo',
    'TABLE', N'system_menu',
    'COLUMN', N'component_name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'菜单状态',
    'SCHEMA', N'dbo',
    'TABLE', N'system_menu',
    'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否可见',
    'SCHEMA', N'dbo',
    'TABLE', N'system_menu',
    'COLUMN', N'visible'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否缓存',
    'SCHEMA', N'dbo',
    'TABLE', N'system_menu',
    'COLUMN', N'keep_alive'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否总是显示',
    'SCHEMA', N'dbo',
    'TABLE', N'system_menu',
    'COLUMN', N'always_show'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_menu',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_menu',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_menu',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_menu',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_menu',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'菜单权限表',
    'SCHEMA', N'dbo',
    'TABLE', N'system_menu'
GO

-- ----------------------------
-- Records of system_menu
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_menu ON
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1, N'系统管理', N'', 1, 10, 0, N'/system', N'ep:tools', NULL, NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2025-03-15 21:30:27', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2, N'基础设施', N'', 1, 20, 0, N'/infra', N'ep:monitor', NULL, NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-03-01 08:28:40', N'0')
GO
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (100, N'用户管理', N'system:user:list', 2, 1, 1, N'user', N'ep:avatar', N'system/user/index', N'SystemUser', 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2026-01-01 18:43:01', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (101, N'角色管理', N'', 2, 2, 1, N'role', N'ep:user', N'system/role/index', N'SystemRole', 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2026-01-05 19:30:33', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (102, N'菜单管理', N'', 2, 3, 1, N'menu', N'ep:menu', N'system/menu/index', N'SystemMenu', 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-02-29 01:03:50', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (103, N'部门管理', N'', 2, 4, 1, N'dept', N'fa:address-card', N'system/dept/index', N'SystemDept', 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-02-29 01:06:28', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (104, N'岗位管理', N'', 2, 5, 1, N'post', N'fa:address-book-o', N'system/post/index', N'SystemPost', 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-02-29 01:06:39', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (105, N'字典管理', N'', 2, 6, 1, N'dict', N'ep:collection', N'system/dict/index', N'SystemDictType', 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-02-29 01:07:12', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (106, N'配置管理', N'', 2, 8, 2, N'config', N'fa:connectdevelop', N'infra/config/index', N'InfraConfig', 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-04-23 00:02:45', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (107, N'通知公告', N'', 2, 4, 2739, N'notice', N'ep:takeaway-box', N'system/notice/index', N'SystemNotice', 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-04-22 23:56:17', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (108, N'审计日志', N'', 1, 9, 1, N'log', N'ep:document-copy', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-02-29 01:08:30', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (109, N'令牌管理', N'', 2, 2, 1261, N'token', N'fa:key', N'system/oauth2/token/index', N'SystemTokenClient', 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-02-29 01:13:48', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (110, N'定时任务', N'', 2, 7, 2, N'job', N'fa-solid:tasks', N'infra/job/index', N'InfraJob', 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-02-29 08:57:36', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (111, N'MySQL 监控', N'', 2, 1, 2740, N'druid', N'fa-solid:box', N'infra/druid/index', N'InfraDruid', 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-04-23 00:05:58', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (112, N'Java 监控', N'', 2, 3, 2740, N'admin-server', N'ep:coffee-cup', N'infra/server/index', N'InfraAdminServer', 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-04-23 00:06:57', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (113, N'Redis 监控', N'', 2, 2, 2740, N'redis', N'fa:reddit-square', N'infra/redis/index', N'InfraRedis', 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-04-23 00:06:09', N'0')
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2027, N'Banner创建', N'promotion:banner:create', 3, 2, 2025, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2022-08-01 14:56:14', N'1', N'2023-10-24 20:20:23', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2028, N'Banner更新', N'promotion:banner:update', 3, 3, 2025, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2022-08-01 14:56:14', N'1', N'2023-10-24 20:20:28', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2029, N'Banner删除', N'promotion:banner:delete', 3, 4, 2025, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2022-08-01 14:56:14', N'1', N'2023-10-24 20:20:36', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2030, N'营销中心', N'', 1, 70, 2362, N'promotion', N'ep:present', NULL, NULL, 0, N'1', N'1', N'1', N'1', N'2022-10-31 21:25:09', N'1', N'2023-09-30 11:54:27', N'0')
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
SET IDENTITY_INSERT system_menu OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_notice
-- ----------------------------
DROP TABLE IF EXISTS system_notice
GO
CREATE TABLE system_notice (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    title nvarchar(50)  NOT NULL,
    content nvarchar(max)  NOT NULL,
    type tinyint  NOT NULL,
    status tinyint DEFAULT 0 NOT NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL,
    tenant_id bigint DEFAULT 0 NOT NULL
)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'公告ID',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notice',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'公告标题',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notice',
    'COLUMN', N'title'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'公告内容',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notice',
    'COLUMN', N'content'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'公告类型（1通知 2公告）',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notice',
    'COLUMN', N'type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'公告状态（0正常 1关闭）',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notice',
    'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notice',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notice',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notice',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notice',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notice',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notice',
    'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'通知公告表',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notice'
GO

-- ----------------------------
-- Records of system_notice
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_notice ON
GO
INSERT INTO system_notice (id, title, content, type, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1, N'光何的公众', N'<p>新版本内容133222</p>', 1, 0, N'admin', N'2021-01-05 17:03:48', N'"1"', N'2025-08-31 09:38:22', N'0', 1)
GO
INSERT INTO system_notice (id, title, content, type, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2, N'系统例行维护通知', N'<p>系统将于每周日凌晨 02:00 - 04:00 进行例行维护，请提前保存好数据。</p>', 2, 1, N'admin', N'2021-01-05 17:03:48', N'1', N'2025-04-18 23:56:40', N'0', 1)
GO
INSERT INTO system_notice (id, title, content, type, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4, N'我是测试标题', N'<p>哈哈哈哈123</p>', 1, 0, N'110', N'2022-02-22 01:01:25', N'110', N'2022-02-22 01:01:46', N'0', 121)
GO
SET IDENTITY_INSERT system_notice OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_notify_message
-- ----------------------------
DROP TABLE IF EXISTS system_notify_message
GO
CREATE TABLE system_notify_message (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    user_id bigint  NOT NULL,
    user_type tinyint  NOT NULL,
    template_id bigint  NOT NULL,
    template_code nvarchar(64)  NOT NULL,
    template_nickname nvarchar(63)  NOT NULL,
    template_content nvarchar(1024)  NOT NULL,
    template_type int  NOT NULL,
    template_params nvarchar(255)  NOT NULL,
    read_status varchar(1)  NOT NULL,
    read_time datetime2 DEFAULT NULL NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL,
    tenant_id bigint DEFAULT 0 NOT NULL
)
GO

CREATE INDEX idx_system_notify_message_01 ON system_notify_message (user_id, user_type, read_status)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户ID',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_message',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户id',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_message',
    'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户类型',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_message',
    'COLUMN', N'user_type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'模版编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_message',
    'COLUMN', N'template_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'模板编码',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_message',
    'COLUMN', N'template_code'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'模版发送人名称',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_message',
    'COLUMN', N'template_nickname'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'模版内容',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_message',
    'COLUMN', N'template_content'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'模版类型',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_message',
    'COLUMN', N'template_type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'模版参数',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_message',
    'COLUMN', N'template_params'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否已读',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_message',
    'COLUMN', N'read_status'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'阅读时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_message',
    'COLUMN', N'read_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_message',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_message',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_message',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_message',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_message',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_message',
    'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'站内信消息表',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_message'
GO

-- ----------------------------
-- Records of system_notify_message
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_notify_message ON
GO
INSERT INTO system_notify_message (id, user_id, user_type, template_id, template_code, template_nickname, template_content, template_type, template_params, read_status, read_time, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2, 1, 2, 1, N'test', N'123', N'我是 1，我开始 2 了', 1, N'{"name":"1","what":"2"}', N'1', N'2025-12-15 21:24:36', N'1', N'2023-01-28 11:44:08', N'1', N'2025-12-15 21:24:36', N'0', 1)
GO
INSERT INTO system_notify_message (id, user_id, user_type, template_id, template_code, template_nickname, template_content, template_type, template_params, read_status, read_time, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3, 1, 2, 1, N'test', N'123', N'我是 1，我开始 2 了', 1, N'{"name":"1","what":"2"}', N'1', N'2025-12-15 21:24:36', N'1', N'2023-01-28 11:45:04', N'1', N'2025-12-15 21:24:36', N'0', 1)
GO
INSERT INTO system_notify_message (id, user_id, user_type, template_id, template_code, template_nickname, template_content, template_type, template_params, read_status, read_time, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4, 103, 2, 2, N'register', N'系统消息', N'你好，欢迎 哈哈 加入大家庭！', 2, N'{"name":"哈哈"}', N'0', NULL, N'1', N'2023-01-28 21:02:20', N'1', N'2023-01-28 21:02:20', N'0', 1)
GO
INSERT INTO system_notify_message (id, user_id, user_type, template_id, template_code, template_nickname, template_content, template_type, template_params, read_status, read_time, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5, 1, 2, 1, N'test', N'123', N'我是 光何，我开始 写代码 了', 1, N'{"name":"光何","what":"写代码"}', N'1', N'2025-12-08 17:25:28', N'1', N'2023-01-28 22:21:42', N'1', N'2025-12-08 17:25:28', N'0', 1)
GO
INSERT INTO system_notify_message (id, user_id, user_type, template_id, template_code, template_nickname, template_content, template_type, template_params, read_status, read_time, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6, 1, 2, 1, N'test', N'123', N'我是 光何，我开始 写代码 了', 1, N'{"name":"光何","what":"写代码"}', N'1', N'2025-12-08 17:25:30', N'1', N'2023-01-28 22:22:07', N'1', N'2025-12-08 17:25:30', N'0', 1)
GO
INSERT INTO system_notify_message (id, user_id, user_type, template_id, template_code, template_nickname, template_content, template_type, template_params, read_status, read_time, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (7, 1, 2, 1, N'test', N'123', N'我是 2，我开始 3 了', 1, N'{"name":"2","what":"3"}', N'1', N'2025-12-08 17:25:22', N'1', N'2023-01-28 23:45:21', N'1', N'2025-12-08 17:25:22', N'0', 1)
GO
INSERT INTO system_notify_message (id, user_id, user_type, template_id, template_code, template_nickname, template_content, template_type, template_params, read_status, read_time, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (8, 1, 2, 2, N'register', N'系统消息', N'你好，欢迎 123 加入大家庭！', 2, N'{"name":"123"}', N'1', N'2025-12-08 16:46:01', N'1', N'2023-01-28 23:50:21', N'1', N'2025-12-08 16:46:01', N'0', 1)
GO
INSERT INTO system_notify_message (id, user_id, user_type, template_id, template_code, template_nickname, template_content, template_type, template_params, read_status, read_time, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (9, 247, 1, 4, N'brokerage_withdraw_audit_approve', N'system', N'您在2023-09-28 08:35:46提现￥0.09元的申请已通过审核', 2, N'{"reason":null,"createTime":"2023-09-28 08:35:46","price":"0.09"}', N'0', NULL, N'1', N'2023-09-28 16:36:22', N'1', N'2023-09-28 16:36:22', N'0', 1)
GO
INSERT INTO system_notify_message (id, user_id, user_type, template_id, template_code, template_nickname, template_content, template_type, template_params, read_status, read_time, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (10, 247, 1, 4, N'brokerage_withdraw_audit_approve', N'system', N'您在2023-09-30 20:59:40提现￥1.00元的申请已通过审核', 2, N'{"reason":null,"createTime":"2023-09-30 20:59:40","price":"1.00"}', N'0', NULL, N'1', N'2023-10-03 12:11:34', N'1', N'2023-10-03 12:11:34', N'0', 1)
GO
SET IDENTITY_INSERT system_notify_message OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_notify_template
-- ----------------------------
DROP TABLE IF EXISTS system_notify_template
GO
CREATE TABLE system_notify_template (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    name nvarchar(63)  NOT NULL,
    code nvarchar(64)  NOT NULL,
    nickname nvarchar(255)  NOT NULL,
    content nvarchar(1024)  NOT NULL,
    type tinyint  NOT NULL,
    params nvarchar(255) DEFAULT NULL NULL,
    status tinyint  NOT NULL,
    remark nvarchar(255) DEFAULT NULL NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL
)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'主键',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_template',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'模板名称',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_template',
    'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'模版编码',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_template',
    'COLUMN', N'code'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'发送人名称',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_template',
    'COLUMN', N'nickname'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'模版内容',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_template',
    'COLUMN', N'content'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'类型',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_template',
    'COLUMN', N'type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'参数数组',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_template',
    'COLUMN', N'params'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'状态',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_template',
    'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'备注',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_template',
    'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_template',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_template',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_template',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_template',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_template',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'站内信模板表',
    'SCHEMA', N'dbo',
    'TABLE', N'system_notify_template'
GO

-- ----------------------------
-- Table structure for system_oauth2_access_token
-- ----------------------------
DROP TABLE IF EXISTS system_oauth2_access_token
GO
CREATE TABLE system_oauth2_access_token (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    user_id bigint  NOT NULL,
    user_type tinyint  NOT NULL,
    user_info nvarchar(512)  NOT NULL,
    access_token nvarchar(255)  NOT NULL,
    refresh_token nvarchar(32)  NOT NULL,
    client_id nvarchar(255)  NOT NULL,
    scopes nvarchar(255) DEFAULT NULL NULL,
    expires_time datetime2  NOT NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL,
    tenant_id bigint DEFAULT 0 NOT NULL
)
GO

CREATE INDEX idx_system_oauth2_access_token_01 ON system_oauth2_access_token (access_token)
GO
CREATE INDEX idx_system_oauth2_access_token_02 ON system_oauth2_access_token (refresh_token)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_access_token',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_access_token',
    'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户类型',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_access_token',
    'COLUMN', N'user_type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户信息',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_access_token',
    'COLUMN', N'user_info'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'访问令牌',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_access_token',
    'COLUMN', N'access_token'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'刷新令牌',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_access_token',
    'COLUMN', N'refresh_token'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'客户端编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_access_token',
    'COLUMN', N'client_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'授权范围',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_access_token',
    'COLUMN', N'scopes'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'过期时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_access_token',
    'COLUMN', N'expires_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_access_token',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_access_token',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_access_token',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_access_token',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_access_token',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_access_token',
    'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'OAuth2 访问令牌',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_access_token'
GO

-- ----------------------------
-- Table structure for system_oauth2_approve
-- ----------------------------
DROP TABLE IF EXISTS system_oauth2_approve
GO
CREATE TABLE system_oauth2_approve (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    user_id bigint  NOT NULL,
    user_type tinyint  NOT NULL,
    client_id nvarchar(255)  NOT NULL,
    scope nvarchar(255) DEFAULT '' NOT NULL,
    approved varchar(1) DEFAULT '0' NOT NULL,
    expires_time datetime2  NOT NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL,
    tenant_id bigint DEFAULT 0 NOT NULL
)
GO

CREATE INDEX idx_system_oauth2_approve_01 ON system_oauth2_approve (user_id, user_type, client_id)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_approve',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_approve',
    'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户类型',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_approve',
    'COLUMN', N'user_type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'客户端编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_approve',
    'COLUMN', N'client_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'授权范围',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_approve',
    'COLUMN', N'scope'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否接受',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_approve',
    'COLUMN', N'approved'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'过期时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_approve',
    'COLUMN', N'expires_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_approve',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_approve',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_approve',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_approve',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_approve',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_approve',
    'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'OAuth2 批准表',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_approve'
GO

-- ----------------------------
-- Table structure for system_oauth2_client
-- ----------------------------
DROP TABLE IF EXISTS system_oauth2_client
GO
CREATE TABLE system_oauth2_client (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    client_id nvarchar(255)  NOT NULL,
    secret nvarchar(255)  NOT NULL,
    name nvarchar(255)  NOT NULL,
    logo nvarchar(255)  NOT NULL,
    description nvarchar(255) DEFAULT NULL NULL,
    status tinyint  NOT NULL,
    access_token_validity_seconds int  NOT NULL,
    refresh_token_validity_seconds int  NOT NULL,
    redirect_uris nvarchar(255)  NOT NULL,
    authorized_grant_types nvarchar(255)  NOT NULL,
    scopes nvarchar(255) DEFAULT NULL NULL,
    auto_approve_scopes nvarchar(255) DEFAULT NULL NULL,
    authorities nvarchar(255) DEFAULT NULL NULL,
    resource_ids nvarchar(255) DEFAULT NULL NULL,
    additional_information nvarchar(4000) DEFAULT NULL NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL
)
GO

CREATE INDEX idx_system_oauth2_client_01 ON system_oauth2_client (client_id)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_client',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'客户端编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_client',
    'COLUMN', N'client_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'客户端密钥',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_client',
    'COLUMN', N'secret'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'应用名',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_client',
    'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'应用图标',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_client',
    'COLUMN', N'logo'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'应用描述',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_client',
    'COLUMN', N'description'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'状态',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_client',
    'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'访问令牌的有效期',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_client',
    'COLUMN', N'access_token_validity_seconds'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'刷新令牌的有效期',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_client',
    'COLUMN', N'refresh_token_validity_seconds'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'可重定向的 URI 地址',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_client',
    'COLUMN', N'redirect_uris'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'授权类型',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_client',
    'COLUMN', N'authorized_grant_types'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'授权范围',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_client',
    'COLUMN', N'scopes'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'自动通过的授权范围',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_client',
    'COLUMN', N'auto_approve_scopes'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'权限',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_client',
    'COLUMN', N'authorities'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'资源',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_client',
    'COLUMN', N'resource_ids'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'附加信息',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_client',
    'COLUMN', N'additional_information'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_client',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_client',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_client',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_client',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_client',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'OAuth2 客户端表',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_client'
GO

-- ----------------------------
-- Records of system_oauth2_client
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_oauth2_client ON
GO
INSERT INTO system_oauth2_client (id, client_id, secret, name, logo, description, status, access_token_validity_seconds, refresh_token_validity_seconds, redirect_uris, authorized_grant_types, scopes, auto_approve_scopes, authorities, resource_ids, additional_information, creator, create_time, updater, update_time, deleted) VALUES (1, N'default', N'admin123', N'光何', N'/logo.png', N'我是描述', 0, 1800, 2592000, N'["https://github.com/guangheUlti/gsite","https://github.com/guangheUlti/gsite"]', N'["password","authorization_code","implicit","refresh_token","client_credentials"]', N'["user.read","user.write"]', N'[]', N'["user.read","user.write"]', N'[]', N'{}', N'1', N'2022-05-11 21:47:12', N'1', N'2025-12-07 20:07:09', N'0')
GO
INSERT INTO system_oauth2_client (id, client_id, secret, name, logo, description, status, access_token_validity_seconds, refresh_token_validity_seconds, redirect_uris, authorized_grant_types, scopes, auto_approve_scopes, authorities, resource_ids, additional_information, creator, create_time, updater, update_time, deleted) VALUES (40, N'test', N'test2', N'biubiu', N'/logo.png', N'啦啦啦啦', 0, 1800, 43200, N'["https://github.com/guangheUlti/gsite"]', N'["password","authorization_code","implicit"]', N'["user_info","projects"]', N'["user_info"]', N'[]', N'[]', N'{}', N'1', N'2022-05-12 00:28:20', N'1', N'2025-12-27 18:04:44', N'0')
GO
INSERT INTO system_oauth2_client (id, client_id, secret, name, logo, description, status, access_token_validity_seconds, refresh_token_validity_seconds, redirect_uris, authorized_grant_types, scopes, auto_approve_scopes, authorities, resource_ids, additional_information, creator, create_time, updater, update_time, deleted) VALUES (41, N'guanghe-sso-demo-by-code', N'test', N'基于授权码模式，如何实现 SSO 单点登录？', N'/logo.png', NULL, 0, 1800, 43200, N'["http://127.0.0.1:18080"]', N'["authorization_code","refresh_token"]', N'["user.read","user.write"]', N'[]', N'[]', N'[]', NULL, N'1', N'2022-09-29 13:28:31', N'1', N'2025-05-02 18:32:30', N'0')
GO
INSERT INTO system_oauth2_client (id, client_id, secret, name, logo, description, status, access_token_validity_seconds, refresh_token_validity_seconds, redirect_uris, authorized_grant_types, scopes, auto_approve_scopes, authorities, resource_ids, additional_information, creator, create_time, updater, update_time, deleted) VALUES (42, N'guanghe-sso-demo-by-password', N'test', N'基于密码模式，如何实现 SSO 单点登录？', N'/logo.png', NULL, 0, 1800, 43200, N'["http://127.0.0.1:18080"]', N'["password","refresh_token"]', N'["user.read","user.write"]', N'[]', N'[]', N'[]', NULL, N'1', N'2022-10-04 17:40:16', N'1', N'2025-10-25 10:49:40', N'0')
GO
SET IDENTITY_INSERT system_oauth2_client OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_oauth2_code
-- ----------------------------
DROP TABLE IF EXISTS system_oauth2_code
GO
CREATE TABLE system_oauth2_code (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    user_id bigint  NOT NULL,
    user_type tinyint  NOT NULL,
    code nvarchar(32)  NOT NULL,
    client_id nvarchar(255)  NOT NULL,
    scopes nvarchar(255) DEFAULT '' NULL,
    expires_time datetime2  NOT NULL,
    redirect_uri nvarchar(255) DEFAULT NULL NULL,
    state nvarchar(255) DEFAULT '' NOT NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL,
    tenant_id bigint DEFAULT 0 NOT NULL
)
GO

CREATE INDEX idx_system_oauth2_code_01 ON system_oauth2_code (code)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_code',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_code',
    'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户类型',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_code',
    'COLUMN', N'user_type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'授权码',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_code',
    'COLUMN', N'code'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'客户端编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_code',
    'COLUMN', N'client_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'授权范围',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_code',
    'COLUMN', N'scopes'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'过期时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_code',
    'COLUMN', N'expires_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'可重定向的 URI 地址',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_code',
    'COLUMN', N'redirect_uri'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'状态',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_code',
    'COLUMN', N'state'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_code',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_code',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_code',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_code',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_code',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_code',
    'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'OAuth2 授权码表',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_code'
GO

-- ----------------------------
-- Table structure for system_oauth2_refresh_token
-- ----------------------------
DROP TABLE IF EXISTS system_oauth2_refresh_token
GO
CREATE TABLE system_oauth2_refresh_token (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    user_id bigint  NOT NULL,
    refresh_token nvarchar(32)  NOT NULL,
    user_type tinyint  NOT NULL,
    client_id nvarchar(255)  NOT NULL,
    scopes nvarchar(255) DEFAULT NULL NULL,
    expires_time datetime2  NOT NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL,
    tenant_id bigint DEFAULT 0 NOT NULL
)
GO

CREATE INDEX idx_system_oauth2_refresh_token_01 ON system_oauth2_refresh_token (refresh_token)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_refresh_token',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_refresh_token',
    'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'刷新令牌',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_refresh_token',
    'COLUMN', N'refresh_token'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户类型',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_refresh_token',
    'COLUMN', N'user_type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'客户端编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_refresh_token',
    'COLUMN', N'client_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'授权范围',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_refresh_token',
    'COLUMN', N'scopes'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'过期时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_refresh_token',
    'COLUMN', N'expires_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_refresh_token',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_refresh_token',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_refresh_token',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_refresh_token',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_refresh_token',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_refresh_token',
    'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'OAuth2 刷新令牌',
    'SCHEMA', N'dbo',
    'TABLE', N'system_oauth2_refresh_token'
GO

-- ----------------------------
-- Table structure for system_operate_log
-- ----------------------------
DROP TABLE IF EXISTS system_operate_log
GO
CREATE TABLE system_operate_log (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    trace_id nvarchar(64) DEFAULT '' NOT NULL,
    user_id bigint  NOT NULL,
    user_type tinyint DEFAULT 0 NOT NULL,
    type nvarchar(50)  NOT NULL,
    sub_type nvarchar(50)  NOT NULL,
    biz_id bigint  NOT NULL,
    action nvarchar(2000) DEFAULT '' NOT NULL,
    success varchar(1) DEFAULT '1' NOT NULL,
    extra nvarchar(2000) DEFAULT '' NOT NULL,
    request_method nvarchar(16) DEFAULT '' NULL,
    request_url nvarchar(255) DEFAULT '' NULL,
    user_ip nvarchar(50) DEFAULT NULL NULL,
    user_agent nvarchar(512) DEFAULT NULL NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL,
    tenant_id bigint DEFAULT 0 NOT NULL
)
GO

CREATE INDEX idx_system_operate_log_01 ON system_operate_log (user_id)
GO
CREATE INDEX idx_system_operate_log_02 ON system_operate_log (create_time)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'日志主键',
    'SCHEMA', N'dbo',
    'TABLE', N'system_operate_log',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'链路追踪编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_operate_log',
    'COLUMN', N'trace_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_operate_log',
    'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户类型',
    'SCHEMA', N'dbo',
    'TABLE', N'system_operate_log',
    'COLUMN', N'user_type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'操作模块类型',
    'SCHEMA', N'dbo',
    'TABLE', N'system_operate_log',
    'COLUMN', N'type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'操作名',
    'SCHEMA', N'dbo',
    'TABLE', N'system_operate_log',
    'COLUMN', N'sub_type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'操作数据模块编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_operate_log',
    'COLUMN', N'biz_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'操作内容',
    'SCHEMA', N'dbo',
    'TABLE', N'system_operate_log',
    'COLUMN', N'action'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'操作结果',
    'SCHEMA', N'dbo',
    'TABLE', N'system_operate_log',
    'COLUMN', N'success'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'拓展字段',
    'SCHEMA', N'dbo',
    'TABLE', N'system_operate_log',
    'COLUMN', N'extra'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'请求方法名',
    'SCHEMA', N'dbo',
    'TABLE', N'system_operate_log',
    'COLUMN', N'request_method'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'请求地址',
    'SCHEMA', N'dbo',
    'TABLE', N'system_operate_log',
    'COLUMN', N'request_url'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户 IP',
    'SCHEMA', N'dbo',
    'TABLE', N'system_operate_log',
    'COLUMN', N'user_ip'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'浏览器 UA',
    'SCHEMA', N'dbo',
    'TABLE', N'system_operate_log',
    'COLUMN', N'user_agent'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_operate_log',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_operate_log',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_operate_log',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_operate_log',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_operate_log',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_operate_log',
    'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'操作日志记录 V2 版本',
    'SCHEMA', N'dbo',
    'TABLE', N'system_operate_log'
GO

-- ----------------------------
-- Table structure for system_post
-- ----------------------------
DROP TABLE IF EXISTS system_post
GO
CREATE TABLE system_post (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    code nvarchar(64)  NOT NULL,
    name nvarchar(50)  NOT NULL,
    sort int  NOT NULL,
    status tinyint  NOT NULL,
    remark nvarchar(500) DEFAULT NULL NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL,
    tenant_id bigint DEFAULT 0 NOT NULL
)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'岗位ID',
    'SCHEMA', N'dbo',
    'TABLE', N'system_post',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'岗位编码',
    'SCHEMA', N'dbo',
    'TABLE', N'system_post',
    'COLUMN', N'code'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'岗位名称',
    'SCHEMA', N'dbo',
    'TABLE', N'system_post',
    'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'显示顺序',
    'SCHEMA', N'dbo',
    'TABLE', N'system_post',
    'COLUMN', N'sort'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'状态（0正常 1停用）',
    'SCHEMA', N'dbo',
    'TABLE', N'system_post',
    'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'备注',
    'SCHEMA', N'dbo',
    'TABLE', N'system_post',
    'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_post',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_post',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_post',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_post',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_post',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_post',
    'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'岗位信息表',
    'SCHEMA', N'dbo',
    'TABLE', N'system_post'
GO

-- ----------------------------
-- Records of system_post
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_post ON
GO
INSERT INTO system_post (id, code, name, sort, status, remark, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2, N'se', N'项目经理', 2, 0, N'', N'admin', N'2021-01-05 17:03:48', N'1', N'2025-12-15 22:38:43', N'0', 1)
GO
INSERT INTO system_post (id, code, name, sort, status, remark, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4, N'user', N'普通员工', 4, 0, N'111222', N'admin', N'2021-01-05 17:03:48', N'1', N'2025-03-24 21:32:40', N'0', 1)
GO
INSERT INTO system_post (id, code, name, sort, status, remark, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5, N'HR', N'人力资源', 5, 0, N'`', N'1', N'2024-03-24 20:45:40', N'1', N'2025-03-29 19:08:10', N'0', 1)
GO
INSERT INTO system_post (id, code, name, sort, status, remark, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (7, N'test', N'测试', 10, 0, NULL, N'1', N'2025-09-02 08:45:57', N'1', N'2025-09-02 08:45:57', N'0', 1)
GO
SET IDENTITY_INSERT system_post OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_role
-- ----------------------------
DROP TABLE IF EXISTS system_role
GO
CREATE TABLE system_role (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    name nvarchar(30)  NOT NULL,
    code nvarchar(100)  NOT NULL,
    sort int  NOT NULL,
    data_scope tinyint DEFAULT 1 NOT NULL,
    data_scope_dept_ids nvarchar(500) DEFAULT '' NOT NULL,
    status tinyint  NOT NULL,
    type tinyint  NOT NULL,
    remark nvarchar(500) DEFAULT NULL NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL,
    tenant_id bigint DEFAULT 0 NOT NULL
)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'角色ID',
    'SCHEMA', N'dbo',
    'TABLE', N'system_role',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'角色名称',
    'SCHEMA', N'dbo',
    'TABLE', N'system_role',
    'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'角色权限字符串',
    'SCHEMA', N'dbo',
    'TABLE', N'system_role',
    'COLUMN', N'code'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'显示顺序',
    'SCHEMA', N'dbo',
    'TABLE', N'system_role',
    'COLUMN', N'sort'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
    'SCHEMA', N'dbo',
    'TABLE', N'system_role',
    'COLUMN', N'data_scope'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'数据范围(指定部门数组)',
    'SCHEMA', N'dbo',
    'TABLE', N'system_role',
    'COLUMN', N'data_scope_dept_ids'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'角色状态（0正常 1停用）',
    'SCHEMA', N'dbo',
    'TABLE', N'system_role',
    'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'角色类型',
    'SCHEMA', N'dbo',
    'TABLE', N'system_role',
    'COLUMN', N'type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'备注',
    'SCHEMA', N'dbo',
    'TABLE', N'system_role',
    'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_role',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_role',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_role',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_role',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_role',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_role',
    'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'角色信息表',
    'SCHEMA', N'dbo',
    'TABLE', N'system_role'
GO

-- ----------------------------
-- Records of system_role
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_role ON
GO
INSERT INTO system_role (id, name, code, sort, data_scope, data_scope_dept_ids, status, type, remark, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1, N'超级管理员', N'super_admin', 1, 1, N'', 0, 1, N'超级管理员', N'admin', N'2021-01-05 17:03:48', N'', N'2022-02-22 05:08:21', N'0', 1)
GO
INSERT INTO system_role (id, name, code, sort, data_scope, data_scope_dept_ids, status, type, remark, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2, N'普通角色', N'common', 2, 2, N'', 0, 1, N'普通角色', N'admin', N'2021-01-05 17:03:48', N'', N'2022-02-22 05:08:20', N'0', 1)
GO
GO
INSERT INTO system_role (id, name, code, sort, data_scope, data_scope_dept_ids, status, type, remark, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (109, N'租户管理员', N'tenant_admin', 0, 1, N'', 0, 1, N'系统自动生成', N'1', N'2022-02-22 00:56:14', N'1', N'2022-02-22 00:56:14', N'0', 121)
GO
INSERT INTO system_role (id, name, code, sort, data_scope, data_scope_dept_ids, status, type, remark, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (111, N'租户管理员', N'tenant_admin', 0, 1, N'', 0, 1, N'系统自动生成', N'1', N'2022-03-07 21:37:58', N'1', N'2022-03-07 21:37:58', N'0', 122)
GO
INSERT INTO system_role (id, name, code, sort, data_scope, data_scope_dept_ids, status, type, remark, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (155, N'测试数据权限1', N'test-dp', 4, 2, N'[112,100,102,103,104,105,107,108]', 0, 2, N'1111', N'1', N'2025-03-31 14:58:06', N'1', N'2025-12-04 23:29:40', N'0', 1)
GO
SET IDENTITY_INSERT system_role OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_role_menu
-- ----------------------------
DROP TABLE IF EXISTS system_role_menu
GO
CREATE TABLE system_role_menu (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    role_id bigint  NOT NULL,
    menu_id bigint  NOT NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL,
    tenant_id bigint DEFAULT 0 NOT NULL
)
GO

CREATE INDEX idx_system_role_menu_01 ON system_role_menu (role_id)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'自增编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_role_menu',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'角色ID',
    'SCHEMA', N'dbo',
    'TABLE', N'system_role_menu',
    'COLUMN', N'role_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'菜单ID',
    'SCHEMA', N'dbo',
    'TABLE', N'system_role_menu',
    'COLUMN', N'menu_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_role_menu',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_role_menu',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_role_menu',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_role_menu',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_role_menu',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_role_menu',
    'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'角色和菜单关联表',
    'SCHEMA', N'dbo',
    'TABLE', N'system_role_menu'
GO

-- ----------------------------
-- Records of system_role_menu
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_role_menu ON
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (263, 109, 1, N'1', N'2022-02-22 00:56:14', N'1', N'2022-02-22 00:56:14', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (434, 2, 1, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (454, 2, 1093, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (455, 2, 1094, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (460, 2, 1100, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (467, 2, 1107, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (476, 2, 1117, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (477, 2, 100, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (478, 2, 101, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (479, 2, 102, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (480, 2, 1126, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (481, 2, 103, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (483, 2, 104, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (485, 2, 105, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (488, 2, 107, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (490, 2, 108, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (492, 2, 109, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (498, 2, 1138, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (523, 2, 1224, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (524, 2, 1225, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (541, 2, 500, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (543, 2, 501, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (675, 2, 2, N'1', N'2022-02-22 13:16:57', N'1', N'2022-02-22 13:16:57', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (689, 2, 1077, N'1', N'2022-02-22 13:16:57', N'1', N'2022-02-22 13:16:57', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (690, 2, 1078, N'1', N'2022-02-22 13:16:57', N'1', N'2022-02-22 13:16:57', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (692, 2, 1083, N'1', N'2022-02-22 13:16:57', N'1', N'2022-02-22 13:16:57', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (693, 2, 1084, N'1', N'2022-02-22 13:16:57', N'1', N'2022-02-22 13:16:57', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (699, 2, 1090, N'1', N'2022-02-22 13:16:57', N'1', N'2022-02-22 13:16:57', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (703, 2, 106, N'1', N'2022-02-22 13:16:57', N'1', N'2022-02-22 13:16:57', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (704, 2, 110, N'1', N'2022-02-22 13:16:57', N'1', N'2022-02-22 13:16:57', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (705, 2, 111, N'1', N'2022-02-22 13:16:57', N'1', N'2022-02-22 13:16:57', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (706, 2, 112, N'1', N'2022-02-22 13:16:57', N'1', N'2022-02-22 13:16:57', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (707, 2, 113, N'1', N'2022-02-22 13:16:57', N'1', N'2022-02-22 13:16:57', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1296, 110, 1, N'110', N'2022-02-23 00:23:55', N'110', N'2022-02-23 00:23:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1578, 111, 1, N'1', N'2022-03-07 21:37:58', N'1', N'2022-03-07 21:37:58', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1729, 109, 100, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1730, 109, 101, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1731, 109, 1063, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1732, 109, 1064, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1733, 109, 1001, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1734, 109, 1065, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1735, 109, 1002, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1736, 109, 1003, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1737, 109, 1004, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1738, 109, 1005, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1739, 109, 1006, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1740, 109, 1007, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1741, 109, 1008, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1742, 109, 1009, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1743, 109, 1010, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1744, 109, 1011, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1745, 109, 1012, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1746, 111, 100, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1747, 111, 101, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1748, 111, 1063, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1749, 111, 1064, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1750, 111, 1001, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1751, 111, 1065, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1752, 111, 1002, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1753, 111, 1003, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1754, 111, 1004, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1755, 111, 1005, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1756, 111, 1006, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1757, 111, 1007, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1758, 111, 1008, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1759, 111, 1009, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1760, 111, 1010, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1761, 111, 1011, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1762, 111, 1012, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1763, 109, 100, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1764, 109, 101, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1765, 109, 1063, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1766, 109, 1064, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1767, 109, 1001, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1768, 109, 1065, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1769, 109, 1002, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1770, 109, 1003, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1771, 109, 1004, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1772, 109, 1005, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1773, 109, 1006, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1774, 109, 1007, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1775, 109, 1008, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1776, 109, 1009, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1777, 109, 1010, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1778, 109, 1011, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1779, 109, 1012, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1780, 111, 100, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1781, 111, 101, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1782, 111, 1063, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1783, 111, 1064, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1784, 111, 1001, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1785, 111, 1065, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1786, 111, 1002, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1787, 111, 1003, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1788, 111, 1004, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1789, 111, 1005, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1790, 111, 1006, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1791, 111, 1007, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1792, 111, 1008, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1793, 111, 1009, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1794, 111, 1010, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1795, 111, 1011, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1796, 111, 1012, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1797, 109, 100, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1798, 109, 101, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1799, 109, 1063, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1800, 109, 1064, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1801, 109, 1001, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1802, 109, 1065, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1803, 109, 1002, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1804, 109, 1003, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1805, 109, 1004, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1806, 109, 1005, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1807, 109, 1006, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1808, 109, 1007, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1809, 109, 1008, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1810, 109, 1009, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1811, 109, 1010, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1812, 109, 1011, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1813, 109, 1012, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1814, 111, 100, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1815, 111, 101, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1816, 111, 1063, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1817, 111, 1064, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1818, 111, 1001, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1819, 111, 1065, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1820, 111, 1002, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1821, 111, 1003, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1822, 111, 1004, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1823, 111, 1005, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1824, 111, 1006, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1825, 111, 1007, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1826, 111, 1008, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1827, 111, 1009, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1828, 111, 1010, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1829, 111, 1011, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1830, 111, 1012, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1831, 109, 103, N'1', N'2022-09-21 22:43:23', N'1', N'2022-09-21 22:43:23', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1832, 109, 1017, N'1', N'2022-09-21 22:43:23', N'1', N'2022-09-21 22:43:23', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1833, 109, 1018, N'1', N'2022-09-21 22:43:23', N'1', N'2022-09-21 22:43:23', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1834, 109, 1019, N'1', N'2022-09-21 22:43:23', N'1', N'2022-09-21 22:43:23', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1835, 109, 1020, N'1', N'2022-09-21 22:43:23', N'1', N'2022-09-21 22:43:23', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1836, 111, 103, N'1', N'2022-09-21 22:43:24', N'1', N'2022-09-21 22:43:24', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1837, 111, 1017, N'1', N'2022-09-21 22:43:24', N'1', N'2022-09-21 22:43:24', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1838, 111, 1018, N'1', N'2022-09-21 22:43:24', N'1', N'2022-09-21 22:43:24', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1839, 111, 1019, N'1', N'2022-09-21 22:43:24', N'1', N'2022-09-21 22:43:24', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1840, 111, 1020, N'1', N'2022-09-21 22:43:24', N'1', N'2022-09-21 22:43:24', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1841, 109, 1036, N'1', N'2022-09-21 22:48:13', N'1', N'2022-09-21 22:48:13', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1842, 109, 1037, N'1', N'2022-09-21 22:48:13', N'1', N'2022-09-21 22:48:13', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1843, 109, 1038, N'1', N'2022-09-21 22:48:13', N'1', N'2022-09-21 22:48:13', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1844, 109, 1039, N'1', N'2022-09-21 22:48:13', N'1', N'2022-09-21 22:48:13', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1845, 109, 107, N'1', N'2022-09-21 22:48:13', N'1', N'2022-09-21 22:48:13', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1846, 111, 1036, N'1', N'2022-09-21 22:48:13', N'1', N'2022-09-21 22:48:13', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1847, 111, 1037, N'1', N'2022-09-21 22:48:13', N'1', N'2022-09-21 22:48:13', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1848, 111, 1038, N'1', N'2022-09-21 22:48:13', N'1', N'2022-09-21 22:48:13', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1849, 111, 1039, N'1', N'2022-09-21 22:48:13', N'1', N'2022-09-21 22:48:13', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1850, 111, 107, N'1', N'2022-09-21 22:48:13', N'1', N'2022-09-21 22:48:13', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1991, 2, 1024, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1992, 2, 1025, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1993, 2, 1026, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1994, 2, 1027, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1995, 2, 1028, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1996, 2, 1029, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1997, 2, 1030, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1998, 2, 1031, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1999, 2, 1032, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2000, 2, 1033, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2001, 2, 1034, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2002, 2, 1035, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2003, 2, 1036, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2004, 2, 1037, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2005, 2, 1038, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2006, 2, 1039, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2007, 2, 1040, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2008, 2, 1042, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2009, 2, 1043, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2010, 2, 1045, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2011, 2, 1046, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2012, 2, 1048, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2013, 2, 1050, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2014, 2, 1051, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2015, 2, 1052, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2016, 2, 1053, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2017, 2, 1054, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2018, 2, 1056, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2019, 2, 1057, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2020, 2, 1058, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2021, 2, 2083, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2022, 2, 1059, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2023, 2, 1060, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2024, 2, 1063, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2025, 2, 1064, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2026, 2, 1065, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2027, 2, 1066, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2028, 2, 1067, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2029, 2, 1070, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2034, 2, 1075, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2036, 2, 1082, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2037, 2, 1085, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2038, 2, 1086, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2039, 2, 1087, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2040, 2, 1088, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2041, 2, 1089, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2042, 2, 1091, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2043, 2, 1092, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2044, 2, 1095, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2045, 2, 1096, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2046, 2, 1097, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2047, 2, 1098, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2048, 2, 1101, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2049, 2, 1102, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2050, 2, 1103, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2051, 2, 1104, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2052, 2, 1105, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2053, 2, 1106, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2054, 2, 1108, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2055, 2, 1109, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2061, 2, 1127, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2062, 2, 1128, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2063, 2, 1129, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2064, 2, 1130, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2066, 2, 1132, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2067, 2, 1133, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2068, 2, 1134, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2069, 2, 1135, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2070, 2, 1136, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2071, 2, 1137, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2072, 2, 114, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2073, 2, 1139, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2074, 2, 115, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2075, 2, 1140, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2076, 2, 116, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2077, 2, 1141, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2078, 2, 1142, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2079, 2, 1143, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2080, 2, 1150, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2081, 2, 1161, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2082, 2, 1162, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2086, 2, 1166, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2087, 2, 1173, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2088, 2, 1174, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2092, 2, 1178, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2099, 2, 1226, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2100, 2, 1227, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2101, 2, 1228, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2102, 2, 1229, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2103, 2, 1237, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2104, 2, 1238, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2105, 2, 1239, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2106, 2, 1240, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2107, 2, 1241, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2108, 2, 1242, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2109, 2, 1243, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2116, 2, 1254, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2117, 2, 1255, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2118, 2, 1256, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2119, 2, 1257, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2120, 2, 1258, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2121, 2, 1259, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2122, 2, 1260, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2123, 2, 1261, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2124, 2, 1263, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2125, 2, 1264, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2126, 2, 1265, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2127, 2, 1266, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2128, 2, 1267, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2129, 2, 1001, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2130, 2, 1002, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2131, 2, 1003, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2132, 2, 1004, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2133, 2, 1005, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2134, 2, 1006, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2135, 2, 1007, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2136, 2, 1008, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2137, 2, 1009, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2138, 2, 1010, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2139, 2, 1011, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2140, 2, 1012, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2141, 2, 1013, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2143, 2, 1015, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2145, 2, 1017, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2146, 2, 1018, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2147, 2, 1019, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2148, 2, 1020, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2149, 2, 1021, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2150, 2, 1022, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2151, 2, 1023, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2152, 2, 1281, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2153, 2, 1282, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2154, 2, 2000, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2155, 2, 2002, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2156, 2, 2003, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2157, 2, 2004, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2158, 2, 2005, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2159, 2, 2006, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2160, 2, 2008, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2161, 2, 2009, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2162, 2, 2010, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2163, 2, 2011, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2164, 2, 2012, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2170, 2, 2019, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2171, 2, 2020, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2172, 2, 2021, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2173, 2, 2022, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2174, 2, 2023, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2175, 2, 2025, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2177, 2, 2027, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2178, 2, 2028, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2179, 2, 2029, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2180, 2, 2014, N'1', N'2023-01-25 08:43:12', N'1', N'2023-01-25 08:43:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2181, 2, 2015, N'1', N'2023-01-25 08:43:12', N'1', N'2023-01-25 08:43:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2182, 2, 2016, N'1', N'2023-01-25 08:43:12', N'1', N'2023-01-25 08:43:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2183, 2, 2017, N'1', N'2023-01-25 08:43:12', N'1', N'2023-01-25 08:43:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2184, 2, 2018, N'1', N'2023-01-25 08:43:12', N'1', N'2023-01-25 08:43:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2929, 109, 1224, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2930, 109, 1225, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2931, 109, 1226, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2932, 109, 1227, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2933, 109, 1228, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2934, 109, 1229, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2935, 109, 1138, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2936, 109, 1139, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2937, 109, 1140, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2938, 109, 1141, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2939, 109, 1142, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2940, 109, 1143, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2941, 111, 1224, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2942, 111, 1225, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2943, 111, 1226, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2944, 111, 1227, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2945, 111, 1228, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2946, 111, 1229, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2947, 111, 1138, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2948, 111, 1139, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2949, 111, 1140, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2950, 111, 1141, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2951, 111, 1142, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2952, 111, 1143, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2993, 109, 2, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2994, 109, 1031, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2995, 109, 1032, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2996, 109, 1033, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2997, 109, 1034, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2998, 109, 1035, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2999, 109, 1050, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3000, 109, 1051, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3001, 109, 1052, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3002, 109, 1053, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3003, 109, 1054, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3004, 109, 1056, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3005, 109, 1057, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3006, 109, 1058, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3007, 109, 1059, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3008, 109, 1060, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3009, 109, 1066, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3010, 109, 1067, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3011, 109, 1070, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3012, 109, 1075, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3014, 109, 1077, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3015, 109, 1078, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3016, 109, 1082, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3017, 109, 1083, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3018, 109, 1084, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3019, 109, 1085, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3020, 109, 1086, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3021, 109, 1087, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3022, 109, 1088, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3023, 109, 1089, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3024, 109, 1090, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3025, 109, 1091, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3026, 109, 1092, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3027, 109, 106, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3028, 109, 110, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3029, 109, 111, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3030, 109, 112, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3031, 109, 113, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3032, 109, 114, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3033, 109, 115, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3034, 109, 116, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3035, 109, 2472, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3036, 109, 2478, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3037, 109, 2479, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3038, 109, 2480, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3039, 109, 2481, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3040, 109, 2482, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3041, 109, 2483, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3042, 109, 2484, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3043, 109, 2485, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3044, 109, 2486, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3045, 109, 2487, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3046, 109, 2488, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3047, 109, 2489, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3048, 109, 2490, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3049, 109, 2491, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3050, 109, 2492, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3051, 109, 2493, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3052, 109, 2494, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3053, 109, 2495, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3054, 109, 2497, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3055, 109, 1237, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3056, 109, 1238, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3057, 109, 1239, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3058, 109, 1240, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3059, 109, 1241, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3060, 109, 1242, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3061, 109, 1243, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3062, 109, 2525, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3063, 109, 1255, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3064, 109, 1256, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3065, 109, 1257, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3066, 109, 1258, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3067, 109, 1259, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3068, 109, 1260, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3069, 111, 2, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3070, 111, 1031, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3071, 111, 1032, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3072, 111, 1033, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3073, 111, 1034, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3074, 111, 1035, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3075, 111, 1050, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3076, 111, 1051, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3077, 111, 1052, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3078, 111, 1053, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3079, 111, 1054, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3080, 111, 1056, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3081, 111, 1057, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3082, 111, 1058, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3083, 111, 1059, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3084, 111, 1060, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3085, 111, 1066, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3086, 111, 1067, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3087, 111, 1070, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3088, 111, 1075, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3090, 111, 1077, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3091, 111, 1078, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3092, 111, 1082, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3093, 111, 1083, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3094, 111, 1084, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3095, 111, 1085, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3096, 111, 1086, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3097, 111, 1087, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3098, 111, 1088, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3099, 111, 1089, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3100, 111, 1090, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3101, 111, 1091, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3102, 111, 1092, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3103, 111, 106, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3104, 111, 110, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3105, 111, 111, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3106, 111, 112, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3107, 111, 113, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3108, 111, 114, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3109, 111, 115, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3110, 111, 116, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3111, 111, 2472, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3112, 111, 2478, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3113, 111, 2479, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3114, 111, 2480, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3115, 111, 2481, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3116, 111, 2482, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3117, 111, 2483, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3118, 111, 2484, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3119, 111, 2485, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3120, 111, 2486, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3121, 111, 2487, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3122, 111, 2488, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3123, 111, 2489, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3124, 111, 2490, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3125, 111, 2491, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3126, 111, 2492, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3127, 111, 2493, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3128, 111, 2494, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3129, 111, 2495, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3130, 111, 2497, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3131, 111, 1237, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3132, 111, 1238, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3133, 111, 1239, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3134, 111, 1240, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3135, 111, 1241, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3136, 111, 1242, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3137, 111, 1243, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3138, 111, 2525, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3139, 111, 1255, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3140, 111, 1256, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3141, 111, 1257, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3142, 111, 1258, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3143, 111, 1259, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3144, 111, 1260, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3221, 109, 102, N'1', N'2023-12-30 11:42:36', N'1', N'2023-12-30 11:42:36', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3222, 109, 1013, N'1', N'2023-12-30 11:42:36', N'1', N'2023-12-30 11:42:36', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3223, 109, 1014, N'1', N'2023-12-30 11:42:36', N'1', N'2023-12-30 11:42:36', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3224, 109, 1015, N'1', N'2023-12-30 11:42:36', N'1', N'2023-12-30 11:42:36', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3225, 109, 1016, N'1', N'2023-12-30 11:42:36', N'1', N'2023-12-30 11:42:36', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3226, 111, 102, N'1', N'2023-12-30 11:42:36', N'1', N'2023-12-30 11:42:36', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3227, 111, 1013, N'1', N'2023-12-30 11:42:36', N'1', N'2023-12-30 11:42:36', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3228, 111, 1014, N'1', N'2023-12-30 11:42:36', N'1', N'2023-12-30 11:42:36', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3229, 111, 1015, N'1', N'2023-12-30 11:42:36', N'1', N'2023-12-30 11:42:36', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3230, 111, 1016, N'1', N'2023-12-30 11:42:36', N'1', N'2023-12-30 11:42:36', N'0', 122)
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5779, 2, 2739, N'1', N'2024-07-07 20:39:38', N'1', N'2024-07-07 20:39:38', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5780, 2, 2740, N'1', N'2024-07-07 20:39:38', N'1', N'2024-07-07 20:39:38', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5781, 2, 2758, N'1', N'2024-07-07 20:39:38', N'1', N'2024-07-07 20:39:38', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5782, 2, 2759, N'1', N'2024-07-07 20:39:38', N'1', N'2024-07-07 20:39:38', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5783, 2, 2362, N'1', N'2024-07-07 20:39:38', N'1', N'2024-07-07 20:39:38', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5784, 2, 2387, N'1', N'2024-07-07 20:39:38', N'1', N'2024-07-07 20:39:38', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5785, 2, 2030, N'1', N'2024-07-07 20:39:38', N'1', N'2024-07-07 20:39:38', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5789, 109, 2739, N'1', N'2024-07-13 22:37:24', N'1', N'2024-07-13 22:37:24', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5790, 109, 2740, N'1', N'2024-07-13 22:37:24', N'1', N'2024-07-13 22:37:24', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5791, 111, 2739, N'1', N'2024-07-13 22:37:24', N'1', N'2024-07-13 22:37:24', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5792, 111, 2740, N'1', N'2024-07-13 22:37:24', N'1', N'2024-07-13 22:37:24', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6053, 155, 4000, N'1', N'2025-04-01 13:48:26', N'1', N'2025-04-01 13:48:26', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6097, 155, 4050, N'1', N'2025-04-01 13:48:26', N'1', N'2025-04-01 13:48:26', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6104, 155, 4032, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6105, 155, 4033, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6106, 155, 4034, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6107, 155, 4035, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6108, 155, 4036, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6109, 155, 4037, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6110, 155, 4038, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6111, 155, 4039, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6112, 155, 4040, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6113, 155, 4041, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6114, 155, 4042, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6115, 155, 4043, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6116, 155, 4044, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6117, 155, 4045, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6119, 155, 4001, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6120, 155, 4002, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6121, 155, 4003, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6122, 155, 4004, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6123, 155, 4005, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6124, 155, 4006, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6125, 155, 4007, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6126, 155, 4008, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6127, 155, 4009, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6128, 155, 4010, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6129, 155, 4011, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6130, 155, 4012, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6131, 155, 4013, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6132, 155, 4014, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6133, 155, 4015, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6134, 155, 4016, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6135, 155, 4017, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6136, 155, 4018, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6137, 155, 4031, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6139, 109, 1117, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6140, 109, 1126, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6141, 109, 1127, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6142, 109, 1128, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6143, 109, 1129, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6144, 109, 1130, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6145, 109, 1132, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6146, 109, 1133, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6147, 109, 1134, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6148, 109, 1135, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6149, 109, 1136, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6150, 109, 1137, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6151, 109, 2161, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6152, 109, 1150, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6153, 109, 1161, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6154, 109, 1162, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6155, 109, 1166, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6156, 109, 1173, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6157, 109, 1174, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6158, 109, 1178, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6159, 109, 2745, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6160, 109, 2746, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6161, 109, 2747, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6162, 109, 2748, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6163, 109, 2301, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6164, 109, 2302, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6165, 109, 5011, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6166, 109, 5012, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6167, 109, 2549, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6168, 109, 2550, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6169, 109, 2551, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6170, 109, 2552, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6171, 109, 2553, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6172, 109, 2554, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6173, 109, 2555, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6174, 109, 2556, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6175, 109, 2557, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6176, 109, 2558, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6177, 109, 2559, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6178, 111, 1117, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6179, 111, 1126, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6180, 111, 1127, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6181, 111, 1128, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6182, 111, 1129, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6183, 111, 1130, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6184, 111, 1132, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6185, 111, 1133, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6186, 111, 1134, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6187, 111, 1135, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6188, 111, 1136, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6189, 111, 1137, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6190, 111, 2161, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6191, 111, 1150, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6192, 111, 1161, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6193, 111, 1162, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6194, 111, 1166, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6195, 111, 1173, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6196, 111, 1174, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6197, 111, 1178, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6198, 111, 2745, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6199, 111, 2746, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6200, 111, 2747, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6201, 111, 2748, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6202, 111, 2301, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6203, 111, 2302, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6204, 111, 5011, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6205, 111, 5012, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6206, 111, 2549, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6207, 111, 2550, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6208, 111, 2551, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6209, 111, 2552, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6210, 111, 2553, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6211, 111, 2554, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6212, 111, 2555, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6213, 111, 2556, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6214, 111, 2557, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6215, 111, 2558, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6216, 111, 2559, N'1', N'2025-09-06 20:52:12', N'1', N'2025-09-06 20:52:12', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6217, 109, 2756, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6218, 109, 2757, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6219, 109, 2262, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6220, 109, 2275, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6221, 109, 2276, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6222, 109, 2277, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6223, 109, 2281, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6224, 109, 2282, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6225, 109, 2283, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6226, 109, 2284, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6227, 109, 2285, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6228, 109, 2287, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6229, 109, 2288, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6230, 109, 2293, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6231, 109, 2294, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6232, 109, 2297, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6233, 109, 2300, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6234, 109, 2317, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6235, 109, 2318, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6236, 109, 2319, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6237, 109, 2320, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6238, 109, 2321, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6239, 109, 2322, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6240, 109, 2323, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6241, 109, 2324, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6242, 109, 2325, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6243, 109, 2326, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6244, 109, 2327, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6245, 109, 2328, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6246, 109, 2329, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6247, 109, 2330, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6248, 109, 2331, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6249, 109, 2332, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6250, 109, 2333, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6251, 109, 2334, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6252, 109, 2335, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6253, 109, 2363, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6254, 109, 2364, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6255, 111, 2756, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6256, 111, 2757, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6257, 111, 2262, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6258, 111, 2275, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6259, 111, 2276, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6260, 111, 2277, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6261, 111, 2281, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6262, 111, 2282, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6263, 111, 2283, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6264, 111, 2284, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6265, 111, 2285, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6266, 111, 2287, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6267, 111, 2288, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6268, 111, 2293, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6269, 111, 2294, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6270, 111, 2297, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6271, 111, 2300, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6272, 111, 2317, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6273, 111, 2318, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6274, 111, 2319, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6275, 111, 2320, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6276, 111, 2321, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6277, 111, 2322, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6278, 111, 2323, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6279, 111, 2324, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6280, 111, 2325, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6281, 111, 2326, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6282, 111, 2327, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6283, 111, 2328, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6284, 111, 2329, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6285, 111, 2330, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6286, 111, 2331, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6287, 111, 2332, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6288, 111, 2333, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6289, 111, 2334, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6290, 111, 2335, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6291, 111, 2363, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6292, 111, 2364, N'1', N'2025-09-06 20:52:25', N'1', N'2025-09-06 20:52:25', N'0', 122)
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6352, 1, 5720, N'1', N'2026-02-19 04:24:53', N'1', N'2026-02-19 04:24:53', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6353, 1, 5721, N'1', N'2026-02-19 04:24:53', N'1', N'2026-02-19 04:24:53', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6354, 1, 5722, N'1', N'2026-02-19 04:24:53', N'1', N'2026-02-19 04:24:53', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6355, 1, 5723, N'1', N'2026-02-19 04:24:53', N'1', N'2026-02-19 04:24:53', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6356, 1, 5724, N'1', N'2026-02-19 04:24:53', N'1', N'2026-02-19 04:24:53', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6357, 1, 5725, N'1', N'2026-02-19 04:24:53', N'1', N'2026-02-19 04:24:53', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6358, 1, 5811, N'', N'2026-03-30 03:11:59', N'', N'2026-03-30 03:11:59', N'0', 0)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6359, 1, 5811, N'', N'2026-03-30 03:13:05', N'', N'2026-03-30 03:13:05', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6360, 2, 5811, N'', N'2026-03-30 03:13:05', N'', N'2026-03-30 03:13:05', N'0', 1)
GO
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6362, 109, 5811, N'', N'2026-03-30 03:13:05', N'', N'2026-03-30 03:13:05', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6363, 111, 5811, N'', N'2026-03-30 03:13:05', N'', N'2026-03-30 03:13:05', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6364, 155, 5811, N'', N'2026-03-30 03:13:05', N'', N'2026-03-30 03:13:05', N'0', 1)
GO
SET IDENTITY_INSERT system_role_menu OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_sms_channel
-- ----------------------------
DROP TABLE IF EXISTS system_sms_channel
GO
CREATE TABLE system_sms_channel (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    signature nvarchar(12)  NOT NULL,
    code nvarchar(63)  NOT NULL,
    status tinyint  NOT NULL,
    remark nvarchar(255) DEFAULT NULL NULL,
    api_key nvarchar(128)  NOT NULL,
    api_secret nvarchar(128) DEFAULT NULL NULL,
    callback_url nvarchar(255) DEFAULT NULL NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL
)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_channel',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'短信签名',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_channel',
    'COLUMN', N'signature'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'渠道编码',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_channel',
    'COLUMN', N'code'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'开启状态',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_channel',
    'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'备注',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_channel',
    'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'短信 API 的账号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_channel',
    'COLUMN', N'api_key'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'短信 API 的秘钥',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_channel',
    'COLUMN', N'api_secret'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'短信发送回调 URL',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_channel',
    'COLUMN', N'callback_url'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_channel',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_channel',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_channel',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_channel',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_channel',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'短信渠道',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_channel'
GO

-- ----------------------------
-- Records of system_sms_channel
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_sms_channel ON
GO
INSERT INTO system_sms_channel (id, signature, code, status, remark, api_key, api_secret, callback_url, creator, create_time, updater, update_time, deleted) VALUES (2, N'Ballcat', N'ALIYUN', 0, N'你要改哦，只有我可以用！！！！', N'your-aliyun-access-key-id', N'your-aliyun-access-key-secret', NULL, N'', N'2021-03-31 11:53:10', N'1', N'2024-08-04 08:53:26', N'0')
GO
INSERT INTO system_sms_channel (id, signature, code, status, remark, api_key, api_secret, callback_url, creator, create_time, updater, update_time, deleted) VALUES (4, N'测试渠道', N'DEBUG_DING_TALK', 0, N'123', N'your-dingtalk-webhook-access-token', N'your-dingtalk-webhook-secret', NULL, N'1', N'2021-04-13 00:23:14', N'1', N'2022-03-27 20:29:49', N'0')
GO
INSERT INTO system_sms_channel (id, signature, code, status, remark, api_key, api_secret, callback_url, creator, create_time, updater, update_time, deleted) VALUES (7, N'mock腾讯云', N'TENCENT', 0, N'123', N'1 2', N'2 3', N'', N'1', N'2024-09-30 08:53:45', N'1', N'2025-12-20 11:30:18', N'0')
GO
SET IDENTITY_INSERT system_sms_channel OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_sms_code
-- ----------------------------
DROP TABLE IF EXISTS system_sms_code
GO
CREATE TABLE system_sms_code (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    mobile nvarchar(11)  NOT NULL,
    code nvarchar(6)  NOT NULL,
    create_ip nvarchar(15)  NOT NULL,
    scene tinyint  NOT NULL,
    today_index tinyint  NOT NULL,
    used tinyint  NOT NULL,
    used_time datetime2 DEFAULT NULL NULL,
    used_ip nvarchar(255) DEFAULT NULL NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL,
    tenant_id bigint DEFAULT 0 NOT NULL
)
GO

CREATE INDEX idx_system_sms_code_01 ON system_sms_code (mobile)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_code',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'手机号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_code',
    'COLUMN', N'mobile'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'验证码',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_code',
    'COLUMN', N'code'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建 IP',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_code',
    'COLUMN', N'create_ip'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'发送场景',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_code',
    'COLUMN', N'scene'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'今日发送的第几条',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_code',
    'COLUMN', N'today_index'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否使用',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_code',
    'COLUMN', N'used'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'使用时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_code',
    'COLUMN', N'used_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'使用 IP',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_code',
    'COLUMN', N'used_ip'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_code',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_code',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_code',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_code',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_code',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_code',
    'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'手机验证码',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_code'
GO

-- ----------------------------
-- Table structure for system_sms_log
-- ----------------------------
DROP TABLE IF EXISTS system_sms_log
GO
CREATE TABLE system_sms_log (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    channel_id bigint  NOT NULL,
    channel_code nvarchar(63)  NOT NULL,
    template_id bigint  NOT NULL,
    template_code nvarchar(63)  NOT NULL,
    template_type tinyint  NOT NULL,
    template_content nvarchar(255)  NOT NULL,
    template_params nvarchar(255)  NOT NULL,
    api_template_id nvarchar(63)  NOT NULL,
    mobile nvarchar(11)  NOT NULL,
    user_id bigint DEFAULT NULL NULL,
    user_type tinyint DEFAULT NULL NULL,
    send_status tinyint DEFAULT 0 NOT NULL,
    send_time datetime2 DEFAULT NULL NULL,
    api_send_code nvarchar(63) DEFAULT NULL NULL,
    api_send_msg nvarchar(255) DEFAULT NULL NULL,
    api_request_id nvarchar(255) DEFAULT NULL NULL,
    api_serial_no nvarchar(255) DEFAULT NULL NULL,
    receive_status tinyint DEFAULT 0 NOT NULL,
    receive_time datetime2 DEFAULT NULL NULL,
    api_receive_code nvarchar(63) DEFAULT NULL NULL,
    api_receive_msg nvarchar(255) DEFAULT NULL NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL
)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_log',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'短信渠道编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_log',
    'COLUMN', N'channel_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'短信渠道编码',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_log',
    'COLUMN', N'channel_code'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'模板编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_log',
    'COLUMN', N'template_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'模板编码',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_log',
    'COLUMN', N'template_code'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'短信类型',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_log',
    'COLUMN', N'template_type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'短信内容',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_log',
    'COLUMN', N'template_content'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'短信参数',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_log',
    'COLUMN', N'template_params'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'短信 API 的模板编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_log',
    'COLUMN', N'api_template_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'手机号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_log',
    'COLUMN', N'mobile'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_log',
    'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户类型',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_log',
    'COLUMN', N'user_type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'发送状态',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_log',
    'COLUMN', N'send_status'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'发送时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_log',
    'COLUMN', N'send_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'短信 API 发送结果的编码',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_log',
    'COLUMN', N'api_send_code'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'短信 API 发送失败的提示',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_log',
    'COLUMN', N'api_send_msg'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'短信 API 发送返回的唯一请求 ID',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_log',
    'COLUMN', N'api_request_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'短信 API 发送返回的序号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_log',
    'COLUMN', N'api_serial_no'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'接收状态',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_log',
    'COLUMN', N'receive_status'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'接收时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_log',
    'COLUMN', N'receive_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'API 接收结果的编码',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_log',
    'COLUMN', N'api_receive_code'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'API 接收结果的说明',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_log',
    'COLUMN', N'api_receive_msg'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_log',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_log',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_log',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_log',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_log',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'短信日志',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_log'
GO

-- ----------------------------
-- Table structure for system_sms_template
-- ----------------------------
DROP TABLE IF EXISTS system_sms_template
GO
CREATE TABLE system_sms_template (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    type tinyint  NOT NULL,
    status tinyint  NOT NULL,
    code nvarchar(63)  NOT NULL,
    name nvarchar(63)  NOT NULL,
    content nvarchar(255)  NOT NULL,
    params nvarchar(255)  NOT NULL,
    remark nvarchar(255) DEFAULT NULL NULL,
    api_template_id nvarchar(63)  NOT NULL,
    channel_id bigint  NOT NULL,
    channel_code nvarchar(63)  NOT NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL
)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_template',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'模板类型',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_template',
    'COLUMN', N'type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'开启状态',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_template',
    'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'模板编码',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_template',
    'COLUMN', N'code'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'模板名称',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_template',
    'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'模板内容',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_template',
    'COLUMN', N'content'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'参数数组',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_template',
    'COLUMN', N'params'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'备注',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_template',
    'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'短信 API 的模板编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_template',
    'COLUMN', N'api_template_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'短信渠道编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_template',
    'COLUMN', N'channel_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'短信渠道编码',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_template',
    'COLUMN', N'channel_code'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_template',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_template',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_template',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_template',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_template',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'短信模板',
    'SCHEMA', N'dbo',
    'TABLE', N'system_sms_template'
GO

-- ----------------------------
-- Records of system_sms_template
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_sms_template ON
GO
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (2, 1, 0, N'test_01', N'测试验证码短信', N'正在进行登录操作{operation}，您的验证码是{code}', N'["operation","code"]', N'测试备注', N'4383920', 4, N'DEBUG_DING_TALK', N'', N'2021-03-31 10:49:38', N'1', N'2024-08-18 11:57:18', N'0')
GO
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (3, 1, 0, N'test_02', N'公告通知', N'您的验证码{code}，该验证码5分钟内有效，请勿泄漏于他人！', N'["code"]', NULL, N'SMS_207945135', 2, N'ALIYUN', N'', N'2021-03-31 11:56:30', N'1', N'2021-04-10 01:22:02', N'0')
GO
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (6, 3, 0, N'test-01', N'测试模板', N'哈哈哈 {name}', N'["name"]', N'f哈哈哈', N'4383920', 4, N'DEBUG_DING_TALK', N'1', N'2021-04-10 01:07:21', N'1', N'2024-08-18 11:57:07', N'0')
GO
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (7, 3, 0, N'test-04', N'测试下', N'老鸡{name}，牛逼{code}', N'["name","code"]', N'哈哈哈哈', N'suibian', 7, N'DEBUG_DING_TALK', N'1', N'2021-04-13 00:29:53', N'1', N'2024-09-30 00:56:24', N'0')
GO
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (8, 1, 0, N'user-sms-login', N'前台用户短信登录', N'您的验证码是{code}', N'["code"]', NULL, N'4372216', 4, N'DEBUG_DING_TALK', N'1', N'2021-10-11 08:10:00', N'1', N'2024-08-18 11:57:06', N'0')
GO
GO
GO
GO
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (12, 2, 0, N'demo', N'演示模板', N'我就是测试一下下', N'[]', NULL, N'biubiubiu', 4, N'DEBUG_DING_TALK', N'1', N'2022-04-10 23:22:49', N'1', N'2024-08-18 11:57:04', N'0')
GO
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (14, 1, 0, N'user-update-mobile', N'会员用户 - 修改手机', N'您的验证码{code}，该验证码 5 分钟内有效，请勿泄漏于他人！', N'["code"]', N'', N'null', 4, N'DEBUG_DING_TALK', N'1', N'2023-08-19 18:58:01', N'1', N'2023-08-19 11:34:04', N'0')
GO
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (15, 1, 0, N'user-update-password', N'会员用户 - 修改密码', N'您的验证码{code}，该验证码 5 分钟内有效，请勿泄漏于他人！', N'["code"]', N'', N'null', 4, N'DEBUG_DING_TALK', N'1', N'2023-08-19 18:58:01', N'1', N'2023-08-19 11:34:18', N'0')
GO
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (16, 1, 0, N'user-reset-password', N'会员用户 - 重置密码', N'您的验证码{code}，该验证码 5 分钟内有效，请勿泄漏于他人！', N'["code"]', N'', N'null', 4, N'DEBUG_DING_TALK', N'1', N'2023-08-19 18:58:01', N'1', N'2023-12-02 22:35:27', N'0')
GO
GO
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (18, 1, 0, N'admin-reset-password', N'后台用户 - 忘记密码', N'您的验证码{code}，该验证码 5 分钟内有效，请勿泄漏于他人！', N'["code"]', N'', N'null', 4, N'DEBUG_DING_TALK', N'1', N'2025-03-16 14:19:34', N'1', N'2025-03-16 14:19:45', N'0')
GO
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (19, 1, 0, N'admin-sms-login', N'后台用户短信登录', N'您的验证码是{code}', N'["code"]', N'', N'4372216', 4, N'DEBUG_DING_TALK', N'1', N'2025-04-08 09:36:03', N'1', N'2025-04-08 09:36:17', N'0')
GO
SET IDENTITY_INSERT system_sms_template OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_social_client
-- ----------------------------
DROP TABLE IF EXISTS system_social_client
GO
CREATE TABLE system_social_client (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    name nvarchar(255)  NOT NULL,
    social_type tinyint  NOT NULL,
    user_type tinyint  NOT NULL,
    client_id nvarchar(255)  NOT NULL,
    client_secret nvarchar(255)  NOT NULL,
    agent_id nvarchar(255) DEFAULT NULL NULL,
    public_key nvarchar(2048) DEFAULT NULL NULL,
    status tinyint  NOT NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL,
    tenant_id bigint DEFAULT 0 NOT NULL
)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_client',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'应用名',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_client',
    'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'社交平台的类型',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_client',
    'COLUMN', N'social_type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户类型',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_client',
    'COLUMN', N'user_type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'客户端编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_client',
    'COLUMN', N'client_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'客户端密钥',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_client',
    'COLUMN', N'client_secret'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'代理编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_client',
    'COLUMN', N'agent_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'publicKey 公钥',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_client',
    'COLUMN', N'public_key'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'状态',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_client',
    'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_client',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_client',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_client',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_client',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_client',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_client',
    'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'社交客户端表',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_client'
GO

-- ----------------------------
-- Records of system_social_client
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_social_client ON
GO
INSERT INTO system_social_client (id, name, social_type, user_type, client_id, client_secret, agent_id, public_key, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1, N'钉钉', 20, 2, N'<scrubbed-dingtalk-client-id>', N'<scrubbed-dingtalk-secret>', NULL, NULL, 0, N'', N'2023-10-18 11:21:18', N'1', N'2023-12-20 21:28:26', N'1', 1)
GO
INSERT INTO system_social_client (id, name, social_type, user_type, client_id, client_secret, agent_id, public_key, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2, N'钉钉（王土豆）', 20, 2, N'dingtsu9hpepjkbmthhw', N'FP_bnSq_HAHKCSncmJjw5hxhnzs6vaVDSZZn3egj6rdqTQ_hu5tQVJyLMpgCakdP', NULL, NULL, 0, N'', N'2023-10-18 11:21:18', N'', N'2023-12-20 21:28:26', N'1', 121)
GO
INSERT INTO system_social_client (id, name, social_type, user_type, client_id, client_secret, agent_id, public_key, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3, N'微信公众号', 31, 1, N'<scrubbed-wx-mp-appid-legacy>', N'<scrubbed-wx-mp-secret-legacy>', NULL, NULL, 0, N'', N'2023-10-18 16:07:46', N'1', N'2023-12-20 21:28:23', N'1', 1)
GO
INSERT INTO system_social_client (id, name, social_type, user_type, client_id, client_secret, agent_id, public_key, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (43, N'微信小程序', 34, 1, N'<scrubbed-wx-miniapp-appid-legacy>', N'<scrubbed-wx-miniapp-secret-legacy>', NULL, NULL, 0, N'', N'2023-10-19 13:37:41', N'1', N'2023-12-20 21:28:25', N'1', 1)
GO
INSERT INTO system_social_client (id, name, social_type, user_type, client_id, client_secret, agent_id, public_key, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (44, N'1', 10, 1, N'2', N'3', NULL, NULL, 0, N'1', N'2025-04-06 20:36:28', N'1', N'2025-04-06 20:43:12', N'1', 1)
GO
INSERT INTO system_social_client (id, name, social_type, user_type, client_id, client_secret, agent_id, public_key, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (45, N'1', 10, 1, N'2', N'3', NULL, NULL, 1, N'1', N'2025-09-06 20:26:15', N'1', N'2025-09-06 20:27:55', N'1', 1)
GO
INSERT INTO system_social_client (id, name, social_type, user_type, client_id, client_secret, agent_id, public_key, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (46, N'1', 10, 1, N'2', N'3', NULL, NULL, 0, N'1', N'2025-11-29 16:04:23', N'1', N'2025-11-29 16:04:26', N'1', 1)
GO
INSERT INTO system_social_client (id, name, social_type, user_type, client_id, client_secret, agent_id, public_key, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (47, N'123', 10, 1, N'1', N'2', N'3', NULL, 0, N'1', N'2025-12-21 10:27:02', N'1', N'2025-12-21 10:27:20', N'1', 1)
GO
SET IDENTITY_INSERT system_social_client OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_social_user
-- ----------------------------
DROP TABLE IF EXISTS system_social_user
GO
CREATE TABLE system_social_user (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    type tinyint  NOT NULL,
    openid nvarchar(32)  NOT NULL,
    token nvarchar(256) DEFAULT NULL NULL,
    raw_token_info nvarchar(1024)  NOT NULL,
    nickname nvarchar(32)  NOT NULL,
    avatar nvarchar(255) DEFAULT NULL NULL,
    raw_user_info nvarchar(1024)  NOT NULL,
    code nvarchar(256)  NOT NULL,
    state nvarchar(256) DEFAULT NULL NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL,
    tenant_id bigint DEFAULT 0 NOT NULL
)
GO

CREATE INDEX idx_system_social_user_01 ON system_social_user (type, openid)
GO
CREATE INDEX idx_system_social_user_02 ON system_social_user (type, code, state)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'主键(自增策略)',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_user',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'社交平台的类型',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_user',
    'COLUMN', N'type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'社交 openid',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_user',
    'COLUMN', N'openid'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'社交 token',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_user',
    'COLUMN', N'token'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'原始 Token 数据，一般是 JSON 格式',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_user',
    'COLUMN', N'raw_token_info'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户昵称',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_user',
    'COLUMN', N'nickname'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户头像',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_user',
    'COLUMN', N'avatar'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'原始用户数据，一般是 JSON 格式',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_user',
    'COLUMN', N'raw_user_info'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'最后一次的认证 code',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_user',
    'COLUMN', N'code'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'最后一次的认证 state',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_user',
    'COLUMN', N'state'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_user',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_user',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_user',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_user',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_user',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_user',
    'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'社交用户表',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_user'
GO

-- ----------------------------
-- Table structure for system_social_user_bind
-- ----------------------------
DROP TABLE IF EXISTS system_social_user_bind
GO
CREATE TABLE system_social_user_bind (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    user_id bigint  NOT NULL,
    user_type tinyint  NOT NULL,
    social_type tinyint  NOT NULL,
    social_user_id bigint  NOT NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL,
    tenant_id bigint DEFAULT 0 NOT NULL
)
GO

CREATE INDEX idx_system_social_user_bind_01 ON system_social_user_bind (user_type, social_user_id)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'主键(自增策略)',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_user_bind',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_user_bind',
    'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户类型',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_user_bind',
    'COLUMN', N'user_type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'社交平台的类型',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_user_bind',
    'COLUMN', N'social_type'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'社交用户的编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_user_bind',
    'COLUMN', N'social_user_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_user_bind',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_user_bind',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_user_bind',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_user_bind',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_user_bind',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_user_bind',
    'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'社交绑定表',
    'SCHEMA', N'dbo',
    'TABLE', N'system_social_user_bind'
GO

-- ----------------------------
-- Table structure for system_tenant
-- ----------------------------
DROP TABLE IF EXISTS system_tenant
GO
CREATE TABLE system_tenant (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    name nvarchar(30)  NOT NULL,
    contact_user_id bigint DEFAULT NULL NULL,
    contact_name nvarchar(30)  NOT NULL,
    contact_mobile nvarchar(500) DEFAULT NULL NULL,
    status tinyint DEFAULT 0 NOT NULL,
    websites nvarchar(1024) DEFAULT '' NULL,
    package_id bigint  NOT NULL,
    expire_time datetime2  NOT NULL,
    account_count int  NOT NULL,
    creator nvarchar(64) DEFAULT '' NOT NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL
)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_tenant',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户名',
    'SCHEMA', N'dbo',
    'TABLE', N'system_tenant',
    'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'联系人的用户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_tenant',
    'COLUMN', N'contact_user_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'联系人',
    'SCHEMA', N'dbo',
    'TABLE', N'system_tenant',
    'COLUMN', N'contact_name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'联系手机',
    'SCHEMA', N'dbo',
    'TABLE', N'system_tenant',
    'COLUMN', N'contact_mobile'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户状态',
    'SCHEMA', N'dbo',
    'TABLE', N'system_tenant',
    'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'绑定域名数组',
    'SCHEMA', N'dbo',
    'TABLE', N'system_tenant',
    'COLUMN', N'websites'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户套餐编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_tenant',
    'COLUMN', N'package_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'过期时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_tenant',
    'COLUMN', N'expire_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'账号数量',
    'SCHEMA', N'dbo',
    'TABLE', N'system_tenant',
    'COLUMN', N'account_count'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_tenant',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_tenant',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_tenant',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_tenant',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_tenant',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户表',
    'SCHEMA', N'dbo',
    'TABLE', N'system_tenant'
GO

-- ----------------------------
-- Records of system_tenant
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_tenant ON
GO
INSERT INTO system_tenant (id, name, contact_user_id, contact_name, contact_mobile, status, websites, package_id, expire_time, account_count, creator, create_time, updater, update_time, deleted) VALUES (1, N'光何', NULL, N'光何', N'17321315478', 0, N'127.0.0.1:3000', 0, N'2099-02-19 17:14:16', 9999, N'1', N'2021-01-05 17:03:47', N'1', N'2025-08-19 05:18:41', N'0')
GO
INSERT INTO system_tenant (id, name, contact_user_id, contact_name, contact_mobile, status, websites, package_id, expire_time, account_count, creator, create_time, updater, update_time, deleted) VALUES (121, N'小租户', 110, N'小王2', N'15601691300', 0, N'', 111, N'2026-07-10 00:00:00', 30, N'1', N'2022-02-22 00:56:14', N'1', N'2025-08-19 21:19:29', N'0')
GO
INSERT INTO system_tenant (id, name, contact_user_id, contact_name, contact_mobile, status, websites, package_id, expire_time, account_count, creator, create_time, updater, update_time, deleted) VALUES (122, N'测试租户', 113, N'光何', N'15601691300', 0, N'', 111, N'2023-04-29 00:00:00', 50, N'1', N'2022-03-07 21:37:58', N'1', N'2025-12-21 09:50:00', N'0')
GO
SET IDENTITY_INSERT system_tenant OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_tenant_package
-- ----------------------------
DROP TABLE IF EXISTS system_tenant_package
GO
CREATE TABLE system_tenant_package (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    name nvarchar(30)  NOT NULL,
    status tinyint DEFAULT 0 NOT NULL,
    remark nvarchar(256) DEFAULT '' NULL,
    menu_ids nvarchar(4000)  NOT NULL,
    creator nvarchar(64) DEFAULT '' NOT NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL
)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'套餐编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_tenant_package',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'套餐名',
    'SCHEMA', N'dbo',
    'TABLE', N'system_tenant_package',
    'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户状态（0正常 1停用）',
    'SCHEMA', N'dbo',
    'TABLE', N'system_tenant_package',
    'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'备注',
    'SCHEMA', N'dbo',
    'TABLE', N'system_tenant_package',
    'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'关联的菜单编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_tenant_package',
    'COLUMN', N'menu_ids'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_tenant_package',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_tenant_package',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_tenant_package',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_tenant_package',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_tenant_package',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户套餐表',
    'SCHEMA', N'dbo',
    'TABLE', N'system_tenant_package'
GO

-- ----------------------------
-- Records of system_tenant_package
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_tenant_package ON
GO
INSERT INTO system_tenant_package (id, name, status, remark, menu_ids, creator, create_time, updater, update_time, deleted) VALUES (111, N'普通套餐', 0, N'小功能', N'[1,2,5,1031,1032,1033,1034,1035,1036,1037,1038,1039,1050,1051,1052,1053,1054,1056,1057,1058,1059,1060,1063,1064,1065,1066,1067,1070,1075,1077,1078,1082,1083,1084,1085,1086,1087,1088,1089,1090,1091,1092,1117,1118,1119,1120,100,101,102,1126,103,1127,1128,1129,106,1130,107,1132,1133,110,1134,111,1135,112,1136,113,1137,2161,114,1138,1139,115,1140,116,1141,1142,1143,1150,1161,1162,1166,1173,1174,2713,2714,1178,2715,2716,2717,2718,2720,2721,1185,2722,1186,1187,2723,1188,2724,1189,2725,1190,2726,1191,2727,1192,2728,2729,1193,1194,2730,1195,2731,2732,1197,2733,1198,2734,1199,2735,1200,1201,1202,2739,2740,1207,1208,1209,2745,1210,2746,1211,2747,1212,2748,1213,1215,1216,1217,1218,1219,1220,2756,1221,2757,1222,1224,1225,1226,1227,1228,1229,1237,1238,2262,1239,1240,1241,1242,1243,2275,2276,2277,1255,1256,1257,2281,1258,2282,1259,2283,1260,2284,2285,2287,2288,2293,2294,2297,2300,2301,2302,2317,2318,2319,2320,2321,2322,2323,2324,2325,2326,2327,2328,2329,2330,2331,2332,2333,2334,2335,2363,2364,5011,5012,2472,2478,2479,2480,2481,2482,2483,2484,2485,2486,2487,2488,2489,2490,2491,2492,2493,2494,2495,2497,2525,1001,1002,1003,1004,1005,1006,1007,1008,1009,1010,1011,1012,1013,2549,1014,2550,1015,2551,1016,2552,1017,2553,1018,2554,1019,2555,1020,2556,2557,2558,2559]', N'1', N'2022-02-22 00:54:00', N'1', N'2025-09-06 20:52:25', N'0')
GO
SET IDENTITY_INSERT system_tenant_package OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_user_post
-- ----------------------------
DROP TABLE IF EXISTS system_user_post
GO
CREATE TABLE system_user_post (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    user_id bigint DEFAULT 0 NOT NULL,
    post_id bigint DEFAULT 0 NOT NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL,
    tenant_id bigint DEFAULT 0 NOT NULL
)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'id',
    'SCHEMA', N'dbo',
    'TABLE', N'system_user_post',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户ID',
    'SCHEMA', N'dbo',
    'TABLE', N'system_user_post',
    'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'岗位ID',
    'SCHEMA', N'dbo',
    'TABLE', N'system_user_post',
    'COLUMN', N'post_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_user_post',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_user_post',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_user_post',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_user_post',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_user_post',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_user_post',
    'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户岗位表',
    'SCHEMA', N'dbo',
    'TABLE', N'system_user_post'
GO

-- ----------------------------
-- Records of system_user_post
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_user_post ON
GO
INSERT INTO system_user_post (id, user_id, post_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (112, 1, 1, N'admin', N'2022-05-02 07:25:24', N'admin', N'2022-05-02 07:25:24', N'0', 1)
GO
INSERT INTO system_user_post (id, user_id, post_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (113, 100, 1, N'admin', N'2022-05-02 07:25:24', N'admin', N'2022-05-02 07:25:24', N'0', 1)
GO
INSERT INTO system_user_post (id, user_id, post_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (115, 104, 1, N'1', N'2022-05-16 19:36:28', N'1', N'2022-05-16 19:36:28', N'0', 1)
GO
INSERT INTO system_user_post (id, user_id, post_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (116, 117, 2, N'1', N'2022-07-09 17:40:26', N'1', N'2022-07-09 17:40:26', N'0', 1)
GO
INSERT INTO system_user_post (id, user_id, post_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (117, 118, 1, N'1', N'2022-07-09 17:44:44', N'1', N'2022-07-09 17:44:44', N'0', 1)
GO
INSERT INTO system_user_post (id, user_id, post_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (119, 114, 5, N'1', N'2024-03-24 20:45:51', N'1', N'2024-03-24 20:45:51', N'0', 1)
GO
GO
GO
INSERT INTO system_user_post (id, user_id, post_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (125, 1, 2, N'1', N'2024-07-13 22:31:39', N'1', N'2024-07-13 22:31:39', N'0', 1)
GO
INSERT INTO system_user_post (id, user_id, post_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (128, 139, 2, N'1', N'2025-12-05 21:43:27', N'1', N'2025-12-05 21:43:27', N'0', 1)
GO
INSERT INTO system_user_post (id, user_id, post_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (129, 139, 4, N'1', N'2025-12-05 21:43:27', N'1', N'2025-12-05 21:43:27', N'0', 1)
GO
SET IDENTITY_INSERT system_user_post OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_user_role
-- ----------------------------
DROP TABLE IF EXISTS system_user_role
GO
CREATE TABLE system_user_role (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    user_id bigint  NOT NULL,
    role_id bigint  NOT NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NULL,
    deleted bit DEFAULT 0 NOT NULL,
    tenant_id bigint DEFAULT 0 NOT NULL
)
GO

CREATE INDEX idx_system_user_role_01 ON system_user_role (user_id)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'自增编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_user_role',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户ID',
    'SCHEMA', N'dbo',
    'TABLE', N'system_user_role',
    'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'角色ID',
    'SCHEMA', N'dbo',
    'TABLE', N'system_user_role',
    'COLUMN', N'role_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_user_role',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_user_role',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_user_role',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_user_role',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_user_role',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_user_role',
    'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户和角色关联表',
    'SCHEMA', N'dbo',
    'TABLE', N'system_user_role'
GO

-- ----------------------------
-- Records of system_user_role
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_user_role ON
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1, 1, 1, N'', N'2022-01-11 13:19:45', N'', N'2022-05-12 12:35:17', N'0', 1)
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2, 2, 2, N'', N'2022-01-11 13:19:45', N'', N'2022-05-12 12:35:13', N'0', 1)
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5, 100, 1, N'', N'2022-01-11 13:19:45', N'', N'2022-05-12 12:35:12', N'0', 1)
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6, 100, 2, N'', N'2022-01-11 13:19:45', N'', N'2022-05-12 12:35:11', N'0', 1)
GO
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (14, 110, 109, N'1', N'2022-02-22 00:56:14', N'1', N'2022-02-22 00:56:14', N'0', 121)
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (15, 111, 110, N'110', N'2022-02-23 13:14:38', N'110', N'2022-02-23 13:14:38', N'0', 121)
GO
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (18, 1, 2, N'1', N'2022-05-12 20:39:29', N'1', N'2022-05-12 20:39:29', N'0', 1)
GO
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (35, 112, 1, N'1', N'2024-03-15 20:00:24', N'1', N'2024-03-15 20:00:24', N'0', 1)
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (36, 118, 1, N'1', N'2024-03-17 09:12:08', N'1', N'2024-03-17 09:12:08', N'0', 1)
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (46, 117, 1, N'1', N'2024-10-02 10:16:11', N'1', N'2024-10-02 10:16:11', N'0', 1)
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (47, 104, 2, N'1', N'2025-01-04 10:40:33', N'1', N'2025-01-04 10:40:33', N'0', 1)
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (48, 100, 155, N'1', N'2025-04-04 10:41:14', N'1', N'2025-04-04 10:41:14', N'0', 1)
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (49, 142, 1, N'1', N'2025-07-23 09:11:42', N'1', N'2025-07-23 09:11:42', N'0', 1)
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (50, 142, 2, N'1', N'2025-10-07 20:50:37', N'1', N'2025-10-07 20:50:37', N'0', 1)
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (51, 139, 1, N'1', N'2025-12-05 22:36:57', N'1', N'2025-12-05 22:36:57', N'0', 1)
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (52, 139, 2, N'1', N'2025-12-05 22:37:00', N'1', N'2025-12-05 22:37:00', N'0', 1)
GO
GO
GO
SET IDENTITY_INSERT system_user_role OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_users
-- ----------------------------
DROP TABLE IF EXISTS system_users
GO
CREATE TABLE system_users (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    username nvarchar(30)  NOT NULL,
    password nvarchar(100) DEFAULT '' NOT NULL,
    nickname nvarchar(30)  NOT NULL,
    remark nvarchar(500) DEFAULT NULL NULL,
    dept_id bigint DEFAULT NULL NULL,
    post_ids nvarchar(255) DEFAULT NULL NULL,
    email nvarchar(50) DEFAULT '' NULL,
    mobile nvarchar(11) DEFAULT '' NULL,
    sex tinyint DEFAULT 0 NULL,
    avatar nvarchar(512) DEFAULT '' NULL,
    status tinyint DEFAULT 0 NOT NULL,
    login_ip nvarchar(50) DEFAULT '' NULL,
    login_date datetime2 DEFAULT NULL NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL,
    tenant_id bigint DEFAULT 0 NOT NULL
)
GO

CREATE INDEX idx_system_users_01 ON system_users (username)
GO
CREATE INDEX idx_system_users_02 ON system_users (mobile)
GO
CREATE INDEX idx_system_users_03 ON system_users (email)
GO
CREATE INDEX idx_system_users_04 ON system_users (dept_id)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户ID',
    'SCHEMA', N'dbo',
    'TABLE', N'system_users',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户账号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_users',
    'COLUMN', N'username'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'密码',
    'SCHEMA', N'dbo',
    'TABLE', N'system_users',
    'COLUMN', N'password'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户昵称',
    'SCHEMA', N'dbo',
    'TABLE', N'system_users',
    'COLUMN', N'nickname'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'备注',
    'SCHEMA', N'dbo',
    'TABLE', N'system_users',
    'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'部门ID',
    'SCHEMA', N'dbo',
    'TABLE', N'system_users',
    'COLUMN', N'dept_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'岗位编号数组',
    'SCHEMA', N'dbo',
    'TABLE', N'system_users',
    'COLUMN', N'post_ids'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户邮箱',
    'SCHEMA', N'dbo',
    'TABLE', N'system_users',
    'COLUMN', N'email'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'手机号码',
    'SCHEMA', N'dbo',
    'TABLE', N'system_users',
    'COLUMN', N'mobile'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户性别',
    'SCHEMA', N'dbo',
    'TABLE', N'system_users',
    'COLUMN', N'sex'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'头像地址',
    'SCHEMA', N'dbo',
    'TABLE', N'system_users',
    'COLUMN', N'avatar'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'帐号状态（0正常 1停用）',
    'SCHEMA', N'dbo',
    'TABLE', N'system_users',
    'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'最后登录IP',
    'SCHEMA', N'dbo',
    'TABLE', N'system_users',
    'COLUMN', N'login_ip'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'最后登录时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_users',
    'COLUMN', N'login_date'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_users',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_users',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'system_users',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'system_users',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'system_users',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'system_users',
    'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'用户信息表',
    'SCHEMA', N'dbo',
    'TABLE', N'system_users'
GO

-- ----------------------------
-- Records of system_users
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_users ON
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1, N'admin', N'$2a$04$vlw8UX2rAtD5E24PSD1zbec8ON6QE4UzjEk8tdSoyaBnXhUmiK/pu', N'光何', N'管理员', 103, N'[1,2]', N'18903378092@163.com', N'18818260272', 1, NULL, 0, N'0:0:0:0:0:0:0:1', N'2026-04-17 08:47:40', N'admin', N'2021-01-05 17:03:47', NULL, N'2026-04-17 08:47:40', N'0', 1)
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (100, N'guanghe', N'$2a$04$UEHS4wOH/P/1wSEzwQSwWOC7C3Dg1LZwqHFBTB5jL2WnSRSWK4mca', N'光何', N'不要吓我', 104, N'[1]', N'guanghe@example.com', N'15601691300', 1, NULL, 0, N'0:0:0:0:0:0:0:1', N'2025-12-15 21:47:26', N'', N'2021-01-07 09:07:17', NULL, N'2025-12-15 21:47:26', N'0', 1)
GO
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (104, N'test', N'$2a$04$2OaMD47grEy5aesBSoC9DOrYxok0mVEhR7DI/l/VWyLkrS6czhFlO', N'测试号', NULL, 107, N'[1,2]', N'111@qq.com', N'15601691200', 1, NULL, 0, N'0:0:0:0:0:0:0:1', N'2026-01-04 18:09:54', N'', N'2021-01-21 02:13:53', NULL, N'2026-01-04 18:09:54', N'0', 1)
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (107, N'admin107', N'$2a$10$dYOOBKMO93v/.ReCqzyFg.o67Tqk.bbc2bhrpyBGkIw9aypCtr2pm', N'光何', NULL, NULL, NULL, N'', N'15601691300', 0, NULL, 0, N'', NULL, N'1', N'2022-02-20 22:59:33', N'1', N'2025-04-21 14:23:08', N'0', 118)
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (108, N'admin108', N'$2a$10$y6mfvKoNYL1GXWak8nYwVOH.kCWqjactkzdoIDgiKl93WN3Ejg.Lu', N'光何', NULL, NULL, NULL, N'', N'15601691300', 0, NULL, 0, N'', NULL, N'1', N'2022-02-20 23:00:50', N'1', N'2025-04-21 14:23:08', N'0', 119)
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (109, N'admin109', N'$2a$10$JAqvH0tEc0I7dfDVBI7zyuB4E3j.uH6daIjV53.vUS6PknFkDJkuK', N'光何', NULL, NULL, NULL, N'', N'15601691300', 0, NULL, 0, N'', NULL, N'1', N'2022-02-20 23:11:50', N'1', N'2025-04-21 14:23:08', N'0', 120)
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (110, N'admin110', N'$2a$10$mRMIYLDtRHlf6.9ipiqH1.Z.bh/R9dO9d5iHiGYPigi6r5KOoR2Wm', N'小王', NULL, NULL, NULL, N'', N'15601691300', 0, NULL, 0, N'0:0:0:0:0:0:0:1', N'2024-07-20 22:23:17', N'1', N'2022-02-22 00:56:14', NULL, N'2025-04-21 14:23:08', N'0', 121)
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (111, N'test', N'$2a$04$2OaMD47grEy5aesBSoC9DOrYxok0mVEhR7DI/l/VWyLkrS6czhFlO', N'测试用户', NULL, NULL, N'[]', N'', N'', 0, NULL, 0, N'0:0:0:0:0:0:0:1', N'2023-12-30 11:42:17', N'110', N'2022-02-23 13:14:33', NULL, N'2025-04-21 14:23:08', N'0', 121)
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (112, N'newobject', N'$2a$04$dB0z8Q819fJWz0hbaLe6B.VfHCjYgWx6LFfET5lyz3JwcqlyCkQ4C', N'新对象', NULL, 100, N'[]', N'', N'15601691235', 1, NULL, 0, N'0:0:0:0:0:0:0:1', N'2024-03-16 23:11:38', N'1', N'2022-02-23 19:08:03', NULL, N'2025-04-21 14:23:08', N'0', 1)
GO
GO
GO
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (117, N'admin123', N'$2a$04$sEtimsHu9YCkYY4/oqElHem2Ijc9ld20eYO6lN.g/21NfLUTDLB9W', N'测试号02', N'1111', 100, N'[2]', N'', N'15601691234', 1, NULL, 0, N'0:0:0:0:0:0:0:1', N'2024-10-02 10:16:20', N'1', N'2022-07-09 17:40:26', N'1', N'2025-05-14 09:56:04', N'0', 1)
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (118, N'goudan', N'$2a$04$3suGZjnA6rM5bErf38u1felbgqbsPHGdRG3l9NkxPCEt2ah9Y6aJi', N'狗蛋', NULL, 103, N'[1]', N'', N'15601691239', 1, NULL, 0, N'0:0:0:0:0:0:0:1', N'2025-11-23 15:28:25', N'1', N'2022-07-09 17:44:43', NULL, N'2025-11-23 15:28:25', N'0', 1)
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (139, N'wwbwwb', N'$2a$04$FJLIyg8lbPytP29pbZaiU.LesJvCsYfEaHqQfB0pGQhK3e9BeZmLy', N'小秃头', N'123', 108, N'[2,4]', N'', N'', 1, NULL, 0, N'0:0:0:0:0:0:0:1', N'2024-09-10 21:03:58', NULL, N'2024-09-10 21:03:58', N'1', N'2025-12-15 22:38:15', N'0', 1)
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (141, N'admin1', N'$2a$04$oj6F6d7HrZ70kYVD3TNzEu.m3TPUzajOVuC66zdKna8KRerK1FmVa', N'新用户', NULL, NULL, NULL, N'', N'', 0, N'', 0, N'0:0:0:0:0:0:0:1', N'2025-04-08 13:09:07', N'1', N'2025-04-08 13:09:07', N'1', N'2025-05-14 19:11:48', N'0', 1)
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (142, N'test01', N'$2a$04$4bCYWZkjxxOC4QE0LY2M9uEEKWeJbLfs489NFtQoyidL5I0FndRaO', N'test01', N'', NULL, N'[]', N'', N'19021719925', 1, N'', 0, N'0:0:0:0:0:0:0:1', N'2025-07-29 19:47:17', N'1', N'2025-07-09 21:07:10', NULL, N'2025-12-02 13:23:11', N'0', 1)
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (143, N'a00001', N'$2a$04$GhVHFviOw/SsTmiQtifHJesDYFlHMeGK7OWh7aGCCjGGVCmbHVAwa', N'a00001', NULL, 104, NULL, N'', N'', 0, N'', 0, N'0:0:0:0:0:0:0:1', N'2025-12-01 16:10:13', NULL, N'2025-12-01 16:10:13', N'1', N'2025-12-05 21:34:05', N'0', 1)
GO
GO
SET IDENTITY_INSERT system_users OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for guanghe_demo01_contact
-- ----------------------------
DROP TABLE IF EXISTS guanghe_demo01_contact
GO
CREATE TABLE guanghe_demo01_contact (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    name nvarchar(100) DEFAULT '' NOT NULL,
    sex tinyint  NOT NULL,
    birthday datetime2  NOT NULL,
    description nvarchar(255)  NOT NULL,
    avatar nvarchar(512) DEFAULT NULL NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL,
    tenant_id bigint DEFAULT 0 NOT NULL
)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'编号',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo01_contact',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'名字',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo01_contact',
    'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'性别',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo01_contact',
    'COLUMN', N'sex'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'出生年',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo01_contact',
    'COLUMN', N'birthday'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'简介',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo01_contact',
    'COLUMN', N'description'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'头像',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo01_contact',
    'COLUMN', N'avatar'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo01_contact',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo01_contact',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo01_contact',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo01_contact',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo01_contact',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo01_contact',
    'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'示例联系人表',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo01_contact'
GO

-- ----------------------------
-- Records of guanghe_demo01_contact
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT guanghe_demo01_contact ON
GO
INSERT INTO guanghe_demo01_contact (id, name, sex, birthday, description, avatar, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1, N'土豆', 2, N'2023-11-07 00:00:00', N'<p>天蚕土豆！呀</p>', N'http://127.0.0.1:2000/admin-api/infra/file/4/get/46f8fa1a37db3f3960d8910ff2fe3962ab3b2db87cf2f8ccb4dc8145b8bdf237.jpeg', N'1', N'2023-11-15 23:34:30', N'1', N'2023-11-15 23:47:39', N'0', 1)
GO
SET IDENTITY_INSERT guanghe_demo01_contact OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for guanghe_demo02_category
-- ----------------------------
DROP TABLE IF EXISTS guanghe_demo02_category
GO
CREATE TABLE guanghe_demo02_category (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    name nvarchar(100) DEFAULT '' NOT NULL,
    parent_id bigint  NOT NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL,
    tenant_id bigint DEFAULT 0 NOT NULL
)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'编号',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo02_category',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'名字',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo02_category',
    'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'父级编号',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo02_category',
    'COLUMN', N'parent_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo02_category',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo02_category',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo02_category',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo02_category',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo02_category',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo02_category',
    'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'示例分类表',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo02_category'
GO

-- ----------------------------
-- Records of guanghe_demo02_category
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT guanghe_demo02_category ON
GO
INSERT INTO guanghe_demo02_category (id, name, parent_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1, N'土豆', 0, N'1', N'2023-11-15 23:34:30', N'1', N'2023-11-16 20:24:23', N'0', 1)
GO
INSERT INTO guanghe_demo02_category (id, name, parent_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2, N'番茄', 0, N'1', N'2023-11-16 20:24:00', N'1', N'2023-11-16 20:24:15', N'0', 1)
GO
INSERT INTO guanghe_demo02_category (id, name, parent_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3, N'怪怪', 0, N'1', N'2023-11-16 20:24:32', N'1', N'2023-11-16 20:24:32', N'0', 1)
GO
INSERT INTO guanghe_demo02_category (id, name, parent_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4, N'小番茄', 2, N'1', N'2023-11-16 20:24:39', N'1', N'2023-11-16 20:24:39', N'0', 1)
GO
INSERT INTO guanghe_demo02_category (id, name, parent_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5, N'大番茄', 2, N'1', N'2023-11-16 20:24:46', N'1', N'2023-11-16 20:24:46', N'0', 1)
GO
INSERT INTO guanghe_demo02_category (id, name, parent_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6, N'11', 3, N'1', N'2023-11-24 19:29:34', N'1', N'2023-11-24 19:29:34', N'0', 1)
GO
INSERT INTO guanghe_demo02_category (id, name, parent_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (7, N'1', 0, N'1', N'2025-10-01 09:19:20', N'1', N'2025-10-01 09:19:20', N'0', 1)
GO
SET IDENTITY_INSERT guanghe_demo02_category OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for guanghe_demo03_course
-- ----------------------------
DROP TABLE IF EXISTS guanghe_demo03_course
GO
CREATE TABLE guanghe_demo03_course (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    student_id bigint  NOT NULL,
    name nvarchar(100) DEFAULT '' NOT NULL,
    score tinyint  NOT NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL,
    tenant_id bigint DEFAULT 0 NOT NULL
)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'编号',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_course',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'学生编号',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_course',
    'COLUMN', N'student_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'名字',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_course',
    'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'分数',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_course',
    'COLUMN', N'score'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_course',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_course',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_course',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_course',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_course',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_course',
    'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'学生课程表',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_course'
GO

-- ----------------------------
-- Records of guanghe_demo03_course
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT guanghe_demo03_course ON
GO
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2, 2, N'语文', 66, N'1', N'2023-11-16 23:21:49', N'1', N'2024-09-17 10:55:30', N'1', 1)
GO
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3, 2, N'数学', 22, N'1', N'2023-11-16 23:21:49', N'1', N'2024-09-17 10:55:30', N'1', 1)
GO
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6, 5, N'体育', 23, N'1', N'2023-11-16 23:22:46', N'1', N'2023-11-16 15:44:40', N'1', 1)
GO
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (7, 5, N'计算机', 11, N'1', N'2023-11-16 23:22:46', N'1', N'2023-11-16 15:44:40', N'1', 1)
GO
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (8, 5, N'体育', 23, N'1', N'2023-11-16 23:22:46', N'1', N'2023-11-16 15:47:09', N'1', 1)
GO
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (9, 5, N'计算机', 11, N'1', N'2023-11-16 23:22:46', N'1', N'2023-11-16 15:47:09', N'1', 1)
GO
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (10, 5, N'体育', 23, N'1', N'2023-11-16 23:22:46', N'1', N'2024-09-17 10:55:28', N'1', 1)
GO
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (11, 5, N'计算机', 11, N'1', N'2023-11-16 23:22:46', N'1', N'2024-09-17 10:55:28', N'1', 1)
GO
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (12, 2, N'电脑', 33, N'1', N'2023-11-17 00:20:42', N'1', N'2023-11-16 16:20:45', N'1', 1)
GO
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (13, 9, N'滑雪', 12, N'1', N'2023-11-17 13:13:20', N'1', N'2024-09-17 10:55:26', N'1', 1)
GO
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (14, 9, N'滑雪', 12, N'1', N'2023-11-17 13:13:20', N'1', N'2024-09-17 10:55:49', N'1', 1)
GO
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (15, 5, N'体育', 23, N'1', N'2023-11-16 23:22:46', N'1', N'2024-09-17 18:55:29', N'0', 1)
GO
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (16, 5, N'计算机', 11, N'1', N'2023-11-16 23:22:46', N'1', N'2024-09-17 18:55:29', N'0', 1)
GO
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (17, 2, N'语文', 66, N'1', N'2023-11-16 23:21:49', N'1', N'2024-09-17 18:55:31', N'0', 1)
GO
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (18, 2, N'数学', 22, N'1', N'2023-11-16 23:21:49', N'1', N'2024-09-17 18:55:31', N'0', 1)
GO
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (19, 9, N'滑雪', 12, N'1', N'2023-11-17 13:13:20', N'1', N'2025-04-19 02:49:03', N'1', 1)
GO
INSERT INTO guanghe_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (20, 9, N'滑雪', 12, N'1', N'2023-11-17 13:13:20', N'1', N'2025-04-19 10:49:04', N'0', 1)
GO
SET IDENTITY_INSERT guanghe_demo03_course OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for guanghe_demo03_grade
-- ----------------------------
DROP TABLE IF EXISTS guanghe_demo03_grade
GO
CREATE TABLE guanghe_demo03_grade (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    student_id bigint  NOT NULL,
    name nvarchar(100) DEFAULT '' NOT NULL,
    teacher nvarchar(255)  NOT NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL,
    tenant_id bigint DEFAULT 0 NOT NULL
)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'编号',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_grade',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'学生编号',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_grade',
    'COLUMN', N'student_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'名字',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_grade',
    'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'班主任',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_grade',
    'COLUMN', N'teacher'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_grade',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_grade',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_grade',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_grade',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_grade',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_grade',
    'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'学生班级表',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_grade'
GO

-- ----------------------------
-- Records of guanghe_demo03_grade
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT guanghe_demo03_grade ON
GO
INSERT INTO guanghe_demo03_grade (id, student_id, name, teacher, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (7, 2, N'三年 2 班', N'周杰伦', N'1', N'2023-11-16 23:21:49', N'1', N'2024-09-17 18:55:31', N'0', 1)
GO
INSERT INTO guanghe_demo03_grade (id, student_id, name, teacher, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (8, 5, N'华为', N'遥遥领先', N'1', N'2023-11-16 23:22:46', N'1', N'2024-09-17 18:55:29', N'0', 1)
GO
INSERT INTO guanghe_demo03_grade (id, student_id, name, teacher, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (9, 9, N'小图', N'小娃111', N'1', N'2023-11-17 13:10:23', N'1', N'2025-04-19 10:49:04', N'0', 1)
GO
SET IDENTITY_INSERT guanghe_demo03_grade OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for guanghe_demo03_student
-- ----------------------------
DROP TABLE IF EXISTS guanghe_demo03_student
GO
CREATE TABLE guanghe_demo03_student (
    id bigint NOT NULL PRIMARY KEY IDENTITY,
    name nvarchar(100) DEFAULT '' NOT NULL,
    sex tinyint  NOT NULL,
    birthday datetime2  NOT NULL,
    description nvarchar(255)  NOT NULL,
    creator nvarchar(64) DEFAULT '' NULL,
    create_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater nvarchar(64) DEFAULT '' NULL,
    update_time datetime2 DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted bit DEFAULT 0 NOT NULL,
    tenant_id bigint DEFAULT 0 NOT NULL
)
GO

EXEC sp_addextendedproperty
    'MS_Description', N'编号',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_student',
    'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'名字',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_student',
    'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'性别',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_student',
    'COLUMN', N'sex'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'出生日期',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_student',
    'COLUMN', N'birthday'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'简介',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_student',
    'COLUMN', N'description'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建者',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_student',
    'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'创建时间',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_student',
    'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新者',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_student',
    'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'更新时间',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_student',
    'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'是否删除',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_student',
    'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'租户编号',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_student',
    'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
    'MS_Description', N'学生表',
    'SCHEMA', N'dbo',
    'TABLE', N'guanghe_demo03_student'
GO

-- ----------------------------
-- Records of guanghe_demo03_student
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT guanghe_demo03_student ON
GO
INSERT INTO guanghe_demo03_student (id, name, sex, birthday, description, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2, N'小白', 1, N'2023-11-16 00:00:00', N'<p>厉害</p>', N'1', N'2023-11-16 23:21:49', N'1', N'2024-09-17 18:55:31', N'0', 1)
GO
INSERT INTO guanghe_demo03_student (id, name, sex, birthday, description, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5, N'大黑', 2, N'2023-11-13 00:00:00', N'<p>你在教我做事?</p>', N'1', N'2023-11-16 23:22:46', N'1', N'2024-09-17 18:55:29', N'0', 1)
GO
INSERT INTO guanghe_demo03_student (id, name, sex, birthday, description, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (9, N'小花', 1, N'2023-11-07 00:00:00', N'<p>哈哈哈</p>', N'1', N'2023-11-17 00:04:47', N'1', N'2025-04-19 10:49:04', N'0', 1)
GO
SET IDENTITY_INSERT guanghe_demo03_student OFF
GO
COMMIT
GO
-- @formatter:on
deleted=2021
