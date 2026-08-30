-- =====================================================================================
-- gsite 业务模块建表脚本（补充 sql/mysql/gsite.sql）
-- =====================================================================================
-- 作用：gsite.sql 只包含 system_* / infra_* / 演示表共 48 张表。
--       其余 16 个业务模块（bpm crm erp fms hrm im member mes mp pay product
--       promotion report trade wms）共 393 张表由本脚本创建。
--       两者都要导入，否则对应模块的后台页面会因缺表报 500/501。
--
-- 用法：
--   mysql -h 127.0.0.1 -uroot -proot --default-character-set=utf8mb4 gsite < gsite.sql
--   mysql -h 127.0.0.1 -uroot -proot --default-character-set=utf8mb4 gsite < gsite_modules.sql
--
-- 说明：
--   1. 不含 act_* / flw_*：Flowable 引擎启动时按 database-schema-update 自动建表。
--   2. 不含 qrtz_*：定时任务表在 quartz.sql 中。
--   3. 全部表统一 utf8mb4 / utf8mb4_unicode_ci，与 gsite.sql 一致；
--      混用排序规则会导致跨表 JOIN/UNION 报 "Illegal mix of collations"。
--   4. 脚本可重复执行（CREATE TABLE IF NOT EXISTS）。
-- =====================================================================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `bpm_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL,
  `sort` int NOT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='分类';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `bpm_form` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL,
  `fields` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `conf` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='动态表单';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `bpm_oa_leave` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` bigint DEFAULT NULL COMMENT 'userId',
  `type` int DEFAULT NULL COMMENT 'type',
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'reason',
  `start_time` datetime DEFAULT NULL COMMENT 'startTime',
  `end_time` datetime DEFAULT NULL COMMENT 'endTime',
  `day` bigint DEFAULT NULL COMMENT 'day',
  `status` int DEFAULT NULL COMMENT 'status',
  `process_instance_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'processInstanceId',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `bpm_process_definition_info` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `process_definition_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '流程定义的编号',
  `model_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '流程模型的编号',
  `model_type` int DEFAULT NULL COMMENT '流程模型的类型',
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '流程分类的编码',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '图标',
  `description` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '描述',
  `form_type` int DEFAULT NULL COMMENT '表单类型',
  `form_id` bigint DEFAULT NULL COMMENT '动态表单编号',
  `form_conf` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '表单的配置',
  `form_fields` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '表单项的数组',
  `form_custom_create_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义表单的提交路径',
  `form_custom_view_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义表单的查看路径',
  `simple_model` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'SIMPLE 设计器模型数据，json 格式',
  `visible` tinyint(1) DEFAULT NULL COMMENT '是否可见',
  `sort` bigint DEFAULT NULL COMMENT '排序值',
  `start_user_ids` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '可发起用户编号数组',
  `start_dept_ids` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '可发起部门编号数组',
  `manager_user_ids` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '可管理用户编号数组',
  `allow_cancel_running_process` tinyint(1) DEFAULT NULL COMMENT '是否允许撤销审批中的申请',
  `allow_withdraw_task` tinyint(1) DEFAULT NULL COMMENT '是否允许审批人撤回任务',
  `process_id_rule` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '流程 ID 规则',
  `auto_approval_type` int DEFAULT NULL COMMENT '自动去重类型',
  `title_setting` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '标题设置',
  `summary_setting` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '摘要设置',
  `process_before_trigger_setting` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '流程前置通知设置',
  `process_after_trigger_setting` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '流程后置通知设置',
  `task_before_trigger_setting` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '任务前置通知设置',
  `task_after_trigger_setting` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '任务后置通知设置',
  `print_template_setting` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '自定义打印模板设置',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='BPM 流程定义的拓展信息';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `bpm_process_expression` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `status` int DEFAULT NULL COMMENT 'status',
  `expression` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'expression',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `bpm_process_instance_copy` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `start_user_id` bigint DEFAULT NULL COMMENT '发起人编号',
  `process_instance_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '流程名',
  `process_instance_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '流程实例的编号',
  `process_definition_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '流程实例的流程定义编号',
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '流程分类',
  `activity_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '流程活动的编号',
  `activity_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '流程活动的名字',
  `task_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '流程任务的编号',
  `user_id` bigint DEFAULT NULL COMMENT '用户编号，被抄送的用户编号',
  `reason` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '抄送意见',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='流程抄送';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `bpm_process_listener` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键编号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '监听器名字',
  `status` int DEFAULT NULL COMMENT '状态',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '监听类型',
  `event` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '监听事件',
  `value_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '值类型',
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '值',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='BPM 流程监听器';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `bpm_user_group` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL,
  `user_ids` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户组';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `crm_business` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商机名称',
  `customer_id` bigint DEFAULT NULL COMMENT '客户编号',
  `follow_up_status` tinyint(1) DEFAULT NULL COMMENT '跟进状态',
  `contact_last_time` datetime DEFAULT NULL COMMENT '最后跟进时间',
  `contact_next_time` datetime DEFAULT NULL COMMENT '下次联系时间',
  `owner_user_id` bigint DEFAULT NULL COMMENT '负责人的用户编号',
  `status_type_id` bigint DEFAULT NULL COMMENT '商机状态组编号',
  `status_id` bigint DEFAULT NULL COMMENT '商机状态编号',
  `end_status` int DEFAULT NULL COMMENT '结束状态',
  `end_remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '结束时的备注',
  `deal_time` datetime DEFAULT NULL COMMENT '预计成交日期',
  `total_product_price` decimal(24,6) DEFAULT NULL COMMENT '产品总金额，单位：元',
  `discount_percent` decimal(24,6) DEFAULT NULL COMMENT '整单折扣，百分比',
  `total_price` decimal(24,6) DEFAULT NULL COMMENT '商机总金额，单位：元',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='CRM 商机';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `crm_business_product` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `business_id` bigint DEFAULT NULL COMMENT '商机编号',
  `product_id` bigint DEFAULT NULL COMMENT '产品编号',
  `product_price` decimal(24,6) DEFAULT NULL COMMENT '产品单价，单位：元',
  `business_price` decimal(24,6) DEFAULT NULL COMMENT '商机价格，单位：元',
  `count` decimal(24,6) DEFAULT NULL COMMENT '数量',
  `total_price` decimal(24,6) DEFAULT NULL COMMENT '总计价格，单位：元',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='CRM 商机产品关联表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `crm_business_status` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type_id` bigint DEFAULT NULL COMMENT '状态类型编号',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '状态名',
  `percent` int DEFAULT NULL COMMENT '赢单率，百分比',
  `sort` int DEFAULT NULL COMMENT '排序',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='CRM 商机状态';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `crm_business_status_type` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '状态类型名',
  `dept_ids` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '使用的部门编号数组(JSON)',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='CRM 商机状态组';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `crm_clue` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '线索名称',
  `follow_up_status` tinyint(1) DEFAULT NULL COMMENT '跟进状态',
  `contact_last_time` datetime DEFAULT NULL COMMENT '最后跟进时间',
  `contact_last_content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '最后跟进内容',
  `contact_next_time` datetime DEFAULT NULL COMMENT '下次联系时间',
  `owner_user_id` bigint DEFAULT NULL COMMENT '负责人的用户编号',
  `transform_status` tinyint(1) DEFAULT NULL COMMENT '转化状态',
  `customer_id` bigint DEFAULT NULL COMMENT '客户编号',
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机号',
  `telephone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
  `qq` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'QQ',
  `wechat` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '微信',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `area_id` int DEFAULT NULL COMMENT '所在地',
  `detail_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '详细地址',
  `industry_id` int DEFAULT NULL COMMENT '所属行业',
  `level` int DEFAULT NULL COMMENT '客户等级',
  `source` int DEFAULT NULL COMMENT '客户来源',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='CRM 线索';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `crm_contact` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系人姓名',
  `customer_id` bigint DEFAULT NULL COMMENT '客户编号',
  `contact_last_time` datetime DEFAULT NULL COMMENT '最后跟进时间',
  `contact_last_content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '最后跟进内容',
  `contact_next_time` datetime DEFAULT NULL COMMENT '下次联系时间',
  `owner_user_id` bigint DEFAULT NULL COMMENT '负责人用户编号',
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机号',
  `telephone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电子邮箱',
  `qq` bigint DEFAULT NULL COMMENT 'QQ',
  `wechat` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '微信',
  `area_id` int DEFAULT NULL COMMENT '所在地',
  `detail_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '详细地址',
  `sex` int DEFAULT NULL COMMENT '性别',
  `master` tinyint(1) DEFAULT NULL COMMENT '是否关键决策人',
  `post` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '职位',
  `parent_id` bigint DEFAULT NULL COMMENT '直属上级',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='CRM 联系人';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `crm_contact_business` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `contact_id` bigint DEFAULT NULL COMMENT '联系人编号',
  `business_id` bigint DEFAULT NULL COMMENT '商机编号',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='CRM 联系人与商机关联';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `crm_contract` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '合同编号',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '合同名称',
  `no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '合同编号',
  `customer_id` bigint DEFAULT NULL COMMENT '客户编号',
  `business_id` bigint DEFAULT NULL COMMENT '商机编号',
  `contact_last_time` datetime DEFAULT NULL COMMENT '最后跟进时间',
  `owner_user_id` bigint DEFAULT NULL COMMENT '负责人的用户编号',
  `process_instance_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '工作流编号',
  `audit_status` int DEFAULT NULL COMMENT '审批状态',
  `order_date` datetime DEFAULT NULL COMMENT '下单日期',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `total_product_price` decimal(24,6) DEFAULT NULL COMMENT '产品总金额，单位：元',
  `discount_percent` decimal(24,6) DEFAULT NULL COMMENT '整单折扣',
  `total_price` decimal(24,6) DEFAULT NULL COMMENT '合同总金额，单位：元',
  `sign_contact_id` bigint DEFAULT NULL COMMENT '客户签约人',
  `sign_user_id` bigint DEFAULT NULL COMMENT '公司签约人',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='CRM 合同';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `crm_contract_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `notify_enabled` tinyint(1) DEFAULT NULL COMMENT '是否开启提前提醒',
  `notify_days` int DEFAULT NULL COMMENT '提前提醒天数',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='CRM 合同配置';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `crm_contract_product` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `contract_id` bigint DEFAULT NULL COMMENT '合同编号',
  `product_id` bigint DEFAULT NULL COMMENT '产品编号',
  `product_price` decimal(24,6) DEFAULT NULL COMMENT '产品单价，单位：元',
  `contract_price` decimal(24,6) DEFAULT NULL COMMENT '合同价格，单位：元',
  `count` decimal(24,6) DEFAULT NULL COMMENT '数量',
  `total_price` decimal(24,6) DEFAULT NULL COMMENT '总计价格，单位：元',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='CRM 合同产品关联表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `crm_customer` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户名称',
  `follow_up_status` tinyint(1) DEFAULT NULL COMMENT '跟进状态',
  `contact_last_time` datetime DEFAULT NULL COMMENT '最后跟进时间',
  `contact_last_content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '最后跟进内容',
  `contact_next_time` datetime DEFAULT NULL COMMENT '下次联系时间',
  `owner_user_id` bigint DEFAULT NULL COMMENT '负责人的用户编号',
  `owner_time` datetime DEFAULT NULL COMMENT '成为负责人的时间',
  `lock_status` tinyint(1) DEFAULT NULL COMMENT '锁定状态',
  `deal_status` tinyint(1) DEFAULT NULL COMMENT '成交状态',
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机',
  `telephone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
  `qq` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'QQ',
  `wechat` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '微信',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `area_id` int DEFAULT NULL COMMENT '所在地',
  `detail_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '详细地址',
  `industry_id` int DEFAULT NULL COMMENT '所属行业',
  `level` int DEFAULT NULL COMMENT '客户等级',
  `source` int DEFAULT NULL COMMENT '客户来源',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='CRM 客户';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `crm_customer_limit_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `type` int DEFAULT NULL COMMENT '规则类型',
  `user_ids` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '规则适用人群(JSON)',
  `dept_ids` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '规则适用部门(JSON)',
  `max_count` int DEFAULT NULL COMMENT '数量上限',
  `deal_count_enabled` tinyint(1) DEFAULT NULL COMMENT '成交客户是否占有拥有客户数',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='CRM 客户限制配置';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `crm_customer_pool_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `enabled` tinyint(1) DEFAULT NULL COMMENT '是否启用客户公海',
  `contact_expire_days` int DEFAULT NULL COMMENT '未跟进放入公海天数',
  `deal_expire_days` int DEFAULT NULL COMMENT '未成交放入公海天数',
  `notify_enabled` tinyint(1) DEFAULT NULL COMMENT '是否开启提前提醒',
  `notify_days` int DEFAULT NULL COMMENT '提前提醒天数',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='CRM 客户公海配置';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `crm_follow_up_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `biz_type` int DEFAULT NULL COMMENT '数据类型',
  `biz_id` bigint DEFAULT NULL COMMENT '数据编号',
  `type` int DEFAULT NULL COMMENT '跟进类型',
  `content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '跟进内容',
  `next_time` datetime DEFAULT NULL COMMENT '下次联系时间',
  `pic_urls` varchar(4096) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '图片(JSON)',
  `file_urls` varchar(4096) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '附件(JSON)',
  `business_ids` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '关联的商机编号数组(JSON)',
  `contact_ids` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '关联的联系人编号数组(JSON)',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='CRM 跟进记录';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `crm_owner_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `biz_type` int DEFAULT NULL COMMENT 'CRM 业务类型',
  `biz_id` bigint DEFAULT NULL COMMENT 'CRM 业务编号',
  `pre_owner_user_id` bigint DEFAULT NULL COMMENT '变更前负责人',
  `post_owner_user_id` bigint DEFAULT NULL COMMENT '变更后负责人',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='CRM 负责人变更记录';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `crm_performance_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `biz_type` int DEFAULT NULL COMMENT '目标类型',
  `object_id` bigint DEFAULT NULL COMMENT '目标对象编号',
  `object_type` int DEFAULT NULL COMMENT '目标对象类型',
  `year` int DEFAULT NULL COMMENT '年份',
  `year_target_price` decimal(24,6) DEFAULT NULL COMMENT '年度目标金额',
  `january_target_price` decimal(24,6) DEFAULT NULL COMMENT '一月目标金额',
  `february_target_price` decimal(24,6) DEFAULT NULL COMMENT '二月目标金额',
  `march_target_price` decimal(24,6) DEFAULT NULL COMMENT '三月目标金额',
  `april_target_price` decimal(24,6) DEFAULT NULL COMMENT '四月目标金额',
  `may_target_price` decimal(24,6) DEFAULT NULL COMMENT '五月目标金额',
  `june_target_price` decimal(24,6) DEFAULT NULL COMMENT '六月目标金额',
  `july_target_price` decimal(24,6) DEFAULT NULL COMMENT '七月目标金额',
  `august_target_price` decimal(24,6) DEFAULT NULL COMMENT '八月目标金额',
  `september_target_price` decimal(24,6) DEFAULT NULL COMMENT '九月目标金额',
  `october_target_price` decimal(24,6) DEFAULT NULL COMMENT '十月目标金额',
  `november_target_price` decimal(24,6) DEFAULT NULL COMMENT '十一月目标金额',
  `december_target_price` decimal(24,6) DEFAULT NULL COMMENT '十二月目标金额',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='CRM 业绩目标';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `crm_permission` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `biz_type` int DEFAULT NULL COMMENT '数据类型',
  `biz_id` bigint DEFAULT NULL COMMENT '数据编号',
  `user_id` bigint DEFAULT NULL COMMENT '用户编号',
  `level` int DEFAULT NULL COMMENT '权限级别',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='CRM 数据权限';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `crm_product` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '产品名称',
  `no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '产品编码',
  `unit` int DEFAULT NULL COMMENT '单位',
  `price` decimal(24,6) DEFAULT NULL COMMENT '价格，单位：元',
  `status` int DEFAULT NULL COMMENT '状态',
  `category_id` bigint DEFAULT NULL COMMENT '产品分类 ID',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '产品描述',
  `owner_user_id` bigint DEFAULT NULL COMMENT '负责人的用户编号',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='CRM 产品';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `crm_product_category` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '分类编号',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分类名称',
  `parent_id` bigint DEFAULT NULL COMMENT '父级编号',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='CRM 产品分类';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `crm_receivable` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '回款编号',
  `plan_id` bigint DEFAULT NULL COMMENT '回款计划编号',
  `customer_id` bigint DEFAULT NULL COMMENT '客户编号',
  `contract_id` bigint DEFAULT NULL COMMENT '合同编号',
  `owner_user_id` bigint DEFAULT NULL COMMENT '负责人编号',
  `return_time` datetime DEFAULT NULL COMMENT '回款日期',
  `return_type` int DEFAULT NULL COMMENT '回款方式',
  `price` decimal(24,6) DEFAULT NULL COMMENT '计划回款金额，单位：元',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `process_instance_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '工作流编号',
  `audit_status` int DEFAULT NULL COMMENT '审批状态',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='CRM 回款';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `crm_receivable_plan` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `period` int DEFAULT NULL COMMENT '期数',
  `customer_id` bigint DEFAULT NULL COMMENT '客户编号',
  `contract_id` bigint DEFAULT NULL COMMENT '合同编号',
  `owner_user_id` bigint DEFAULT NULL COMMENT '负责人编号',
  `return_time` datetime DEFAULT NULL COMMENT '计划回款日期',
  `return_type` int DEFAULT NULL COMMENT '计划回款类型',
  `price` decimal(24,6) DEFAULT NULL COMMENT '计划回款金额，单位：元',
  `receivable_id` bigint DEFAULT NULL COMMENT '回款编号',
  `remind_days` int DEFAULT NULL COMMENT '提前几天提醒',
  `remind_time` datetime DEFAULT NULL COMMENT '提醒日期',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='CRM 回款计划';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_account` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '结算账户编号',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '账户名称',
  `no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '账户编码',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `status` int DEFAULT NULL COMMENT '开启状态',
  `sort` int DEFAULT NULL COMMENT '排序',
  `default_status` tinyint(1) DEFAULT NULL COMMENT '是否默认',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 结算账户';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_customer` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '客户编号',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户名称',
  `contact` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系人',
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机号码',
  `telephone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系电话',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电子邮箱',
  `fax` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '传真',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `status` int DEFAULT NULL COMMENT '开启状态',
  `sort` int DEFAULT NULL COMMENT '排序',
  `tax_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '纳税人识别号',
  `tax_percent` decimal(24,6) DEFAULT NULL COMMENT '税率',
  `bank_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '开户行',
  `bank_account` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '开户账号',
  `bank_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '开户地址',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 客户';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_finance_payment` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '付款单号',
  `status` int DEFAULT NULL COMMENT '付款状态',
  `payment_time` datetime DEFAULT NULL COMMENT '付款时间',
  `finance_user_id` bigint DEFAULT NULL COMMENT '财务人员编号',
  `supplier_id` bigint DEFAULT NULL COMMENT '供应商编号',
  `account_id` bigint DEFAULT NULL COMMENT '付款账户编号',
  `total_price` decimal(24,6) DEFAULT NULL COMMENT '合计价格，单位：元',
  `discount_price` decimal(24,6) DEFAULT NULL COMMENT '优惠金额，单位：元',
  `payment_price` decimal(24,6) DEFAULT NULL COMMENT '实付金额，单位：元',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 付款单';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_finance_payment_item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '入库项编号',
  `payment_id` bigint DEFAULT NULL COMMENT '付款单编号',
  `biz_type` int DEFAULT NULL COMMENT '业务类型',
  `biz_id` bigint DEFAULT NULL COMMENT '业务编号',
  `biz_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '业务单号',
  `total_price` decimal(24,6) DEFAULT NULL COMMENT '应付金额，单位：元',
  `paid_price` decimal(24,6) DEFAULT NULL COMMENT '已付金额，单位：元',
  `payment_price` decimal(24,6) DEFAULT NULL COMMENT '本次付款，单位：元',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 付款项';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_finance_receipt` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收款单号',
  `status` int DEFAULT NULL COMMENT '收款状态',
  `receipt_time` datetime DEFAULT NULL COMMENT '收款时间',
  `finance_user_id` bigint DEFAULT NULL COMMENT '财务人员编号',
  `customer_id` bigint DEFAULT NULL COMMENT '客户编号',
  `account_id` bigint DEFAULT NULL COMMENT '收款账户编号',
  `total_price` decimal(24,6) DEFAULT NULL COMMENT '合计价格，单位：元',
  `discount_price` decimal(24,6) DEFAULT NULL COMMENT '优惠金额，单位：元',
  `receipt_price` decimal(24,6) DEFAULT NULL COMMENT '实收金额，单位：元',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 收款单';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_finance_receipt_item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '入库项编号',
  `receipt_id` bigint DEFAULT NULL COMMENT '收款单编号',
  `biz_type` int DEFAULT NULL COMMENT '业务类型',
  `biz_id` bigint DEFAULT NULL COMMENT '业务编号',
  `biz_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '业务单号',
  `total_price` decimal(24,6) DEFAULT NULL COMMENT '应收金额，单位：元',
  `receipted_price` decimal(24,6) DEFAULT NULL COMMENT '已收金额，单位：元',
  `receipt_price` decimal(24,6) DEFAULT NULL COMMENT '本次收款，单位：元',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 收款项';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_product` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '产品编号',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '产品名称',
  `bar_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '产品条码',
  `category_id` bigint DEFAULT NULL COMMENT '产品分类编号',
  `unit_id` bigint DEFAULT NULL COMMENT '单位编号',
  `status` int DEFAULT NULL COMMENT '产品状态',
  `standard` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '产品规格',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '产品备注',
  `expiry_day` int DEFAULT NULL COMMENT '保质期天数',
  `weight` decimal(24,6) DEFAULT NULL COMMENT '基础重量（kg）',
  `purchase_price` decimal(24,6) DEFAULT NULL COMMENT '采购价格，单位：元',
  `sale_price` decimal(24,6) DEFAULT NULL COMMENT '销售价格，单位：元',
  `min_price` decimal(24,6) DEFAULT NULL COMMENT '最低价格，单位：元',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 产品';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_product_category` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '分类编号',
  `parent_id` bigint DEFAULT NULL COMMENT '父分类编号',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分类名称',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分类编码',
  `sort` int DEFAULT NULL COMMENT '分类排序',
  `status` int DEFAULT NULL COMMENT '开启状态',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 产品分类';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_product_unit` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '单位编号',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '单位名字',
  `status` int DEFAULT NULL COMMENT '单位状态',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 产品单位';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_purchase_in` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '采购入库单号',
  `status` int DEFAULT NULL COMMENT '入库状态',
  `supplier_id` bigint DEFAULT NULL COMMENT '供应商编号',
  `account_id` bigint DEFAULT NULL COMMENT '结算账户编号',
  `in_time` datetime DEFAULT NULL COMMENT '入库时间',
  `order_id` bigint DEFAULT NULL COMMENT '采购订单编号',
  `order_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '采购订单号',
  `total_count` decimal(24,6) DEFAULT NULL COMMENT '合计数量',
  `total_price` decimal(24,6) DEFAULT NULL COMMENT '最终合计价格，单位：元',
  `payment_price` decimal(24,6) DEFAULT NULL COMMENT '已支付金额，单位：元',
  `total_product_price` decimal(24,6) DEFAULT NULL COMMENT '合计产品价格，单位：元',
  `total_tax_price` decimal(24,6) DEFAULT NULL COMMENT '合计税额，单位：元',
  `discount_percent` decimal(24,6) DEFAULT NULL COMMENT '优惠率，百分比',
  `discount_price` decimal(24,6) DEFAULT NULL COMMENT '优惠金额，单位：元',
  `other_price` decimal(24,6) DEFAULT NULL COMMENT '其它金额，单位：元',
  `file_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '附件地址',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 采购入库';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_purchase_in_items` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `in_id` bigint DEFAULT NULL COMMENT '采购入库编号',
  `order_item_id` bigint DEFAULT NULL COMMENT '采购订单项编号',
  `warehouse_id` bigint DEFAULT NULL COMMENT '仓库编号',
  `product_id` bigint DEFAULT NULL COMMENT '产品编号',
  `product_unit_id` bigint DEFAULT NULL COMMENT '产品单位编号',
  `product_price` decimal(24,6) DEFAULT NULL COMMENT '产品单位单价，单位：元',
  `count` decimal(24,6) DEFAULT NULL COMMENT '数量',
  `total_price` decimal(24,6) DEFAULT NULL COMMENT '总价，单位：元',
  `tax_percent` decimal(24,6) DEFAULT NULL COMMENT '税率，百分比',
  `tax_price` decimal(24,6) DEFAULT NULL COMMENT '税额，单位：元',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 采购入库项';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_purchase_order` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '采购订单号',
  `status` int DEFAULT NULL COMMENT '采购状态',
  `supplier_id` bigint DEFAULT NULL COMMENT '供应商编号',
  `account_id` bigint DEFAULT NULL COMMENT '结算账户编号',
  `order_time` datetime DEFAULT NULL COMMENT '下单时间',
  `total_count` decimal(24,6) DEFAULT NULL COMMENT '合计数量',
  `total_price` decimal(24,6) DEFAULT NULL COMMENT '最终合计价格，单位：元',
  `total_product_price` decimal(24,6) DEFAULT NULL COMMENT '合计产品价格，单位：元',
  `total_tax_price` decimal(24,6) DEFAULT NULL COMMENT '合计税额，单位：元',
  `discount_percent` decimal(24,6) DEFAULT NULL COMMENT '优惠率，百分比',
  `discount_price` decimal(24,6) DEFAULT NULL COMMENT '优惠金额，单位：元',
  `deposit_price` decimal(24,6) DEFAULT NULL COMMENT '定金金额，单位：元',
  `file_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '附件地址',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `in_count` decimal(24,6) DEFAULT NULL COMMENT '采购入库数量',
  `return_count` decimal(24,6) DEFAULT NULL COMMENT '采购退货数量',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 采购订单';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_purchase_order_items` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `order_id` bigint DEFAULT NULL COMMENT '采购订单编号',
  `product_id` bigint DEFAULT NULL COMMENT '产品编号',
  `product_unit_id` bigint DEFAULT NULL COMMENT '产品单位编号',
  `product_price` decimal(24,6) DEFAULT NULL COMMENT '产品单位单价，单位：元',
  `count` decimal(24,6) DEFAULT NULL COMMENT '数量',
  `total_price` decimal(24,6) DEFAULT NULL COMMENT '总价，单位：元',
  `tax_percent` decimal(24,6) DEFAULT NULL COMMENT '税率，百分比',
  `tax_price` decimal(24,6) DEFAULT NULL COMMENT '税额，单位：元',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `in_count` decimal(24,6) DEFAULT NULL COMMENT '采购入库数量',
  `return_count` decimal(24,6) DEFAULT NULL COMMENT '采购退货数量',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 采购订单项';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_purchase_return` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '采购退货单号',
  `status` int DEFAULT NULL COMMENT '退货状态',
  `supplier_id` bigint DEFAULT NULL COMMENT '供应商编号',
  `account_id` bigint DEFAULT NULL COMMENT '结算账户编号',
  `return_time` datetime DEFAULT NULL COMMENT '退货时间',
  `order_id` bigint DEFAULT NULL COMMENT '采购订单编号',
  `order_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '采购订单号',
  `total_count` decimal(24,6) DEFAULT NULL COMMENT '合计数量',
  `total_price` decimal(24,6) DEFAULT NULL COMMENT '最终合计价格，单位：元',
  `refund_price` decimal(24,6) DEFAULT NULL COMMENT '已退款金额，单位：元',
  `total_product_price` decimal(24,6) DEFAULT NULL COMMENT '合计产品价格，单位：元',
  `total_tax_price` decimal(24,6) DEFAULT NULL COMMENT '合计税额，单位：元',
  `discount_percent` decimal(24,6) DEFAULT NULL COMMENT '优惠率，百分比',
  `discount_price` decimal(24,6) DEFAULT NULL COMMENT '优惠金额，单位：元',
  `other_price` decimal(24,6) DEFAULT NULL COMMENT '其它金额，单位：元',
  `file_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '附件地址',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 采购退货';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_purchase_return_items` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `return_id` bigint DEFAULT NULL COMMENT '采购退货编号',
  `order_item_id` bigint DEFAULT NULL COMMENT '采购订单项编号',
  `warehouse_id` bigint DEFAULT NULL COMMENT '仓库编号',
  `product_id` bigint DEFAULT NULL COMMENT '产品编号',
  `product_unit_id` bigint DEFAULT NULL COMMENT '产品单位编号',
  `product_price` decimal(24,6) DEFAULT NULL COMMENT '产品单位单价，单位：元',
  `count` decimal(24,6) DEFAULT NULL COMMENT '数量',
  `total_price` decimal(24,6) DEFAULT NULL COMMENT '总价，单位：元',
  `tax_percent` decimal(24,6) DEFAULT NULL COMMENT '税率，百分比',
  `tax_price` decimal(24,6) DEFAULT NULL COMMENT '税额，单位：元',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 采购退货项';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_sale_order` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '销售订单号',
  `status` int DEFAULT NULL COMMENT '销售状态',
  `customer_id` bigint DEFAULT NULL COMMENT '客户编号',
  `account_id` bigint DEFAULT NULL COMMENT '结算账户编号',
  `sale_user_id` bigint DEFAULT NULL COMMENT '销售员编号',
  `order_time` datetime DEFAULT NULL COMMENT '下单时间',
  `total_count` decimal(24,6) DEFAULT NULL COMMENT '合计数量',
  `total_price` decimal(24,6) DEFAULT NULL COMMENT '最终合计价格，单位：元',
  `total_product_price` decimal(24,6) DEFAULT NULL COMMENT '合计产品价格，单位：元',
  `total_tax_price` decimal(24,6) DEFAULT NULL COMMENT '合计税额，单位：元',
  `discount_percent` decimal(24,6) DEFAULT NULL COMMENT '优惠率，百分比',
  `discount_price` decimal(24,6) DEFAULT NULL COMMENT '优惠金额，单位：元',
  `deposit_price` decimal(24,6) DEFAULT NULL COMMENT '定金金额，单位：元',
  `file_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '附件地址',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `out_count` decimal(24,6) DEFAULT NULL COMMENT '销售出库数量',
  `return_count` decimal(24,6) DEFAULT NULL COMMENT '销售退货数量',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 销售订单';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_sale_order_items` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `order_id` bigint DEFAULT NULL COMMENT '销售订单编号',
  `product_id` bigint DEFAULT NULL COMMENT '产品编号',
  `product_unit_id` bigint DEFAULT NULL COMMENT '产品单位编号',
  `product_price` decimal(24,6) DEFAULT NULL COMMENT '产品单位单价，单位：元',
  `count` decimal(24,6) DEFAULT NULL COMMENT '数量',
  `total_price` decimal(24,6) DEFAULT NULL COMMENT '总价，单位：元',
  `tax_percent` decimal(24,6) DEFAULT NULL COMMENT '税率，百分比',
  `tax_price` decimal(24,6) DEFAULT NULL COMMENT '税额，单位：元',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `out_count` decimal(24,6) DEFAULT NULL COMMENT '销售出库数量',
  `return_count` decimal(24,6) DEFAULT NULL COMMENT '销售退货数量',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 销售订单项';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_sale_out` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '销售出库单号',
  `status` int DEFAULT NULL COMMENT '出库状态',
  `customer_id` bigint DEFAULT NULL COMMENT '客户编号',
  `account_id` bigint DEFAULT NULL COMMENT '结算账户编号',
  `sale_user_id` bigint DEFAULT NULL COMMENT '销售员编号',
  `out_time` datetime DEFAULT NULL COMMENT '出库时间',
  `order_id` bigint DEFAULT NULL COMMENT '销售订单编号',
  `order_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '销售订单号',
  `total_count` decimal(24,6) DEFAULT NULL COMMENT '合计数量',
  `total_price` decimal(24,6) DEFAULT NULL COMMENT '最终合计价格，单位：元',
  `receipt_price` decimal(24,6) DEFAULT NULL COMMENT '已收款金额，单位：元',
  `total_product_price` decimal(24,6) DEFAULT NULL COMMENT '合计产品价格，单位：元',
  `total_tax_price` decimal(24,6) DEFAULT NULL COMMENT '合计税额，单位：元',
  `discount_percent` decimal(24,6) DEFAULT NULL COMMENT '优惠率，百分比',
  `discount_price` decimal(24,6) DEFAULT NULL COMMENT '优惠金额，单位：元',
  `other_price` decimal(24,6) DEFAULT NULL COMMENT '其它金额，单位：元',
  `file_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '附件地址',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 销售出库';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_sale_out_items` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `out_id` bigint DEFAULT NULL COMMENT '销售出库编号',
  `order_item_id` bigint DEFAULT NULL COMMENT '销售订单项编号',
  `warehouse_id` bigint DEFAULT NULL COMMENT '仓库编号',
  `product_id` bigint DEFAULT NULL COMMENT '产品编号',
  `product_unit_id` bigint DEFAULT NULL COMMENT '产品单位编号',
  `product_price` decimal(24,6) DEFAULT NULL COMMENT '产品单位单价，单位：元',
  `count` decimal(24,6) DEFAULT NULL COMMENT '数量',
  `total_price` decimal(24,6) DEFAULT NULL COMMENT '总价，单位：元',
  `tax_percent` decimal(24,6) DEFAULT NULL COMMENT '税率，百分比',
  `tax_price` decimal(24,6) DEFAULT NULL COMMENT '税额，单位：元',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 销售出库项';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_sale_return` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '销售退货单号',
  `status` int DEFAULT NULL COMMENT '退货状态',
  `customer_id` bigint DEFAULT NULL COMMENT '客户编号',
  `account_id` bigint DEFAULT NULL COMMENT '结算账户编号',
  `sale_user_id` bigint DEFAULT NULL COMMENT '销售员编号',
  `return_time` datetime DEFAULT NULL COMMENT '退货时间',
  `order_id` bigint DEFAULT NULL COMMENT '销售订单编号',
  `order_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '销售订单号',
  `total_count` decimal(24,6) DEFAULT NULL COMMENT '合计数量',
  `total_price` decimal(24,6) DEFAULT NULL COMMENT '最终合计价格，单位：元',
  `refund_price` decimal(24,6) DEFAULT NULL COMMENT '已退款金额，单位：元',
  `total_product_price` decimal(24,6) DEFAULT NULL COMMENT '合计产品价格，单位：元',
  `total_tax_price` decimal(24,6) DEFAULT NULL COMMENT '合计税额，单位：元',
  `discount_percent` decimal(24,6) DEFAULT NULL COMMENT '优惠率，百分比',
  `discount_price` decimal(24,6) DEFAULT NULL COMMENT '优惠金额，单位：元',
  `other_price` decimal(24,6) DEFAULT NULL COMMENT '其它金额，单位：元',
  `file_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '附件地址',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 销售退货';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_sale_return_items` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `return_id` bigint DEFAULT NULL COMMENT '销售退货编号',
  `order_item_id` bigint DEFAULT NULL COMMENT '销售订单项编号',
  `warehouse_id` bigint DEFAULT NULL COMMENT '仓库编号',
  `product_id` bigint DEFAULT NULL COMMENT '产品编号',
  `product_unit_id` bigint DEFAULT NULL COMMENT '产品单位编号',
  `product_price` decimal(24,6) DEFAULT NULL COMMENT '产品单位单价，单位：元',
  `count` decimal(24,6) DEFAULT NULL COMMENT '数量',
  `total_price` decimal(24,6) DEFAULT NULL COMMENT '总价，单位：元',
  `tax_percent` decimal(24,6) DEFAULT NULL COMMENT '税率，百分比',
  `tax_price` decimal(24,6) DEFAULT NULL COMMENT '税额，单位：元',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 销售退货项';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_stock` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `product_id` bigint DEFAULT NULL COMMENT '产品编号',
  `warehouse_id` bigint DEFAULT NULL COMMENT '仓库编号',
  `count` decimal(24,6) DEFAULT NULL COMMENT '库存数量',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 产品库存';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_stock_check` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '盘点编号',
  `no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '盘点单号',
  `check_time` datetime DEFAULT NULL COMMENT '盘点时间',
  `total_count` decimal(24,6) DEFAULT NULL COMMENT '合计数量',
  `total_price` decimal(24,6) DEFAULT NULL COMMENT '合计金额，单位：元',
  `status` int DEFAULT NULL COMMENT '状态',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `file_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '附件 URL',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 库存盘点单';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_stock_check_item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '盘点项编号',
  `check_id` bigint DEFAULT NULL COMMENT '盘点编号',
  `warehouse_id` bigint DEFAULT NULL COMMENT '仓库编号',
  `product_id` bigint DEFAULT NULL COMMENT '产品编号',
  `product_unit_id` bigint DEFAULT NULL COMMENT '产品单位编号',
  `product_price` decimal(24,6) DEFAULT NULL COMMENT '产品单价',
  `stock_count` decimal(24,6) DEFAULT NULL COMMENT '账面数量（当前库存）',
  `actual_count` decimal(24,6) DEFAULT NULL COMMENT '实际数量（实际库存）',
  `count` decimal(24,6) DEFAULT NULL COMMENT '盈亏数量',
  `total_price` decimal(24,6) DEFAULT NULL COMMENT '合计金额，单位：元',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 库存盘点单项';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_stock_in` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '入库编号',
  `no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '入库单号',
  `supplier_id` bigint DEFAULT NULL COMMENT '供应商编号',
  `in_time` datetime DEFAULT NULL COMMENT '入库时间',
  `total_count` decimal(24,6) DEFAULT NULL COMMENT '合计数量',
  `total_price` decimal(24,6) DEFAULT NULL COMMENT '合计金额，单位：元',
  `status` int DEFAULT NULL COMMENT '状态',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `file_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '附件 URL',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 其它入库单';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_stock_in_item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '入库项编号',
  `in_id` bigint DEFAULT NULL COMMENT '入库编号',
  `warehouse_id` bigint DEFAULT NULL COMMENT '仓库编号',
  `product_id` bigint DEFAULT NULL COMMENT '产品编号',
  `product_unit_id` bigint DEFAULT NULL COMMENT '产品单位编号',
  `product_price` decimal(24,6) DEFAULT NULL COMMENT '产品单价',
  `count` decimal(24,6) DEFAULT NULL COMMENT '产品数量',
  `total_price` decimal(24,6) DEFAULT NULL COMMENT '合计金额，单位：元',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 其它入库单项';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_stock_move` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '调拨编号',
  `no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '调拨单号',
  `move_time` datetime DEFAULT NULL COMMENT '调拨时间',
  `total_count` decimal(24,6) DEFAULT NULL COMMENT '合计数量',
  `total_price` decimal(24,6) DEFAULT NULL COMMENT '合计金额，单位：元',
  `status` int DEFAULT NULL COMMENT '状态',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `file_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '附件 URL',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 库存调拨单';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_stock_move_item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '调拨项编号',
  `move_id` bigint DEFAULT NULL COMMENT '调拨编号',
  `from_warehouse_id` bigint DEFAULT NULL COMMENT '调出仓库编号',
  `to_warehouse_id` bigint DEFAULT NULL COMMENT '调入仓库编号',
  `product_id` bigint DEFAULT NULL COMMENT '产品编号',
  `product_unit_id` bigint DEFAULT NULL COMMENT '产品单位编号',
  `product_price` decimal(24,6) DEFAULT NULL COMMENT '产品单价',
  `count` decimal(24,6) DEFAULT NULL COMMENT '产品数量',
  `total_price` decimal(24,6) DEFAULT NULL COMMENT '合计金额，单位：元',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 库存调拨单项';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_stock_out` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '出库编号',
  `no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '出库单号',
  `customer_id` bigint DEFAULT NULL COMMENT '客户编号',
  `out_time` datetime DEFAULT NULL COMMENT '出库时间',
  `total_count` decimal(24,6) DEFAULT NULL COMMENT '合计数量',
  `total_price` decimal(24,6) DEFAULT NULL COMMENT '合计金额，单位：元',
  `status` int DEFAULT NULL COMMENT '状态',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `file_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '附件 URL',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 其它出库单';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_stock_out_item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '出库项编号',
  `out_id` bigint DEFAULT NULL COMMENT '出库编号',
  `warehouse_id` bigint DEFAULT NULL COMMENT '仓库编号',
  `product_id` bigint DEFAULT NULL COMMENT '产品编号',
  `product_unit_id` bigint DEFAULT NULL COMMENT '产品单位编号',
  `product_price` decimal(24,6) DEFAULT NULL COMMENT '产品单价',
  `count` decimal(24,6) DEFAULT NULL COMMENT '产品数量',
  `total_price` decimal(24,6) DEFAULT NULL COMMENT '合计金额，单位：元',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 其它出库单项';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_stock_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `product_id` bigint DEFAULT NULL COMMENT '产品编号',
  `warehouse_id` bigint DEFAULT NULL COMMENT '仓库编号',
  `count` decimal(24,6) DEFAULT NULL COMMENT '出入库数量',
  `total_count` decimal(24,6) DEFAULT NULL COMMENT '总库存量',
  `biz_type` int DEFAULT NULL COMMENT '业务类型',
  `biz_id` bigint DEFAULT NULL COMMENT '业务编号',
  `biz_item_id` bigint DEFAULT NULL COMMENT '业务项编号',
  `biz_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '业务单号',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 产品库存明细';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_supplier` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '供应商编号',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '供应商名称',
  `contact` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系人',
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机号码',
  `telephone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系电话',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电子邮箱',
  `fax` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '传真',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `status` int DEFAULT NULL COMMENT '开启状态',
  `sort` int DEFAULT NULL COMMENT '排序',
  `tax_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '纳税人识别号',
  `tax_percent` decimal(24,6) DEFAULT NULL COMMENT '税率',
  `bank_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '开户行',
  `bank_account` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '开户账号',
  `bank_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '开户地址',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 供应商';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `erp_warehouse` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '仓库编号',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '仓库名称',
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '仓库地址',
  `sort` bigint DEFAULT NULL COMMENT '排序',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `principal` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '负责人',
  `warehouse_price` decimal(24,6) DEFAULT NULL COMMENT '仓储费，单位：元',
  `truckage_price` decimal(24,6) DEFAULT NULL COMMENT '搬运费，单位：元',
  `status` int DEFAULT NULL COMMENT '开启状态',
  `default_status` tinyint(1) DEFAULT NULL COMMENT '是否默认',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ERP 仓库';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `fms_account_set` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `company_code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_profile` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `industry` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `legal_representative` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `legal_representative_id_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `business_license_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `organization_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `office_telephone` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fax_number` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qq_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `other_contact` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency_id` bigint DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `standard` int DEFAULT NULL,
  `initialized` bit(1) NOT NULL DEFAULT b'0',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `company_code` (`company_code`,`deleted`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `fms_account_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_set_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `default_status` bit(1) NOT NULL DEFAULT b'0',
  `founder` bit(1) NOT NULL DEFAULT b'0',
  `level` int NOT NULL DEFAULT '2',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `fms_assist_combination` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `subject_id` bigint DEFAULT NULL,
  `account_set_id` bigint DEFAULT NULL,
  `items` varchar(10000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `fms_auxiliary_item` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `auxiliary_type_id` bigint DEFAULT NULL,
  `status` int DEFAULT NULL,
  `account_set_id` bigint DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `specification` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_set_id` (`account_set_id`,`auxiliary_type_id`,`code`,`deleted`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `fms_auxiliary_type` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `system_preset` bit(1) NOT NULL DEFAULT b'0',
  `account_set_id` bigint DEFAULT NULL,
  `type` int DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_set_id` (`account_set_id`,`name`,`deleted`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `fms_balance_sheet_config` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `row_no` int DEFAULT NULL,
  `formula` text COLLATE utf8mb4_unicode_ci,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editable` bit(1) NOT NULL DEFAULT b'0',
  `sort` int DEFAULT NULL,
  `account_set_id` bigint DEFAULT NULL,
  `level` int DEFAULT NULL,
  `row_id` int DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `fms_balance_sheet_report` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `from_period` int DEFAULT NULL,
  `to_period` int DEFAULT NULL,
  `type` int DEFAULT NULL,
  `level` int DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `row_no` int DEFAULT NULL,
  `formula` text COLLATE utf8mb4_unicode_ci,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editable` bit(1) NOT NULL DEFAULT b'0',
  `sort` int DEFAULT NULL,
  `opening_amount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `closing_amount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `account_set_id` bigint DEFAULT NULL,
  `settled` bit(1) NOT NULL DEFAULT b'0',
  `row_id` int DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `fms_cash_flow_extend_config` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `row_no` int DEFAULT NULL,
  `formula` text COLLATE utf8mb4_unicode_ci,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category` int DEFAULT NULL,
  `type` int DEFAULT NULL,
  `current_amount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `year_amount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `editable` bit(1) NOT NULL DEFAULT b'0',
  `account_set_id` bigint DEFAULT NULL,
  `sort` int DEFAULT NULL,
  `level` int DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `fms_cash_flow_extend_data` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `row_no` int DEFAULT NULL,
  `formula` text COLLATE utf8mb4_unicode_ci,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category` int DEFAULT NULL,
  `current_amount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `year_amount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `from_period` int DEFAULT NULL,
  `editable` bit(1) NOT NULL DEFAULT b'0',
  `account_set_id` bigint DEFAULT NULL,
  `sort` int DEFAULT NULL,
  `to_period` int DEFAULT NULL,
  `type` int DEFAULT NULL,
  `level` int DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `fms_cash_flow_statement_config` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `row_no` int DEFAULT NULL,
  `formula` text COLLATE utf8mb4_unicode_ci,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editable` bit(1) NOT NULL DEFAULT b'0',
  `sort` int DEFAULT NULL,
  `category` int DEFAULT NULL,
  `account_set_id` bigint DEFAULT NULL,
  `level` int DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `fms_cash_flow_statement_report` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `from_period` int DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `row_no` int DEFAULT NULL,
  `formula` text COLLATE utf8mb4_unicode_ci,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editable` bit(1) NOT NULL DEFAULT b'0',
  `current_amount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `year_amount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `sort` int DEFAULT NULL,
  `category` int DEFAULT NULL,
  `account_set_id` bigint DEFAULT NULL,
  `to_period` int DEFAULT NULL,
  `type` int DEFAULT NULL,
  `level` int DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `fms_closing` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `period_end` bit(1) NOT NULL DEFAULT b'0',
  `subject_id` bigint DEFAULT NULL,
  `formula_rule` int DEFAULT NULL,
  `time_type` int DEFAULT NULL,
  `voucher_word_id` bigint DEFAULT NULL,
  `digest` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `voucher_type` int DEFAULT NULL,
  `prior_year_adjustment_subject_id` bigint DEFAULT NULL,
  `adjustment_closing_subject_id` bigint DEFAULT NULL,
  `other_closing_subject_id` bigint DEFAULT NULL,
  `reverse_balance` bit(1) NOT NULL DEFAULT b'0',
  `type` int DEFAULT NULL,
  `account_set_id` bigint DEFAULT NULL,
  `closing_day` int DEFAULT NULL,
  `subject_rules` varchar(10000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `fms_closing_period` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `closing_time` timestamp NULL DEFAULT NULL,
  `account_set_id` bigint DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `fms_closing_template` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_set_id` bigint DEFAULT NULL,
  `preset_code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category` int DEFAULT NULL,
  `period_end` bit(1) NOT NULL DEFAULT b'0',
  `subject_id` bigint DEFAULT NULL,
  `formula_rule` int DEFAULT NULL,
  `time_type` int DEFAULT NULL,
  `subject_rules` varchar(10000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort` int DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `fms_closing_voucher` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `closing_id` bigint DEFAULT NULL,
  `voucher_id` bigint DEFAULT NULL,
  `voucher_time` timestamp NULL DEFAULT NULL,
  `amount` decimal(24,6) NOT NULL DEFAULT '0.000000',
  `closed` bit(1) NOT NULL DEFAULT b'0',
  `account_set_id` bigint DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `fms_currency` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exchange_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `standard` bit(1) NOT NULL DEFAULT b'0',
  `account_set_id` bigint DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_set_id` (`account_set_id`,`code`,`deleted`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `fms_digest` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_set_id` bigint NOT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `fms_finance_indicator` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_set_id` bigint NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` int NOT NULL,
  `formula` varchar(2000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort` int NOT NULL DEFAULT '0',
  `status` int NOT NULL DEFAULT '0',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `fms_finance_parameter` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_set_id` bigint NOT NULL,
  `level` int NOT NULL,
  `subject_code_rule` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ledger_balance_mode` int NOT NULL,
  `deficit_check` bit(1) NOT NULL DEFAULT b'0',
  `voucher_review_required` bit(1) NOT NULL DEFAULT b'0',
  `asset_period_locked` bit(1) NOT NULL DEFAULT b'0',
  `taxpayer_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `taxpayer_number` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_set_id` (`account_set_id`,`deleted`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `fms_income_statement_config` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `row_no` int DEFAULT NULL,
  `formula` text COLLATE utf8mb4_unicode_ci,
  `sort` int DEFAULT NULL,
  `editable` bit(1) NOT NULL DEFAULT b'0',
  `account_set_id` bigint DEFAULT NULL,
  `level` int DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `fms_income_statement_report` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type` int DEFAULT NULL,
  `from_period` int DEFAULT NULL,
  `to_period` int DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `row_no` int DEFAULT NULL,
  `formula` text COLLATE utf8mb4_unicode_ci,
  `sort` int DEFAULT NULL,
  `editable` bit(1) NOT NULL DEFAULT b'0',
  `current_amount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `year_amount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `account_set_id` bigint DEFAULT NULL,
  `level` int DEFAULT NULL,
  `settled` bit(1) NOT NULL DEFAULT b'0',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `fms_initial_balance` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `subject_id` bigint DEFAULT NULL,
  `auxiliary_accounting` bit(1) NOT NULL DEFAULT b'0',
  `opening_amount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `opening_quantity` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `year_debit_amount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `year_debit_quantity` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `year_credit_amount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `year_credit_quantity` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `year_opening_amount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `year_opening_quantity` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `profit_loss_amount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `profit_loss_quantity` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `account_set_id` bigint DEFAULT NULL,
  `assist_balances` varchar(10000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_set_id` (`account_set_id`,`subject_id`,`deleted`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `fms_report_template` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `row_no` int DEFAULT NULL,
  `formula` text COLLATE utf8mb4_unicode_ci,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editable` bit(1) NOT NULL DEFAULT b'0',
  `sort` int DEFAULT NULL,
  `row_id` int DEFAULT NULL,
  `type` int DEFAULT NULL,
  `category` int DEFAULT NULL,
  `level` int DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `fms_subject` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` bigint NOT NULL DEFAULT '0',
  `type` int DEFAULT NULL,
  `category` int DEFAULT NULL,
  `balance_direction` int DEFAULT NULL,
  `quantity_unit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cash` bit(1) NOT NULL DEFAULT b'0',
  `status` tinyint NOT NULL DEFAULT '0',
  `level` int DEFAULT NULL,
  `quantity_accounting` bit(1) NOT NULL DEFAULT b'0',
  `account_set_id` bigint DEFAULT NULL,
  `auxiliary_type_ids` varchar(10000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency_ids` varchar(4000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `fms_subject_template` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` bigint NOT NULL DEFAULT '0',
  `type` int DEFAULT NULL,
  `category` int DEFAULT NULL,
  `balance_direction` int DEFAULT NULL,
  `quantity_unit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cash` bit(1) NOT NULL DEFAULT b'0',
  `status` int DEFAULT NULL,
  `level` int DEFAULT NULL,
  `quantity_accounting` bit(1) NOT NULL DEFAULT b'0',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `fms_voucher` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `voucher_word_id` bigint DEFAULT NULL,
  `voucher_number` int DEFAULT NULL,
  `voucher_time` timestamp NULL DEFAULT NULL,
  `voucher_period` int GENERATED ALWAYS AS (((year(`voucher_time`) * 100) + month(`voucher_time`))) VIRTUAL,
  `attachment_urls` varchar(10000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attachment_count` int NOT NULL DEFAULT '0',
  `debit_amount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `credit_amount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `total` decimal(18,2) NOT NULL DEFAULT '0.00',
  `status` int DEFAULT NULL,
  `reviewer_user_id` bigint DEFAULT NULL,
  `account_set_id` bigint DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `fms_voucher_entry` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `digest` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `debit_amount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `credit_amount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `voucher_id` bigint DEFAULT NULL,
  `subject_code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort` int DEFAULT NULL,
  `subject_id` bigint DEFAULT NULL,
  `account_set_id` bigint DEFAULT NULL,
  `unit_price` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `assist_combination_id` bigint DEFAULT NULL,
  `auxiliaries` varchar(10000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `fms_voucher_template` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` bigint NOT NULL,
  `entries` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_set_id` bigint NOT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `fms_voucher_template_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_set_id` bigint NOT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `fms_voucher_word` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `print_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_status` bit(1) NOT NULL DEFAULT b'0',
  `sort` int NOT NULL DEFAULT '0',
  `account_set_id` bigint DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_attendance_clock` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `employee_id` bigint DEFAULT NULL,
  `clock_time` timestamp NOT NULL,
  `type` tinyint NOT NULL,
  `attendance_time` timestamp NOT NULL,
  `source_type` tinyint DEFAULT '2',
  `status` tinyint DEFAULT '0',
  `stage` int DEFAULT '1',
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longitude` decimal(10,6) DEFAULT NULL,
  `latitude` decimal(10,6) DEFAULT NULL,
  `ssid` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mac` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_attendance_group` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dept_ids` text COLLATE utf8mb4_unicode_ci,
  `employee_ids` text COLLATE utf8mb4_unicode_ci,
  `open_wifi_card` tinyint(1) NOT NULL DEFAULT '0',
  `open_point_card` tinyint(1) NOT NULL DEFAULT '0',
  `shifts` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `rest` tinyint(1) NOT NULL DEFAULT '1',
  `special_dates` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `points` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `wifis` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `deduct_rule` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `default_status` tinyint(1) NOT NULL DEFAULT '0',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_attendance_holiday` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL,
  `type` tinyint DEFAULT '2',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_attendance_leave` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `employee_id` bigint NOT NULL,
  `type` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `day` decimal(10,2) DEFAULT NULL,
  `reason` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approval_status` tinyint NOT NULL,
  `process_instance_id` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approval_time` timestamp NULL DEFAULT NULL,
  `approval_reason` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_hrm_attendance_leave_process_instance_id` (`process_instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_config` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type` tinyint NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort` int DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_employee` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `job_number` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nation` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_type` tinyint DEFAULT NULL,
  `id_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sex` tinyint DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `native_place` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birthday` timestamp NULL DEFAULT NULL,
  `age` int DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `highest_education` tinyint DEFAULT NULL,
  `dept_id` bigint DEFAULT NULL,
  `leader_employee_id` bigint DEFAULT NULL,
  `entry_status` tinyint DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  `type` tinyint DEFAULT NULL,
  `entry_time` timestamp NULL DEFAULT NULL,
  `probation` int DEFAULT NULL,
  `regular_time` timestamp NULL DEFAULT NULL,
  `leave_time` timestamp NULL DEFAULT NULL,
  `post_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `post_level` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `work_city` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `work_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `work_detail_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel_id` bigint DEFAULT NULL,
  `company_age_start_time` timestamp NULL DEFAULT NULL,
  `company_age` int DEFAULT NULL,
  `candidate_id` bigint DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_employee_certificate` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `employee_id` bigint NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `level` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `issuing_authority` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `issuing_time` timestamp NULL DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort` int DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_employee_change_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `employee_id` bigint NOT NULL,
  `type` tinyint DEFAULT NULL,
  `reason` tinyint DEFAULT NULL,
  `old_dept_id` bigint DEFAULT NULL,
  `new_dept_id` bigint DEFAULT NULL,
  `old_post_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `new_post_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `old_post_level` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `new_post_level` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `old_work_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `new_work_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `old_leader_employee_id` bigint DEFAULT NULL,
  `new_leader_employee_id` bigint DEFAULT NULL,
  `probation` int DEFAULT NULL,
  `effect_time` timestamp NULL DEFAULT NULL,
  `applied_time` timestamp NULL DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_employee_contact` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `employee_id` bigint NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `relation` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `work_unit` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `post_name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort` int DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_employee_contract` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `employee_id` bigint NOT NULL,
  `no` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` tinyint DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `term` int DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  `sign_company` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sign_time` timestamp NULL DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expire_remind` tinyint(1) DEFAULT NULL,
  `sort` int DEFAULT NULL,
  `file_urls` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_employee_education_experience` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `employee_id` bigint NOT NULL,
  `education` tinyint DEFAULT NULL,
  `graduate_school` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `major` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admission_time` timestamp NULL DEFAULT NULL,
  `graduation_time` timestamp NULL DEFAULT NULL,
  `teaching_methods` tinyint DEFAULT NULL,
  `first_degree` tinyint(1) DEFAULT NULL,
  `sort` int DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_employee_file` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `employee_id` bigint NOT NULL,
  `type` tinyint NOT NULL,
  `url` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_employee_personal_note` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `employee_id` bigint NOT NULL,
  `content` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reminder_time` timestamp NOT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_employee_quit_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `employee_id` bigint NOT NULL,
  `plan_quit_time` timestamp NULL DEFAULT NULL,
  `apply_quit_time` timestamp NULL DEFAULT NULL,
  `salary_settlement_time` timestamp NULL DEFAULT NULL,
  `type` tinyint DEFAULT NULL,
  `reason` tinyint DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `old_employee_status` tinyint DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_employee_salary_card` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `employee_id` bigint NOT NULL,
  `bank_card_number` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_area_id` int DEFAULT NULL,
  `bank_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_branch_name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_employee_training_experience` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `employee_id` bigint NOT NULL,
  `course` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `organization_name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `duration` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `result` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `certificate_name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort` int DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_employee_work_experience` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `employee_id` bigint NOT NULL,
  `work_unit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `post_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `reason` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `witness_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `witness_phone` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort` int DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_insurance_employee_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `employee_id` bigint NOT NULL,
  `first_social_security` tinyint(1) NOT NULL DEFAULT '0',
  `first_accumulation_fund` tinyint(1) NOT NULL DEFAULT '0',
  `social_security_number` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `accumulation_fund_number` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `social_security_start_month` timestamp NULL DEFAULT NULL,
  `scheme_id` bigint DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_insurance_month_employee_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `month_record_id` bigint NOT NULL,
  `employee_id` bigint NOT NULL,
  `scheme_id` bigint DEFAULT NULL,
  `year` int NOT NULL,
  `month` int NOT NULL,
  `personal_insurance_amount` decimal(12,2) DEFAULT NULL,
  `personal_provident_fund_amount` decimal(12,2) DEFAULT NULL,
  `corporate_insurance_amount` decimal(12,2) DEFAULT NULL,
  `corporate_provident_fund_amount` decimal(12,2) DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  `projects` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_insurance_month_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` int NOT NULL,
  `month` int NOT NULL,
  `insured_employee_count` int DEFAULT NULL,
  `stopped_employee_count` int DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  `personal_insurance_amount` decimal(12,2) DEFAULT NULL,
  `personal_provident_fund_amount` decimal(12,2) DEFAULT NULL,
  `corporate_insurance_amount` decimal(12,2) DEFAULT NULL,
  `corporate_provident_fund_amount` decimal(12,2) DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_insurance_scheme` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `area_id` int DEFAULT NULL,
  `household_type` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` tinyint NOT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_insurance_scheme_project` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `scheme_id` bigint NOT NULL,
  `type` tinyint NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `base_amount` decimal(12,2) DEFAULT NULL,
  `corporate_rate` decimal(10,2) DEFAULT NULL,
  `personal_rate` decimal(10,2) DEFAULT NULL,
  `corporate_amount` decimal(12,2) DEFAULT NULL,
  `personal_amount` decimal(12,2) DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_performance_assessment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `plan_id` bigint NOT NULL,
  `employee_id` bigint NOT NULL,
  `status` tinyint DEFAULT '2',
  `process_status` tinyint DEFAULT '1',
  `stage_type` tinyint DEFAULT '0',
  `stage_sort` int DEFAULT '0',
  `score` decimal(10,2) DEFAULT '0.00',
  `result_level` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coefficient` decimal(10,2) DEFAULT '1.00',
  `target_confirmation_result` tinyint DEFAULT NULL,
  `target_confirmation_comment` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_confirmation_time` timestamp NULL DEFAULT NULL,
  `self_comment` text COLLATE utf8mb4_unicode_ci,
  `reviewer_comment` text COLLATE utf8mb4_unicode_ci,
  `result_comment` text COLLATE utf8mb4_unicode_ci,
  `result_confirmation_time` timestamp NULL DEFAULT NULL,
  `result_audit_status` tinyint DEFAULT NULL,
  `result_audit_time` timestamp NULL DEFAULT NULL,
  `result_audit_reason` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `appeal_reason` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `appeal_file_urls` text COLLATE utf8mb4_unicode_ci,
  `appeal_submit_time` timestamp NULL DEFAULT NULL,
  `appeal_status` tinyint DEFAULT '0',
  `appeal_time` timestamp NULL DEFAULT NULL,
  `appeal_comment` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `archive_time` timestamp NULL DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_performance_assessment_action_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `assessment_id` bigint NOT NULL,
  `stage_id` bigint DEFAULT NULL,
  `employee_id` bigint DEFAULT NULL,
  `type` tinyint NOT NULL,
  `title` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  `file_urls` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_performance_assessment_appeal_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `assessment_id` bigint NOT NULL,
  `stage_id` bigint NOT NULL,
  `status` tinyint NOT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_performance_assessment_dimension` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `assessment_id` bigint NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quota_type` tinyint DEFAULT NULL,
  `weight` decimal(10,2) DEFAULT NULL,
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `allow_edit` tinyint(1) NOT NULL DEFAULT '0',
  `sort` int NOT NULL DEFAULT '0',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_performance_assessment_quota` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `assessment_id` bigint NOT NULL,
  `dimension_id` bigint NOT NULL,
  `preset` tinyint(1) NOT NULL DEFAULT '1',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `standard` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `weight` decimal(10,2) DEFAULT '100.00',
  `score_type` tinyint DEFAULT NULL,
  `target_value` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actual_value` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `self_score` decimal(10,2) DEFAULT '0.00',
  `reviewer_score` decimal(10,2) DEFAULT '0.00',
  `final_score` decimal(10,2) DEFAULT '0.00',
  `sort` int DEFAULT '0',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_performance_assessment_quota_score` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `assessment_stage_id` bigint NOT NULL,
  `assessment_quota_id` bigint NOT NULL,
  `score` decimal(10,2) NOT NULL,
  `comment` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_performance_assessment_stage` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `assessment_id` bigint NOT NULL,
  `type` tinyint NOT NULL,
  `name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `handler_employee_id` bigint DEFAULT NULL,
  `rater_type` tinyint DEFAULT NULL,
  `weight` decimal(10,2) DEFAULT NULL,
  `scoring_type` tinyint DEFAULT NULL,
  `visible_content` tinyint DEFAULT NULL,
  `required_setting` tinyint(1) DEFAULT NULL,
  `reject_authority` tinyint(1) DEFAULT NULL,
  `sort` int NOT NULL DEFAULT '0',
  `status` tinyint NOT NULL DEFAULT '0',
  `score` decimal(10,2) DEFAULT NULL,
  `result_level` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci,
  `reject_reason` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `submit_time` timestamp NULL DEFAULT NULL,
  `deadline_time` timestamp NULL DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_performance_assessment_template` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `illustrate` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `score_calculation` tinyint DEFAULT '1',
  `upper_limit_type` tinyint DEFAULT '0',
  `upper_limit_score` decimal(10,2) DEFAULT '100.00',
  `dimension_count` int DEFAULT '0',
  `quota_count` int DEFAULT '0',
  `dimensions` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint DEFAULT '0',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_performance_plan` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cycle_type` tinyint DEFAULT NULL,
  `cycle` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quarter` tinyint DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `description` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `assessment_template_id` bigint NOT NULL,
  `assessment_config` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `result_template_id` bigint NOT NULL,
  `result_config` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `quota_setting_type` tinyint NOT NULL DEFAULT '1',
  `target_confirmation` tinyint(1) NOT NULL DEFAULT '0',
  `target_confirmation_stage` longtext COLLATE utf8mb4_unicode_ci,
  `review_stages` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `result_audit` tinyint(1) NOT NULL DEFAULT '1',
  `result_audit_stages` longtext COLLATE utf8mb4_unicode_ci,
  `result_confirmation` tinyint(1) NOT NULL DEFAULT '1',
  `appeal_stages` longtext COLLATE utf8mb4_unicode_ci,
  `appeal_timeout_days` int NOT NULL DEFAULT '2',
  `appeal_timeout_action` tinyint NOT NULL DEFAULT '1',
  `sync_to_salary` tinyint(1) DEFAULT '0',
  `paid_for_month` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stage_type` tinyint DEFAULT '0',
  `status` tinyint DEFAULT '2',
  `operation_type` tinyint DEFAULT NULL,
  `terminate_time` timestamp NULL DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_performance_result_template` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `levels` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint DEFAULT '0',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_recruit_candidate` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sex` tinyint NOT NULL,
  `age` int DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `post_id` bigint NOT NULL,
  `stage_number` int DEFAULT NULL,
  `work_time` int DEFAULT NULL,
  `education` tinyint NOT NULL,
  `graduate_school` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latest_work_place` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel_id` bigint DEFAULT NULL,
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  `eliminate` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_update_time` timestamp NULL DEFAULT NULL,
  `entry_time` timestamp NULL DEFAULT NULL,
  `resume_urls` varchar(4000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_recruit_channel` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `system_flag` bit(1) DEFAULT b'0',
  `status` tinyint DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort` int DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_recruit_interview` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `candidate_id` bigint NOT NULL,
  `type` tinyint DEFAULT NULL,
  `stage_number` int DEFAULT NULL,
  `interview_employee_id` bigint DEFAULT NULL,
  `other_interview_employee_ids` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interview_time` timestamp NULL DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `result` tinyint DEFAULT NULL,
  `evaluate` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cancel_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_recruit_post` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `post_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dept_id` bigint DEFAULT NULL,
  `job_nature` tinyint DEFAULT NULL,
  `area_id` int DEFAULT NULL,
  `recruit_num` int DEFAULT NULL,
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `work_time` tinyint DEFAULT NULL,
  `education_require` tinyint DEFAULT NULL,
  `min_salary` decimal(10,2) DEFAULT NULL,
  `max_salary` decimal(10,2) DEFAULT NULL,
  `salary_unit` tinyint DEFAULT NULL,
  `min_age` int DEFAULT NULL,
  `max_age` int DEFAULT NULL,
  `latest_entry_time` timestamp NULL DEFAULT NULL,
  `owner_employee_id` bigint DEFAULT NULL,
  `interview_employee_ids` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(4000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `emergency_level` tinyint DEFAULT NULL,
  `post_type_id` bigint DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  `stop_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_recruit_post_type` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` bigint DEFAULT NULL,
  `sort` int DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_salary_change_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `employee_id` bigint NOT NULL,
  `type` tinyint DEFAULT NULL,
  `reason` tinyint DEFAULT NULL,
  `effect_time` timestamp NULL DEFAULT NULL,
  `before_total` decimal(12,2) DEFAULT NULL,
  `after_total` decimal(12,2) DEFAULT NULL,
  `probation_before_total` decimal(12,2) DEFAULT NULL,
  `probation_after_total` decimal(12,2) DEFAULT NULL,
  `salary_options` text COLLATE utf8mb4_unicode_ci,
  `probation_salary_options` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_salary_change_template` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `default_status` tinyint(1) NOT NULL DEFAULT '0',
  `options` text COLLATE utf8mb4_unicode_ci,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_salary_config` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cycle_start_day` int DEFAULT NULL,
  `cycle_end_day` int DEFAULT NULL,
  `social_security_month_type` tinyint DEFAULT NULL,
  `start_year` int DEFAULT NULL,
  `start_month` int DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_hrm_salary_config_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_salary_employee_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `employee_id` bigint NOT NULL,
  `change_reason` tinyint DEFAULT NULL,
  `effect_time` timestamp NULL DEFAULT NULL,
  `change_type` tinyint DEFAULT NULL,
  `probation_salary` decimal(12,2) DEFAULT NULL,
  `regular_salary` decimal(12,2) DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `salary_options` longtext COLLATE utf8mb4_unicode_ci,
  `probation_salary_options` longtext COLLATE utf8mb4_unicode_ci,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_hrm_salary_employee_info_employee_id` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_salary_group` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `salary_standard` decimal(12,2) DEFAULT NULL,
  `change_rule` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dept_ids` longtext COLLATE utf8mb4_unicode_ci,
  `employee_ids` longtext COLLATE utf8mb4_unicode_ci,
  `tax_rule_id` bigint DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_salary_month_employee_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `month_record_id` bigint NOT NULL,
  `employee_id` bigint NOT NULL,
  `actual_work_day` decimal(10,2) DEFAULT NULL,
  `need_work_day` decimal(10,2) DEFAULT NULL,
  `year` int NOT NULL,
  `month` int NOT NULL,
  `expected_pay_salary` decimal(12,2) DEFAULT NULL,
  `taxable_salary` decimal(12,2) DEFAULT NULL,
  `personal_tax` decimal(12,2) DEFAULT NULL,
  `real_pay_salary` decimal(12,2) DEFAULT NULL,
  `option_values` longtext COLLATE utf8mb4_unicode_ci,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_salary_month_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` int NOT NULL,
  `month` int NOT NULL,
  `employee_count` int DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `expected_pay_salary` decimal(12,2) DEFAULT NULL,
  `personal_tax` decimal(12,2) DEFAULT NULL,
  `real_pay_salary` decimal(12,2) DEFAULT NULL,
  `personal_insurance_amount` decimal(12,2) DEFAULT NULL,
  `personal_provident_fund_amount` decimal(12,2) DEFAULT NULL,
  `corporate_insurance_amount` decimal(12,2) DEFAULT NULL,
  `corporate_provident_fund_amount` decimal(12,2) DEFAULT NULL,
  `option_headers` longtext COLLATE utf8mb4_unicode_ci,
  `status` tinyint DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_salary_option` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` int NOT NULL,
  `parent_code` int NOT NULL DEFAULT '0',
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `system_flag` tinyint(1) NOT NULL DEFAULT '0',
  `template_id` bigint DEFAULT NULL,
  `type` tinyint NOT NULL DEFAULT '1',
  `tax_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `calculate_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_hrm_salary_option_tenant_code` (`tenant_id`,`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_salary_option_template` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` int NOT NULL,
  `parent_code` int NOT NULL DEFAULT '0',
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `system_flag` tinyint(1) NOT NULL DEFAULT '0',
  `type` tinyint NOT NULL DEFAULT '1',
  `tax_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `calculate_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_hrm_salary_option_template_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_salary_slip` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `send_record_id` bigint NOT NULL,
  `month_employee_record_id` bigint NOT NULL,
  `employee_id` bigint NOT NULL,
  `year` int NOT NULL,
  `month` int NOT NULL,
  `read_status` tinyint DEFAULT NULL,
  `real_pay_salary` decimal(12,2) DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `options` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_salary_slip_send_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `month_record_id` bigint NOT NULL,
  `employee_count` int DEFAULT NULL,
  `send_employee_count` int DEFAULT NULL,
  `year` int NOT NULL,
  `month` int NOT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_salary_slip_template` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hide_empty` tinyint(1) NOT NULL DEFAULT '0',
  `default_status` tinyint(1) NOT NULL DEFAULT '0',
  `options` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `hrm_salary_tax_rule` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` tinyint DEFAULT NULL,
  `tax_enabled` tinyint(1) DEFAULT NULL,
  `threshold` decimal(12,2) DEFAULT NULL,
  `decimal_scale` int DEFAULT NULL,
  `cycle_type` tinyint DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `im_channel` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `code` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '频道业务码；唯一',
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '频道名称',
  `avatar` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '频道头像',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态；0 启用 1 停用',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IM 频道表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `im_channel_material` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `channel_id` bigint NOT NULL COMMENT '频道编号',
  `type` tinyint NOT NULL COMMENT '内容类型；1 站内富文本 2 外链',
  `title` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题',
  `cover_url` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '封面图',
  `summary` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '摘要',
  `content` longtext COLLATE utf8mb4_unicode_ci COMMENT '正文；富文本 HTML',
  `url` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '跳转链接；为空时点击在客户端内置详情页拉 content；非空则跳 url',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IM 频道素材表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `im_channel_message` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `channel_id` bigint NOT NULL COMMENT '频道编号；冗余 im_channel_material.channel_id 便于检索',
  `material_id` bigint NOT NULL COMMENT '关联素材编号',
  `type` smallint NOT NULL COMMENT '消息类型',
  `content` varchar(8192) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '消息内容；推送时 payload JSON 快照；不含富文本正文',
  `receiver_user_ids` text COLLATE utf8mb4_unicode_ci COMMENT '接收人编号列表；逗号分隔；为空表示全员',
  `send_time` timestamp NOT NULL COMMENT '发送时间',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IM 频道消息表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `im_conversation_read` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `conversation_type` tinyint NOT NULL COMMENT '会话类型',
  `target_id` bigint NOT NULL COMMENT '目标编号',
  `message_id` bigint NOT NULL COMMENT '最大已读消息编号',
  `read_time` timestamp NOT NULL COMMENT '最近已读时间',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_im_conversation_read_user_target` (`user_id`,`conversation_type`,`target_id`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IM 会话读位置表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `im_face_pack` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '表情包名称',
  `icon` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '表情包图标（面板底部 tab 显示）',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint NOT NULL COMMENT '状态',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IM 表情包表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `im_face_pack_item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `pack_id` bigint NOT NULL COMMENT '所属表情包编号',
  `url` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '表情图 URL',
  `name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '表情名（可选；如「狗头」「捂脸」）',
  `width` int NOT NULL DEFAULT '0' COMMENT '渲染宽度（像素）',
  `height` int NOT NULL DEFAULT '0' COMMENT '渲染高度（像素）',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint NOT NULL COMMENT '状态',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IM 表情包项表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `im_face_user_item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint NOT NULL COMMENT '所属用户编号',
  `url` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '表情图 URL',
  `name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '表情名（可选）',
  `width` int NOT NULL DEFAULT '0' COMMENT '渲染宽度（像素）',
  `height` int NOT NULL DEFAULT '0' COMMENT '渲染高度（像素）',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_im_face_user_item_user_url_deleted` (`user_id`,`url`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IM 用户私有表情表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `im_friend` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `friend_user_id` bigint NOT NULL COMMENT '好友用户编号',
  `silent` bit(1) DEFAULT b'0' COMMENT '是否免打扰',
  `display_name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '好友展示备注（仅自己可见）',
  `add_source` tinyint DEFAULT NULL COMMENT '添加来源',
  `pinned` bit(1) DEFAULT b'0' COMMENT '是否置顶联系人',
  `blocked` bit(1) DEFAULT b'0' COMMENT '是否拉黑',
  `status` tinyint NOT NULL COMMENT '好友状态',
  `add_time` timestamp NULL DEFAULT NULL COMMENT '添加好友时间',
  `delete_time` timestamp NULL DEFAULT NULL COMMENT '删除好友时间',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_friend` (`user_id`,`friend_user_id`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IM 好友关系表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `im_friend_request` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `from_user_id` bigint NOT NULL COMMENT '发起方用户编号',
  `to_user_id` bigint NOT NULL COMMENT '接收方用户编号',
  `handle_result` tinyint NOT NULL DEFAULT '0' COMMENT '处理结果；0未处理；1同意；2拒绝',
  `apply_content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '申请理由',
  `handle_content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '处理理由',
  `display_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发起方对接收方的备注',
  `add_source` tinyint DEFAULT NULL COMMENT '添加来源',
  `handle_time` timestamp NULL DEFAULT NULL COMMENT '处理时间',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_im_friend_request` (`from_user_id`,`to_user_id`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IM 好友申请记录表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `im_group` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '群名称',
  `owner_user_id` bigint NOT NULL COMMENT '群主用户编号',
  `avatar` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '群头像',
  `notice` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '群公告',
  `banned` bit(1) DEFAULT b'0' COMMENT '是否封禁',
  `banned_reason` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '封禁原因',
  `banned_time` timestamp NULL DEFAULT NULL COMMENT '封禁时间',
  `status` tinyint NOT NULL COMMENT '群状态',
  `dissolved_time` timestamp NULL DEFAULT NULL COMMENT '解散时间',
  `muted_all` bit(1) DEFAULT b'0' COMMENT '是否全群禁言',
  `join_approval` bit(1) NOT NULL DEFAULT b'0' COMMENT '进群是否需群主 / 管理员审批；false 自由进群，true 需审批',
  `pinned_message_ids` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '群置顶消息编号列表，逗号分隔',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IM 群信息表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `im_group_member` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `group_id` bigint NOT NULL COMMENT '群编号',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `display_user_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '组内显示名',
  `group_remark` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '群备注',
  `silent` bit(1) DEFAULT b'0' COMMENT '是否免打扰',
  `status` tinyint NOT NULL COMMENT '成员状态',
  `role` tinyint NOT NULL DEFAULT '3' COMMENT '成员角色：1=群主 2=管理员 3=普通成员',
  `join_time` timestamp NULL DEFAULT NULL COMMENT '入群时间',
  `add_source` tinyint DEFAULT NULL COMMENT '加入来源',
  `inviter_user_id` bigint DEFAULT NULL COMMENT '邀请人用户编号；用户主动申请进群时为 NULL',
  `quit_time` timestamp NULL DEFAULT NULL COMMENT '退群时间',
  `mute_end_time` timestamp NULL DEFAULT NULL COMMENT '禁言到期时间',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_im_group_member` (`group_id`,`user_id`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IM 群成员表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `im_group_message` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `client_message_id` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户端消息编号',
  `sender_id` bigint NOT NULL COMMENT '发送人编号',
  `group_id` bigint NOT NULL COMMENT '群编号',
  `type` smallint NOT NULL COMMENT '消息类型',
  `content` varchar(8192) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '消息内容',
  `status` tinyint NOT NULL COMMENT '消息状态',
  `send_time` timestamp NOT NULL COMMENT '发送时间',
  `receiver_user_ids` text COLLATE utf8mb4_unicode_ci COMMENT '定向接收用户编号列表',
  `at_user_ids` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '@ 目标用户编号列表',
  `receipt_status` tinyint NOT NULL DEFAULT '0' COMMENT '回执状态',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_im_group_message_sender_client` (`sender_id`,`client_message_id`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IM 群聊消息表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `im_group_request` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `group_id` bigint NOT NULL COMMENT '群编号',
  `user_id` bigint NOT NULL COMMENT '申请人 / 被邀请人用户编号',
  `inviter_user_id` bigint DEFAULT NULL COMMENT '邀请人用户编号；NULL=主动申请；非NULL=被邀请待审批',
  `apply_content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '申请理由',
  `add_source` tinyint DEFAULT NULL COMMENT '加入来源',
  `handle_result` tinyint NOT NULL DEFAULT '0' COMMENT '处理结果；0未处理；1同意；2拒绝',
  `handle_user_id` bigint DEFAULT NULL COMMENT '处理人用户编号',
  `handle_content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '处理理由',
  `handle_time` timestamp NULL DEFAULT NULL COMMENT '处理时间',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_im_group_request` (`group_id`,`user_id`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IM 加群申请记录表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `im_private_message` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `client_message_id` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户端消息编号',
  `sender_id` bigint NOT NULL COMMENT '发送人编号',
  `receiver_id` bigint NOT NULL COMMENT '接收人编号',
  `type` smallint NOT NULL COMMENT '消息类型',
  `content` varchar(8192) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '消息内容',
  `status` tinyint NOT NULL COMMENT '消息状态',
  `receipt_status` tinyint NOT NULL DEFAULT '0' COMMENT '回执状态',
  `send_time` timestamp NOT NULL COMMENT '发送时间',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_im_private_message_sender_client` (`sender_id`,`client_message_id`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IM 私聊消息表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `im_rtc_call` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `room` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '业务通话编号',
  `conversation_type` tinyint NOT NULL COMMENT '会话类型',
  `media_type` tinyint NOT NULL COMMENT '媒体类型',
  `inviter_user_id` bigint NOT NULL COMMENT '发起人用户编号',
  `group_id` bigint DEFAULT NULL COMMENT '群编号',
  `status` tinyint NOT NULL COMMENT '通话状态',
  `end_reason` tinyint DEFAULT NULL COMMENT '结束原因',
  `start_time` timestamp NOT NULL COMMENT '发起时间',
  `accept_time` timestamp NULL DEFAULT NULL COMMENT '接通时间',
  `end_time` timestamp NULL DEFAULT NULL COMMENT '结束时间',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IM 通话记录表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `im_rtc_participant` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `call_id` bigint NOT NULL COMMENT '通话编号',
  `room` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '业务通话编号',
  `user_id` bigint NOT NULL COMMENT '参与者用户编号',
  `role` tinyint NOT NULL COMMENT '参与角色',
  `status` tinyint NOT NULL COMMENT '参与状态',
  `invite_time` timestamp NOT NULL COMMENT '被邀请时间',
  `accept_time` timestamp NULL DEFAULT NULL COMMENT '接听时间',
  `leave_time` timestamp NULL DEFAULT NULL COMMENT '离开时间',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_im_rtc_participant_room_user` (`room`,`user_id`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IM 通话参与者表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `im_sensitive_word` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `word` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '敏感词',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态；0 启用 1 停用',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_im_sensitive_word` (`word`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IM 敏感词表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `market_activity` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `activity_type` tinyint NOT NULL,
  `status` tinyint NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `invalid_time` datetime DEFAULT NULL,
  `delete_time` datetime DEFAULT NULL,
  `time_limited_discount` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `full_privilege` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='促销活动';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `member_address` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `name` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `area_id` bigint NOT NULL,
  `detail_address` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `default_status` bit(1) NOT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户收件地址';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `member_brokerage_record` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `biz_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `biz_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int NOT NULL,
  `total_price` int NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `frozen_days` int NOT NULL,
  `unfreeze_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='佣金记录';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `member_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `point_trade_deduct_enable` tinyint(1) DEFAULT NULL COMMENT '积分抵扣开关',
  `point_trade_deduct_unit_price` int DEFAULT NULL COMMENT '积分抵扣，单位：分，1 积分抵扣多少分',
  `point_trade_deduct_max_price` int DEFAULT NULL COMMENT '积分抵扣最大值',
  `point_trade_give_point` int DEFAULT NULL COMMENT '1 元赠送多少分',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员配置';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `member_experience_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint DEFAULT NULL COMMENT '用户编号',
  `biz_type` int DEFAULT NULL COMMENT '业务类型',
  `biz_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '业务编号',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `description` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '描述',
  `experience` int DEFAULT NULL COMMENT '经验',
  `total_experience` int DEFAULT NULL COMMENT '变更后的经验',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员经验记录';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `member_group` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  `creator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户分组';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `member_level` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `experience` int NOT NULL,
  `level` int NOT NULL,
  `discount_percent` int NOT NULL,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `background_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  `status` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员等级';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `member_level_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint DEFAULT NULL COMMENT '用户编号',
  `level_id` bigint DEFAULT NULL COMMENT '等级编号',
  `level` int DEFAULT NULL COMMENT '会员等级',
  `discount_percent` int DEFAULT NULL COMMENT '享受折扣',
  `experience` int DEFAULT NULL COMMENT '升级经验',
  `user_experience` int DEFAULT NULL COMMENT '会员此时的经验',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `description` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '描述',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员等级记录';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `member_point_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `user_id` bigint DEFAULT NULL COMMENT '用户编号',
  `biz_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '业务编码',
  `biz_type` int DEFAULT NULL COMMENT '业务类型',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '积分标题',
  `description` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '积分描述',
  `point` int DEFAULT NULL COMMENT '变动积分，正数表示获得积分，负数表示消耗积分',
  `total_point` int DEFAULT NULL COMMENT '变动后的积分',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户积分记录';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `member_sign_in_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '规则自增主键',
  `day` int DEFAULT NULL COMMENT '签到第 x 天',
  `point` int DEFAULT NULL COMMENT '奖励积分',
  `experience` int DEFAULT NULL COMMENT '奖励经验',
  `status` int DEFAULT NULL COMMENT '状态',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='签到规则';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `member_sign_in_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint DEFAULT NULL COMMENT '签到用户',
  `day` int DEFAULT NULL COMMENT '第几天签到',
  `point` int DEFAULT NULL COMMENT '签到的积分',
  `experience` int DEFAULT NULL COMMENT '签到的经验',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='签到记录';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `member_tag` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员标签';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `member_user` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `nickname` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户昵称',
  `name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '真实名字',
  `sex` tinyint DEFAULT NULL COMMENT '性别',
  `birthday` datetime DEFAULT NULL COMMENT '出生日期',
  `area_id` int DEFAULT NULL COMMENT '所在地',
  `mark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户备注',
  `point` int DEFAULT '0' COMMENT '积分',
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '头像',
  `status` tinyint NOT NULL COMMENT '状态',
  `mobile` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '手机号',
  `email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `password` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码',
  `register_ip` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '注册 IP',
  `login_ip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `tag_ids` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户标签编号列表,以逗号分隔',
  `level_id` bigint DEFAULT NULL COMMENT '等级编号',
  `experience` bigint DEFAULT NULL COMMENT '经验',
  `group_id` bigint DEFAULT NULL COMMENT '用户分组编号',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  `register_terminal` int DEFAULT NULL COMMENT '注册终端',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_cal_holiday` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `day` datetime DEFAULT NULL COMMENT 'day',
  `type` int DEFAULT NULL COMMENT 'type',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_cal_plan` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `calendar_type` tinyint DEFAULT NULL,
  `start_date` timestamp NULL DEFAULT NULL,
  `end_date` timestamp NULL DEFAULT NULL,
  `shift_type` tinyint DEFAULT NULL,
  `shift_method` tinyint DEFAULT NULL,
  `shift_count` int DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_cal_plan_shift` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `plan_id` bigint DEFAULT NULL,
  `sort` int DEFAULT NULL,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_time` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `end_time` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_cal_plan_team` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `plan_id` bigint DEFAULT NULL,
  `team_id` bigint DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_cal_team` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `calendar_type` int DEFAULT NULL COMMENT 'calendarType',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_cal_team_member` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `team_id` bigint DEFAULT NULL COMMENT 'teamId',
  `user_id` bigint DEFAULT NULL COMMENT 'userId',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_cal_team_shift` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `plan_id` bigint DEFAULT NULL,
  `team_id` bigint DEFAULT NULL,
  `shift_id` bigint DEFAULT NULL,
  `day` timestamp NULL DEFAULT NULL,
  `sort` int DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_dv_check_plan` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `type` int DEFAULT NULL COMMENT 'type',
  `start_date` datetime DEFAULT NULL COMMENT 'startDate',
  `end_date` datetime DEFAULT NULL COMMENT 'endDate',
  `cycle_type` int DEFAULT NULL COMMENT 'cycleType',
  `cycle_count` int DEFAULT NULL COMMENT 'cycleCount',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_dv_check_plan_machinery` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `plan_id` bigint DEFAULT NULL COMMENT 'planId',
  `machinery_id` bigint DEFAULT NULL COMMENT 'machineryId',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_dv_check_plan_subject` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `plan_id` bigint DEFAULT NULL COMMENT 'planId',
  `subject_id` bigint DEFAULT NULL COMMENT 'subjectId',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_dv_check_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `plan_id` bigint DEFAULT NULL COMMENT 'planId',
  `machinery_id` bigint DEFAULT NULL COMMENT 'machineryId',
  `check_time` datetime DEFAULT NULL COMMENT 'checkTime',
  `user_id` bigint DEFAULT NULL COMMENT 'userId',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_dv_check_record_line` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `record_id` bigint DEFAULT NULL COMMENT 'recordId',
  `subject_id` bigint DEFAULT NULL COMMENT 'subjectId',
  `check_status` int DEFAULT NULL COMMENT 'checkStatus',
  `check_result` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'checkResult',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_dv_machinery` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `brand` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'brand',
  `specification` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'specification',
  `machinery_type_id` bigint DEFAULT NULL COMMENT 'machineryTypeId',
  `workshop_id` bigint DEFAULT NULL COMMENT 'workshopId',
  `status` int DEFAULT NULL COMMENT 'status',
  `last_mainten_time` datetime DEFAULT NULL COMMENT 'lastMaintenTime',
  `last_check_time` datetime DEFAULT NULL COMMENT 'lastCheckTime',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_dv_machinery_type` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `parent_id` bigint DEFAULT NULL COMMENT 'parentId',
  `status` int DEFAULT NULL COMMENT 'status',
  `sort` int DEFAULT NULL COMMENT 'sort',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_dv_mainten_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `plan_id` bigint DEFAULT NULL COMMENT 'planId',
  `machinery_id` bigint DEFAULT NULL COMMENT 'machineryId',
  `mainten_time` datetime DEFAULT NULL COMMENT 'maintenTime',
  `user_id` bigint DEFAULT NULL COMMENT 'userId',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_dv_mainten_record_line` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `record_id` bigint DEFAULT NULL COMMENT 'recordId',
  `subject_id` bigint DEFAULT NULL COMMENT 'subjectId',
  `status` int DEFAULT NULL COMMENT 'status',
  `result` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'result',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_dv_repair` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `machinery_id` bigint DEFAULT NULL COMMENT 'machineryId',
  `require_date` datetime DEFAULT NULL COMMENT 'requireDate',
  `finish_date` datetime DEFAULT NULL COMMENT 'finishDate',
  `confirm_date` datetime DEFAULT NULL COMMENT 'confirmDate',
  `result` int DEFAULT NULL COMMENT 'result',
  `accepted_user_id` bigint DEFAULT NULL COMMENT 'acceptedUserId',
  `confirm_user_id` bigint DEFAULT NULL COMMENT 'confirmUserId',
  `source_doc_type` int DEFAULT NULL COMMENT 'sourceDocType',
  `source_doc_id` bigint DEFAULT NULL COMMENT 'sourceDocId',
  `source_doc_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'sourceDocCode',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_dv_repair_line` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `repair_id` bigint DEFAULT NULL COMMENT 'repairId',
  `subject_id` bigint DEFAULT NULL COMMENT 'subjectId',
  `malfunction` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'malfunction',
  `malfunction_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'malfunctionUrl',
  `description` text COLLATE utf8mb4_unicode_ci COMMENT 'description',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_dv_subject` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `type` int DEFAULT NULL COMMENT 'type',
  `content` longtext COLLATE utf8mb4_unicode_ci COMMENT 'content',
  `standard` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'standard',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_md_auto_code_part` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `rule_id` bigint NOT NULL,
  `sort` int NOT NULL,
  `type` tinyint NOT NULL,
  `length` int NOT NULL,
  `date_format` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fix_character` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serial_start_no` int DEFAULT NULL,
  `serial_step` int DEFAULT NULL,
  `cycle_flag` bit(1) DEFAULT b'0',
  `cycle_method` tinyint DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_md_auto_code_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `rule_id` bigint NOT NULL,
  `result` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serial_no` bigint DEFAULT NULL,
  `input_char` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_md_auto_code_rule` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `max_length` int DEFAULT NULL,
  `padded` bit(1) NOT NULL DEFAULT b'0',
  `padded_char` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `padded_method` tinyint DEFAULT NULL,
  `status` tinyint NOT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_md_client` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `nickname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'nickname',
  `english_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'englishName',
  `description` text COLLATE utf8mb4_unicode_ci COMMENT 'description',
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'logo',
  `type` int DEFAULT NULL COMMENT 'type',
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'address',
  `website` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'website',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'email',
  `telephone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'telephone',
  `contact1_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'contact1Name',
  `contact1_telephone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'contact1Telephone',
  `contact1_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'contact1Email',
  `contact2_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'contact2Name',
  `contact2_telephone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'contact2Telephone',
  `contact2_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'contact2Email',
  `credit_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'creditCode',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_md_item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `specification` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'specification',
  `unit_measure_id` bigint DEFAULT NULL COMMENT 'unitMeasureId',
  `item_type_id` bigint DEFAULT NULL COMMENT 'itemTypeId',
  `status` int DEFAULT NULL COMMENT 'status',
  `safe_stock_flag` tinyint(1) DEFAULT NULL COMMENT 'safeStockFlag',
  `min_stock` decimal(24,6) DEFAULT NULL COMMENT 'minStock',
  `max_stock` decimal(24,6) DEFAULT NULL COMMENT 'maxStock',
  `high_value` tinyint(1) DEFAULT NULL COMMENT 'highValue',
  `batch_flag` tinyint(1) DEFAULT NULL COMMENT 'batchFlag',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_md_item_batch_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `produce_date_flag` tinyint(1) DEFAULT NULL COMMENT 'produceDateFlag',
  `expire_date_flag` tinyint(1) DEFAULT NULL COMMENT 'expireDateFlag',
  `receipt_date_flag` tinyint(1) DEFAULT NULL COMMENT 'receiptDateFlag',
  `vendor_flag` tinyint(1) DEFAULT NULL COMMENT 'vendorFlag',
  `client_flag` tinyint(1) DEFAULT NULL COMMENT 'clientFlag',
  `sales_order_code_flag` tinyint(1) DEFAULT NULL COMMENT 'salesOrderCodeFlag',
  `purchase_order_code_flag` tinyint(1) DEFAULT NULL COMMENT 'purchaseOrderCodeFlag',
  `work_order_flag` tinyint(1) DEFAULT NULL COMMENT 'workOrderFlag',
  `task_flag` tinyint(1) DEFAULT NULL COMMENT 'taskFlag',
  `workstation_flag` tinyint(1) DEFAULT NULL COMMENT 'workstationFlag',
  `tool_flag` tinyint(1) DEFAULT NULL COMMENT 'toolFlag',
  `mold_flag` tinyint(1) DEFAULT NULL COMMENT 'moldFlag',
  `lot_number_flag` tinyint(1) DEFAULT NULL COMMENT 'lotNumberFlag',
  `quality_status_flag` tinyint(1) DEFAULT NULL COMMENT 'qualityStatusFlag',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_md_item_type` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `parent_id` bigint DEFAULT NULL COMMENT 'parentId',
  `item_or_product` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'itemOrProduct',
  `sort` int DEFAULT NULL COMMENT 'sort',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_md_product_bom` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `bom_item_id` bigint DEFAULT NULL COMMENT 'bomItemId',
  `quantity` decimal(24,6) DEFAULT NULL COMMENT 'quantity',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_md_product_sip` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `sort` int DEFAULT NULL COMMENT 'sort',
  `process_id` bigint DEFAULT NULL COMMENT 'processId',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'title',
  `description` text COLLATE utf8mb4_unicode_ci COMMENT 'description',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'url',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_md_product_sop` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `sort` int DEFAULT NULL COMMENT 'sort',
  `process_id` bigint DEFAULT NULL COMMENT 'processId',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'title',
  `description` text COLLATE utf8mb4_unicode_ci COMMENT 'description',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'url',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_md_unit_measure` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `primary_flag` tinyint(1) DEFAULT NULL COMMENT 'primaryFlag',
  `primary_id` bigint DEFAULT NULL COMMENT 'primaryId',
  `change_rate` decimal(24,6) DEFAULT NULL COMMENT 'changeRate',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_md_vendor` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `nickname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'nickname',
  `english_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'englishName',
  `description` text COLLATE utf8mb4_unicode_ci COMMENT 'description',
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'logo',
  `level` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'level',
  `score` int DEFAULT NULL COMMENT 'score',
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'address',
  `website` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'website',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'email',
  `telephone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'telephone',
  `contact1_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'contact1Name',
  `contact1_telephone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'contact1Telephone',
  `contact1_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'contact1Email',
  `contact2_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'contact2Name',
  `contact2_telephone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'contact2Telephone',
  `contact2_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'contact2Email',
  `credit_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'creditCode',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_md_workshop` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `area` decimal(24,6) DEFAULT NULL COMMENT 'area',
  `charge_user_id` bigint DEFAULT NULL COMMENT 'chargeUserId',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_md_workstation` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'address',
  `workshop_id` bigint DEFAULT NULL COMMENT 'workshopId',
  `process_id` bigint DEFAULT NULL COMMENT 'processId',
  `warehouse_id` bigint DEFAULT NULL COMMENT 'warehouseId',
  `location_id` bigint DEFAULT NULL COMMENT 'locationId',
  `area_id` bigint DEFAULT NULL COMMENT 'areaId',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_md_workstation_machine` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `workstation_id` bigint DEFAULT NULL COMMENT 'workstationId',
  `machinery_id` bigint DEFAULT NULL COMMENT 'machineryId',
  `quantity` int DEFAULT NULL COMMENT 'quantity',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_md_workstation_tool` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `workstation_id` bigint DEFAULT NULL COMMENT 'workstationId',
  `tool_type_id` bigint DEFAULT NULL COMMENT 'toolTypeId',
  `quantity` int DEFAULT NULL COMMENT 'quantity',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_md_workstation_worker` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `workstation_id` bigint DEFAULT NULL COMMENT 'workstationId',
  `post_id` bigint DEFAULT NULL COMMENT 'postId',
  `quantity` int DEFAULT NULL COMMENT 'quantity',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_pro_andon_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'reason',
  `level` int DEFAULT NULL COMMENT 'level',
  `handler_role_id` bigint DEFAULT NULL COMMENT 'handlerRoleId',
  `handler_user_id` bigint DEFAULT NULL COMMENT 'handlerUserId',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_pro_andon_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `config_id` bigint DEFAULT NULL COMMENT 'configId',
  `workstation_id` bigint DEFAULT NULL COMMENT 'workstationId',
  `user_id` bigint DEFAULT NULL COMMENT 'userId',
  `work_order_id` bigint DEFAULT NULL COMMENT 'workOrderId',
  `process_id` bigint DEFAULT NULL COMMENT 'processId',
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'reason',
  `level` int DEFAULT NULL COMMENT 'level',
  `status` int DEFAULT NULL COMMENT 'status',
  `handle_time` datetime DEFAULT NULL COMMENT 'handleTime',
  `handler_user_id` bigint DEFAULT NULL COMMENT 'handlerUserId',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_pro_card` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `work_order_id` bigint DEFAULT NULL COMMENT 'workOrderId',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `batch_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'batchCode',
  `transfered_quantity` decimal(24,6) DEFAULT NULL COMMENT 'transferedQuantity',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_pro_card_process` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `card_id` bigint DEFAULT NULL COMMENT 'cardId',
  `sort` int DEFAULT NULL COMMENT 'sort',
  `process_id` bigint DEFAULT NULL COMMENT 'processId',
  `input_time` datetime DEFAULT NULL COMMENT 'inputTime',
  `output_time` datetime DEFAULT NULL COMMENT 'outputTime',
  `input_quantity` decimal(24,6) DEFAULT NULL COMMENT 'inputQuantity',
  `output_quantity` decimal(24,6) DEFAULT NULL COMMENT 'outputQuantity',
  `unqualified_quantity` decimal(24,6) DEFAULT NULL COMMENT 'unqualifiedQuantity',
  `workstation_id` bigint DEFAULT NULL COMMENT 'workstationId',
  `user_id` bigint DEFAULT NULL COMMENT 'userId',
  `ipqc_id` bigint DEFAULT NULL COMMENT 'ipqcId',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_pro_feedback` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` tinyint DEFAULT NULL,
  `channel` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `feedback_time` timestamp NULL DEFAULT NULL,
  `workstation_id` bigint DEFAULT NULL,
  `route_id` bigint DEFAULT NULL,
  `process_id` bigint DEFAULT NULL,
  `work_order_id` bigint DEFAULT NULL,
  `task_id` bigint DEFAULT NULL,
  `item_id` bigint DEFAULT NULL,
  `expire_date` timestamp NULL DEFAULT NULL,
  `lot_number` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scheduled_quantity` decimal(14,2) DEFAULT NULL,
  `feedback_quantity` decimal(14,2) DEFAULT NULL,
  `qualified_quantity` decimal(14,2) DEFAULT NULL,
  `unqualified_quantity` decimal(14,2) DEFAULT NULL,
  `uncheck_quantity` decimal(14,2) DEFAULT NULL,
  `labor_scrap_quantity` decimal(14,2) DEFAULT NULL,
  `material_scrap_quantity` decimal(14,2) DEFAULT NULL,
  `other_scrap_quantity` decimal(14,2) DEFAULT NULL,
  `feedback_user_id` bigint DEFAULT NULL,
  `approve_user_id` bigint DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_pro_process` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `attention` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'attention',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_pro_process_content` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `process_id` bigint DEFAULT NULL COMMENT 'processId',
  `sort` int DEFAULT NULL COMMENT 'sort',
  `content` longtext COLLATE utf8mb4_unicode_ci COMMENT 'content',
  `device` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'device',
  `material` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'material',
  `doc_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'docUrl',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_pro_route` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `description` text COLLATE utf8mb4_unicode_ci COMMENT 'description',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_pro_route_process` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `route_id` bigint DEFAULT NULL,
  `process_id` bigint DEFAULT NULL,
  `sort` int DEFAULT NULL,
  `next_process_id` bigint DEFAULT NULL,
  `link_type` int DEFAULT NULL,
  `prepare_time` int DEFAULT NULL,
  `wait_time` int DEFAULT NULL,
  `color_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `key_flag` bit(1) DEFAULT b'0',
  `check_flag` bit(1) DEFAULT b'0',
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_pro_route_product` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `route_id` bigint DEFAULT NULL COMMENT 'routeId',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `quantity` int DEFAULT NULL COMMENT 'quantity',
  `production_time` decimal(24,6) DEFAULT NULL COMMENT 'productionTime',
  `time_unit_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'timeUnitType',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_pro_route_product_bom` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `route_id` bigint DEFAULT NULL COMMENT 'routeId',
  `process_id` bigint DEFAULT NULL COMMENT 'processId',
  `product_id` bigint DEFAULT NULL COMMENT 'productId',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `quantity` decimal(24,6) DEFAULT NULL COMMENT 'quantity',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_pro_task` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `work_order_id` bigint DEFAULT NULL,
  `workstation_id` bigint DEFAULT NULL,
  `route_id` bigint DEFAULT NULL,
  `process_id` bigint DEFAULT NULL,
  `item_id` bigint DEFAULT NULL,
  `quantity` decimal(14,2) DEFAULT NULL,
  `produced_quantity` decimal(14,2) DEFAULT NULL,
  `qualify_quantity` decimal(14,2) DEFAULT NULL,
  `unqualify_quantity` decimal(14,2) DEFAULT NULL,
  `changed_quantity` decimal(14,2) DEFAULT NULL,
  `client_id` bigint DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `duration` int DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `color_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `finish_date` timestamp NULL DEFAULT NULL,
  `cancel_date` timestamp NULL DEFAULT NULL,
  `status` int DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_pro_task_issue` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `task_id` bigint DEFAULT NULL COMMENT 'taskId',
  `work_order_id` bigint DEFAULT NULL COMMENT 'workOrderId',
  `workstation_id` bigint DEFAULT NULL COMMENT 'workstationId',
  `source_doc_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'sourceDocType',
  `source_doc_id` bigint DEFAULT NULL COMMENT 'sourceDocId',
  `source_line_id` bigint DEFAULT NULL COMMENT 'sourceLineId',
  `source_doc_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'sourceDocCode',
  `batch_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'batchCode',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `unit_measure_id` bigint DEFAULT NULL COMMENT 'unitMeasureId',
  `issued_quantity` decimal(24,6) DEFAULT NULL COMMENT 'issuedQuantity',
  `available_quantity` decimal(24,6) DEFAULT NULL COMMENT 'availableQuantity',
  `used_quantity` decimal(24,6) DEFAULT NULL COMMENT 'usedQuantity',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_pro_work_order` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `type` int DEFAULT NULL COMMENT 'type',
  `order_source_type` int DEFAULT NULL COMMENT 'orderSourceType',
  `order_source_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'orderSourceCode',
  `product_id` bigint DEFAULT NULL COMMENT 'productId',
  `quantity` decimal(24,6) DEFAULT NULL COMMENT 'quantity',
  `quantity_produced` decimal(24,6) DEFAULT NULL COMMENT 'quantityProduced',
  `quantity_changed` decimal(24,6) DEFAULT NULL COMMENT 'quantityChanged',
  `quantity_scheduled` decimal(24,6) DEFAULT NULL COMMENT 'quantityScheduled',
  `client_id` bigint DEFAULT NULL COMMENT 'clientId',
  `vendor_id` bigint DEFAULT NULL COMMENT 'vendorId',
  `batch_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'batchCode',
  `request_date` datetime DEFAULT NULL COMMENT 'requestDate',
  `parent_id` bigint DEFAULT NULL COMMENT 'parentId',
  `finish_date` datetime DEFAULT NULL COMMENT 'finishDate',
  `cancel_date` datetime DEFAULT NULL COMMENT 'cancelDate',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_pro_work_order_bom` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `work_order_id` bigint DEFAULT NULL COMMENT 'workOrderId',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `quantity` decimal(24,6) DEFAULT NULL COMMENT 'quantity',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_pro_work_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` bigint DEFAULT NULL COMMENT 'userId',
  `workstation_id` bigint DEFAULT NULL COMMENT 'workstationId',
  `type` int DEFAULT NULL COMMENT 'type',
  `clock_in_time` datetime DEFAULT NULL COMMENT 'clockInTime',
  `clock_out_time` datetime DEFAULT NULL COMMENT 'clockOutTime',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_pro_work_record_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` bigint DEFAULT NULL COMMENT 'userId',
  `workstation_id` bigint DEFAULT NULL COMMENT 'workstationId',
  `type` int DEFAULT NULL COMMENT 'type',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_qc_defect` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `type` int DEFAULT NULL COMMENT 'type',
  `level` int DEFAULT NULL COMMENT 'level',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_qc_defect_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `qc_type` int DEFAULT NULL COMMENT 'qcType',
  `qc_id` bigint DEFAULT NULL COMMENT 'qcId',
  `line_id` bigint DEFAULT NULL COMMENT 'lineId',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `level` int DEFAULT NULL COMMENT 'level',
  `quantity` int DEFAULT NULL COMMENT 'quantity',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_qc_indicator` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `type` int DEFAULT NULL COMMENT 'type',
  `tool` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'tool',
  `result_type` int DEFAULT NULL COMMENT 'resultType',
  `result_specification` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'resultSpecification',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_qc_indicator_result` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qc_id` bigint DEFAULT NULL,
  `qc_type` int DEFAULT NULL,
  `item_id` bigint DEFAULT NULL,
  `sn` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_qc_indicator_result_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `result_id` bigint DEFAULT NULL COMMENT 'resultId',
  `indicator_id` bigint DEFAULT NULL COMMENT 'indicatorId',
  `value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'value',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_qc_ipqc` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` tinyint DEFAULT NULL,
  `template_id` bigint DEFAULT NULL,
  `source_doc_type` int DEFAULT NULL,
  `source_doc_id` bigint DEFAULT NULL,
  `source_line_id` bigint DEFAULT NULL,
  `source_doc_code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `work_order_id` bigint DEFAULT NULL,
  `task_id` bigint DEFAULT NULL,
  `workstation_id` bigint DEFAULT NULL,
  `process_id` bigint DEFAULT NULL,
  `item_id` bigint DEFAULT NULL,
  `check_quantity` decimal(14,2) DEFAULT NULL,
  `qualified_quantity` decimal(14,2) DEFAULT NULL,
  `unqualified_quantity` decimal(14,2) DEFAULT NULL,
  `labor_scrap_quantity` decimal(14,2) DEFAULT NULL,
  `material_scrap_quantity` decimal(14,2) DEFAULT NULL,
  `other_scrap_quantity` decimal(14,2) DEFAULT NULL,
  `critical_rate` decimal(14,2) DEFAULT NULL,
  `major_rate` decimal(14,2) DEFAULT NULL,
  `minor_rate` decimal(14,2) DEFAULT NULL,
  `critical_quantity` int DEFAULT NULL,
  `major_quantity` int DEFAULT NULL,
  `minor_quantity` int DEFAULT NULL,
  `check_result` tinyint DEFAULT NULL,
  `inspect_date` timestamp NULL DEFAULT NULL,
  `inspector_user_id` bigint DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_qc_ipqc_line` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `ipqc_id` bigint DEFAULT NULL COMMENT 'ipqcId',
  `indicator_id` bigint DEFAULT NULL COMMENT 'indicatorId',
  `tool` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'tool',
  `check_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'checkMethod',
  `standard_value` decimal(24,6) DEFAULT NULL COMMENT 'standardValue',
  `unit_measure_id` bigint DEFAULT NULL COMMENT 'unitMeasureId',
  `max_threshold` decimal(24,6) DEFAULT NULL COMMENT 'maxThreshold',
  `min_threshold` decimal(24,6) DEFAULT NULL COMMENT 'minThreshold',
  `critical_quantity` int DEFAULT NULL COMMENT 'criticalQuantity',
  `major_quantity` int DEFAULT NULL COMMENT 'majorQuantity',
  `minor_quantity` int DEFAULT NULL COMMENT 'minorQuantity',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_qc_iqc` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `template_id` bigint DEFAULT NULL,
  `source_doc_type` int DEFAULT NULL,
  `source_doc_id` bigint DEFAULT NULL,
  `source_line_id` bigint DEFAULT NULL,
  `source_doc_code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vendor_id` bigint DEFAULT NULL,
  `vendor_batch` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_id` bigint DEFAULT NULL,
  `received_quantity` decimal(24,6) DEFAULT NULL,
  `check_quantity` decimal(24,6) DEFAULT NULL,
  `qualified_quantity` decimal(24,6) DEFAULT NULL,
  `unqualified_quantity` decimal(24,6) DEFAULT NULL,
  `critical_rate` decimal(10,2) DEFAULT NULL,
  `major_rate` decimal(10,2) DEFAULT NULL,
  `minor_rate` decimal(10,2) DEFAULT NULL,
  `critical_quantity` int DEFAULT NULL,
  `major_quantity` int DEFAULT NULL,
  `minor_quantity` int DEFAULT NULL,
  `check_result` tinyint DEFAULT NULL,
  `receive_date` timestamp NULL DEFAULT NULL,
  `inspect_date` timestamp NULL DEFAULT NULL,
  `inspector_user_id` bigint DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_qc_iqc_line` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `iqc_id` bigint DEFAULT NULL COMMENT 'iqcId',
  `indicator_id` bigint DEFAULT NULL COMMENT 'indicatorId',
  `tool` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'tool',
  `check_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'checkMethod',
  `standard_value` decimal(24,6) DEFAULT NULL COMMENT 'standardValue',
  `unit_measure_id` bigint DEFAULT NULL COMMENT 'unitMeasureId',
  `max_threshold` decimal(24,6) DEFAULT NULL COMMENT 'maxThreshold',
  `min_threshold` decimal(24,6) DEFAULT NULL COMMENT 'minThreshold',
  `critical_quantity` int DEFAULT NULL COMMENT 'criticalQuantity',
  `major_quantity` int DEFAULT NULL COMMENT 'majorQuantity',
  `minor_quantity` int DEFAULT NULL COMMENT 'minorQuantity',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_qc_oqc` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `template_id` bigint NOT NULL,
  `source_doc_type` int DEFAULT NULL,
  `source_doc_id` bigint DEFAULT NULL,
  `source_line_id` bigint DEFAULT NULL,
  `source_doc_code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_id` bigint NOT NULL,
  `batch_code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_id` bigint NOT NULL,
  `min_check_quantity` int DEFAULT '1',
  `max_unqualified_quantity` int DEFAULT '0',
  `out_quantity` decimal(14,2) NOT NULL,
  `check_quantity` decimal(14,2) DEFAULT NULL,
  `qualified_quantity` decimal(14,2) DEFAULT '0.00',
  `unqualified_quantity` decimal(14,2) DEFAULT '0.00',
  `critical_rate` decimal(14,2) DEFAULT '0.00',
  `major_rate` decimal(14,2) DEFAULT '0.00',
  `minor_rate` decimal(14,2) DEFAULT '0.00',
  `critical_quantity` int DEFAULT '0',
  `major_quantity` int DEFAULT '0',
  `minor_quantity` int DEFAULT '0',
  `check_result` tinyint DEFAULT NULL,
  `out_date` timestamp NULL DEFAULT NULL,
  `inspect_date` timestamp NULL DEFAULT NULL,
  `inspector_user_id` bigint DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_qc_oqc_line` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `oqc_id` bigint DEFAULT NULL COMMENT 'oqcId',
  `indicator_id` bigint DEFAULT NULL COMMENT 'indicatorId',
  `tool` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'tool',
  `check_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'checkMethod',
  `standard_value` decimal(24,6) DEFAULT NULL COMMENT 'standardValue',
  `unit_measure_id` bigint DEFAULT NULL COMMENT 'unitMeasureId',
  `max_threshold` decimal(24,6) DEFAULT NULL COMMENT 'maxThreshold',
  `min_threshold` decimal(24,6) DEFAULT NULL COMMENT 'minThreshold',
  `critical_quantity` int DEFAULT NULL COMMENT 'criticalQuantity',
  `major_quantity` int DEFAULT NULL COMMENT 'majorQuantity',
  `minor_quantity` int DEFAULT NULL COMMENT 'minorQuantity',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_qc_rqc` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `template_id` bigint NOT NULL,
  `source_doc_type` int DEFAULT NULL,
  `source_doc_id` bigint DEFAULT NULL,
  `source_line_id` bigint DEFAULT NULL,
  `source_doc_code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` int DEFAULT NULL,
  `item_id` bigint NOT NULL,
  `batch_code` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `check_quantity` decimal(14,2) DEFAULT NULL,
  `qualified_quantity` decimal(14,2) DEFAULT '0.00',
  `unqualified_quantity` decimal(14,2) DEFAULT '0.00',
  `critical_rate` decimal(14,2) DEFAULT '0.00',
  `major_rate` decimal(14,2) DEFAULT '0.00',
  `minor_rate` decimal(14,2) DEFAULT '0.00',
  `critical_quantity` int DEFAULT '0',
  `major_quantity` int DEFAULT '0',
  `minor_quantity` int DEFAULT '0',
  `check_result` tinyint DEFAULT NULL,
  `inspect_date` timestamp NULL DEFAULT NULL,
  `inspector_user_id` bigint DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_qc_rqc_line` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `rqc_id` bigint DEFAULT NULL COMMENT 'rqcId',
  `indicator_id` bigint DEFAULT NULL COMMENT 'indicatorId',
  `tool` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'tool',
  `check_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'checkMethod',
  `standard_value` decimal(24,6) DEFAULT NULL COMMENT 'standardValue',
  `unit_measure_id` bigint DEFAULT NULL COMMENT 'unitMeasureId',
  `max_threshold` decimal(24,6) DEFAULT NULL COMMENT 'maxThreshold',
  `min_threshold` decimal(24,6) DEFAULT NULL COMMENT 'minThreshold',
  `critical_quantity` int DEFAULT NULL COMMENT 'criticalQuantity',
  `major_quantity` int DEFAULT NULL COMMENT 'majorQuantity',
  `minor_quantity` int DEFAULT NULL COMMENT 'minorQuantity',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_qc_template` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '方案编号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '方案名称',
  `types` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '检测种类',
  `status` int DEFAULT NULL COMMENT '状态',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='MES 质检方案';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_qc_template_indicator` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `template_id` bigint DEFAULT NULL COMMENT 'templateId',
  `indicator_id` bigint DEFAULT NULL COMMENT 'indicatorId',
  `check_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'checkMethod',
  `standard_value` decimal(24,6) DEFAULT NULL COMMENT 'standardValue',
  `unit_measure_id` bigint DEFAULT NULL COMMENT 'unitMeasureId',
  `threshold_max` decimal(24,6) DEFAULT NULL COMMENT 'thresholdMax',
  `threshold_min` decimal(24,6) DEFAULT NULL COMMENT 'thresholdMin',
  `doc_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'docUrl',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_qc_template_item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `template_id` bigint DEFAULT NULL COMMENT 'templateId',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `quantity_check` int DEFAULT NULL COMMENT 'quantityCheck',
  `quantity_unqualified` int DEFAULT NULL COMMENT 'quantityUnqualified',
  `critical_rate` decimal(24,6) DEFAULT NULL COMMENT 'criticalRate',
  `major_rate` decimal(24,6) DEFAULT NULL COMMENT 'majorRate',
  `minor_rate` decimal(24,6) DEFAULT NULL COMMENT 'minorRate',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_tm_tool` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `brand` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'brand',
  `specification` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'specification',
  `tool_type_id` bigint DEFAULT NULL COMMENT 'toolTypeId',
  `quantity` int DEFAULT NULL COMMENT 'quantity',
  `available_quantity` int DEFAULT NULL COMMENT 'availableQuantity',
  `mainten_type` int DEFAULT NULL COMMENT 'maintenType',
  `next_mainten_period` int DEFAULT NULL COMMENT 'nextMaintenPeriod',
  `next_mainten_date` datetime DEFAULT NULL COMMENT 'nextMaintenDate',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_tm_tool_type` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `code_flag` tinyint(1) DEFAULT NULL COMMENT 'codeFlag',
  `mainten_type` int DEFAULT NULL COMMENT 'maintenType',
  `mainten_period` int DEFAULT NULL COMMENT 'maintenPeriod',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_arrival_notice` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_order_code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vendor_id` bigint DEFAULT NULL,
  `arrival_date` timestamp NULL DEFAULT NULL,
  `contact_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_telephone` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_arrival_notice_line` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `notice_id` bigint DEFAULT NULL COMMENT 'noticeId',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `arrival_quantity` decimal(24,6) DEFAULT NULL COMMENT 'arrivalQuantity',
  `qualified_quantity` decimal(24,6) DEFAULT NULL COMMENT 'qualifiedQuantity',
  `iqc_check_flag` tinyint(1) DEFAULT NULL COMMENT 'iqcCheckFlag',
  `iqc_id` bigint DEFAULT NULL COMMENT 'iqcId',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_barcode` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `config_id` bigint DEFAULT NULL COMMENT 'configId',
  `format` int DEFAULT NULL COMMENT 'format',
  `biz_type` int DEFAULT NULL COMMENT 'bizType',
  `content` longtext COLLATE utf8mb4_unicode_ci COMMENT 'content',
  `biz_id` bigint DEFAULT NULL COMMENT 'bizId',
  `biz_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'bizCode',
  `biz_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'bizName',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_barcode_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `format` int DEFAULT NULL COMMENT 'format',
  `biz_type` int DEFAULT NULL COMMENT 'bizType',
  `content_format` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'contentFormat',
  `content_example` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'contentExample',
  `auto_generate_flag` tinyint(1) DEFAULT NULL COMMENT 'autoGenerateFlag',
  `default_template` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'defaultTemplate',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_batch` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_id` bigint DEFAULT NULL,
  `produce_date` timestamp NULL DEFAULT NULL,
  `expire_date` timestamp NULL DEFAULT NULL,
  `receipt_date` timestamp NULL DEFAULT NULL,
  `vendor_id` bigint DEFAULT NULL,
  `client_id` bigint DEFAULT NULL,
  `sales_order_code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_order_code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `work_order_id` bigint DEFAULT NULL,
  `task_id` bigint DEFAULT NULL,
  `workstation_id` bigint DEFAULT NULL,
  `tool_id` bigint DEFAULT NULL,
  `mold_id` bigint DEFAULT NULL,
  `lot_number` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quality_status` int DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_item_consume` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `work_order_id` bigint NOT NULL,
  `task_id` bigint NOT NULL,
  `workstation_id` bigint NOT NULL,
  `process_id` bigint NOT NULL,
  `feedback_id` bigint NOT NULL,
  `consume_date` timestamp NOT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_item_consume_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `consume_id` bigint NOT NULL,
  `line_id` bigint NOT NULL,
  `material_stock_id` bigint DEFAULT NULL,
  `item_id` bigint NOT NULL,
  `quantity` decimal(14,2) NOT NULL,
  `batch_id` bigint DEFAULT NULL,
  `batch_code` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `warehouse_id` bigint NOT NULL,
  `location_id` bigint NOT NULL,
  `area_id` bigint NOT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_item_consume_line` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `consume_id` bigint NOT NULL,
  `item_id` bigint NOT NULL,
  `quantity` decimal(14,2) NOT NULL,
  `batch_id` bigint DEFAULT NULL,
  `batch_code` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_item_receipt` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `iqc_id` bigint DEFAULT NULL,
  `notice_id` bigint DEFAULT NULL,
  `vendor_id` bigint DEFAULT NULL,
  `purchase_order_code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt_date` timestamp NULL DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_item_receipt_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `line_id` bigint NOT NULL,
  `receipt_id` bigint NOT NULL,
  `item_id` bigint NOT NULL,
  `quantity` decimal(14,2) DEFAULT NULL,
  `batch_id` bigint DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `location_id` bigint DEFAULT NULL,
  `area_id` bigint DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_item_receipt_line` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `receipt_id` bigint NOT NULL,
  `arrival_notice_line_id` bigint DEFAULT NULL,
  `item_id` bigint NOT NULL,
  `received_quantity` decimal(14,2) DEFAULT NULL,
  `batch_id` bigint DEFAULT NULL,
  `batch_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `production_date` timestamp NULL DEFAULT NULL,
  `expire_date` timestamp NULL DEFAULT NULL,
  `lot_number` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_material_stock` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `item_type_id` bigint DEFAULT NULL,
  `item_id` bigint DEFAULT NULL,
  `batch_id` bigint DEFAULT NULL,
  `batch_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `location_id` bigint DEFAULT NULL,
  `area_id` bigint DEFAULT NULL,
  `vendor_id` bigint DEFAULT NULL,
  `quantity` decimal(14,2) DEFAULT NULL,
  `receipt_time` timestamp NULL DEFAULT NULL,
  `frozen` bit(1) DEFAULT b'0',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_misc_issue` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `type` int DEFAULT NULL COMMENT 'type',
  `source_doc_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'sourceDocType',
  `source_doc_id` bigint DEFAULT NULL COMMENT 'sourceDocId',
  `source_doc_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'sourceDocCode',
  `issue_date` datetime DEFAULT NULL COMMENT 'issueDate',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_misc_issue_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `issue_id` bigint DEFAULT NULL COMMENT 'issueId',
  `line_id` bigint DEFAULT NULL COMMENT 'lineId',
  `material_stock_id` bigint DEFAULT NULL COMMENT 'materialStockId',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `quantity` decimal(24,6) DEFAULT NULL COMMENT 'quantity',
  `batch_id` bigint DEFAULT NULL COMMENT 'batchId',
  `batch_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'batchCode',
  `warehouse_id` bigint DEFAULT NULL COMMENT 'warehouseId',
  `location_id` bigint DEFAULT NULL COMMENT 'locationId',
  `area_id` bigint DEFAULT NULL COMMENT 'areaId',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_misc_issue_line` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `issue_id` bigint DEFAULT NULL COMMENT 'issueId',
  `source_doc_line_id` bigint DEFAULT NULL COMMENT 'sourceDocLineId',
  `material_stock_id` bigint DEFAULT NULL COMMENT 'materialStockId',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `quantity` decimal(24,6) DEFAULT NULL COMMENT 'quantity',
  `batch_id` bigint DEFAULT NULL COMMENT 'batchId',
  `batch_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'batchCode',
  `warehouse_id` bigint DEFAULT NULL COMMENT 'warehouseId',
  `location_id` bigint DEFAULT NULL COMMENT 'locationId',
  `area_id` bigint DEFAULT NULL COMMENT 'areaId',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_misc_receipt` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `type` int DEFAULT NULL COMMENT 'type',
  `source_doc_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'sourceDocType',
  `source_doc_id` bigint DEFAULT NULL COMMENT 'sourceDocId',
  `source_doc_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'sourceDocCode',
  `receipt_date` datetime DEFAULT NULL COMMENT 'receiptDate',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_misc_receipt_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `receipt_id` bigint DEFAULT NULL COMMENT 'receiptId',
  `line_id` bigint DEFAULT NULL COMMENT 'lineId',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `quantity` decimal(24,6) DEFAULT NULL COMMENT 'quantity',
  `batch_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'batchCode',
  `warehouse_id` bigint DEFAULT NULL COMMENT 'warehouseId',
  `location_id` bigint DEFAULT NULL COMMENT 'locationId',
  `area_id` bigint DEFAULT NULL COMMENT 'areaId',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_misc_receipt_line` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `receipt_id` bigint DEFAULT NULL COMMENT 'receiptId',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `quantity` decimal(24,6) DEFAULT NULL COMMENT 'quantity',
  `batch_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'batchCode',
  `warehouse_id` bigint DEFAULT NULL COMMENT 'warehouseId',
  `location_id` bigint DEFAULT NULL COMMENT 'locationId',
  `area_id` bigint DEFAULT NULL COMMENT 'areaId',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_outsource_issue` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `vendor_id` bigint DEFAULT NULL COMMENT 'vendorId',
  `work_order_id` bigint DEFAULT NULL COMMENT 'workOrderId',
  `issue_date` datetime DEFAULT NULL COMMENT 'issueDate',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_outsource_issue_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `line_id` bigint DEFAULT NULL COMMENT 'lineId',
  `issue_id` bigint DEFAULT NULL COMMENT 'issueId',
  `material_stock_id` bigint DEFAULT NULL COMMENT 'materialStockId',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `quantity` decimal(24,6) DEFAULT NULL COMMENT 'quantity',
  `batch_id` bigint DEFAULT NULL COMMENT 'batchId',
  `warehouse_id` bigint DEFAULT NULL COMMENT 'warehouseId',
  `location_id` bigint DEFAULT NULL COMMENT 'locationId',
  `area_id` bigint DEFAULT NULL COMMENT 'areaId',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_outsource_issue_line` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `issue_id` bigint DEFAULT NULL COMMENT 'issueId',
  `material_stock_id` bigint DEFAULT NULL COMMENT 'materialStockId',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `quantity` decimal(24,6) DEFAULT NULL COMMENT 'quantity',
  `batch_id` bigint DEFAULT NULL COMMENT 'batchId',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_outsource_receipt` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `work_order_id` bigint DEFAULT NULL,
  `vendor_id` bigint DEFAULT NULL,
  `receipt_date` timestamp NULL DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_outsource_receipt_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `line_id` bigint DEFAULT NULL COMMENT 'lineId',
  `receipt_id` bigint DEFAULT NULL COMMENT 'receiptId',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `quantity` decimal(24,6) DEFAULT NULL COMMENT 'quantity',
  `batch_id` bigint DEFAULT NULL COMMENT 'batchId',
  `warehouse_id` bigint DEFAULT NULL COMMENT 'warehouseId',
  `location_id` bigint DEFAULT NULL COMMENT 'locationId',
  `area_id` bigint DEFAULT NULL COMMENT 'areaId',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_outsource_receipt_line` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `receipt_id` bigint DEFAULT NULL COMMENT 'receiptId',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `quantity` decimal(24,6) DEFAULT NULL COMMENT 'quantity',
  `batch_id` bigint DEFAULT NULL COMMENT 'batchId',
  `batch_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'batchCode',
  `production_date` datetime DEFAULT NULL COMMENT 'productionDate',
  `expire_date` datetime DEFAULT NULL COMMENT 'expireDate',
  `lot_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'lotNumber',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `iqc_id` bigint DEFAULT NULL COMMENT 'iqcId',
  `iqc_check_flag` tinyint(1) DEFAULT NULL COMMENT 'iqcCheckFlag',
  `quality_status` int DEFAULT NULL COMMENT 'qualityStatus',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_package` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `parent_id` bigint DEFAULT NULL COMMENT 'parentId',
  `package_date` datetime DEFAULT NULL COMMENT 'packageDate',
  `sales_order_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'salesOrderCode',
  `invoice_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'invoiceCode',
  `client_id` bigint DEFAULT NULL COMMENT 'clientId',
  `length` decimal(24,6) DEFAULT NULL COMMENT 'length',
  `width` decimal(24,6) DEFAULT NULL COMMENT 'width',
  `height` decimal(24,6) DEFAULT NULL COMMENT 'height',
  `size_unit_id` bigint DEFAULT NULL COMMENT 'sizeUnitId',
  `net_weight` decimal(24,6) DEFAULT NULL COMMENT 'netWeight',
  `gross_weight` decimal(24,6) DEFAULT NULL COMMENT 'grossWeight',
  `weight_unit_id` bigint DEFAULT NULL COMMENT 'weightUnitId',
  `inspector_user_id` bigint DEFAULT NULL COMMENT 'inspectorUserId',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_package_line` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `package_id` bigint DEFAULT NULL COMMENT 'packageId',
  `material_stock_id` bigint DEFAULT NULL COMMENT 'materialStockId',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `quantity` decimal(24,6) DEFAULT NULL COMMENT 'quantity',
  `work_order_id` bigint DEFAULT NULL COMMENT 'workOrderId',
  `expire_date` datetime DEFAULT NULL COMMENT 'expireDate',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_product_issue` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `workstation_id` bigint DEFAULT NULL COMMENT 'workstationId',
  `work_order_id` bigint DEFAULT NULL COMMENT 'workOrderId',
  `task_id` bigint DEFAULT NULL COMMENT 'taskId',
  `issue_date` datetime DEFAULT NULL COMMENT 'issueDate',
  `required_time` datetime DEFAULT NULL COMMENT 'requiredTime',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_product_issue_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `issue_id` bigint DEFAULT NULL COMMENT 'issueId',
  `line_id` bigint DEFAULT NULL COMMENT 'lineId',
  `material_stock_id` bigint DEFAULT NULL COMMENT 'materialStockId',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `quantity` decimal(24,6) DEFAULT NULL COMMENT 'quantity',
  `batch_id` bigint DEFAULT NULL COMMENT 'batchId',
  `batch_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'batchCode',
  `warehouse_id` bigint DEFAULT NULL COMMENT 'warehouseId',
  `location_id` bigint DEFAULT NULL COMMENT 'locationId',
  `area_id` bigint DEFAULT NULL COMMENT 'areaId',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_product_issue_line` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `issue_id` bigint DEFAULT NULL COMMENT 'issueId',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `quantity` decimal(24,6) DEFAULT NULL COMMENT 'quantity',
  `batch_id` bigint DEFAULT NULL COMMENT 'batchId',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_product_produce` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `work_order_id` bigint DEFAULT NULL,
  `feedback_id` bigint DEFAULT NULL,
  `task_id` bigint DEFAULT NULL,
  `workstation_id` bigint DEFAULT NULL,
  `process_id` bigint DEFAULT NULL,
  `produce_date` timestamp NULL DEFAULT NULL,
  `status` int DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_product_produce_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `produce_id` bigint DEFAULT NULL,
  `line_id` bigint DEFAULT NULL,
  `item_id` bigint DEFAULT NULL,
  `quantity` decimal(12,2) DEFAULT NULL,
  `batch_id` bigint DEFAULT NULL,
  `batch_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `location_id` bigint DEFAULT NULL,
  `area_id` bigint DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_product_produce_line` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `produce_id` bigint DEFAULT NULL,
  `feedback_id` bigint DEFAULT NULL,
  `item_id` bigint DEFAULT NULL,
  `quantity` decimal(12,2) DEFAULT NULL,
  `batch_id` bigint DEFAULT NULL,
  `batch_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expire_date` timestamp NULL DEFAULT NULL,
  `lot_number` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quality_status` int DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_product_receipt` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `work_order_id` bigint DEFAULT NULL COMMENT 'workOrderId',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `receipt_date` datetime DEFAULT NULL COMMENT 'receiptDate',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_product_receipt_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `line_id` bigint DEFAULT NULL COMMENT 'lineId',
  `receipt_id` bigint DEFAULT NULL COMMENT 'receiptId',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `quantity` decimal(24,6) DEFAULT NULL COMMENT 'quantity',
  `batch_id` bigint DEFAULT NULL COMMENT 'batchId',
  `warehouse_id` bigint DEFAULT NULL COMMENT 'warehouseId',
  `location_id` bigint DEFAULT NULL COMMENT 'locationId',
  `area_id` bigint DEFAULT NULL COMMENT 'areaId',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_product_receipt_line` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `receipt_id` bigint DEFAULT NULL COMMENT 'receiptId',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `material_stock_id` bigint DEFAULT NULL COMMENT 'materialStockId',
  `quantity` decimal(24,6) DEFAULT NULL COMMENT 'quantity',
  `batch_id` bigint DEFAULT NULL COMMENT 'batchId',
  `batch_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'batchCode',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_product_sales` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `client_id` bigint DEFAULT NULL COMMENT 'clientId',
  `sales_order_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'salesOrderCode',
  `notice_id` bigint DEFAULT NULL COMMENT 'noticeId',
  `sales_date` datetime DEFAULT NULL COMMENT 'salesDate',
  `contact_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'contactName',
  `contact_telephone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'contactTelephone',
  `contact_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'contactAddress',
  `carrier` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'carrier',
  `shipping_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'shippingNumber',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_product_sales_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `line_id` bigint NOT NULL,
  `sales_id` bigint NOT NULL,
  `item_id` bigint NOT NULL,
  `quantity` decimal(14,2) DEFAULT NULL,
  `material_stock_id` bigint DEFAULT NULL,
  `batch_id` bigint DEFAULT NULL,
  `batch_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `location_id` bigint DEFAULT NULL,
  `area_id` bigint DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_product_sales_line` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sales_id` bigint NOT NULL,
  `notice_line_id` bigint DEFAULT NULL,
  `item_id` bigint NOT NULL,
  `quantity` decimal(20,6) NOT NULL,
  `batch_id` bigint DEFAULT NULL,
  `batch_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `material_stock_id` bigint DEFAULT NULL,
  `oqc_check_flag` tinyint DEFAULT NULL,
  `oqc_id` bigint DEFAULT NULL,
  `quality_status` int DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_return_issue` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `work_order_id` bigint DEFAULT NULL COMMENT 'workOrderId',
  `workstation_id` bigint DEFAULT NULL COMMENT 'workstationId',
  `type` int DEFAULT NULL COMMENT 'type',
  `return_date` datetime DEFAULT NULL COMMENT 'returnDate',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_return_issue_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `issue_id` bigint DEFAULT NULL COMMENT 'issueId',
  `line_id` bigint DEFAULT NULL COMMENT 'lineId',
  `material_stock_id` bigint DEFAULT NULL COMMENT 'materialStockId',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `quantity` decimal(24,6) DEFAULT NULL COMMENT 'quantity',
  `batch_id` bigint DEFAULT NULL COMMENT 'batchId',
  `batch_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'batchCode',
  `warehouse_id` bigint DEFAULT NULL COMMENT 'warehouseId',
  `location_id` bigint DEFAULT NULL COMMENT 'locationId',
  `area_id` bigint DEFAULT NULL COMMENT 'areaId',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_return_issue_line` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `issue_id` bigint NOT NULL,
  `material_stock_id` bigint DEFAULT NULL,
  `item_id` bigint NOT NULL,
  `quantity` decimal(12,2) NOT NULL DEFAULT '0.00',
  `batch_id` bigint DEFAULT NULL,
  `batch_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rqc_id` bigint DEFAULT NULL,
  `rqc_check_flag` bit(1) NOT NULL DEFAULT b'0',
  `quality_status` int DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_return_sales` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `sales_order_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'salesOrderCode',
  `client_id` bigint DEFAULT NULL COMMENT 'clientId',
  `return_date` datetime DEFAULT NULL COMMENT 'returnDate',
  `return_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'returnReason',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_return_sales_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `return_id` bigint DEFAULT NULL COMMENT 'returnId',
  `line_id` bigint DEFAULT NULL COMMENT 'lineId',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `quantity` decimal(24,6) DEFAULT NULL COMMENT 'quantity',
  `batch_id` bigint DEFAULT NULL COMMENT 'batchId',
  `batch_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'batchCode',
  `warehouse_id` bigint DEFAULT NULL COMMENT 'warehouseId',
  `location_id` bigint DEFAULT NULL COMMENT 'locationId',
  `area_id` bigint DEFAULT NULL COMMENT 'areaId',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_return_sales_line` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `return_id` bigint NOT NULL,
  `item_id` bigint NOT NULL,
  `quantity` decimal(12,2) NOT NULL DEFAULT '0.00',
  `batch_id` bigint DEFAULT NULL,
  `batch_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rqc_id` bigint DEFAULT NULL,
  `rqc_check_flag` bit(1) NOT NULL DEFAULT b'0',
  `quality_status` int DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_return_vendor` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `purchase_order_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'purchaseOrderCode',
  `vendor_id` bigint DEFAULT NULL COMMENT 'vendorId',
  `return_date` datetime DEFAULT NULL COMMENT 'returnDate',
  `return_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'returnReason',
  `transport_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'transportCode',
  `transport_telephone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'transportTelephone',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_return_vendor_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `return_id` bigint DEFAULT NULL COMMENT 'returnId',
  `line_id` bigint DEFAULT NULL COMMENT 'lineId',
  `material_stock_id` bigint DEFAULT NULL COMMENT 'materialStockId',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `quantity` decimal(24,6) DEFAULT NULL COMMENT 'quantity',
  `batch_id` bigint DEFAULT NULL COMMENT 'batchId',
  `batch_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'batchCode',
  `warehouse_id` bigint DEFAULT NULL COMMENT 'warehouseId',
  `location_id` bigint DEFAULT NULL COMMENT 'locationId',
  `area_id` bigint DEFAULT NULL COMMENT 'areaId',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_return_vendor_line` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `return_id` bigint DEFAULT NULL COMMENT 'returnId',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `quantity` decimal(24,6) DEFAULT NULL COMMENT 'quantity',
  `batch_id` bigint DEFAULT NULL COMMENT 'batchId',
  `batch_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'batchCode',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_sales_notice` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `sales_order_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'salesOrderCode',
  `client_id` bigint DEFAULT NULL COMMENT 'clientId',
  `sales_date` datetime DEFAULT NULL COMMENT 'salesDate',
  `recipient_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'recipientName',
  `recipient_telephone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'recipientTelephone',
  `recipient_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'recipientAddress',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_sales_notice_line` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `notice_id` bigint DEFAULT NULL COMMENT 'noticeId',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `batch_id` bigint DEFAULT NULL COMMENT 'batchId',
  `batch_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'batchCode',
  `quantity` decimal(24,6) DEFAULT NULL COMMENT 'quantity',
  `oqc_check_flag` tinyint(1) DEFAULT NULL COMMENT 'oqcCheckFlag',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_sn` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'uuid',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `batch_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'batchCode',
  `work_order_id` bigint DEFAULT NULL COMMENT 'workOrderId',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_stock_taking_plan` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `type` int DEFAULT NULL COMMENT 'type',
  `start_time` datetime DEFAULT NULL COMMENT 'startTime',
  `end_time` datetime DEFAULT NULL COMMENT 'endTime',
  `blind_flag` tinyint(1) DEFAULT NULL COMMENT 'blindFlag',
  `frozen` tinyint(1) DEFAULT NULL COMMENT 'frozen',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_stock_taking_plan_param` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `plan_id` bigint DEFAULT NULL COMMENT 'planId',
  `type` int DEFAULT NULL COMMENT 'type',
  `value_id` bigint DEFAULT NULL COMMENT 'valueId',
  `value_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'valueCode',
  `value_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'valueName',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_stock_taking_task` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `taking_date` datetime DEFAULT NULL COMMENT 'takingDate',
  `type` int DEFAULT NULL COMMENT 'type',
  `user_id` bigint DEFAULT NULL COMMENT 'userId',
  `plan_id` bigint DEFAULT NULL COMMENT 'planId',
  `blind_flag` tinyint(1) DEFAULT NULL COMMENT 'blindFlag',
  `frozen` tinyint(1) DEFAULT NULL COMMENT 'frozen',
  `start_time` datetime DEFAULT NULL COMMENT 'startTime',
  `end_time` datetime DEFAULT NULL COMMENT 'endTime',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_stock_taking_task_line` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `task_id` bigint DEFAULT NULL COMMENT 'taskId',
  `material_stock_id` bigint DEFAULT NULL COMMENT 'materialStockId',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `batch_id` bigint DEFAULT NULL COMMENT 'batchId',
  `batch_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'batchCode',
  `quantity` decimal(24,6) DEFAULT NULL COMMENT 'quantity',
  `taking_quantity` decimal(24,6) DEFAULT NULL COMMENT 'takingQuantity',
  `warehouse_id` bigint DEFAULT NULL COMMENT 'warehouseId',
  `location_id` bigint DEFAULT NULL COMMENT 'locationId',
  `area_id` bigint DEFAULT NULL COMMENT 'areaId',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_stock_taking_task_result` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `task_id` bigint DEFAULT NULL COMMENT 'taskId',
  `line_id` bigint DEFAULT NULL COMMENT 'lineId',
  `material_stock_id` bigint DEFAULT NULL COMMENT 'materialStockId',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `batch_id` bigint DEFAULT NULL COMMENT 'batchId',
  `batch_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'batchCode',
  `warehouse_id` bigint DEFAULT NULL COMMENT 'warehouseId',
  `location_id` bigint DEFAULT NULL COMMENT 'locationId',
  `area_id` bigint DEFAULT NULL COMMENT 'areaId',
  `quantity` decimal(24,6) DEFAULT NULL COMMENT 'quantity',
  `taking_quantity` decimal(24,6) DEFAULT NULL COMMENT 'takingQuantity',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_transaction` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` int DEFAULT NULL COMMENT 'type',
  `biz_type` int DEFAULT NULL COMMENT 'bizType',
  `biz_id` bigint DEFAULT NULL COMMENT 'bizId',
  `biz_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'bizCode',
  `biz_line_id` bigint DEFAULT NULL COMMENT 'bizLineId',
  `material_stock_id` bigint DEFAULT NULL COMMENT 'materialStockId',
  `related_transaction_id` bigint DEFAULT NULL COMMENT 'relatedTransactionId',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `quantity` decimal(24,6) DEFAULT NULL COMMENT 'quantity',
  `batch_id` bigint DEFAULT NULL COMMENT 'batchId',
  `batch_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'batchCode',
  `warehouse_id` bigint DEFAULT NULL COMMENT 'warehouseId',
  `location_id` bigint DEFAULT NULL COMMENT 'locationId',
  `area_id` bigint DEFAULT NULL COMMENT 'areaId',
  `transaction_time` datetime DEFAULT NULL COMMENT 'transactionTime',
  `erp_time` datetime DEFAULT NULL COMMENT 'erpTime',
  `receipt_time` datetime DEFAULT NULL COMMENT 'receiptTime',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_transfer` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `type` int DEFAULT NULL COMMENT 'type',
  `delivery_flag` tinyint(1) DEFAULT NULL COMMENT 'deliveryFlag',
  `recipient_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'recipientName',
  `recipient_telephone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'recipientTelephone',
  `destination_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'destinationAddress',
  `carrier` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'carrier',
  `shipping_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'shippingNumber',
  `confirm_flag` tinyint(1) DEFAULT NULL COMMENT 'confirmFlag',
  `transfer_date` datetime DEFAULT NULL COMMENT 'transferDate',
  `status` int DEFAULT NULL COMMENT 'status',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_transfer_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `line_id` bigint DEFAULT NULL COMMENT 'lineId',
  `transfer_id` bigint DEFAULT NULL COMMENT 'transferId',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `quantity` decimal(24,6) DEFAULT NULL COMMENT 'quantity',
  `batch_id` bigint DEFAULT NULL COMMENT 'batchId',
  `to_warehouse_id` bigint DEFAULT NULL COMMENT 'toWarehouseId',
  `to_location_id` bigint DEFAULT NULL COMMENT 'toLocationId',
  `to_area_id` bigint DEFAULT NULL COMMENT 'toAreaId',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_transfer_line` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `transfer_id` bigint DEFAULT NULL COMMENT 'transferId',
  `material_stock_id` bigint DEFAULT NULL COMMENT 'materialStockId',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId',
  `quantity` decimal(24,6) DEFAULT NULL COMMENT 'quantity',
  `batch_id` bigint DEFAULT NULL COMMENT 'batchId',
  `from_warehouse_id` bigint DEFAULT NULL COMMENT 'fromWarehouseId',
  `from_location_id` bigint DEFAULT NULL COMMENT 'fromLocationId',
  `from_area_id` bigint DEFAULT NULL COMMENT 'fromAreaId',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_warehouse` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'address',
  `area` decimal(24,6) DEFAULT NULL COMMENT 'area',
  `charge_user_id` bigint DEFAULT NULL COMMENT 'chargeUserId',
  `frozen` tinyint(1) DEFAULT NULL COMMENT 'frozen',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_warehouse_area` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `location_id` bigint DEFAULT NULL COMMENT 'locationId',
  `area` decimal(24,6) DEFAULT NULL COMMENT 'area',
  `max_load` decimal(24,6) DEFAULT NULL COMMENT 'maxLoad',
  `position_x` int DEFAULT NULL COMMENT 'positionX',
  `position_y` int DEFAULT NULL COMMENT 'positionY',
  `position_z` int DEFAULT NULL COMMENT 'positionZ',
  `status` int DEFAULT NULL COMMENT 'status',
  `frozen` tinyint(1) DEFAULT NULL COMMENT 'frozen',
  `allow_item_mixing` tinyint(1) DEFAULT NULL COMMENT 'allowItemMixing',
  `allow_batch_mixing` tinyint(1) DEFAULT NULL COMMENT 'allowBatchMixing',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mes_wm_warehouse_location` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'code',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'name',
  `warehouse_id` bigint DEFAULT NULL COMMENT 'warehouseId',
  `area` decimal(24,6) DEFAULT NULL COMMENT 'area',
  `frozen` tinyint(1) DEFAULT NULL COMMENT 'frozen',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT 'remark',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mp_account` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公众号名称',
  `account` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公众号账号',
  `app_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公众号 appid',
  `app_secret` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公众号密钥',
  `token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公众号token',
  `aes_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '消息加解密密钥',
  `qr_code_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '二维码图片 URL',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='公众号账号';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mp_auto_reply` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `account_id` bigint DEFAULT NULL COMMENT '公众号账号的编号',
  `app_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公众号 appId',
  `type` int DEFAULT NULL COMMENT '回复类型',
  `request_keyword` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '请求的关键字',
  `request_match` int DEFAULT NULL COMMENT '请求的关键字的匹配',
  `request_message_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '请求的消息类型',
  `response_message_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '回复的消息类型',
  `response_content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '回复的消息内容',
  `response_media_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '回复的媒体 id',
  `response_media_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '回复的媒体 URL',
  `response_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '回复的标题',
  `response_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '回复的描述',
  `response_thumb_media_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '回复的缩略图的媒体 id',
  `response_thumb_media_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '回复的缩略图的媒体 URL',
  `response_articles` text COLLATE utf8mb4_unicode_ci COMMENT '回复的图文消息(JSON)',
  `response_music_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '回复的音乐链接',
  `response_hq_music_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '回复的高质量音乐链接',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='公众号消息自动回复';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mp_material` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `account_id` bigint DEFAULT NULL COMMENT '公众号账号的编号',
  `app_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公众号 appId',
  `media_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公众号素材 id',
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文件类型',
  `permanent` tinyint(1) DEFAULT NULL COMMENT '是否永久',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文件服务器的 URL',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名字',
  `mp_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公众号文件 URL',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '视频素材的标题',
  `introduction` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '视频素材的描述',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='公众号素材';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mp_menu` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `account_id` bigint DEFAULT NULL COMMENT '公众号账号的编号',
  `app_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公众号 appId',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '菜单名称',
  `menu_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '菜单标识',
  `parent_id` bigint DEFAULT NULL COMMENT '父菜单编号',
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '按钮类型',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '网页链接',
  `mini_program_app_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '小程序的 appId',
  `mini_program_page_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '小程序的页面路径',
  `article_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '跳转图文的媒体编号',
  `reply_message_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '消息类型',
  `reply_content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '回复的消息内容',
  `reply_media_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '回复的媒体 id',
  `reply_media_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '回复的媒体 URL',
  `reply_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '回复的标题',
  `reply_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '回复的描述',
  `reply_thumb_media_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '回复的缩略图的媒体 id',
  `reply_thumb_media_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '回复的缩略图的媒体 URL',
  `reply_articles` text COLLATE utf8mb4_unicode_ci COMMENT '回复的图文消息数组(JSON)',
  `reply_music_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '回复的音乐链接',
  `reply_hq_music_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '回复的高质量音乐链接',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='公众号菜单';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mp_message` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `msg_id` bigint DEFAULT NULL COMMENT '微信公众号消息 id',
  `account_id` bigint DEFAULT NULL COMMENT '公众号账号的 ID',
  `app_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公众号 appid',
  `user_id` bigint DEFAULT NULL COMMENT '公众号粉丝的编号',
  `openid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公众号粉丝标志',
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '消息类型',
  `send_from` int DEFAULT NULL COMMENT '消息来源',
  `content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '消息内容',
  `media_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '媒体文件的编号',
  `media_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '媒体文件的 URL',
  `recognition` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '语音识别后文本',
  `format` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '语音格式',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '描述',
  `thumb_media_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '缩略图的媒体 id',
  `thumb_media_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '缩略图的媒体 URL',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '点击图文消息跳转链接',
  `location_x` double DEFAULT NULL COMMENT '地理位置维度',
  `location_y` double DEFAULT NULL COMMENT '地理位置经度',
  `scale` double DEFAULT NULL COMMENT '地图缩放大小',
  `label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '详细地址',
  `articles` text COLLATE utf8mb4_unicode_ci COMMENT '图文消息数组(JSON)',
  `music_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '音乐链接',
  `hq_music_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '高质量音乐链接',
  `event` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '事件类型',
  `event_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '事件 Key',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='公众号消息';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mp_message_template` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `account_id` bigint DEFAULT NULL COMMENT '公众号账号的编号',
  `app_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公众号 appId',
  `template_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公众号模板 ID',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '模板内容',
  `example` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '模板示例',
  `primary_industry` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '模板所属行业的一级行业',
  `deputy_industry` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '模板所属行业的二级行业',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='公众号模版消息';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mp_tag` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tag_id` bigint DEFAULT NULL COMMENT '公众号标签 id',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标签名',
  `count` int DEFAULT NULL COMMENT '此标签下粉丝数',
  `account_id` bigint DEFAULT NULL COMMENT '公众号账号的编号',
  `app_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公众号 appId',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='公众号标签';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mp_user` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `openid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '粉丝标识',
  `union_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '微信生态唯一标识',
  `subscribe_status` int DEFAULT NULL COMMENT '关注状态',
  `subscribe_time` datetime DEFAULT NULL COMMENT '关注时间',
  `unsubscribe_time` datetime DEFAULT NULL COMMENT '取消关注时间',
  `nickname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '昵称',
  `head_image_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像地址',
  `language` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '语言',
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '国家',
  `province` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '省份',
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '城市',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `tag_ids` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标签编号数组(JSON)',
  `account_id` bigint DEFAULT NULL COMMENT '公众号账号的编号',
  `app_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公众号 appId',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='微信公众号粉丝';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `pay_app` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app_key` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL,
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_notify_url` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `refund_notify_url` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `transfer_notify_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '转账结果的回调地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='支付应用';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `pay_channel` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL,
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fee_rate` decimal(24,6) NOT NULL DEFAULT '0.000000',
  `app_id` bigint NOT NULL,
  `config` varchar(10240) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='支付渠道';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `pay_demo_order` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '订单编号',
  `user_id` bigint DEFAULT NULL COMMENT '用户编号',
  `spu_id` bigint DEFAULT NULL COMMENT '商品编号',
  `spu_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品名称',
  `price` int DEFAULT NULL COMMENT '价格，单位：分',
  `pay_status` tinyint(1) DEFAULT NULL COMMENT '是否支付',
  `pay_order_id` bigint DEFAULT NULL COMMENT '支付订单编号',
  `pay_time` datetime DEFAULT NULL COMMENT '付款时间',
  `pay_channel_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '支付渠道',
  `pay_refund_id` bigint DEFAULT NULL COMMENT '支付退款单号',
  `refund_price` int DEFAULT NULL COMMENT '退款金额，单位：分',
  `refund_time` datetime DEFAULT NULL COMMENT '退款完成时间',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='示例订单';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `pay_demo_withdraw` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '提现单编号',
  `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '提现标题',
  `price` int DEFAULT NULL COMMENT '提现金额，单位：分',
  `user_account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收款人账号',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收款人姓名',
  `type` int DEFAULT NULL COMMENT '提现方式',
  `status` int DEFAULT NULL COMMENT '提现状态',
  `pay_transfer_id` bigint DEFAULT NULL COMMENT '转账单编号',
  `transfer_channel_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '转账渠道',
  `transfer_time` datetime DEFAULT NULL COMMENT '转账成功时间',
  `transfer_error_msg` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '转账错误提示',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='示例提现订单';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `pay_notify_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `task_id` bigint NOT NULL,
  `notify_times` int NOT NULL,
  `response` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='支付通知日志';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `pay_notify_task` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app_id` bigint NOT NULL,
  `type` tinyint NOT NULL,
  `data_id` bigint NOT NULL,
  `merchant_order_id` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL,
  `next_notify_time` datetime DEFAULT NULL,
  `last_execute_time` datetime DEFAULT NULL,
  `notify_times` int NOT NULL,
  `max_notify_times` int NOT NULL,
  `notify_url` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  `merchant_refund_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商户退款编号',
  `merchant_transfer_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商户转账编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='支付通知任务';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `pay_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app_id` bigint NOT NULL,
  `channel_id` bigint DEFAULT NULL,
  `channel_code` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `merchant_order_id` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notify_url` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` bigint NOT NULL,
  `channel_fee_rate` decimal(24,6) DEFAULT '0.000000',
  `channel_fee_price` bigint DEFAULT '0',
  `status` tinyint NOT NULL,
  `user_ip` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `user_type` tinyint DEFAULT NULL,
  `expire_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `success_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `notify_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `extension_id` bigint DEFAULT NULL,
  `no` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `refund_price` bigint NOT NULL,
  `channel_user_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel_order_no` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='支付订单';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `pay_order_extension` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `no` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_id` bigint NOT NULL,
  `channel_id` bigint NOT NULL,
  `channel_code` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_ip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint NOT NULL,
  `channel_extras` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel_error_code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel_error_msg` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel_notify_data` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='支付订单拓展';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `pay_refund` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `no` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `app_id` bigint NOT NULL,
  `channel_id` bigint NOT NULL,
  `channel_code` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_id` bigint NOT NULL,
  `order_no` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `merchant_order_id` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `merchant_refund_id` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notify_url` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL,
  `pay_price` bigint NOT NULL,
  `refund_price` bigint NOT NULL,
  `reason` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_ip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `user_type` tinyint DEFAULT NULL,
  `channel_order_no` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `channel_refund_no` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `success_time` datetime DEFAULT NULL,
  `channel_error_code` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel_error_msg` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel_notify_data` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='退款订单';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `pay_transfer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `no` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `app_id` bigint NOT NULL,
  `channel_id` bigint NOT NULL,
  `channel_code` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `user_type` tinyint DEFAULT NULL,
  `merchant_transfer_id` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` bigint NOT NULL,
  `subject` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_account` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint NOT NULL,
  `notify_url` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_ip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel_transfer_no` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `success_time` datetime DEFAULT NULL,
  `channel_error_code` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel_error_msg` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel_notify_data` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel_extras` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel_package_info` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='转账单';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `pay_wallet` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint DEFAULT NULL COMMENT '用户编号',
  `user_type` int DEFAULT NULL COMMENT '用户类型',
  `balance` int DEFAULT NULL COMMENT '余额，单位：分',
  `freeze_price` int DEFAULT NULL COMMENT '冻结金额，单位：分',
  `total_expense` int DEFAULT NULL COMMENT '累计支出，单位：分',
  `total_recharge` int DEFAULT NULL COMMENT '累计充值，单位：分',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员钱包';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `pay_wallet_recharge` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `wallet_id` bigint DEFAULT NULL COMMENT '钱包编号',
  `total_price` int DEFAULT NULL COMMENT '用户实际到账余额，单位：分',
  `pay_price` int DEFAULT NULL COMMENT '实际支付金额，单位：分',
  `bonus_price` int DEFAULT NULL COMMENT '钱包赠送金额，单位：分',
  `package_id` bigint DEFAULT NULL COMMENT '充值套餐编号',
  `pay_status` tinyint(1) DEFAULT NULL COMMENT '是否已支付',
  `pay_order_id` bigint DEFAULT NULL COMMENT '支付订单编号',
  `pay_channel_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '支付成功的支付渠道',
  `pay_time` datetime DEFAULT NULL COMMENT '订单支付时间',
  `pay_refund_id` bigint DEFAULT NULL COMMENT '支付退款单编号',
  `refund_total_price` int DEFAULT NULL COMMENT '退款金额，包含赠送金额，单位：分',
  `refund_pay_price` int DEFAULT NULL COMMENT '退款支付金额，单位：分',
  `refund_bonus_price` int DEFAULT NULL COMMENT '退款钱包赠送金额，单位：分',
  `refund_time` datetime DEFAULT NULL COMMENT '退款时间',
  `refund_status` int DEFAULT NULL COMMENT '退款状态',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员钱包充值';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `pay_wallet_recharge_package` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '套餐名',
  `pay_price` int DEFAULT NULL COMMENT '支付金额，单位：分',
  `bonus_price` int DEFAULT NULL COMMENT '赠送金额，单位：分',
  `status` int DEFAULT NULL COMMENT '状态',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员钱包充值套餐';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `pay_wallet_transaction` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '流水号',
  `wallet_id` bigint DEFAULT NULL COMMENT '钱包编号',
  `biz_type` int DEFAULT NULL COMMENT '关联业务分类',
  `biz_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '关联业务编号',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '流水说明',
  `price` int DEFAULT NULL COMMENT '交易金额，单位：分，正值表示余额增加，负值表示余额减少',
  `balance` int DEFAULT NULL COMMENT '交易后余额，单位：分',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员钱包流水';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `product_brand` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '品牌编号',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '品牌名称',
  `pic_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '品牌图片',
  `sort` int DEFAULT '0' COMMENT '品牌排序',
  `description` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '品牌描述',
  `status` tinyint NOT NULL COMMENT '状态',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品品牌';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `product_browse_history` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `spu_id` bigint DEFAULT NULL COMMENT '商品 SPU 编号',
  `user_id` bigint DEFAULT NULL COMMENT '用户编号',
  `user_deleted` tinyint(1) DEFAULT NULL COMMENT '用户是否删除',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品浏览记录';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `product_category` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '分类编号',
  `parent_id` bigint NOT NULL COMMENT '父分类编号',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分类名称',
  `pic_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '移动端分类图',
  `big_pic_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'PC 端分类图',
  `sort` int DEFAULT '0' COMMENT '分类排序',
  `status` tinyint NOT NULL COMMENT '开启状态',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品分类';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `product_comment` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '评论编号，主键自增',
  `user_id` bigint DEFAULT NULL COMMENT '评价人的用户编号关联 MemberUserDO 的 id 编号',
  `user_nickname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '评价人名称',
  `user_avatar` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '评价人头像',
  `anonymous` tinyint(1) DEFAULT NULL COMMENT '是否匿名',
  `order_id` bigint DEFAULT NULL COMMENT '交易订单编号关联 TradeOrderDO 的 id 编号',
  `order_item_id` bigint DEFAULT NULL COMMENT '交易订单项编号关联 TradeOrderItemDO 的 id 编号',
  `spu_id` bigint DEFAULT NULL COMMENT '商品 SPU 编号关联 ProductSpuDO 的 id',
  `spu_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品 SPU 名称',
  `sku_id` bigint DEFAULT NULL COMMENT '商品 SKU 编号关联 ProductSkuDO 的 id 编号',
  `visible` tinyint(1) DEFAULT NULL COMMENT '是否可见true:显示false:隐藏',
  `scores` tinyint DEFAULT NULL COMMENT '评分星级1-5分',
  `description_scores` tinyint DEFAULT NULL COMMENT '描述星级1-5 星',
  `benefit_scores` tinyint DEFAULT NULL COMMENT '服务星级1-5 星',
  `content` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '评论内容',
  `pic_urls` varchar(4096) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '评论图片地址数组',
  `reply_status` tinyint(1) DEFAULT NULL COMMENT '商家是否回复',
  `reply_user_id` bigint DEFAULT NULL COMMENT '回复管理员编号关联 AdminUserDO 的 id 编号',
  `reply_content` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商家回复内容',
  `reply_time` datetime DEFAULT NULL COMMENT '商家回复时间',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  `sku_pic_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品 SKU 图片地址',
  `sku_properties` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '属性数组，JSON 格式',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品评论';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `product_favorite` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint DEFAULT NULL COMMENT '用户编号',
  `spu_id` bigint DEFAULT NULL COMMENT '商品 SPU 编号',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品收藏';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `product_property` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '规格名称',
  `status` tinyint DEFAULT NULL COMMENT '状态： 0 开启 ，1 禁用',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='规格名称';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `product_property_value` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `property_id` bigint DEFAULT NULL COMMENT '规格键id',
  `name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '规格值名字',
  `status` tinyint DEFAULT NULL COMMENT '状态： 1 开启 ，2 禁用',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='规格值';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `product_sku` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `spu_id` bigint NOT NULL COMMENT 'spu编号',
  `properties` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '属性数组，JSON 格式',
  `price` int NOT NULL DEFAULT '-1' COMMENT '商品价格，单位：分',
  `market_price` int DEFAULT NULL COMMENT '市场价，单位：分',
  `cost_price` int NOT NULL DEFAULT '-1' COMMENT '成本价，单位： 分',
  `bar_code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'SKU 的条形码',
  `pic_url` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '图片地址',
  `stock` int DEFAULT NULL COMMENT '库存',
  `weight` decimal(24,6) DEFAULT NULL COMMENT '商品重量，单位：kg 千克',
  `volume` decimal(24,6) DEFAULT NULL COMMENT '商品体积，单位：m^3 平米',
  `sub_commission_first_price` int DEFAULT NULL COMMENT '一级分销的佣金，单位：分',
  `sub_commission_second_price` int DEFAULT NULL COMMENT '二级分销的佣金，单位：分',
  `sales_count` int DEFAULT NULL COMMENT '商品销量',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  `first_brokerage_price` int DEFAULT NULL COMMENT '一级分销的佣金，单位：分',
  `second_brokerage_price` int DEFAULT NULL COMMENT '二级分销的佣金，单位：分',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品sku';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `product_spu` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '商品 SPU 编号，自增',
  `name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品名称',
  `keyword` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '关键字',
  `introduction` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品简介',
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品详情',
  `bar_code` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '条形码',
  `category_id` bigint NOT NULL COMMENT '商品分类编号',
  `brand_id` int DEFAULT NULL COMMENT '商品品牌编号',
  `pic_url` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品封面图',
  `slider_pic_urls` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '商品轮播图地址\n 数组，以逗号分隔\n 最多上传15张',
  `video_url` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品视频',
  `unit` tinyint NOT NULL COMMENT '单位',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序字段',
  `status` tinyint NOT NULL COMMENT '商品状态: 0 上架（开启） 1 下架（禁用）-1 回收',
  `spec_type` tinyint(1) NOT NULL COMMENT '规格类型：0 单规格 1 多规格',
  `price` int NOT NULL DEFAULT '-1' COMMENT '商品价格，单位使用：分',
  `market_price` int NOT NULL COMMENT '市场价，单位使用：分',
  `cost_price` int NOT NULL DEFAULT '-1' COMMENT '成本价，单位： 分',
  `stock` int NOT NULL DEFAULT '0' COMMENT '库存',
  `delivery_template_id` bigint NOT NULL COMMENT '物流配置模板编号',
  `recommend_hot` tinyint(1) NOT NULL COMMENT '是否热卖推荐: 0 默认 1 热卖',
  `recommend_benefit` tinyint(1) NOT NULL COMMENT '是否优惠推荐: 0 默认 1 优选',
  `recommend_best` tinyint(1) NOT NULL COMMENT '是否精品推荐: 0 默认 1 精品',
  `recommend_new` tinyint(1) NOT NULL COMMENT '是否新品推荐: 0 默认 1 新品',
  `recommend_good` tinyint(1) NOT NULL COMMENT '是否优品推荐',
  `give_integral` int NOT NULL COMMENT '赠送积分',
  `give_coupon_template_ids` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '赠送的优惠劵编号的数组',
  `sub_commission_type` tinyint(1) NOT NULL COMMENT '分销类型',
  `activity_orders` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '活动显示排序0=默认, 1=秒杀，2=砍价，3=拼团',
  `sales_count` int DEFAULT '0' COMMENT '商品销量',
  `virtual_sales_count` int DEFAULT '0' COMMENT '虚拟销量',
  `browse_count` int DEFAULT '0' COMMENT '商品点击量',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  `delivery_types` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '配送方式数组，对应 DeliveryTypeEnum 枚举',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品spu';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `product_statistics` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `time` date DEFAULT NULL COMMENT '统计日期',
  `spu_id` bigint DEFAULT NULL COMMENT '商品 SPU 编号',
  `browse_count` int DEFAULT NULL COMMENT '浏览量',
  `browse_user_count` int DEFAULT NULL COMMENT '访客量',
  `favorite_count` int DEFAULT NULL COMMENT '收藏数量',
  `cart_count` int DEFAULT NULL COMMENT '加购数量',
  `order_count` int DEFAULT NULL COMMENT '下单件数',
  `order_pay_count` int DEFAULT NULL COMMENT '支付件数',
  `order_pay_price` int DEFAULT NULL COMMENT '支付金额，单位：分',
  `after_sale_count` int DEFAULT NULL COMMENT '退款件数',
  `after_sale_refund_price` int DEFAULT NULL COMMENT '退款金额，单位：分',
  `browse_convert_percent` int DEFAULT NULL COMMENT '访客支付转化率（百分比）',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品统计';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `promotion_article` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `category_id` bigint NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `author` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pic_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `introduction` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `browse_count` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort` int NOT NULL,
  `status` int NOT NULL,
  `spu_id` bigint NOT NULL,
  `recommend_hot` bit(1) NOT NULL,
  `recommend_banner` bit(1) NOT NULL,
  `content` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文章管理表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `promotion_article_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pic_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int NOT NULL,
  `sort` int NOT NULL,
  `creator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文章分类表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `promotion_banner` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `url` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '跳转链接',
  `pic_url` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '图片链接',
  `sort` int DEFAULT NULL COMMENT '排序',
  `status` int DEFAULT NULL COMMENT '状态',
  `position` int DEFAULT NULL COMMENT '定位',
  `memo` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `browse_count` int DEFAULT NULL COMMENT '点击次数',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='banner 主图';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `promotion_bargain_activity` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '砍价活动编号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '砍价活动名称',
  `start_time` datetime DEFAULT NULL COMMENT '活动开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '活动结束时间',
  `status` int DEFAULT NULL COMMENT '活动状态',
  `spu_id` bigint DEFAULT NULL COMMENT '商品 SPU 编号',
  `sku_id` bigint DEFAULT NULL COMMENT '商品 SKU 编号',
  `bargain_first_price` int DEFAULT NULL COMMENT '砍价起始价格，单位：分',
  `bargain_min_price` int DEFAULT NULL COMMENT '砍价底价，单位：分',
  `stock` int DEFAULT NULL COMMENT '砍价库存，剩余库存砍价时扣减',
  `total_stock` int DEFAULT NULL COMMENT '砍价总库存',
  `help_max_count` int DEFAULT NULL COMMENT '砍价人数，需要多少人砍价才能成功',
  `bargain_count` int DEFAULT NULL COMMENT '帮砍次数，单个活动用户可以帮砍的次数',
  `total_limit_count` int DEFAULT NULL COMMENT '总限购数量',
  `random_min_price` int DEFAULT NULL COMMENT '用户每次砍价的最小金额，单位：分',
  `random_max_price` int DEFAULT NULL COMMENT '用户每次砍价的最大金额，单位：分',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='砍价活动';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `promotion_bargain_help` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `activity_id` bigint DEFAULT NULL COMMENT '砍价活动编号',
  `record_id` bigint DEFAULT NULL COMMENT '砍价记录编号',
  `user_id` bigint DEFAULT NULL COMMENT '用户编号',
  `reduce_price` int DEFAULT NULL COMMENT '减少价格，单位：分',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='砍价助力';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `promotion_bargain_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint DEFAULT NULL COMMENT '用户编号',
  `activity_id` bigint DEFAULT NULL COMMENT '砍价活动编号',
  `spu_id` bigint DEFAULT NULL COMMENT '商品 SPU 编号',
  `sku_id` bigint DEFAULT NULL COMMENT '商品 SKU 编号',
  `bargain_first_price` int DEFAULT NULL COMMENT '砍价起始价格，单位：分',
  `bargain_price` int DEFAULT NULL COMMENT '当前砍价，单位：分',
  `status` int DEFAULT NULL COMMENT '砍价状态',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `order_id` bigint DEFAULT NULL COMMENT '订单编号',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='砍价记录';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `promotion_combination_activity` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `spu_id` bigint DEFAULT NULL,
  `total_limit_count` int NOT NULL,
  `single_limit_count` int NOT NULL,
  `start_time` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `end_time` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_size` int NOT NULL,
  `total_num` int NOT NULL,
  `success_num` int NOT NULL,
  `order_user_count` int NOT NULL,
  `virtual_group` int NOT NULL,
  `status` int NOT NULL,
  `limit_duration` int NOT NULL,
  `creator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='拼团活动';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `promotion_combination_product` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `activity_id` bigint DEFAULT NULL COMMENT '拼团活动编号',
  `spu_id` bigint DEFAULT NULL COMMENT '商品 SPU 编号',
  `sku_id` bigint DEFAULT NULL COMMENT '商品 SKU 编号',
  `combination_price` int DEFAULT NULL COMMENT '拼团价格，单位：分',
  `activity_status` int DEFAULT NULL COMMENT '拼团商品状态',
  `activity_start_time` datetime DEFAULT NULL COMMENT '活动开始时间点',
  `activity_end_time` datetime DEFAULT NULL COMMENT '活动结束时间点',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='拼团商品';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `promotion_combination_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `activity_id` bigint NOT NULL,
  `combination_price` int NOT NULL,
  `spu_id` bigint NOT NULL,
  `spu_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pic_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sku_id` bigint NOT NULL,
  `count` int NOT NULL,
  `user_id` bigint NOT NULL,
  `nickname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `head_id` bigint NOT NULL,
  `status` int NOT NULL,
  `order_id` bigint NOT NULL,
  `user_size` int NOT NULL,
  `user_count` int NOT NULL,
  `virtual_group` bit(1) NOT NULL,
  `expire_time` datetime DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `creator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='拼团记录';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `promotion_coupon` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `template_id` bigint NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NOT NULL,
  `user_id` bigint NOT NULL,
  `take_type` int NOT NULL,
  `use_price` int NOT NULL,
  `valid_start_time` datetime NOT NULL,
  `valid_end_time` datetime NOT NULL,
  `product_scope` int NOT NULL,
  `product_scope_values` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_type` int NOT NULL,
  `discount_percent` int DEFAULT NULL,
  `discount_price` int DEFAULT NULL,
  `discount_limit_price` int DEFAULT NULL,
  `use_order_id` bigint DEFAULT NULL,
  `use_time` datetime DEFAULT NULL,
  `creator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='优惠劵';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `promotion_coupon_template` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int NOT NULL,
  `total_count` int NOT NULL,
  `take_limit_count` int NOT NULL,
  `take_type` int NOT NULL,
  `use_price` int NOT NULL,
  `product_scope` int NOT NULL,
  `product_scope_values` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `validity_type` int NOT NULL,
  `valid_start_time` datetime DEFAULT NULL,
  `valid_end_time` datetime DEFAULT NULL,
  `fixed_start_term` int DEFAULT NULL,
  `fixed_end_term` int DEFAULT NULL,
  `discount_type` int NOT NULL,
  `discount_percent` int DEFAULT NULL,
  `discount_price` int DEFAULT NULL,
  `discount_limit_price` int DEFAULT NULL,
  `take_count` int NOT NULL DEFAULT '0',
  `use_count` int NOT NULL DEFAULT '0',
  `creator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='优惠劵模板';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `promotion_discount_activity` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='限时折扣活动';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `promotion_discount_product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `activity_id` bigint NOT NULL,
  `spu_id` bigint NOT NULL,
  `sku_id` bigint NOT NULL,
  `discount_type` int NOT NULL,
  `discount_percent` int DEFAULT NULL,
  `discount_price` int DEFAULT NULL,
  `activity_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `activity_status` int NOT NULL,
  `activity_start_time` datetime NOT NULL,
  `activity_end_time` datetime NOT NULL,
  `creator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='限时折扣商品';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `promotion_diy_page` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `template_id` bigint NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `preview_pic_urls` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `property` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='装修页面';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `promotion_diy_template` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `used` bit(1) NOT NULL,
  `used_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `preview_pic_urls` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `property` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='装修模板';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `promotion_kefu_conversation` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint DEFAULT NULL COMMENT '会话所属用户',
  `last_message_time` datetime DEFAULT NULL COMMENT '最后聊天时间',
  `last_message_content` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '最后聊天内容',
  `last_message_content_type` int DEFAULT NULL COMMENT '最后发送的消息类型',
  `admin_pinned` tinyint(1) DEFAULT NULL COMMENT '管理端置顶',
  `user_deleted` tinyint(1) DEFAULT NULL COMMENT '用户是否可见，用户删除时为 true',
  `admin_deleted` tinyint(1) DEFAULT NULL COMMENT '管理员是否可见，管理员删除时为 true',
  `admin_unread_message_count` int DEFAULT NULL COMMENT '管理员未读消息数',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='客服会话';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `promotion_kefu_message` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `conversation_id` bigint DEFAULT NULL COMMENT '会话编号',
  `sender_id` bigint DEFAULT NULL COMMENT '发送人编号',
  `sender_type` int DEFAULT NULL COMMENT '发送人类型',
  `receiver_id` bigint DEFAULT NULL COMMENT '接收人编号',
  `receiver_type` int DEFAULT NULL COMMENT '接收人类型',
  `content_type` int DEFAULT NULL COMMENT '消息类型',
  `content` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '消息',
  `read_status` tinyint(1) DEFAULT NULL COMMENT '是否已读',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='客服消息';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `promotion_point_activity` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '积分商城活动编号',
  `spu_id` bigint DEFAULT NULL COMMENT '积分商城活动商品',
  `status` int DEFAULT NULL COMMENT '活动状态',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `sort` int DEFAULT NULL COMMENT '排序',
  `stock` int DEFAULT NULL COMMENT '积分商城活动库存，剩余库存积分兑换时扣减',
  `total_stock` int DEFAULT NULL COMMENT '积分商城活动总库存',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='积分商城活动';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `promotion_point_product` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '积分商城商品编号',
  `activity_id` bigint DEFAULT NULL COMMENT '积分商城活动编号',
  `spu_id` bigint DEFAULT NULL COMMENT '商品 SPU 编号',
  `sku_id` bigint DEFAULT NULL COMMENT '商品 SKU 编号',
  `count` int DEFAULT NULL COMMENT '可兑换次数',
  `point` int DEFAULT NULL COMMENT '所需兑换积分',
  `price` int DEFAULT NULL COMMENT '所需兑换金额，单位：分',
  `stock` int DEFAULT NULL COMMENT '积分商城商品库存',
  `activity_status` int DEFAULT NULL COMMENT '积分商城商品状态',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='积分商城商品';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `promotion_reward_activity` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `condition_type` int NOT NULL,
  `product_scope` int NOT NULL,
  `product_spu_ids` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rules` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `product_scope_values` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '商品 SPU 编号的数组',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='满减送活动';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `promotion_seckill_activity` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `spu_id` bigint NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NOT NULL,
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_time` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `end_time` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort` int NOT NULL,
  `config_ids` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_count` int NOT NULL,
  `user_count` int NOT NULL,
  `total_price` int NOT NULL,
  `total_limit_count` int DEFAULT NULL,
  `single_limit_count` int DEFAULT NULL,
  `stock` int DEFAULT NULL,
  `total_stock` int DEFAULT NULL,
  `creator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='秒杀活动';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `promotion_seckill_config` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_time` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `end_time` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pic_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NOT NULL,
  `creator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL,
  `slider_pic_urls` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '秒杀轮播图',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='秒杀时段配置';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `promotion_seckill_product` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '秒杀参与商品编号',
  `activity_id` bigint DEFAULT NULL COMMENT '秒杀活动编号',
  `config_ids` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '秒杀时段编号数组',
  `spu_id` bigint DEFAULT NULL COMMENT '商品 SPU 编号',
  `sku_id` bigint DEFAULT NULL COMMENT '商品 SKU 编号',
  `seckill_price` int DEFAULT NULL COMMENT '秒杀金额，单位：分',
  `stock` int DEFAULT NULL COMMENT '秒杀库存',
  `activity_status` int DEFAULT NULL COMMENT '秒杀商品状态',
  `activity_start_time` datetime DEFAULT NULL COMMENT '活动开始时间点',
  `activity_end_time` datetime DEFAULT NULL COMMENT '活动结束时间点',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='秒杀参与商品';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `report_go_view_project` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pic_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='GoView 项目表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `trade_after_sale` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NOT NULL,
  `type` int NOT NULL,
  `way` int NOT NULL,
  `user_id` bigint NOT NULL,
  `apply_reason` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apply_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `apply_pic_urls` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_id` bigint NOT NULL,
  `order_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_item_id` bigint NOT NULL,
  `spu_id` bigint NOT NULL,
  `spu_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sku_id` bigint NOT NULL,
  `properties` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pic_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `count` int NOT NULL,
  `audit_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `audit_user_id` bigint DEFAULT NULL,
  `audit_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `refund_price` int NOT NULL,
  `pay_refund_id` bigint DEFAULT NULL,
  `refund_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logistics_id` bigint DEFAULT NULL,
  `logistics_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivery_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receive_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receive_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='交易售后表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `trade_after_sale_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `user_type` int NOT NULL,
  `after_sale_id` bigint NOT NULL,
  `order_id` bigint NOT NULL,
  `order_item_id` bigint NOT NULL,
  `before_status` int DEFAULT NULL,
  `after_status` int NOT NULL,
  `content` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `operate_type` int DEFAULT NULL COMMENT '操作类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='交易售后日志';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `trade_brokerage_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `biz_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `biz_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int NOT NULL,
  `total_price` int NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `frozen_days` int NOT NULL,
  `unfreeze_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_user_level` int DEFAULT NULL,
  `source_user_id` bigint DEFAULT NULL,
  `creator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='佣金记录';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `trade_brokerage_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `bind_user_id` bigint NOT NULL,
  `bind_user_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brokerage_enabled` bit(1) NOT NULL,
  `brokerage_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` int NOT NULL,
  `frozen_price` int NOT NULL,
  `creator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  `brokerage_price` int DEFAULT NULL COMMENT '可用佣金',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='分销用户';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `trade_brokerage_withdraw` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `price` int NOT NULL,
  `fee_price` int NOT NULL,
  `total_price` int NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_qr_code_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `audit_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `audit_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '提现姓名',
  `user_account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '提现账号',
  `qr_code_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收款码',
  `pay_transfer_id` bigint DEFAULT NULL COMMENT '转账单编号',
  `transfer_channel_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '转账渠道',
  `transfer_time` datetime DEFAULT NULL COMMENT '转账成功时间',
  `transfer_error_msg` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '转账错误提示',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='佣金提现';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `trade_cart` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint DEFAULT NULL COMMENT '用户编号',
  `spu_id` bigint DEFAULT NULL COMMENT '商品 SPU 编号',
  `sku_id` bigint DEFAULT NULL COMMENT '商品 SKU 编号',
  `count` int DEFAULT NULL COMMENT '商品购买数量',
  `selected` tinyint(1) DEFAULT NULL COMMENT '是否选中',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='购物车的商品信息';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `trade_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `after_sale_refund_reasons` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '售后的退款理由',
  `after_sale_return_reasons` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '售后的退货理由',
  `delivery_express_free_enabled` tinyint(1) DEFAULT NULL COMMENT '是否启用全场包邮',
  `delivery_express_free_price` int DEFAULT NULL COMMENT '全场包邮的最小金额，单位：分',
  `delivery_pick_up_enabled` tinyint(1) DEFAULT NULL COMMENT '是否开启自提',
  `brokerage_enabled` tinyint(1) DEFAULT NULL COMMENT '是否启用分佣',
  `brokerage_enabled_condition` int DEFAULT NULL COMMENT '分佣模式',
  `brokerage_bind_mode` int DEFAULT NULL COMMENT '分销关系绑定模式',
  `brokerage_poster_urls` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '分销海报图地址数组',
  `brokerage_first_percent` int DEFAULT NULL COMMENT '一级返佣比例',
  `brokerage_second_percent` int DEFAULT NULL COMMENT '二级返佣比例',
  `brokerage_withdraw_min_price` int DEFAULT NULL COMMENT '用户提现最低金额',
  `brokerage_withdraw_fee_percent` int DEFAULT NULL COMMENT '用户提现手续费百分比',
  `brokerage_frozen_days` int DEFAULT NULL COMMENT '佣金冻结时间（天）',
  `brokerage_withdraw_types` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '提现方式',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='交易中心配置';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `trade_delivery_express` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort` int NOT NULL,
  `status` int NOT NULL,
  `creator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='佣金提现';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `trade_delivery_express_template` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '模板名称',
  `charge_mode` int DEFAULT NULL COMMENT '配送计费方式',
  `sort` int DEFAULT NULL COMMENT '排序',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='快递运费模板';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `trade_delivery_express_template_charge` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `template_id` bigint DEFAULT NULL COMMENT '配送模板编号',
  `area_ids` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '配送区域编号列表',
  `charge_mode` int DEFAULT NULL COMMENT '配送计费方式',
  `start_count` double DEFAULT NULL COMMENT '首件数量（件数、重量，或体积）',
  `start_price` int DEFAULT NULL COMMENT '起步价，单位：分',
  `extra_count` double DEFAULT NULL COMMENT '续件数量（件、重量，或体积）',
  `extra_price` int DEFAULT NULL COMMENT '额外价，单位：分',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='快递运费模板计费配置';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `trade_delivery_express_template_free` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `template_id` bigint DEFAULT NULL COMMENT '配送模板编号',
  `area_ids` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '配送区域编号列表',
  `free_price` int DEFAULT NULL COMMENT '包邮金额，单位：分，订单总金额 >= 包邮金额时才免运费',
  `free_count` int DEFAULT NULL COMMENT '包邮件数，订单总件数 >= 包邮件数时才免运费',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='快递运费模板包邮配置';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `trade_delivery_pick_up_store` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '门店名称',
  `introduction` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '门店简介',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '门店手机',
  `area_id` int DEFAULT NULL COMMENT '区域编号',
  `detail_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '门店详细地址',
  `logo` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '门店 logo',
  `opening_time` time DEFAULT NULL COMMENT '营业开始时间',
  `closing_time` time DEFAULT NULL COMMENT '营业结束时间',
  `latitude` double DEFAULT NULL COMMENT '纬度',
  `longitude` double DEFAULT NULL COMMENT '经度',
  `verify_user_ids` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '核销员工用户编号数组',
  `status` int DEFAULT NULL COMMENT '门店状态',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='自提门店';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `trade_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` int NOT NULL,
  `terminal` int NOT NULL,
  `user_id` bigint NOT NULL,
  `user_ip` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int NOT NULL,
  `product_count` int NOT NULL,
  `cancel_type` int DEFAULT NULL,
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comment_status` tinyint(1) DEFAULT NULL,
  `brokerage_user_id` bigint DEFAULT NULL,
  `pay_status` bit(1) NOT NULL,
  `pay_time` datetime DEFAULT NULL,
  `finish_time` datetime DEFAULT NULL,
  `cancel_time` datetime DEFAULT NULL,
  `total_price` int DEFAULT NULL,
  `order_price` int DEFAULT NULL,
  `discount_price` int NOT NULL,
  `delivery_price` int NOT NULL,
  `adjust_price` int NOT NULL,
  `pay_price` int NOT NULL,
  `delivery_type` int NOT NULL,
  `pay_order_id` bigint DEFAULT NULL,
  `pay_channel_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivery_template_id` bigint DEFAULT NULL,
  `logistics_id` bigint DEFAULT NULL,
  `logistics_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivery_time` datetime DEFAULT NULL,
  `receive_time` datetime DEFAULT NULL,
  `receiver_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `receiver_mobile` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `receiver_area_id` int NOT NULL,
  `receiver_post_code` int DEFAULT NULL,
  `receiver_detail_address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pick_up_store_id` mediumtext COLLATE utf8mb4_unicode_ci,
  `pick_up_verify_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `refund_status` int DEFAULT NULL,
  `refund_price` int DEFAULT NULL,
  `after_sale_status` int DEFAULT NULL,
  `coupon_id` bigint NOT NULL,
  `coupon_price` int NOT NULL,
  `use_point` int DEFAULT NULL,
  `point_price` int NOT NULL,
  `give_point` int DEFAULT NULL,
  `refund_point` int DEFAULT NULL,
  `vip_price` int DEFAULT NULL,
  `give_coupons_map` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seckill_activity_id` mediumtext COLLATE utf8mb4_unicode_ci,
  `bargain_activity_id` mediumtext COLLATE utf8mb4_unicode_ci,
  `bargain_record_id` mediumtext COLLATE utf8mb4_unicode_ci,
  `combination_activity_id` mediumtext COLLATE utf8mb4_unicode_ci,
  `combination_head_id` mediumtext COLLATE utf8mb4_unicode_ci,
  `combination_record_id` mediumtext COLLATE utf8mb4_unicode_ci,
  `creator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `give_coupon_template_counts` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '赠送的优惠劵，key 为优惠劵模版编号，value 为对应的优惠券数量',
  `give_coupon_ids` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '赠送的优惠劵编号',
  `point_activity_id` bigint DEFAULT NULL COMMENT '积分商城活动的编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='交易订单表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `trade_order_item` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `order_id` bigint NOT NULL,
  `cart_id` int DEFAULT NULL,
  `spu_id` bigint NOT NULL,
  `spu_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sku_id` bigint NOT NULL,
  `properties` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pic_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `count` int NOT NULL,
  `comment_status` tinyint(1) DEFAULT NULL,
  `price` int NOT NULL,
  `discount_price` int NOT NULL,
  `delivery_price` int DEFAULT NULL,
  `adjust_price` int DEFAULT NULL,
  `pay_price` int NOT NULL,
  `coupon_price` int DEFAULT NULL,
  `point_price` int DEFAULT NULL,
  `use_point` int DEFAULT NULL,
  `give_point` int DEFAULT NULL,
  `vip_price` int DEFAULT NULL,
  `after_sale_id` mediumtext COLLATE utf8mb4_unicode_ci,
  `after_sale_status` int NOT NULL,
  `creator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='交易订单明细表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `trade_order_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint DEFAULT NULL COMMENT '用户编号',
  `user_type` int DEFAULT NULL COMMENT '用户类型',
  `order_id` bigint DEFAULT NULL COMMENT '订单号',
  `before_status` int DEFAULT NULL COMMENT '操作前状态',
  `after_status` int DEFAULT NULL COMMENT '操作后状态',
  `operate_type` int DEFAULT NULL COMMENT '操作类型',
  `content` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '订单日志信息',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单日志';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `trade_statistics` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `time` datetime DEFAULT NULL COMMENT '统计日期',
  `order_create_count` int DEFAULT NULL COMMENT '创建订单数',
  `order_pay_count` int DEFAULT NULL COMMENT '支付订单商品数',
  `order_pay_price` int DEFAULT NULL COMMENT '总支付金额，单位：分',
  `after_sale_count` int DEFAULT NULL COMMENT '退款订单数',
  `after_sale_refund_price` int DEFAULT NULL COMMENT '总退款金额，单位：分',
  `brokerage_settlement_price` int DEFAULT NULL COMMENT '佣金金额（已结算），单位：分',
  `wallet_pay_price` int DEFAULT NULL COMMENT '总支付金额（余额），单位：分',
  `recharge_pay_count` int DEFAULT NULL COMMENT '充值订单数',
  `recharge_pay_price` int DEFAULT NULL COMMENT '充值金额，单位：分',
  `recharge_refund_count` int DEFAULT NULL COMMENT '充值退款订单数',
  `recharge_refund_price` int DEFAULT NULL COMMENT '充值退款金额，单位：分',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='交易统计';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `wms_check_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `no` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_time` timestamp NOT NULL,
  `status` int NOT NULL DEFAULT '0',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `warehouse_id` bigint NOT NULL,
  `area_id` bigint NOT NULL DEFAULT '0',
  `total_quantity` decimal(20,2) NOT NULL DEFAULT '0.00',
  `total_price` decimal(16,2) DEFAULT NULL,
  `actual_price` decimal(16,2) DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='WMS 盘库单表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `wms_check_order_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` bigint NOT NULL,
  `sku_id` bigint NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `area_id` bigint NOT NULL DEFAULT '0',
  `inventory_id` bigint DEFAULT NULL,
  `inventory_detail_id` bigint DEFAULT NULL,
  `batch_no` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `production_date` timestamp NULL DEFAULT NULL,
  `expiration_date` timestamp NULL DEFAULT NULL,
  `receipt_time` timestamp NULL DEFAULT NULL,
  `quantity` decimal(20,2) NOT NULL DEFAULT '0.00',
  `check_quantity` decimal(20,2) NOT NULL DEFAULT '0.00',
  `price` decimal(16,2) DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='WMS 盘库单明细表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `wms_inventory` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sku_id` bigint NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `area_id` bigint NOT NULL DEFAULT '0',
  `quantity` decimal(20,2) NOT NULL DEFAULT '0.00',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_sku_id_warehouse_id` (`sku_id`,`warehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='WMS 库存表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `wms_inventory_history` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `area_id` bigint NOT NULL DEFAULT '0',
  `sku_id` bigint NOT NULL,
  `quantity` decimal(20,2) NOT NULL DEFAULT '0.00',
  `before_quantity` decimal(20,2) DEFAULT NULL,
  `after_quantity` decimal(20,2) DEFAULT NULL,
  `batch_no` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `production_date` timestamp NULL DEFAULT NULL,
  `expiration_date` timestamp NULL DEFAULT NULL,
  `price` decimal(16,2) DEFAULT NULL,
  `total_price` decimal(16,2) DEFAULT NULL,
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_id` bigint DEFAULT NULL,
  `order_no` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_type` int DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='WMS 库存流水表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `wms_item` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` bigint NOT NULL,
  `unit` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brand_id` bigint DEFAULT NULL,
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='WMS 商品表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `wms_item_brand` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='WMS 商品品牌表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `wms_item_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `parent_id` bigint NOT NULL DEFAULT '0',
  `code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort` int DEFAULT '0',
  `status` tinyint NOT NULL DEFAULT '1',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='WMS 商品分类表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `wms_item_sku` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_id` bigint NOT NULL,
  `bar_code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `length` decimal(10,1) DEFAULT NULL,
  `width` decimal(10,1) DEFAULT NULL,
  `height` decimal(10,1) DEFAULT NULL,
  `gross_weight` decimal(10,3) DEFAULT NULL,
  `net_weight` decimal(10,3) DEFAULT NULL,
  `cost_price` decimal(16,2) DEFAULT NULL,
  `selling_price` decimal(16,2) DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='WMS 商品 SKU 表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `wms_merchant` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` tinyint NOT NULL,
  `level` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_account` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(13) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telephone` varchar(13) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='WMS 往来企业表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `wms_movement_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `no` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_time` timestamp NOT NULL,
  `status` int NOT NULL DEFAULT '0',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_warehouse_id` bigint NOT NULL,
  `target_warehouse_id` bigint NOT NULL,
  `total_quantity` decimal(20,2) NOT NULL DEFAULT '0.00',
  `total_price` decimal(16,2) DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='WMS 移库单表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `wms_movement_order_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` bigint NOT NULL,
  `sku_id` bigint NOT NULL,
  `source_warehouse_id` bigint NOT NULL,
  `target_warehouse_id` bigint NOT NULL,
  `inventory_detail_id` bigint DEFAULT NULL,
  `batch_no` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `production_date` timestamp NULL DEFAULT NULL,
  `expiration_date` timestamp NULL DEFAULT NULL,
  `quantity` decimal(20,2) NOT NULL DEFAULT '0.00',
  `price` decimal(16,2) DEFAULT NULL,
  `total_price` decimal(16,2) DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='WMS 移库单明细表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `wms_receipt_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `no` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` int NOT NULL,
  `order_time` timestamp NOT NULL,
  `status` int NOT NULL DEFAULT '0',
  `biz_order_no` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `merchant_id` bigint DEFAULT NULL,
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `warehouse_id` bigint NOT NULL,
  `area_id` bigint NOT NULL DEFAULT '0',
  `total_quantity` decimal(20,2) NOT NULL DEFAULT '0.00',
  `total_price` decimal(16,2) DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='WMS 入库单表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `wms_receipt_order_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` bigint NOT NULL,
  `sku_id` bigint NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `area_id` bigint NOT NULL DEFAULT '0',
  `batch_no` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `production_date` timestamp NULL DEFAULT NULL,
  `expiration_date` timestamp NULL DEFAULT NULL,
  `quantity` decimal(20,2) NOT NULL DEFAULT '0.00',
  `price` decimal(16,2) DEFAULT NULL,
  `total_price` decimal(16,2) DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='WMS 入库单明细表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `wms_shipment_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `no` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` int NOT NULL,
  `order_time` timestamp NOT NULL,
  `status` int NOT NULL DEFAULT '0',
  `biz_order_no` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `merchant_id` bigint DEFAULT NULL,
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `warehouse_id` bigint NOT NULL,
  `area_id` bigint NOT NULL DEFAULT '0',
  `total_quantity` decimal(20,2) NOT NULL DEFAULT '0.00',
  `total_price` decimal(16,2) DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='WMS 出库单表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `wms_shipment_order_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` bigint NOT NULL,
  `sku_id` bigint NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `area_id` bigint NOT NULL DEFAULT '0',
  `inventory_detail_id` bigint DEFAULT NULL,
  `batch_no` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `production_date` timestamp NULL DEFAULT NULL,
  `expiration_date` timestamp NULL DEFAULT NULL,
  `quantity` decimal(20,2) NOT NULL DEFAULT '0.00',
  `price` decimal(16,2) DEFAULT NULL,
  `total_price` decimal(16,2) DEFAULT NULL,
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='WMS 出库单明细表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `wms_warehouse` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort` int DEFAULT '0',
  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` bit(1) NOT NULL DEFAULT b'0',
  `tenant_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='WMS 仓库表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;


SET FOREIGN_KEY_CHECKS = 1;
