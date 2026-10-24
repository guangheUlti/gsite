-- =====================================================================================
-- 光何企业管理平台（gsite）核心建库脚本
-- =====================================================================================
-- 内容：system_* / infra_* / guanghe_demo_* / qrtz_* 共 59 张表的结构与初始化数据
--       （含当前 2 个已启用模块：系统管理 system、基础设施 infra）。
--       会员中心 / IM / 数据报表等已裁剪模块的表不再包含。
--
-- 用法：
--   mysql -h 127.0.0.1 -uroot -proot -e "CREATE DATABASE IF NOT EXISTS gsite DEFAULT CHARACTER SET utf8mb4;"
--   mysql -h 127.0.0.1 -uroot -proot --default-character-set=utf8mb4 gsite < sql/mysql/gsite.sql
--
-- 默认账号：admin / admin
-- 本脚本可重复执行（先 DROP 后 CREATE）。
-- 生成方式：mysqldump 当前 59 张活跃表（排除已裁剪模块前缀），随 2026-10-13 双模块精简同步生成。
-- =====================================================================================

-- MySQL dump 10.13  Distrib 8.4.11, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: gsite
-- ------------------------------------------------------
-- Server version	8.4.11

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

--
-- Table structure for table `guanghe_demo01_contact`
--

DROP TABLE IF EXISTS `guanghe_demo01_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guanghe_demo01_contact` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '名字',
  `sex` tinyint(1) NOT NULL COMMENT '性别',
  `birthday` datetime NOT NULL COMMENT '出生年',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '简介',
  `avatar` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='示例联系人表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guanghe_demo01_contact`
--

LOCK TABLES `guanghe_demo01_contact` WRITE;
/*!40000 ALTER TABLE `guanghe_demo01_contact` DISABLE KEYS */;
INSERT INTO `guanghe_demo01_contact` VALUES (1,'土豆',2,'2023-11-07 00:00:00','<p>天蚕土豆！呀</p>','http://127.0.0.1:48080/admin-api/infra/file/4/get/46f8fa1a37db3f3960d8910ff2fe3962ab3b2db87cf2f8ccb4dc8145b8bdf237.jpeg','1','2023-11-15 23:34:30','1','2023-11-15 23:47:39',_binary '\0',1);
/*!40000 ALTER TABLE `guanghe_demo01_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guanghe_demo02_category`
--

DROP TABLE IF EXISTS `guanghe_demo02_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guanghe_demo02_category` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '名字',
  `parent_id` bigint NOT NULL COMMENT '父级编号',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='示例分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guanghe_demo02_category`
--

LOCK TABLES `guanghe_demo02_category` WRITE;
/*!40000 ALTER TABLE `guanghe_demo02_category` DISABLE KEYS */;
INSERT INTO `guanghe_demo02_category` VALUES (1,'土豆',0,'1','2023-11-15 23:34:30','1','2023-11-16 20:24:23',_binary '\0',1),(2,'番茄',0,'1','2023-11-16 20:24:00','1','2023-11-16 20:24:15',_binary '\0',1),(3,'怪怪',0,'1','2023-11-16 20:24:32','1','2023-11-16 20:24:32',_binary '\0',1),(4,'小番茄',2,'1','2023-11-16 20:24:39','1','2023-11-16 20:24:39',_binary '\0',1),(5,'大番茄',2,'1','2023-11-16 20:24:46','1','2023-11-16 20:24:46',_binary '\0',1),(6,'11',3,'1','2023-11-24 19:29:34','1','2023-11-24 19:29:34',_binary '\0',1),(7,'1',0,'1','2025-10-01 09:19:20','1','2025-10-01 09:19:20',_binary '\0',1);
/*!40000 ALTER TABLE `guanghe_demo02_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guanghe_demo03_course`
--

DROP TABLE IF EXISTS `guanghe_demo03_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guanghe_demo03_course` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `student_id` bigint NOT NULL COMMENT '学生编号',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '名字',
  `score` tinyint NOT NULL COMMENT '分数',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='学生课程表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guanghe_demo03_course`
--

LOCK TABLES `guanghe_demo03_course` WRITE;
/*!40000 ALTER TABLE `guanghe_demo03_course` DISABLE KEYS */;
INSERT INTO `guanghe_demo03_course` VALUES (2,2,'语文',66,'1','2023-11-16 23:21:49','1','2024-09-17 10:55:30',_binary '',1),(3,2,'数学',22,'1','2023-11-16 23:21:49','1','2024-09-17 10:55:30',_binary '',1),(6,5,'体育',23,'1','2023-11-16 23:22:46','1','2023-11-16 15:44:40',_binary '',1),(7,5,'计算机',11,'1','2023-11-16 23:22:46','1','2023-11-16 15:44:40',_binary '',1),(8,5,'体育',23,'1','2023-11-16 23:22:46','1','2023-11-16 15:47:09',_binary '',1),(9,5,'计算机',11,'1','2023-11-16 23:22:46','1','2023-11-16 15:47:09',_binary '',1),(10,5,'体育',23,'1','2023-11-16 23:22:46','1','2024-09-17 10:55:28',_binary '',1),(11,5,'计算机',11,'1','2023-11-16 23:22:46','1','2024-09-17 10:55:28',_binary '',1),(12,2,'电脑',33,'1','2023-11-17 00:20:42','1','2023-11-16 16:20:45',_binary '',1),(13,9,'滑雪',12,'1','2023-11-17 13:13:20','1','2024-09-17 10:55:26',_binary '',1),(14,9,'滑雪',12,'1','2023-11-17 13:13:20','1','2024-09-17 10:55:49',_binary '',1),(15,5,'体育',23,'1','2023-11-16 23:22:46','1','2024-09-17 18:55:29',_binary '\0',1),(16,5,'计算机',11,'1','2023-11-16 23:22:46','1','2024-09-17 18:55:29',_binary '\0',1),(17,2,'语文',66,'1','2023-11-16 23:21:49','1','2024-09-17 18:55:31',_binary '\0',1),(18,2,'数学',22,'1','2023-11-16 23:21:49','1','2024-09-17 18:55:31',_binary '\0',1),(19,9,'滑雪',12,'1','2023-11-17 13:13:20','1','2025-04-19 02:49:03',_binary '',1),(20,9,'滑雪',12,'1','2023-11-17 13:13:20','1','2026-06-27 08:42:44',_binary '\0',1);
/*!40000 ALTER TABLE `guanghe_demo03_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guanghe_demo03_grade`
--

DROP TABLE IF EXISTS `guanghe_demo03_grade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guanghe_demo03_grade` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `student_id` bigint NOT NULL COMMENT '学生编号',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '名字',
  `teacher` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '班主任',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='学生班级表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guanghe_demo03_grade`
--

LOCK TABLES `guanghe_demo03_grade` WRITE;
/*!40000 ALTER TABLE `guanghe_demo03_grade` DISABLE KEYS */;
INSERT INTO `guanghe_demo03_grade` VALUES (7,2,'三年 2 班','周杰伦','1','2023-11-16 23:21:49','1','2024-09-17 18:55:31',_binary '\0',1),(8,5,'华为','遥遥领先','1','2023-11-16 23:22:46','1','2024-09-17 18:55:29',_binary '\0',1),(9,9,'小图','小娃111','1','2023-11-17 13:10:23','1','2026-06-27 08:42:44',_binary '\0',1);
/*!40000 ALTER TABLE `guanghe_demo03_grade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guanghe_demo03_student`
--

DROP TABLE IF EXISTS `guanghe_demo03_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guanghe_demo03_student` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '名字',
  `sex` tinyint NOT NULL COMMENT '性别',
  `birthday` datetime NOT NULL COMMENT '出生日期',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '简介',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='学生表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guanghe_demo03_student`
--

LOCK TABLES `guanghe_demo03_student` WRITE;
/*!40000 ALTER TABLE `guanghe_demo03_student` DISABLE KEYS */;
INSERT INTO `guanghe_demo03_student` VALUES (2,'小白',1,'2023-11-16 00:00:00','<p>厉害</p>','1','2023-11-16 23:21:49','1','2024-09-17 18:55:31',_binary '\0',1),(5,'大黑',2,'2023-11-13 00:00:00','<p>你在教我做事?</p>','1','2023-11-16 23:22:46','1','2024-09-17 18:55:29',_binary '\0',1),(9,'小花',1,'2023-11-07 00:00:00','<p>哈哈哈</p>','1','2023-11-17 00:04:47','1','2026-06-27 08:42:44',_binary '\0',1);
/*!40000 ALTER TABLE `guanghe_demo03_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `infra_api_access_log`
--

DROP TABLE IF EXISTS `infra_api_access_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `infra_api_access_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `trace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '链路追踪编号',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT '用户编号',
  `user_type` tinyint NOT NULL DEFAULT '0' COMMENT '用户类型',
  `application_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用名',
  `request_method` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '请求方法名',
  `request_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '请求地址',
  `request_params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '请求参数',
  `response_body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '响应结果',
  `user_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户 IP',
  `user_agent` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '浏览器 UA',
  `operate_module` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '操作模块',
  `operate_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '操作名',
  `operate_type` tinyint DEFAULT '0' COMMENT '操作分类',
  `begin_time` datetime NOT NULL COMMENT '开始请求时间',
  `end_time` datetime NOT NULL COMMENT '结束请求时间',
  `duration` int NOT NULL COMMENT '执行时长',
  `result_code` int NOT NULL DEFAULT '0' COMMENT '结果码',
  `result_msg` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '结果提示',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=36369 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='API 访问日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `infra_api_access_log`
--

LOCK TABLES `infra_api_access_log` WRITE;
/*!40000 ALTER TABLE `infra_api_access_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `infra_api_access_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `infra_api_error_log`
--

DROP TABLE IF EXISTS `infra_api_error_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `infra_api_error_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `trace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '链路追踪编号',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT '用户编号',
  `user_type` tinyint NOT NULL DEFAULT '0' COMMENT '用户类型',
  `application_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用名',
  `request_method` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '请求方法名',
  `request_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '请求地址',
  `request_params` varchar(8000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '请求参数',
  `user_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户 IP',
  `user_agent` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '浏览器 UA',
  `exception_time` datetime NOT NULL COMMENT '异常发生时间',
  `exception_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '异常名',
  `exception_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常导致的消息',
  `exception_root_cause_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常导致的根消息',
  `exception_stack_trace` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常的栈轨迹',
  `exception_class_name` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常发生的类全名',
  `exception_file_name` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常发生的类文件',
  `exception_method_name` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常发生的方法名',
  `exception_line_number` int NOT NULL COMMENT '异常发生的方法所在行',
  `process_status` tinyint NOT NULL COMMENT '处理状态',
  `process_time` datetime DEFAULT NULL COMMENT '处理时间',
  `process_user_id` int DEFAULT '0' COMMENT '处理用户编号',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=25897 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统异常日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `infra_api_error_log`
--

LOCK TABLES `infra_api_error_log` WRITE;
/*!40000 ALTER TABLE `infra_api_error_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `infra_api_error_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `infra_codegen_column`
--

DROP TABLE IF EXISTS `infra_codegen_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `infra_codegen_column` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NOT NULL COMMENT '表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '字段名',
  `data_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '字段类型',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '字段描述',
  `nullable` bit(1) NOT NULL COMMENT '是否允许为空',
  `primary_key` bit(1) NOT NULL COMMENT '是否主键',
  `ordinal_position` int NOT NULL COMMENT '排序',
  `java_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Java 属性类型',
  `java_field` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Java 属性名',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '字典类型',
  `example` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '数据示例',
  `create_operation` bit(1) NOT NULL COMMENT '是否为 Create 创建操作的字段',
  `update_operation` bit(1) NOT NULL COMMENT '是否为 Update 更新操作的字段',
  `list_operation` bit(1) NOT NULL COMMENT '是否为 List 查询操作的字段',
  `list_operation_condition` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '=' COMMENT 'List 查询操作的条件类型',
  `list_operation_result` bit(1) NOT NULL COMMENT '是否为 List 查询操作的返回字段',
  `html_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '显示类型',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_table_id` (`table_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2880 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='代码生成表字段定义';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `infra_codegen_column`
--

LOCK TABLES `infra_codegen_column` WRITE;
/*!40000 ALTER TABLE `infra_codegen_column` DISABLE KEYS */;
/*!40000 ALTER TABLE `infra_codegen_column` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `infra_codegen_table`
--

DROP TABLE IF EXISTS `infra_codegen_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `infra_codegen_table` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `data_source_config_id` bigint NOT NULL COMMENT '数据源配置的编号',
  `scene` tinyint NOT NULL DEFAULT '1' COMMENT '生成场景',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '表描述',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '业务名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '类名称',
  `class_comment` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '类描述',
  `author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '作者',
  `template_type` tinyint NOT NULL DEFAULT '1' COMMENT '模板类型',
  `front_type` tinyint NOT NULL COMMENT '前端类型',
  `parent_menu_id` bigint DEFAULT NULL COMMENT '父菜单编号',
  `master_table_id` bigint DEFAULT NULL COMMENT '主表的编号',
  `sub_join_column_id` bigint DEFAULT NULL COMMENT '子表关联主表的字段编号',
  `sub_join_many` bit(1) DEFAULT NULL COMMENT '主表与子表是否一对多',
  `tree_parent_column_id` bigint DEFAULT NULL COMMENT '树表的父字段编号',
  `tree_name_column_id` bigint DEFAULT NULL COMMENT '树表的名字字段编号',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=210 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='代码生成表定义';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `infra_codegen_table`
--

LOCK TABLES `infra_codegen_table` WRITE;
/*!40000 ALTER TABLE `infra_codegen_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `infra_codegen_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `infra_config`
--

DROP TABLE IF EXISTS `infra_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `infra_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参数分组',
  `type` tinyint NOT NULL COMMENT '参数类型',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '参数键名',
  `value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '参数键值',
  `visible` bit(1) NOT NULL COMMENT '是否可见',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_config_key` (`config_key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='参数配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `infra_config`
--

LOCK TABLES `infra_config` WRITE;
/*!40000 ALTER TABLE `infra_config` DISABLE KEYS */;
INSERT INTO `infra_config` VALUES (2,'biz',1,'用户管理-账号初始密码','system.user.init-password','123456',_binary '\0','初始化密码 123456','admin','2021-01-05 17:03:48','1','2024-07-20 17:22:47',_binary '\0');
INSERT INTO `infra_config` VALUES (7,'url',2,'MySQL 监控的地址','url.druid','',_binary '','','1','2023-04-07 13:41:16','1','2023-04-07 14:33:38',_binary '\0');
INSERT INTO `infra_config` VALUES (8,'url',2,'SkyWalking 监控的地址','url.skywalking','',_binary '','','1','2023-04-07 13:41:16','1','2023-04-07 14:57:03',_binary '\0');
INSERT INTO `infra_config` VALUES (9,'url',2,'Spring Boot Admin 监控的地址','url.spring-boot-admin','',_binary '','','1','2023-04-07 13:41:16','1','2023-04-07 14:52:07',_binary '\0');
INSERT INTO `infra_config` VALUES (10,'url',2,'Swagger 接口文档的地址','url.swagger','',_binary '','','1','2023-04-07 13:41:16','1','2023-04-07 14:59:00',_binary '\0');
INSERT INTO `infra_config` VALUES (13,'biz',2,'用户管理-注册开关','system.user.register-enabled','true',_binary '\0','','1','2025-04-26 17:23:41','admin','2026-01-05 09:00:00',_binary '\0');
/*!40000 ALTER TABLE `infra_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `infra_data_source_config`
--

DROP TABLE IF EXISTS `infra_data_source_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `infra_data_source_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键编号',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '参数名称',
  `url` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '数据源连接',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='数据源配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `infra_data_source_config`
--

LOCK TABLES `infra_data_source_config` WRITE;
/*!40000 ALTER TABLE `infra_data_source_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `infra_data_source_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `infra_file`
--

DROP TABLE IF EXISTS `infra_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `infra_file` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '文件编号',
  `config_id` bigint DEFAULT NULL COMMENT '配置编号',
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文件名',
  `path` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件路径',
  `url` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件 URL',
  `type` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文件类型',
  `size` int NOT NULL COMMENT '文件大小',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2280 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `infra_file`
--

LOCK TABLES `infra_file` WRITE;
/*!40000 ALTER TABLE `infra_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `infra_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `infra_file_config`
--

DROP TABLE IF EXISTS `infra_file_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `infra_file_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置名',
  `storage` tinyint NOT NULL COMMENT '存储器',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `master` bit(1) NOT NULL COMMENT '是否为主配置',
  `config` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '存储配置',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文件配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `infra_file_config`
--

LOCK TABLES `infra_file_config` WRITE;
/*!40000 ALTER TABLE `infra_file_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `infra_file_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `infra_file_content`
--

DROP TABLE IF EXISTS `infra_file_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `infra_file_content` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `config_id` bigint NOT NULL COMMENT '配置编号',
  `path` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件路径',
  `content` mediumblob NOT NULL COMMENT '文件内容',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_config_id_path` (`config_id`,`path`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=288 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `infra_file_content`
--

LOCK TABLES `infra_file_content` WRITE;
/*!40000 ALTER TABLE `infra_file_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `infra_file_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `infra_job`
--

DROP TABLE IF EXISTS `infra_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `infra_job` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务编号',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '任务名称',
  `status` tinyint NOT NULL COMMENT '任务状态',
  `handler_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '处理器的名字',
  `handler_param` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '处理器的参数',
  `cron_expression` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'CRON 表达式',
  `retry_count` int NOT NULL DEFAULT '0' COMMENT '重试次数',
  `retry_interval` int NOT NULL DEFAULT '0' COMMENT '重试间隔',
  `monitor_timeout` int NOT NULL DEFAULT '0' COMMENT '监控超时时间',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12904 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='定时任务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `infra_job`
--

LOCK TABLES `infra_job` WRITE;
/*!40000 ALTER TABLE `infra_job` DISABLE KEYS */;
INSERT INTO `infra_job` VALUES (25,'访问日志清理 Job',2,'accessLogCleanJob','','0 0 0 * * ?',3,0,0,'1','2023-10-03 10:59:41','1','2023-10-03 11:01:10',_binary '\0');
INSERT INTO `infra_job` VALUES (26,'错误日志清理 Job',2,'errorLogCleanJob','','0 0 0 * * ?',3,0,0,'1','2023-10-03 11:00:43','1','2023-10-03 11:01:12',_binary '\0');
INSERT INTO `infra_job` VALUES (27,'任务日志清理 Job',2,'jobLogCleanJob','','0 0 0 * * ?',3,0,0,'1','2023-10-03 11:01:33','1','2024-09-12 13:40:34',_binary '\0');
/*!40000 ALTER TABLE `infra_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `infra_job_log`
--

DROP TABLE IF EXISTS `infra_job_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `infra_job_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志编号',
  `job_id` bigint NOT NULL COMMENT '任务编号',
  `handler_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '处理器的名字',
  `handler_param` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '处理器的参数',
  `execute_index` tinyint NOT NULL DEFAULT '1' COMMENT '第几次执行',
  `begin_time` datetime NOT NULL COMMENT '开始执行时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束执行时间',
  `duration` int DEFAULT NULL COMMENT '执行时长',
  `status` tinyint NOT NULL COMMENT '任务状态',
  `result` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '结果数据',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_job_id` (`job_id`) USING BTREE,
  KEY `idx_create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=44329 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='定时任务日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `infra_job_log`
--

LOCK TABLES `infra_job_log` WRITE;
/*!40000 ALTER TABLE `infra_job_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `infra_job_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_blob_triggers`
--

DROP TABLE IF EXISTS `qrtz_blob_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_blob_triggers` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `TRIGGER_NAME` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `TRIGGER_GROUP` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  KEY `SCHED_NAME` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_blob_triggers`
--

LOCK TABLES `qrtz_blob_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_blob_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_blob_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_calendars`
--

DROP TABLE IF EXISTS `qrtz_calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_calendars` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `CALENDAR_NAME` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_calendars`
--

LOCK TABLES `qrtz_calendars` WRITE;
/*!40000 ALTER TABLE `qrtz_calendars` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_calendars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_cron_triggers`
--

DROP TABLE IF EXISTS `qrtz_cron_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_cron_triggers` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `TRIGGER_NAME` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `TRIGGER_GROUP` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `CRON_EXPRESSION` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `TIME_ZONE_ID` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_cron_triggers`
--

LOCK TABLES `qrtz_cron_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_cron_triggers` DISABLE KEYS */;
INSERT INTO `qrtz_cron_triggers` VALUES ('schedulerName','accessLogCleanJob','DEFAULT','0 0 0 * * ?','Asia/Shanghai'),('schedulerName','brokerageRecordUnfreezeJob','DEFAULT','0 * * * * ?','Asia/Shanghai'),('schedulerName','errorLogCleanJob','DEFAULT','0 0 0 * * ?','Asia/Shanghai'),('schedulerName','jobLogCleanJob','DEFAULT','0 0 0 * * ?','Asia/Shanghai'),('schedulerName','payNotifyJob','DEFAULT','* * * * * ?','Asia/Shanghai'),('schedulerName','payOrderExpireJob','DEFAULT','0 0/1 * * * ?','Asia/Shanghai'),('schedulerName','payOrderSyncJob','DEFAULT','0 0/1 * * * ?','Asia/Shanghai'),('schedulerName','payRefundSyncJob','DEFAULT','0 0/1 * * * ?','Asia/Shanghai'),('schedulerName','tradeOrderAutoCancelJob','DEFAULT','0 * * * * ?','Asia/Shanghai'),('schedulerName','tradeOrderAutoCommentJob','DEFAULT','0 * * * * ?','Asia/Shanghai'),('schedulerName','tradeOrderAutoReceiveJob','DEFAULT','0 * * * * ?','Asia/Shanghai');
/*!40000 ALTER TABLE `qrtz_cron_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_fired_triggers`
--

DROP TABLE IF EXISTS `qrtz_fired_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_fired_triggers` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ENTRY_ID` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `TRIGGER_NAME` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `TRIGGER_GROUP` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `INSTANCE_NAME` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `FIRED_TIME` bigint NOT NULL,
  `SCHED_TIME` bigint NOT NULL,
  `PRIORITY` int NOT NULL,
  `STATE` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `JOB_NAME` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `JOB_GROUP` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`) USING BTREE,
  KEY `IDX_QRTZ_FT_TRIG_INST_NAME` (`SCHED_NAME`,`INSTANCE_NAME`) USING BTREE,
  KEY `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY` (`SCHED_NAME`,`INSTANCE_NAME`,`REQUESTS_RECOVERY`) USING BTREE,
  KEY `IDX_QRTZ_FT_J_G` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`) USING BTREE,
  KEY `IDX_QRTZ_FT_JG` (`SCHED_NAME`,`JOB_GROUP`) USING BTREE,
  KEY `IDX_QRTZ_FT_T_G` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  KEY `IDX_QRTZ_FT_TG` (`SCHED_NAME`,`TRIGGER_GROUP`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_fired_triggers`
--

LOCK TABLES `qrtz_fired_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_fired_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_fired_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_job_details`
--

DROP TABLE IF EXISTS `qrtz_job_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_job_details` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `JOB_NAME` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `JOB_GROUP` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `IS_DURABLE` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `IS_UPDATE_DATA` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`) USING BTREE,
  KEY `IDX_QRTZ_J_REQ_RECOVERY` (`SCHED_NAME`,`REQUESTS_RECOVERY`) USING BTREE,
  KEY `IDX_QRTZ_J_GRP` (`SCHED_NAME`,`JOB_GROUP`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_job_details`
--

LOCK TABLES `qrtz_job_details` WRITE;
/*!40000 ALTER TABLE `qrtz_job_details` DISABLE KEYS */;
INSERT INTO `qrtz_job_details` VALUES ('schedulerName','accessLogCleanJob','DEFAULT',NULL,'guanghe.gsite.framework.quartz.core.handler.JobHandlerInvoker','0','1','1','0',_binary '�\�\0sr\0org.quartz.JobDataMap���迩�\�\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�\�\��\�](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap\�.�(v\n\�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap\��\�`\�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0JOB_IDsr\0java.lang.Long;�\�̏#\�\0J\0valuexr\0java.lang.Number����\��\0\0xp\0\0\0\0\0\0\0t\0JOB_HANDLER_NAMEt\0accessLogCleanJobx\0'),('schedulerName','brokerageRecordUnfreezeJob','DEFAULT',NULL,'guanghe.gsite.framework.quartz.core.handler.JobHandlerInvoker','0','1','1','0',_binary '�\�\0sr\0org.quartz.JobDataMap���迩�\�\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�\�\��\�](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap\�.�(v\n\�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap\��\�`\�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0JOB_IDsr\0java.lang.Long;�\�̏#\�\0J\0valuexr\0java.lang.Number����\��\0\0xp\0\0\0\0\0\0\0t\0JOB_HANDLER_NAMEt\0\ZbrokerageRecordUnfreezeJobx\0'),('schedulerName','errorLogCleanJob','DEFAULT',NULL,'guanghe.gsite.framework.quartz.core.handler.JobHandlerInvoker','0','1','1','0',_binary '�\�\0sr\0org.quartz.JobDataMap���迩�\�\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�\�\��\�](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap\�.�(v\n\�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap\��\�`\�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0JOB_IDsr\0java.lang.Long;�\�̏#\�\0J\0valuexr\0java.lang.Number����\��\0\0xp\0\0\0\0\0\0\0\Zt\0JOB_HANDLER_NAMEt\0errorLogCleanJobx\0'),('schedulerName','jobLogCleanJob','DEFAULT',NULL,'guanghe.gsite.framework.quartz.core.handler.JobHandlerInvoker','0','1','1','0',_binary '�\�\0sr\0org.quartz.JobDataMap���迩�\�\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�\�\��\�](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap\�.�(v\n\�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap\��\�`\�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0JOB_IDsr\0java.lang.Long;�\�̏#\�\0J\0valuexr\0java.lang.Number����\��\0\0xp\0\0\0\0\0\0\0t\0JOB_HANDLER_NAMEt\0jobLogCleanJobx\0'),('schedulerName','payNotifyJob','DEFAULT',NULL,'guanghe.gsite.framework.quartz.core.handler.JobHandlerInvoker','0','1','1','0',_binary '�\�\0sr\0org.quartz.JobDataMap���迩�\�\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�\�\��\�](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap\�.�(v\n\�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap\��\�`\�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0JOB_IDsr\0java.lang.Long;�\�̏#\�\0J\0valuexr\0java.lang.Number����\��\0\0xp\0\0\0\0\0\0\0t\0JOB_HANDLER_NAMEt\0payNotifyJobx\0'),('schedulerName','payOrderExpireJob','DEFAULT',NULL,'guanghe.gsite.framework.quartz.core.handler.JobHandlerInvoker','0','1','1','0',_binary '�\�\0sr\0org.quartz.JobDataMap���迩�\�\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�\�\��\�](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap\�.�(v\n\�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap\��\�`\�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0JOB_IDsr\0java.lang.Long;�\�̏#\�\0J\0valuexr\0java.lang.Number����\��\0\0xp\0\0\0\0\0\0\0t\0JOB_HANDLER_NAMEt\0payOrderExpireJobx\0'),('schedulerName','payOrderSyncJob','DEFAULT',NULL,'guanghe.gsite.framework.quartz.core.handler.JobHandlerInvoker','0','1','1','0',_binary '�\�\0sr\0org.quartz.JobDataMap���迩�\�\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�\�\��\�](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap\�.�(v\n\�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap\��\�`\�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0JOB_IDsr\0java.lang.Long;�\�̏#\�\0J\0valuexr\0java.lang.Number����\��\0\0xp\0\0\0\0\0\0\0t\0JOB_HANDLER_NAMEt\0payOrderSyncJobx\0'),('schedulerName','payRefundSyncJob','DEFAULT',NULL,'guanghe.gsite.framework.quartz.core.handler.JobHandlerInvoker','0','1','1','0',_binary '�\�\0sr\0org.quartz.JobDataMap���迩�\�\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�\�\��\�](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap\�.�(v\n\�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap\��\�`\�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0JOB_IDsr\0java.lang.Long;�\�̏#\�\0J\0valuexr\0java.lang.Number����\��\0\0xp\0\0\0\0\0\0\0t\0JOB_HANDLER_NAMEt\0payRefundSyncJobx\0'),('schedulerName','tradeOrderAutoCancelJob','DEFAULT',NULL,'guanghe.gsite.framework.quartz.core.handler.JobHandlerInvoker','0','1','1','0',_binary '�\�\0sr\0org.quartz.JobDataMap���迩�\�\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�\�\��\�](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap\�.�(v\n\�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap\��\�`\�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0JOB_IDsr\0java.lang.Long;�\�̏#\�\0J\0valuexr\0java.lang.Number����\��\0\0xp\0\0\0\0\0\0\0t\0JOB_HANDLER_NAMEt\0tradeOrderAutoCancelJobx\0'),('schedulerName','tradeOrderAutoCommentJob','DEFAULT',NULL,'guanghe.gsite.framework.quartz.core.handler.JobHandlerInvoker','0','1','1','0',_binary '�\�\0sr\0org.quartz.JobDataMap���迩�\�\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�\�\��\�](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap\�.�(v\n\�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap\��\�`\�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0JOB_IDsr\0java.lang.Long;�\�̏#\�\0J\0valuexr\0java.lang.Number����\��\0\0xp\0\0\0\0\0\0\0t\0JOB_HANDLER_NAMEt\0tradeOrderAutoCommentJobx\0'),('schedulerName','tradeOrderAutoReceiveJob','DEFAULT',NULL,'guanghe.gsite.framework.quartz.core.handler.JobHandlerInvoker','0','1','1','0',_binary '�\�\0sr\0org.quartz.JobDataMap���迩�\�\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�\�\��\�](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap\�.�(v\n\�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap\��\�`\�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0JOB_IDsr\0java.lang.Long;�\�̏#\�\0J\0valuexr\0java.lang.Number����\��\0\0xp\0\0\0\0\0\0\0t\0JOB_HANDLER_NAMEt\0tradeOrderAutoReceiveJobx\0');
/*!40000 ALTER TABLE `qrtz_job_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_locks`
--

DROP TABLE IF EXISTS `qrtz_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_locks` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `LOCK_NAME` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_locks`
--

LOCK TABLES `qrtz_locks` WRITE;
/*!40000 ALTER TABLE `qrtz_locks` DISABLE KEYS */;
INSERT INTO `qrtz_locks` VALUES ('iotScheduler','STATE_ACCESS'),('schedulerName','STATE_ACCESS'),('schedulerName','TRIGGER_ACCESS');
/*!40000 ALTER TABLE `qrtz_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_paused_trigger_grps`
--

DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `TRIGGER_GROUP` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_paused_trigger_grps`
--

LOCK TABLES `qrtz_paused_trigger_grps` WRITE;
/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_scheduler_state`
--

DROP TABLE IF EXISTS `qrtz_scheduler_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_scheduler_state` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `INSTANCE_NAME` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `LAST_CHECKIN_TIME` bigint NOT NULL,
  `CHECKIN_INTERVAL` bigint NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_scheduler_state`
--

LOCK TABLES `qrtz_scheduler_state` WRITE;
/*!40000 ALTER TABLE `qrtz_scheduler_state` DISABLE KEYS */;
INSERT INTO `qrtz_scheduler_state` VALUES ('iotScheduler','PURE-20260725TM1788039863575',1788039878625,15000),('schedulerName','MacBook-Pro.local1713489703551',1713742509534,15000);
/*!40000 ALTER TABLE `qrtz_scheduler_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_simple_triggers`
--

DROP TABLE IF EXISTS `qrtz_simple_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_simple_triggers` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `TRIGGER_NAME` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `TRIGGER_GROUP` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `REPEAT_COUNT` bigint NOT NULL,
  `REPEAT_INTERVAL` bigint NOT NULL,
  `TIMES_TRIGGERED` bigint NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_simple_triggers`
--

LOCK TABLES `qrtz_simple_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_simple_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_simple_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_simprop_triggers`
--

DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_simprop_triggers` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `TRIGGER_NAME` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `TRIGGER_GROUP` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `STR_PROP_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `STR_PROP_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `STR_PROP_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `INT_PROP_1` int DEFAULT NULL,
  `INT_PROP_2` int DEFAULT NULL,
  `LONG_PROP_1` bigint DEFAULT NULL,
  `LONG_PROP_2` bigint DEFAULT NULL,
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_simprop_triggers`
--

LOCK TABLES `qrtz_simprop_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_simprop_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_simprop_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_triggers`
--

DROP TABLE IF EXISTS `qrtz_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_triggers` (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `TRIGGER_NAME` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `TRIGGER_GROUP` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `JOB_NAME` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `JOB_GROUP` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint DEFAULT NULL,
  `PREV_FIRE_TIME` bigint DEFAULT NULL,
  `PRIORITY` int DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `TRIGGER_TYPE` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `START_TIME` bigint NOT NULL,
  `END_TIME` bigint DEFAULT NULL,
  `CALENDAR_NAME` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MISFIRE_INSTR` smallint DEFAULT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  KEY `IDX_QRTZ_T_J` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`) USING BTREE,
  KEY `IDX_QRTZ_T_JG` (`SCHED_NAME`,`JOB_GROUP`) USING BTREE,
  KEY `IDX_QRTZ_T_C` (`SCHED_NAME`,`CALENDAR_NAME`) USING BTREE,
  KEY `IDX_QRTZ_T_G` (`SCHED_NAME`,`TRIGGER_GROUP`) USING BTREE,
  KEY `IDX_QRTZ_T_STATE` (`SCHED_NAME`,`TRIGGER_STATE`) USING BTREE,
  KEY `IDX_QRTZ_T_N_STATE` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`) USING BTREE,
  KEY `IDX_QRTZ_T_N_G_STATE` (`SCHED_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`) USING BTREE,
  KEY `IDX_QRTZ_T_NEXT_FIRE_TIME` (`SCHED_NAME`,`NEXT_FIRE_TIME`) USING BTREE,
  KEY `IDX_QRTZ_T_NFT_ST` (`SCHED_NAME`,`TRIGGER_STATE`,`NEXT_FIRE_TIME`) USING BTREE,
  KEY `IDX_QRTZ_T_NFT_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`) USING BTREE,
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_STATE`) USING BTREE,
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_GROUP`,`TRIGGER_STATE`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_triggers`
--

LOCK TABLES `qrtz_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_triggers` DISABLE KEYS */;
INSERT INTO `qrtz_triggers` VALUES ('schedulerName','accessLogCleanJob','DEFAULT','accessLogCleanJob','DEFAULT',NULL,1696348800000,-1,5,'PAUSED','CRON',1696301981000,0,NULL,0,_binary '�\�\0sr\0org.quartz.JobDataMap���迩�\�\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�\�\��\�](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap\�.�(v\n\�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap\��\�`\�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0JOB_HANDLER_PARAMt\0\0t\0JOB_RETRY_INTERVALsr\0java.lang.Integer⠤\���8\0I\0valuexr\0java.lang.Number����\��\0\0xp\0\0\0\0t\0JOB_RETRY_COUNTsq\0~\0\n\0\0\0x\0'),('schedulerName','brokerageRecordUnfreezeJob','DEFAULT','brokerageRecordUnfreezeJob','DEFAULT',NULL,1695909720000,-1,5,'PAUSED','CRON',1695909706000,0,NULL,0,_binary '�\�\0sr\0org.quartz.JobDataMap���迩�\�\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�\�\��\�](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap\�.�(v\n\�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap\��\�`\�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0JOB_HANDLER_PARAMt\0\0t\0JOB_RETRY_INTERVALsr\0java.lang.Integer⠤\���8\0I\0valuexr\0java.lang.Number����\��\0\0xp\0\0\0\0t\0JOB_RETRY_COUNTsq\0~\0\n\0\0\0x\0'),('schedulerName','errorLogCleanJob','DEFAULT','errorLogCleanJob','DEFAULT',NULL,1696348800000,-1,5,'PAUSED','CRON',1696302043000,0,NULL,0,_binary '�\�\0sr\0org.quartz.JobDataMap���迩�\�\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�\�\��\�](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap\�.�(v\n\�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap\��\�`\�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0JOB_HANDLER_PARAMt\0\0t\0JOB_RETRY_INTERVALsr\0java.lang.Integer⠤\���8\0I\0valuexr\0java.lang.Number����\��\0\0xp\0\0\0\0t\0JOB_RETRY_COUNTsq\0~\0\n\0\0\0x\0'),('schedulerName','jobLogCleanJob','DEFAULT','jobLogCleanJob','DEFAULT',NULL,1696348800000,-1,5,'PAUSED','CRON',1696302092000,0,NULL,0,_binary '�\�\0sr\0org.quartz.JobDataMap���迩�\�\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�\�\��\�](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap\�.�(v\n\�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap\��\�`\�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0JOB_HANDLER_PARAMt\0\0t\0JOB_RETRY_INTERVALsr\0java.lang.Integer⠤\���8\0I\0valuexr\0java.lang.Number����\��\0\0xp\0\0\0\0t\0JOB_RETRY_COUNTsq\0~\0\n\0\0\0x\0'),('schedulerName','payNotifyJob','DEFAULT','payNotifyJob','DEFAULT',NULL,1688907102000,1688907101000,5,'PAUSED','CRON',1635294882000,0,NULL,0,_binary '�\�\0sr\0org.quartz.JobDataMap���迩�\�\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�\�\��\�](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap\�.�(v\n\�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap\��\�`\�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0JOB_HANDLER_PARAMpt\0JOB_RETRY_INTERVALsr\0java.lang.Integer⠤\���8\0I\0valuexr\0java.lang.Number����\��\0\0xp\0\0\0\0t\0JOB_RETRY_COUNTq\0~\0x\0'),('schedulerName','payOrderExpireJob','DEFAULT','payOrderExpireJob','DEFAULT',NULL,1690011600000,-1,5,'PAUSED','CRON',1690011553000,0,NULL,0,_binary '�\�\0sr\0org.quartz.JobDataMap���迩�\�\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�\�\��\�](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap\�.�(v\n\�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap\��\�`\�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0JOB_HANDLER_PARAMpt\0JOB_RETRY_INTERVALsr\0java.lang.Integer⠤\���8\0I\0valuexr\0java.lang.Number����\��\0\0xp\0\0\0\0t\0JOB_RETRY_COUNTq\0~\0x\0'),('schedulerName','payOrderSyncJob','DEFAULT','payOrderSyncJob','DEFAULT',NULL,1690011600000,1690011540000,5,'PAUSED','CRON',1690007785000,0,NULL,0,_binary '�\�\0sr\0org.quartz.JobDataMap���迩�\�\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�\�\��\�](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap\�.�(v\n\�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap\��\�`\�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0JOB_HANDLER_PARAMpt\0JOB_RETRY_INTERVALsr\0java.lang.Integer⠤\���8\0I\0valuexr\0java.lang.Number����\��\0\0xp\0\0\0\0t\0JOB_RETRY_COUNTq\0~\0x\0'),('schedulerName','payRefundSyncJob','DEFAULT','payRefundSyncJob','DEFAULT',NULL,1690117560000,1690117500000,5,'PAUSED','CRON',1690117424000,0,NULL,0,_binary '�\�\0sr\0org.quartz.JobDataMap���迩�\�\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�\�\��\�](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap\�.�(v\n\�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap\��\�`\�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0JOB_HANDLER_PARAMpt\0JOB_RETRY_INTERVALsr\0java.lang.Integer⠤\���8\0I\0valuexr\0java.lang.Number����\��\0\0xp\0\0\0\0t\0JOB_RETRY_COUNTq\0~\0x\0'),('schedulerName','tradeOrderAutoCancelJob','DEFAULT','tradeOrderAutoCancelJob','DEFAULT',NULL,1695727440000,1695727380000,5,'PAUSED','CRON',1695656605000,0,NULL,0,_binary '�\�\0sr\0org.quartz.JobDataMap���迩�\�\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�\�\��\�](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap\�.�(v\n\�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap\��\�`\�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0JOB_HANDLER_PARAMt\0\0t\0JOB_RETRY_INTERVALsr\0java.lang.Integer⠤\���8\0I\0valuexr\0java.lang.Number����\��\0\0xp\0\0\0\0t\0JOB_RETRY_COUNTsq\0~\0\n\0\0\0x\0'),('schedulerName','tradeOrderAutoCommentJob','DEFAULT','tradeOrderAutoCommentJob','DEFAULT',NULL,1695783840000,1695783780000,5,'PAUSED','CRON',1695742709000,0,NULL,0,_binary '�\�\0sr\0org.quartz.JobDataMap���迩�\�\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�\�\��\�](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap\�.�(v\n\�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap\��\�`\�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0JOB_HANDLER_PARAMt\0\0t\0JOB_RETRY_INTERVALsr\0java.lang.Integer⠤\���8\0I\0valuexr\0java.lang.Number����\��\0\0xp\0\0\0\0t\0JOB_RETRY_COUNTsq\0~\0\n\0\0\0x\0'),('schedulerName','tradeOrderAutoReceiveJob','DEFAULT','tradeOrderAutoReceiveJob','DEFAULT',NULL,1695742740000,1695742680000,5,'PAUSED','CRON',1695727433000,0,NULL,0,_binary '�\�\0sr\0org.quartz.JobDataMap���迩�\�\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�\�\��\�](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap\�.�(v\n\�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap\��\�`\�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0JOB_HANDLER_PARAMt\0\0t\0JOB_RETRY_INTERVALsr\0java.lang.Integer⠤\���8\0I\0valuexr\0java.lang.Number����\��\0\0xp\0\0\0\0t\0JOB_RETRY_COUNTsq\0~\0\n\0\0\0x\0');
/*!40000 ALTER TABLE `qrtz_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_dept`
--

DROP TABLE IF EXISTS `system_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_dept` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '部门名称',
  `parent_id` bigint NOT NULL DEFAULT '0' COMMENT '父部门id',
  `sort` int NOT NULL DEFAULT '0' COMMENT '显示顺序',
  `leader_user_id` bigint DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `status` tinyint NOT NULL COMMENT '部门状态（0正常 1停用）',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='部门表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_dept`
--

LOCK TABLES `system_dept` WRITE;
/*!40000 ALTER TABLE `system_dept` DISABLE KEYS */;
INSERT INTO `system_dept` VALUES
(100,'光何集团',0,0,1001,'01086000000','hr@guanghe.com.cn',0,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(101,'集团总部（北京）',100,1,1001,'01086000001','hq@guanghe.com.cn',0,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(110,'研发中心',101,1,1005,'01086001100','rd@guanghe.com.cn',0,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(111,'平台研发部',110,1,1006,'01086001101','platform@guanghe.com.cn',0,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(112,'应用研发部',110,2,1008,'01086001102','app@guanghe.com.cn',0,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(113,'前端研发部',110,3,1010,'01086001103','frontend@guanghe.com.cn',0,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(114,'测试部',110,4,1012,'01086001104','qa@guanghe.com.cn',0,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(115,'产品部',101,2,1014,'01086001200','product@guanghe.com.cn',0,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(116,'运维部',101,3,1016,'01086001300','ops@guanghe.com.cn',0,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(117,'市场部',101,4,1017,'01086001400','marketing@guanghe.com.cn',0,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(118,'销售部',101,5,1018,'01086001500','sales@guanghe.com.cn',0,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(119,'客户服务部',101,6,1019,'01086001600','service@guanghe.com.cn',0,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(120,'财务部',101,7,1003,'01086001700','finance@guanghe.com.cn',0,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(121,'人力资源部',101,8,1002,'01086001800','hr@guanghe.com.cn',0,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(122,'行政部',101,9,1004,'01086001900','admin@guanghe.com.cn',0,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(102,'光何科技（上海）有限公司',100,2,1022,'02188000200','shanghai@guanghe.com.cn',0,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(130,'上海研发部',102,1,1020,'02188000210','sh-rd@guanghe.com.cn',0,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(131,'上海交付部',102,2,1022,'02188000220','delivery@guanghe.com.cn',0,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(132,'上海市场部',102,3,1023,'02188000230','sh-sales@guanghe.com.cn',0,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1);
/*!40000 ALTER TABLE `system_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_dict_data`
--

DROP TABLE IF EXISTS `system_dict_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_dict_data` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `sort` int NOT NULL DEFAULT '0' COMMENT '字典排序',
  `label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '字典标签',
  `value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '字典类型',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `color_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '颜色类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'css 样式',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1292 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='字典数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_dict_data`
--

LOCK TABLES `system_dict_data` WRITE;
/*!40000 ALTER TABLE `system_dict_data` DISABLE KEYS */;
INSERT INTO `system_dict_data` VALUES (1,1,'男','1','system_user_sex',0,'primary','A','性别男','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (2,2,'女','2','system_user_sex',0,'success','','性别女','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (3,1,'正常','1','infra_job_status',0,'success','','正常状态','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (4,2,'暂停','2','infra_job_status',0,'danger','','停用状态','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (5,1,'系统内置','1','infra_config_type',0,'danger','','参数类型 - 系统内置','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (6,2,'自定义','2','infra_config_type',0,'primary','','参数类型 - 自定义','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (7,1,'通知','1','system_notice_type',0,'success','','通知','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (8,2,'公告','2','system_notice_type',0,'info','','公告','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (9,0,'其它','0','infra_operate_type',0,'default','','其它操作','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (10,1,'查询','1','infra_operate_type',0,'info','','查询操作','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (11,2,'新增','2','infra_operate_type',0,'primary','','新增操作','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (12,3,'修改','3','infra_operate_type',0,'warning','','修改操作','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (13,4,'删除','4','infra_operate_type',0,'danger','','删除操作','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (14,5,'导出','5','infra_operate_type',0,'default','','导出操作','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (15,6,'导入','6','infra_operate_type',0,'default','','导入操作','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (16,1,'开启','0','common_status',0,'primary','','开启状态','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (17,2,'关闭','1','common_status',0,'info','','关闭状态','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (18,1,'目录','1','system_menu_type',0,'','','目录','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (19,2,'菜单','2','system_menu_type',0,'','','菜单','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (20,3,'按钮','3','system_menu_type',0,'','','按钮','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (21,1,'内置','1','system_role_type',0,'danger','','内置角色','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (22,2,'自定义','2','system_role_type',0,'primary','','自定义角色','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (23,1,'全部数据权限','1','system_data_scope',0,'','','全部数据权限','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (24,2,'指定部门数据权限','2','system_data_scope',0,'','','指定部门数据权限','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (25,3,'本部门数据权限','3','system_data_scope',0,'','','本部门数据权限','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (26,4,'本部门及以下数据权限','4','system_data_scope',0,'','','本部门及以下数据权限','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (27,5,'仅本人数据权限','5','system_data_scope',0,'','','仅本人数据权限','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (28,0,'成功','0','system_login_result',0,'success','','登陆结果 - 成功','','2021-01-18 06:17:36','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (29,10,'账号或密码不正确','10','system_login_result',0,'primary','','登陆结果 - 账号或密码不正确','','2021-01-18 06:17:54','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (30,20,'用户被禁用','20','system_login_result',0,'warning','','登陆结果 - 用户被禁用','','2021-01-18 06:17:54','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (31,30,'验证码不存在','30','system_login_result',0,'info','','登陆结果 - 验证码不存在','','2021-01-18 06:17:54','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (32,31,'验证码不正确','31','system_login_result',0,'info','','登陆结果 - 验证码不正确','','2021-01-18 06:17:54','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (33,100,'未知异常','100','system_login_result',0,'danger','','登陆结果 - 未知异常','','2021-01-18 06:17:54','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (34,1,'是','true','infra_boolean_string',0,'danger','','Boolean 是否类型 - 是','','2021-01-19 03:20:55','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (35,1,'否','false','infra_boolean_string',0,'info','','Boolean 是否类型 - 否','','2021-01-19 03:20:55','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (36,1,'单表（增删改查）','1','infra_codegen_template_type',0,'','',NULL,'','2021-02-05 07:09:06','','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (37,2,'树表（增删改查）','2','infra_codegen_template_type',0,'','',NULL,'','2021-02-05 07:14:46','','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (38,0,'初始化中','0','infra_job_status',0,'primary','',NULL,'','2021-02-07 07:46:49','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (39,0,'运行中','0','infra_job_log_status',0,'primary','','RUNNING','','2021-02-08 10:04:24','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (40,1,'成功','1','infra_job_log_status',0,'success','',NULL,'','2021-02-08 10:06:57','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (41,2,'失败','2','infra_job_log_status',0,'warning','','失败','','2021-02-08 10:07:38','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (42,1,'会员','1','user_type',0,'primary','',NULL,'','2021-02-26 00:16:27','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (43,2,'管理员','2','user_type',0,'success','',NULL,'','2021-02-26 00:16:34','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (44,0,'未处理','0','infra_api_error_log_process_status',0,'primary','',NULL,'','2021-02-26 07:07:19','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (45,1,'已处理','1','infra_api_error_log_process_status',0,'success','',NULL,'','2021-02-26 07:07:26','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (46,2,'已忽略','2','infra_api_error_log_process_status',0,'danger','',NULL,'','2021-02-26 07:07:34','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (47,1,'阿里云','ALIYUN','system_sms_channel_code',0,'primary','',NULL,'1','2021-04-05 01:05:26','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (48,1,'验证码','1','system_sms_template_type',0,'warning','',NULL,'1','2021-04-05 21:50:57','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (49,2,'通知','2','system_sms_template_type',0,'primary','',NULL,'1','2021-04-05 21:51:08','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (50,0,'营销','3','system_sms_template_type',0,'danger','',NULL,'1','2021-04-05 21:51:15','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (51,0,'初始化','0','system_sms_send_status',0,'primary','',NULL,'1','2021-04-11 20:18:33','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (52,1,'发送成功','10','system_sms_send_status',0,'success','',NULL,'1','2021-04-11 20:18:43','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (53,2,'发送失败','20','system_sms_send_status',0,'danger','',NULL,'1','2021-04-11 20:18:49','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (54,3,'不发送','30','system_sms_send_status',0,'info','',NULL,'1','2021-04-11 20:19:44','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (55,0,'等待结果','0','system_sms_receive_status',0,'primary','',NULL,'1','2021-04-11 20:27:43','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (56,1,'接收成功','10','system_sms_receive_status',0,'success','',NULL,'1','2021-04-11 20:29:25','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (57,2,'接收失败','20','system_sms_receive_status',0,'danger','',NULL,'1','2021-04-11 20:29:31','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (58,0,'调试(钉钉)','DEBUG_DING_TALK','system_sms_channel_code',0,'info','',NULL,'1','2021-04-13 00:20:37','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (59,100,'账号登录','100','system_login_type',0,'primary','','账号登录','1','2021-10-06 00:52:02','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (60,101,'社交登录','101','system_login_type',0,'info','','社交登录','1','2021-10-06 00:52:17','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (61,200,'主动登出','200','system_login_type',0,'primary','','主动登出','1','2021-10-06 00:52:58','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (62,202,'强制登出','202','system_login_type',0,'danger','','强制退出','1','2021-10-06 00:53:41','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (103,1,'管理后台','1','infra_codegen_scene',0,'','','代码生成的场景枚举 - 管理后台','1','2022-02-02 13:15:06','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (104,2,'用户 APP','2','infra_codegen_scene',0,'','','代码生成的场景枚举 - 用户 APP','1','2022-02-02 13:15:19','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (105,1,'数据库','1','infra_file_storage',0,'default','',NULL,'1','2022-03-15 00:25:28','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (106,10,'本地磁盘','10','infra_file_storage',0,'default','',NULL,'1','2022-03-15 00:25:41','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (107,11,'FTP 服务器','11','infra_file_storage',0,'default','',NULL,'1','2022-03-15 00:26:06','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (108,12,'SFTP 服务器','12','infra_file_storage',0,'default','',NULL,'1','2022-03-15 00:26:22','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (109,20,'S3 对象存储','20','infra_file_storage',0,'default','',NULL,'1','2022-03-15 00:26:31','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (110,103,'短信登录','103','system_login_type',0,'default','',NULL,'1','2022-05-09 23:57:58','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (111,1,'password','password','system_oauth2_grant_type',0,'default','','密码模式','1','2022-05-12 00:22:05','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (112,2,'authorization_code','authorization_code','system_oauth2_grant_type',0,'primary','','授权码模式','1','2022-05-12 00:22:59','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (113,3,'implicit','implicit','system_oauth2_grant_type',0,'success','','简化模式','1','2022-05-12 00:23:40','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (114,4,'client_credentials','client_credentials','system_oauth2_grant_type',0,'default','','客户端模式','1','2022-05-12 00:23:51','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (115,5,'refresh_token','refresh_token','system_oauth2_grant_type',0,'info','','刷新模式','1','2022-05-12 00:24:02','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (148,10,'微信小程序','10','terminal',0,'default','','终端 - 微信小程序','1','2022-12-10 10:51:11','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (149,20,'H5 网页','20','terminal',0,'default','','终端 - H5 网页','1','2022-12-10 10:51:30','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (150,11,'微信公众号','11','terminal',0,'default','','终端 - 微信公众号','1','2022-12-10 10:54:16','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (151,31,'苹果 App','31','terminal',0,'default','','终端 - 苹果 App','1','2022-12-10 10:54:42','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (152,32,'安卓 App','32','terminal',0,'default','','终端 - 安卓 App','1','2022-12-10 10:55:02','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (177,0,'初始化','0','system_mail_send_status',0,'primary','','邮件发送状态 - 初始化\n','1','2023-01-26 09:53:49','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (178,10,'发送成功','10','system_mail_send_status',0,'success','','邮件发送状态 - 发送成功','1','2023-01-26 09:54:28','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (179,20,'发送失败','20','system_mail_send_status',0,'danger','','邮件发送状态 - 发送失败','1','2023-01-26 09:54:50','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (180,30,'不发送','30','system_mail_send_status',0,'info','','邮件发送状态 -  不发送','1','2023-01-26 09:55:06','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (181,1,'通知公告','1','system_notify_template_type',0,'primary','','站内信模版的类型 - 通知公告','1','2023-01-28 10:35:59','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (182,2,'系统消息','2','system_notify_template_type',0,'success','','站内信模版的类型 - 系统消息','1','2023-01-28 10:36:20','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (184,10,'Vue2 Element UI 标准模版','10','infra_codegen_front_type',0,'','','','1','2023-04-13 00:03:55','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (185,20,'Vue3 Element Plus 标准模版','20','infra_codegen_front_type',0,'','','','1','2023-04-13 00:04:08','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (186,30,'Vben2.0 Ant Design Schema 模版','30','infra_codegen_front_type',1,'','','','1','2023-04-13 00:04:26','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (274,10,'Gitee','10','system_social_type',0,'','','','1','2023-11-04 13:04:42','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (275,20,'钉钉','20','system_social_type',0,'','','','1','2023-11-04 13:04:54','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (276,30,'企业微信','30','system_social_type',0,'','','','1','2023-11-04 13:05:09','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (277,31,'微信公众平台','31','system_social_type',0,'','','','1','2023-11-04 13:05:18','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (278,32,'微信开放平台','32','system_social_type',0,'','','','1','2023-11-04 13:05:30','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (279,34,'微信小程序','34','system_social_type',0,'','','','1','2023-11-04 13:05:38','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (282,15,'子表','15','infra_codegen_template_type',0,'default','','','1','2023-11-13 23:06:16','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (283,10,'主表（标准模式）','10','infra_codegen_template_type',0,'default','','','1','2023-11-14 12:32:49','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (284,11,'主表（ERP 模式）','11','infra_codegen_template_type',0,'default','','','1','2023-11-14 12:33:05','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (285,12,'主表（内嵌模式）','12','infra_codegen_template_type',0,'','','','1','2023-11-14 12:33:31','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (353,1,'天','1','date_interval',0,'','','','1','2024-03-29 22:50:26','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (354,2,'周','2','date_interval',0,'','','','1','2024-03-29 22:50:36','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (355,3,'月','3','date_interval',0,'','','','1','2024-03-29 22:50:46','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (356,4,'季度','4','date_interval',0,'','','','1','2024-03-29 22:51:01','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (357,5,'年','5','date_interval',0,'','','','1','2024-03-29 22:51:07','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (407,2,'腾讯云','TENCENT','system_sms_channel_code',0,'','','','1','2024-07-22 22:23:16','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (408,3,'华为云','HUAWEI','system_sms_channel_code',0,'','','','1','2024-07-22 22:23:46','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (412,4,'七牛云','QINIU','system_sms_channel_code',0,'','','','1','2024-08-31 08:45:03','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (596,40,'Vben5.0 Ant Design Schema 模版','40','infra_codegen_front_type',0,'','',NULL,'1','2025-04-23 21:47:47','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (622,41,'Vben5.0 Ant Design 标准模版','41','infra_codegen_front_type',0,'','','','1','2025-09-04 23:26:07','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (623,50,'Vben5.0 Element Plus Schema 模版','50','infra_codegen_front_type',0,'','','','1','2025-09-04 23:26:38','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (624,51,'Vben5.0 Element Plus 标准模版','51','infra_codegen_front_type',0,'','','','1','2025-09-04 23:26:49','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (626,40,'支付宝小程序','40','system_social_type',0,'','','','1','2023-11-04 13:05:38','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (627,60,'Admin Uniapp 移动端','60','infra_codegen_front_type',0,'','',NULL,'1','2025-12-16 19:25:51','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (628,42,'Vben5.0 Antdv Next Schema 模版','42','infra_codegen_front_type',0,'','','','1','2026-05-23 13:52:25','1','2026-08-14 01:49:42',_binary '\0');
INSERT INTO `system_dict_data` VALUES (629,43,'Vben5.0 Antdv Next 标准模版','43','infra_codegen_front_type',0,'','','','1','2026-05-23 13:52:25','1','2026-08-14 01:49:42',_binary '\0');
/*!40000 ALTER TABLE `system_dict_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_dict_type`
--

DROP TABLE IF EXISTS `system_dict_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_dict_type` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '字典名称',
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '字典类型',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `deleted_time` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=274 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='字典类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_dict_type`
--

LOCK TABLES `system_dict_type` WRITE;
/*!40000 ALTER TABLE `system_dict_type` DISABLE KEYS */;
INSERT INTO `system_dict_type` VALUES (1,'用户性别','system_user_sex',0,NULL,'admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0',NULL);
INSERT INTO `system_dict_type` VALUES (2,'参数类型','infra_config_type',0,NULL,'admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0',NULL);
INSERT INTO `system_dict_type` VALUES (3,'通知类型','system_notice_type',0,NULL,'admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0',NULL);
INSERT INTO `system_dict_type` VALUES (4,'操作类型','infra_operate_type',0,NULL,'admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0',NULL);
INSERT INTO `system_dict_type` VALUES (5,'系统状态','common_status',0,NULL,'admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0',NULL);
INSERT INTO `system_dict_type` VALUES (6,'Boolean 是否类型','infra_boolean_string',0,'boolean 转是否','','2021-01-19 03:20:08','','2026-08-14 01:49:42',_binary '\0',NULL);
INSERT INTO `system_dict_type` VALUES (7,'登陆结果','system_login_result',0,'登陆结果','','2021-01-18 06:17:11','','2026-08-14 01:49:42',_binary '\0',NULL);
INSERT INTO `system_dict_type` VALUES (8,'代码生成模板类型','infra_codegen_template_type',0,NULL,'','2021-02-05 07:08:06','1','2026-08-14 01:49:42',_binary '\0',NULL);
INSERT INTO `system_dict_type` VALUES (9,'定时任务状态','infra_job_status',0,NULL,'','2021-02-07 07:44:16','','2026-08-14 01:49:42',_binary '\0',NULL);
INSERT INTO `system_dict_type` VALUES (10,'定时任务日志状态','infra_job_log_status',0,NULL,'','2021-02-08 10:03:51','','2026-08-14 01:49:42',_binary '\0',NULL);
INSERT INTO `system_dict_type` VALUES (11,'用户类型','user_type',0,NULL,'','2021-02-26 00:15:51','','2026-08-14 01:49:42',_binary '\0',NULL);
INSERT INTO `system_dict_type` VALUES (12,'API 异常数据的处理状态','infra_api_error_log_process_status',0,NULL,'','2021-02-26 07:07:01','','2026-08-14 01:49:42',_binary '\0',NULL);
INSERT INTO `system_dict_type` VALUES (13,'短信渠道编码','system_sms_channel_code',0,NULL,'1','2021-04-05 01:04:50','1','2026-08-14 01:49:42',_binary '\0',NULL);
INSERT INTO `system_dict_type` VALUES (14,'短信模板的类型','system_sms_template_type',0,NULL,'1','2021-04-05 21:50:43','1','2026-08-14 01:49:42',_binary '\0',NULL);
INSERT INTO `system_dict_type` VALUES (15,'短信发送状态','system_sms_send_status',0,NULL,'1','2021-04-11 20:18:03','1','2026-08-14 01:49:42',_binary '\0',NULL);
INSERT INTO `system_dict_type` VALUES (16,'短信接收状态','system_sms_receive_status',0,NULL,'1','2021-04-11 20:27:14','1','2026-08-14 01:49:42',_binary '\0',NULL);
INSERT INTO `system_dict_type` VALUES (17,'登陆日志的类型','system_login_type',0,'登陆日志的类型','1','2021-10-06 00:50:46','1','2026-08-14 01:49:42',_binary '\0',NULL);
INSERT INTO `system_dict_type` VALUES (27,'代码生成的场景枚举','infra_codegen_scene',0,'代码生成的场景枚举','1','2022-02-02 13:14:45','1','2026-08-14 01:49:42',_binary '\0',NULL);
INSERT INTO `system_dict_type` VALUES (28,'角色类型','system_role_type',0,'角色类型','1','2022-02-16 13:01:46','1','2026-08-14 01:49:42',_binary '\0',NULL);
INSERT INTO `system_dict_type` VALUES (29,'文件存储器','infra_file_storage',0,'文件存储器','1','2022-03-15 00:24:38','1','2026-08-14 01:49:42',_binary '\0',NULL);
INSERT INTO `system_dict_type` VALUES (30,'OAuth 2.0 授权类型','system_oauth2_grant_type',0,'OAuth 2.0 授权类型（模式）','1','2022-05-12 00:20:52','1','2026-08-14 01:49:42',_binary '\0',NULL);
INSERT INTO `system_dict_type` VALUES (42,'终端','terminal',0,'终端','1','2022-12-10 10:50:50','1','2026-08-14 01:49:42',_binary '\0',NULL);
INSERT INTO `system_dict_type` VALUES (48,'邮件发送状态','system_mail_send_status',0,'邮件发送状态','1','2023-01-26 09:53:13','1','2026-08-14 01:49:42',_binary '\0','1970-01-01 00:00:00');
INSERT INTO `system_dict_type` VALUES (49,'站内信模版的类型','system_notify_template_type',0,'站内信模版的类型','1','2023-01-28 10:35:10','1','2026-08-14 01:49:42',_binary '\0','1970-01-01 00:00:00');
INSERT INTO `system_dict_type` VALUES (50,'代码生成的前端类型','infra_codegen_front_type',0,'','1','2023-04-12 23:57:52','1','2026-08-14 01:49:42',_binary '\0','1970-01-01 00:00:00');
INSERT INTO `system_dict_type` VALUES (70,'社交类型','system_social_type',0,'','1','2023-11-04 13:03:54','1','2026-08-14 01:49:42',_binary '\0','1970-01-01 00:00:00');
INSERT INTO `system_dict_type` VALUES (81,'时间间隔','date_interval',0,'','1','2024-03-29 22:50:09','1','2026-08-14 01:49:42',_binary '\0','1970-01-01 00:00:00');
INSERT INTO `system_dict_type` VALUES (116,'菜单类型','system_menu_type',0,'菜单的类型：目录、菜单、按钮','admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',NULL);
INSERT INTO `system_dict_type` VALUES (117,'数据范围','system_data_scope',0,'角色可访问的数据范围','admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',NULL);
/*!40000 ALTER TABLE `system_dict_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_login_log`
--

DROP TABLE IF EXISTS `system_login_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_login_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `log_type` bigint NOT NULL COMMENT '日志类型',
  `trace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '链路追踪编号',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT '用户编号',
  `user_type` tinyint NOT NULL DEFAULT '0' COMMENT '用户类型',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户账号',
  `result` tinyint NOT NULL COMMENT '登陆结果',
  `user_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户 IP',
  `user_agent` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '浏览器 UA',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_username` (`username`) USING BTREE,
  KEY `idx_create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7210 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统访问记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_login_log`
--

LOCK TABLES `system_login_log` WRITE;
/*!40000 ALTER TABLE `system_login_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_login_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_mail_account`
--

DROP TABLE IF EXISTS `system_mail_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_mail_account` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `mail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮箱',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `host` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'SMTP 服务器域名',
  `port` int NOT NULL COMMENT 'SMTP 服务器端口',
  `ssl_enable` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否开启 SSL',
  `starttls_enable` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否开启 STARTTLS',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='邮箱账号表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_mail_account`
--

LOCK TABLES `system_mail_account` WRITE;
/*!40000 ALTER TABLE `system_mail_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_mail_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_mail_log`
--

DROP TABLE IF EXISTS `system_mail_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_mail_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint DEFAULT NULL COMMENT '用户编号',
  `user_type` tinyint DEFAULT NULL COMMENT '用户类型',
  `to_mails` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '接收邮箱地址',
  `cc_mails` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '抄送邮箱地址',
  `bcc_mails` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密送邮箱地址',
  `account_id` bigint NOT NULL COMMENT '邮箱账号编号',
  `from_mail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '发送邮箱地址',
  `template_id` bigint NOT NULL COMMENT '模板编号',
  `template_code` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板编码',
  `template_nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '模版发送人名称',
  `template_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮件标题',
  `template_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮件内容',
  `template_params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮件参数',
  `send_status` tinyint NOT NULL DEFAULT '0' COMMENT '发送状态',
  `send_time` datetime DEFAULT NULL COMMENT '发送时间',
  `send_message_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发送返回的消息 ID',
  `send_exception` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发送异常',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=368 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='邮件日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_mail_log`
--

LOCK TABLES `system_mail_log` WRITE;
/*!40000 ALTER TABLE `system_mail_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_mail_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_mail_template`
--

DROP TABLE IF EXISTS `system_mail_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_mail_template` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板名称',
  `code` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板编码',
  `account_id` bigint NOT NULL COMMENT '发送的邮箱账号编号',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发送人名称',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板标题',
  `content` varchar(10240) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板内容',
  `params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参数数组',
  `status` tinyint NOT NULL COMMENT '开启状态',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='邮件模版表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_mail_template`
--

LOCK TABLES `system_mail_template` WRITE;
/*!40000 ALTER TABLE `system_mail_template` DISABLE KEYS */;
INSERT INTO `system_mail_template` VALUES (13,'后台用户短信登录','admin-sms-login',1,'奥特曼','你猜我猜','<p>您的验证码是{code}，名字是{name}</p>','[\"code\",\"name\"]',0,'3','1','2021-10-11 08:10:00','1','2023-12-02 19:51:14',_binary '\0');
/*!40000 ALTER TABLE `system_mail_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_menu`
--

DROP TABLE IF EXISTS `system_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_menu` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单名称',
  `permission` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '权限标识',
  `type` tinyint NOT NULL COMMENT '菜单类型',
  `sort` int NOT NULL DEFAULT '0' COMMENT '显示顺序',
  `parent_id` bigint NOT NULL DEFAULT '0' COMMENT '父菜单ID',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '路由地址',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '#' COMMENT '菜单图标',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '组件路径',
  `component_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '组件名',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '菜单状态',
  `visible` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否可见',
  `keep_alive` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否缓存',
  `always_show` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否总是显示',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2032 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='菜单权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_menu`
--

LOCK TABLES `system_menu` WRITE;
/*!40000 ALTER TABLE `system_menu` DISABLE KEYS */;
INSERT INTO `system_menu` VALUES (1,'系统管理','',1,10,0,'/system','ep:tools',NULL,NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(2,'基础设施','',1,20,0,'/infra','ep:monitor',NULL,NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(4,'用户管理','system:user:list',2,1,1,'user','ep:avatar','system/user/index','SystemUser',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(5,'角色管理','',2,2,1,'role','ep:user','system/role/index','SystemRole',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(6,'菜单管理','',2,3,1,'menu','ep:menu','system/menu/index','SystemMenu',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(7,'部门管理','',2,4,1,'dept','fa:address-card','system/dept/index','SystemDept',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(8,'岗位管理','',2,5,1,'post','fa:address-book-o','system/post/index','SystemPost',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(9,'字典管理','',2,6,1,'dict','ep:collection','system/dict/index','SystemDictType',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(10,'配置管理','',2,8,2,'config','fa:connectdevelop','infra/config/index','InfraConfig',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(11,'通知公告','',2,4,772,'notice','ep:takeaway-box','system/notice/index','SystemNotice',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(12,'审计日志','',1,9,1,'log','ep:document-copy','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(13,'令牌管理','',2,2,201,'token','fa:key','system/oauth2/token/index','SystemTokenClient',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(14,'定时任务','',2,7,2,'job','fa-solid:tasks','infra/job/index','InfraJob',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(15,'MySQL 监控','',2,1,773,'druid','fa-solid:box','infra/druid/index','InfraDruid',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(16,'Java 监控','',2,3,773,'admin-server','ep:coffee-cup','infra/server/index','InfraAdminServer',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(17,'Redis 监控','',2,2,773,'redis','fa:reddit-square','infra/redis/index','InfraRedis',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(18,'表单构建','infra:build:list',2,2,2,'build','fa:wpforms','infra/build/index','InfraBuild',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(19,'代码生成','infra:codegen:query',2,1,2,'codegen','ep:document-copy','infra/codegen/index','InfraCodegen',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(20,'API 接口','infra:swagger:list',2,3,2,'swagger','fa:fighter-jet','infra/swagger/index','InfraSwagger',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(21,'操作日志','',2,1,12,'operate-log','ep:position','system/operatelog/index','SystemOperateLog',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(22,'登录日志','',2,2,12,'login-log','ep:promotion','system/loginlog/index','SystemLoginLog',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(23,'用户查询','system:user:query',3,1,4,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0'),(24,'用户新增','system:user:create',3,2,4,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(25,'用户修改','system:user:update',3,3,4,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(26,'用户删除','system:user:delete',3,4,4,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(27,'用户导出','system:user:export',3,5,4,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0'),(28,'用户导入','system:user:import',3,6,4,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0'),(29,'重置密码','system:user:update-password',3,7,4,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(30,'角色查询','system:role:query',3,1,5,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0'),(31,'角色新增','system:role:create',3,2,5,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(32,'角色修改','system:role:update',3,3,5,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(33,'角色删除','system:role:delete',3,4,5,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(34,'角色导出','system:role:export',3,5,5,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0'),(35,'菜单查询','system:menu:query',3,1,6,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0'),(36,'菜单新增','system:menu:create',3,2,6,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0'),(37,'菜单修改','system:menu:update',3,3,6,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0'),(38,'菜单删除','system:menu:delete',3,4,6,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0'),(39,'部门查询','system:dept:query',3,1,7,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0'),(40,'部门新增','system:dept:create',3,2,7,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(41,'部门修改','system:dept:update',3,3,7,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(42,'部门删除','system:dept:delete',3,4,7,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(43,'岗位查询','system:post:query',3,1,8,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0'),(44,'岗位新增','system:post:create',3,2,8,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(45,'岗位修改','system:post:update',3,3,8,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(46,'岗位删除','system:post:delete',3,4,8,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(47,'岗位导出','system:post:export',3,5,8,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0'),(48,'字典查询','system:dict:query',3,1,9,'#','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0'),(49,'字典新增','system:dict:create',3,2,9,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(50,'字典修改','system:dict:update',3,3,9,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(51,'字典删除','system:dict:delete',3,4,9,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(52,'字典导出','system:dict:export',3,5,9,'#','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0'),(53,'配置查询','infra:config:query',3,1,10,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0'),(54,'配置新增','infra:config:create',3,2,10,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(55,'配置修改','infra:config:update',3,3,10,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(56,'配置删除','infra:config:delete',3,4,10,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(57,'配置导出','infra:config:export',3,5,10,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0'),(58,'公告查询','system:notice:query',3,1,11,'#','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0'),(59,'公告新增','system:notice:create',3,2,11,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(60,'公告修改','system:notice:update',3,3,11,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(61,'公告删除','system:notice:delete',3,4,11,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(62,'操作查询','system:operate-log:query',3,1,21,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0'),(63,'日志导出','system:operate-log:export',3,2,21,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0'),(64,'登录查询','system:login-log:query',3,1,22,'#','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0'),(65,'日志导出','system:login-log:export',3,3,22,'#','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0'),(66,'令牌列表','system:oauth2-token:page',3,1,13,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(67,'令牌删除','system:oauth2-token:delete',3,2,13,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(68,'任务新增','infra:job:create',3,2,14,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0'),(69,'任务修改','infra:job:update',3,3,14,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0'),(70,'任务删除','infra:job:delete',3,4,14,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0'),(71,'状态修改','infra:job:update',3,5,14,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0'),(72,'任务导出','infra:job:export',3,7,14,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2026-08-14 01:49:42',_binary '\0'),(73,'生成修改','infra:codegen:update',3,2,19,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(74,'生成删除','infra:codegen:delete',3,3,19,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(75,'导入代码','infra:codegen:create',3,2,19,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(76,'预览代码','infra:codegen:preview',3,4,19,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(77,'生成代码','infra:codegen:download',3,5,19,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2026-08-14 01:49:42',_binary '\0'),(78,'设置角色菜单权限','system:permission:assign-role-menu',3,6,5,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-01-06 17:53:44','','2026-08-14 01:49:42',_binary '\0'),(79,'设置角色数据权限','system:permission:assign-role-data-scope',3,7,5,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-01-06 17:56:31','','2026-08-14 01:49:42',_binary '\0'),(80,'设置用户角色','system:permission:assign-user-role',3,8,5,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-01-07 10:23:28','','2026-08-14 01:49:42',_binary '\0'),(81,'获得 Redis 监控信息','infra:redis:get-monitor-info',3,1,17,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-01-26 01:02:31','','2026-08-14 01:49:42',_binary '\0'),(82,'获得 Redis Key 列表','infra:redis:get-key-list',3,2,17,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-01-26 01:02:52','','2026-08-14 01:49:42',_binary '\0'),(83,'代码生成案例','',1,1,2,'demo','ep:aim','infra/testDemo/index',NULL,0,_binary '',_binary '',_binary '','','2021-02-06 12:42:49','1','2026-08-14 01:49:42',_binary '\0'),(84,'任务触发','infra:job:trigger',3,8,14,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-02-07 13:03:10','','2026-08-14 01:49:42',_binary '\0'),(85,'链路追踪','',2,4,773,'skywalking','fa:eye','infra/skywalking/index','InfraSkyWalking',0,_binary '',_binary '',_binary '','','2021-02-08 20:41:31','1','2026-08-14 01:49:42',_binary '\0'),(86,'访问日志','',2,1,88,'api-access-log','ep:place','infra/apiAccessLog/index','InfraApiAccessLog',0,_binary '',_binary '',_binary '','','2021-02-26 01:32:59','1','2026-08-14 01:49:42',_binary '\0'),(87,'日志导出','infra:api-access-log:export',3,2,86,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-02-26 01:32:59','1','2026-08-14 01:49:42',_binary '\0'),(88,'API 日志','',2,4,2,'log','fa:tasks',NULL,NULL,0,_binary '',_binary '',_binary '','','2021-02-26 02:18:24','1','2026-08-14 01:49:42',_binary '\0'),(89,'错误日志','infra:api-error-log:query',2,2,88,'api-error-log','ep:warning-filled','infra/apiErrorLog/index','InfraApiErrorLog',0,_binary '',_binary '',_binary '','','2021-02-26 07:53:20','1','2026-08-14 01:49:42',_binary '\0'),(90,'日志处理','infra:api-error-log:update-status',3,2,89,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-02-26 07:53:20','1','2026-08-14 01:49:42',_binary '\0'),(91,'日志导出','infra:api-error-log:export',3,3,89,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-02-26 07:53:20','1','2026-08-14 01:49:42',_binary '\0'),(92,'任务查询','infra:job:query',3,1,14,'','','',NULL,0,_binary '',_binary '',_binary '','1','2021-03-10 01:26:19','1','2026-08-14 01:49:42',_binary '\0'),(93,'日志查询','infra:api-access-log:query',3,1,86,'','','',NULL,0,_binary '',_binary '',_binary '','1','2021-03-10 01:28:04','1','2026-08-14 01:49:42',_binary '\0'),(94,'日志查询','infra:api-error-log:query',3,1,89,'','','',NULL,0,_binary '',_binary '',_binary '','1','2021-03-10 01:29:09','1','2026-08-14 01:49:42',_binary '\0'),(95,'文件列表','',2,5,193,'file','ep:upload-filled','infra/file/index','InfraFile',0,_binary '',_binary '',_binary '','','2021-03-12 20:16:20','1','2026-08-14 01:49:42',_binary '\0'),(96,'文件查询','infra:file:query',3,1,95,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-03-12 20:16:20','','2026-08-14 01:49:42',_binary '\0'),(97,'文件删除','infra:file:delete',3,4,95,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-03-12 20:16:20','','2026-08-14 01:49:42',_binary '\0'),(98,'短信管理','',1,1,772,'sms','ep:message',NULL,NULL,0,_binary '',_binary '',_binary '','1','2021-04-05 01:10:16','1','2026-08-14 01:49:42',_binary '\0'),(99,'短信渠道','',2,0,98,'sms-channel','fa:stack-exchange','system/sms/channel/index','SystemSmsChannel',0,_binary '',_binary '',_binary '','','2021-04-01 11:07:15','1','2026-08-14 01:49:42',_binary '\0'),(100,'短信渠道查询','system:sms-channel:query',3,1,99,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-04-01 11:07:15','','2026-08-14 01:49:42',_binary '\0'),(101,'短信渠道创建','system:sms-channel:create',3,2,99,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-04-01 11:07:15','','2026-08-14 01:49:42',_binary '\0'),(102,'短信渠道更新','system:sms-channel:update',3,3,99,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-04-01 11:07:15','','2026-08-14 01:49:42',_binary '\0'),(103,'短信渠道删除','system:sms-channel:delete',3,4,99,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-04-01 11:07:15','','2026-08-14 01:49:42',_binary '\0'),(104,'短信模板','',2,1,98,'sms-template','ep:connection','system/sms/template/index','SystemSmsTemplate',0,_binary '',_binary '',_binary '','','2021-04-01 17:35:17','1','2026-08-14 01:49:42',_binary '\0'),(105,'短信模板查询','system:sms-template:query',3,1,104,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-04-01 17:35:17','','2026-08-14 01:49:42',_binary '\0'),(106,'短信模板创建','system:sms-template:create',3,2,104,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-04-01 17:35:17','','2026-08-14 01:49:42',_binary '\0'),(107,'短信模板更新','system:sms-template:update',3,3,104,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-04-01 17:35:17','','2026-08-14 01:49:42',_binary '\0'),(108,'短信模板删除','system:sms-template:delete',3,4,104,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-04-01 17:35:17','','2026-08-14 01:49:42',_binary '\0'),(109,'短信模板导出','system:sms-template:export',3,5,104,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-04-01 17:35:17','','2026-08-14 01:49:42',_binary '\0'),(110,'发送测试短信','system:sms-template:send-sms',3,6,104,'','','',NULL,0,_binary '',_binary '',_binary '','1','2021-04-11 00:26:40','1','2026-08-14 01:49:42',_binary '\0'),(111,'短信日志','',2,2,98,'sms-log','fa:edit','system/sms/log/index','SystemSmsLog',0,_binary '',_binary '',_binary '','','2021-04-11 08:37:05','1','2026-08-14 01:49:42',_binary '\0'),(112,'短信日志查询','system:sms-log:query',3,1,111,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-04-11 08:37:05','','2026-08-14 01:49:42',_binary '\0'),(113,'短信日志导出','system:sms-log:export',3,5,111,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-04-11 08:37:05','','2026-08-14 01:49:42',_binary '\0'),(129,'租户列表','',2,0,181,'list','ep:house','system/tenant/index','SystemTenant',0,_binary '',_binary '',_binary '','','2021-12-14 12:31:43','1','2026-08-14 01:49:42',_binary '\0'),(130,'租户查询','system:tenant:query',3,1,129,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-12-14 12:31:44','','2026-08-14 01:49:42',_binary '\0'),(131,'租户创建','system:tenant:create',3,2,129,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-12-14 12:31:44','','2026-08-14 01:49:42',_binary '\0'),(132,'租户更新','system:tenant:update',3,3,129,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-12-14 12:31:44','','2026-08-14 01:49:42',_binary '\0'),(133,'租户删除','system:tenant:delete',3,4,129,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-12-14 12:31:44','','2026-08-14 01:49:42',_binary '\0'),(134,'租户导出','system:tenant:export',3,5,129,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-12-14 12:31:44','','2026-08-14 01:49:42',_binary '\0'),(181,'租户管理','',2,11,1,'tenant','fa-solid:house-user',NULL,NULL,0,_binary '',_binary '',_binary '','1','2022-02-20 01:41:13','1','2026-08-29 11:46:32',_binary '\0'),(182,'租户套餐','',2,0,181,'package','fa:bars','system/tenantPackage/index','SystemTenantPackage',0,_binary '',_binary '',_binary '','','2022-02-19 17:44:06','1','2026-08-14 01:49:42',_binary '\0'),(183,'租户套餐查询','system:tenant-package:query',3,1,182,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-02-19 17:44:06','','2026-08-14 01:49:42',_binary '\0'),(184,'租户套餐创建','system:tenant-package:create',3,2,182,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-02-19 17:44:06','','2026-08-14 01:49:42',_binary '\0'),(185,'租户套餐更新','system:tenant-package:update',3,3,182,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-02-19 17:44:06','','2026-08-14 01:49:42',_binary '\0'),(186,'租户套餐删除','system:tenant-package:delete',3,4,182,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-02-19 17:44:06','','2026-08-14 01:49:42',_binary '\0'),(187,'文件配置','',2,0,193,'file-config','fa-solid:file-signature','infra/fileConfig/index','InfraFileConfig',0,_binary '',_binary '',_binary '','','2022-03-15 14:35:28','1','2026-08-14 01:49:42',_binary '\0'),(188,'文件配置查询','infra:file-config:query',3,1,187,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-03-15 14:35:28','','2026-08-14 01:49:42',_binary '\0'),(189,'文件配置创建','infra:file-config:create',3,2,187,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-03-15 14:35:28','','2026-08-14 01:49:42',_binary '\0'),(190,'文件配置更新','infra:file-config:update',3,3,187,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-03-15 14:35:28','','2026-08-14 01:49:42',_binary '\0'),(191,'文件配置删除','infra:file-config:delete',3,4,187,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-03-15 14:35:28','','2026-08-14 01:49:42',_binary '\0'),(192,'文件配置导出','infra:file-config:export',3,5,187,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-03-15 14:35:28','','2026-08-14 01:49:42',_binary '\0'),(193,'文件管理','',2,6,2,'file','ep:files',NULL,'',0,_binary '',_binary '',_binary '','1','2022-03-16 23:47:40','1','2026-08-14 01:49:42',_binary '\0'),(195,'数据源配置','',2,1,2,'data-source-config','ep:data-analysis','infra/dataSourceConfig/index','InfraDataSourceConfig',0,_binary '',_binary '',_binary '','','2022-04-27 14:37:32','1','2026-08-14 01:49:42',_binary '\0'),(196,'数据源配置查询','infra:data-source-config:query',3,1,195,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-04-27 14:37:32','','2026-08-14 01:49:42',_binary '\0'),(197,'数据源配置创建','infra:data-source-config:create',3,2,195,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-04-27 14:37:32','','2026-08-14 01:49:42',_binary '\0'),(198,'数据源配置更新','infra:data-source-config:update',3,3,195,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-04-27 14:37:32','','2026-08-14 01:49:42',_binary '\0'),(199,'数据源配置删除','infra:data-source-config:delete',3,4,195,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-04-27 14:37:32','','2026-08-14 01:49:42',_binary '\0'),(200,'数据源配置导出','infra:data-source-config:export',3,5,195,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-04-27 14:37:32','','2026-08-14 01:49:42',_binary '\0'),(201,'OAuth 2.0','',2,10,1,'oauth2','fa:dashcube',NULL,NULL,0,_binary '',_binary '',_binary '','1','2022-05-09 23:38:17','1','2026-08-14 01:49:42',_binary '\0'),(202,'应用管理','',2,0,201,'oauth2/application','fa:hdd-o','system/oauth2/client/index','SystemOAuth2Client',0,_binary '',_binary '',_binary '','','2022-05-10 16:26:33','1','2026-08-14 01:49:42',_binary '\0'),(203,'客户端查询','system:oauth2-client:query',3,1,202,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-05-10 16:26:33','1','2026-08-14 01:49:42',_binary '\0'),(204,'客户端创建','system:oauth2-client:create',3,2,202,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-05-10 16:26:33','1','2026-08-14 01:49:42',_binary '\0'),(205,'客户端更新','system:oauth2-client:update',3,3,202,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-05-10 16:26:33','1','2026-08-14 01:49:42',_binary '\0'),(206,'客户端删除','system:oauth2-client:delete',3,4,202,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-05-10 16:26:33','1','2026-08-14 01:49:42',_binary '\0'),(271,'地区管理','',2,14,1,'area','fa:map-marker','system/area/index','SystemArea',0,_binary '',_binary '',_binary '','1','2022-12-23 17:35:05','1','2026-08-14 01:49:42',_binary '\0'),(318,'邮箱管理','',2,2,772,'mail','fa-solid:mail-bulk',NULL,NULL,0,_binary '',_binary '',_binary '','1','2023-01-25 17:27:44','1','2026-08-14 01:49:42',_binary '\0'),(319,'邮箱账号','',2,0,318,'mail-account','fa:universal-access','system/mail/account/index','SystemMailAccount',0,_binary '',_binary '',_binary '','','2023-01-25 09:33:48','1','2026-08-14 01:49:42',_binary '\0'),(320,'账号查询','system:mail-account:query',3,1,319,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-25 09:33:48','','2026-08-14 01:49:42',_binary '\0'),(321,'账号创建','system:mail-account:create',3,2,319,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-25 09:33:48','','2026-08-14 01:49:42',_binary '\0'),(322,'账号更新','system:mail-account:update',3,3,319,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-25 09:33:48','','2026-08-14 01:49:42',_binary '\0'),(323,'账号删除','system:mail-account:delete',3,4,319,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-25 09:33:48','','2026-08-14 01:49:42',_binary '\0'),(324,'邮件模版','',2,0,318,'mail-template','fa:tag','system/mail/template/index','SystemMailTemplate',0,_binary '',_binary '',_binary '','','2023-01-25 12:05:31','1','2026-08-14 01:49:42',_binary '\0'),(325,'模版查询','system:mail-template:query',3,1,324,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-25 12:05:31','','2026-08-14 01:49:42',_binary '\0'),(326,'模版创建','system:mail-template:create',3,2,324,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-25 12:05:31','','2026-08-14 01:49:42',_binary '\0'),(327,'模版更新','system:mail-template:update',3,3,324,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-25 12:05:31','','2026-08-14 01:49:42',_binary '\0'),(328,'模版删除','system:mail-template:delete',3,4,324,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-25 12:05:31','','2026-08-14 01:49:42',_binary '\0'),(329,'邮件记录','',2,0,318,'mail-log','fa:edit','system/mail/log/index','SystemMailLog',0,_binary '',_binary '',_binary '','','2023-01-26 02:16:50','1','2026-08-14 01:49:42',_binary '\0'),(330,'日志查询','system:mail-log:query',3,1,329,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-26 02:16:50','','2026-08-14 01:49:42',_binary '\0'),(331,'发送测试邮件','system:mail-template:send-mail',3,5,324,'','','',NULL,0,_binary '',_binary '',_binary '','1','2023-01-26 23:29:15','1','2026-08-14 01:49:42',_binary '\0'),(332,'站内信管理','',1,3,772,'notify','ep:message-box',NULL,NULL,0,_binary '',_binary '',_binary '','1','2023-01-28 10:25:18','1','2026-08-14 01:49:42',_binary '\0'),(333,'模板管理','',2,0,332,'notify-template','fa:archive','system/notify/template/index','SystemNotifyTemplate',0,_binary '',_binary '',_binary '','','2023-01-28 02:26:42','1','2026-08-14 01:49:42',_binary '\0'),(334,'站内信模板查询','system:notify-template:query',3,1,333,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-28 02:26:42','','2026-08-14 01:49:42',_binary '\0'),(335,'站内信模板创建','system:notify-template:create',3,2,333,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-28 02:26:42','','2026-08-14 01:49:42',_binary '\0'),(336,'站内信模板更新','system:notify-template:update',3,3,333,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-28 02:26:42','','2026-08-14 01:49:42',_binary '\0'),(337,'站内信模板删除','system:notify-template:delete',3,4,333,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-28 02:26:42','','2026-08-14 01:49:42',_binary '\0'),(338,'发送测试站内信','system:notify-template:send-notify',3,5,333,'','','',NULL,0,_binary '',_binary '',_binary '','1','2023-01-28 10:54:43','1','2026-08-14 01:49:42',_binary '\0'),(339,'消息记录','',2,0,332,'notify-message','fa:edit','system/notify/message/index','SystemNotifyMessage',0,_binary '',_binary '',_binary '','','2023-01-28 04:28:22','1','2026-08-14 01:49:42',_binary '\0'),(340,'站内信消息查询','system:notify-message:query',3,1,339,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-28 04:28:22','','2026-08-14 01:49:42',_binary '\0'),(529,'三方登录','',1,10,1,'social','fa:rocket','','',0,_binary '',_binary '',_binary '','1','2023-11-04 12:12:01','1','2026-08-14 01:49:42',_binary '\0'),(530,'三方应用','',2,1,529,'client','ep:set-up','system/social/client/index.vue','SocialClient',0,_binary '',_binary '',_binary '','1','2023-11-04 12:17:19','1','2026-08-14 01:49:42',_binary '\0'),(531,'三方应用查询','system:social-client:query',3,1,530,'','','','',0,_binary '',_binary '',_binary '','1','2023-11-04 12:43:12','1','2026-08-14 01:49:42',_binary '\0'),(532,'三方应用创建','system:social-client:create',3,2,530,'','','','',0,_binary '',_binary '',_binary '','1','2023-11-04 12:43:58','1','2026-08-14 01:49:42',_binary '\0'),(533,'三方应用更新','system:social-client:update',3,3,530,'','','','',0,_binary '',_binary '',_binary '','1','2023-11-04 12:44:27','1','2026-08-14 01:49:42',_binary '\0'),(534,'三方应用删除','system:social-client:delete',3,4,530,'','','','',0,_binary '',_binary '',_binary '','1','2023-11-04 12:44:43','1','2026-08-14 01:49:42',_binary '\0'),(535,'三方用户','system:social-user:query',2,2,529,'user','ep:avatar','system/social/user/index.vue','SocialUser',0,_binary '',_binary '',_binary '','1','2023-11-04 14:01:05','1','2026-08-14 01:49:42',_binary '\0'),(536,'主子表（内嵌）','',2,12,83,'demo03-inner','fa:power-off','infra/demo/demo03/inner/index','Demo03StudentInner',0,_binary '',_binary '',_binary '','','2023-11-13 04:39:51','1','2026-08-14 01:49:42',_binary '\0'),(537,'单表（增删改查）','',2,1,83,'demo01-contact','ep:bicycle','infra/demo/demo01/index','Demo01Contact',0,_binary '',_binary '',_binary '','','2023-11-15 14:42:30','1','2026-08-14 01:49:42',_binary '\0'),(538,'示例联系人查询','infra:demo01-contact:query',3,1,537,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-11-15 14:42:30','','2026-08-14 01:49:42',_binary '\0'),(539,'示例联系人创建','infra:demo01-contact:create',3,2,537,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-11-15 14:42:30','','2026-08-14 01:49:42',_binary '\0'),(540,'示例联系人更新','infra:demo01-contact:update',3,3,537,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-11-15 14:42:30','','2026-08-14 01:49:42',_binary '\0'),(541,'示例联系人删除','infra:demo01-contact:delete',3,4,537,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-11-15 14:42:30','','2026-08-14 01:49:42',_binary '\0'),(542,'示例联系人导出','infra:demo01-contact:export',3,5,537,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-11-15 14:42:30','','2026-08-14 01:49:42',_binary '\0'),(543,'树表（增删改查）','',2,2,83,'demo02-category','fa:tree','infra/demo/demo02/index','Demo02Category',0,_binary '',_binary '',_binary '','','2023-11-16 12:18:27','1','2026-08-14 01:49:42',_binary '\0'),(544,'示例分类查询','infra:demo02-category:query',3,1,543,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-11-16 12:18:27','','2026-08-14 01:49:42',_binary '\0'),(545,'示例分类创建','infra:demo02-category:create',3,2,543,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-11-16 12:18:27','','2026-08-14 01:49:42',_binary '\0'),(546,'示例分类更新','infra:demo02-category:update',3,3,543,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-11-16 12:18:27','','2026-08-14 01:49:42',_binary '\0'),(547,'示例分类删除','infra:demo02-category:delete',3,4,543,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-11-16 12:18:27','','2026-08-14 01:49:42',_binary '\0'),(548,'示例分类导出','infra:demo02-category:export',3,5,543,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-11-16 12:18:27','','2026-08-14 01:49:42',_binary '\0'),(549,'主子表（标准）','',2,10,83,'demo03-normal','fa:battery-3','infra/demo/demo03/normal/index','Demo03StudentNormal',0,_binary '',_binary '',_binary '','','2023-11-16 12:53:37','1','2026-08-14 01:49:42',_binary '\0'),(550,'学生查询','infra:demo03-student:query',3,1,549,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-11-16 12:53:37','','2026-08-14 01:49:42',_binary '\0'),(551,'学生创建','infra:demo03-student:create',3,2,549,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-11-16 12:53:37','','2026-08-14 01:49:42',_binary '\0'),(552,'学生更新','infra:demo03-student:update',3,3,549,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-11-16 12:53:37','','2026-08-14 01:49:42',_binary '\0'),(553,'学生删除','infra:demo03-student:delete',3,4,549,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-11-16 12:53:37','','2026-08-14 01:49:42',_binary '\0'),(554,'学生导出','infra:demo03-student:export',3,5,549,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-11-16 12:53:37','','2026-08-14 01:49:42',_binary '\0'),(555,'主子表（ERP）','',2,11,83,'demo03-erp','ep:calendar','infra/demo/demo03/erp/index','Demo03StudentERP',0,_binary '',_binary '',_binary '','','2023-11-16 15:50:59','1','2026-08-14 01:49:42',_binary '\0'),(565,'WebSocket','',2,5,2,'websocket','ep:connection','infra/webSocket/index','InfraWebSocket',0,_binary '',_binary '',_binary '','1','2023-11-23 19:41:55','1','2026-08-14 01:49:42',_binary '\0'),(772,'消息中心','',1,7,1,'messages','ep:chat-dot-round','','',0,_binary '',_binary '',_binary '','1','2024-04-22 23:54:30','1','2026-08-14 01:49:42',_binary '\0'),(773,'监控中心','',1,10,2,'monitors','ep:monitor','','',0,_binary '',_binary '',_binary '','1','2024-04-23 00:04:44','1','2026-08-14 01:49:42',_binary '\0'),(920,'租户切换','system:tenant:visit',3,999,129,'','','','',0,_binary '',_binary '',_binary '','1','2025-05-05 15:25:32','1','2026-08-14 01:49:42',_binary '\0'),(2027,'系统更新','',2,10,1,'system-update','ep:upload-filled','infra/systemUpdate/index','InfraSystemUpdate',0,_binary '',_binary '',_binary '','admin','2026-08-29 22:20:10','admin','2026-08-29 22:20:10',_binary '\0'),(2028,'更新查询','infra:system-update:query',3,1,2027,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2026-08-29 22:20:10','admin','2026-08-29 22:20:10',_binary '\0'),(2029,'上传更新包','infra:system-update:upload',3,2,2027,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2026-08-29 22:20:10','admin','2026-08-29 22:20:10',_binary '\0'),(2030,'应用更新','infra:system-update:apply',3,3,2027,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2026-08-29 22:20:10','admin','2026-08-29 22:20:10',_binary '\0'),(2031,'回滚版本','infra:system-update:rollback',3,4,2027,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2026-08-29 22:20:10','admin','2026-08-29 22:20:10',_binary '\0');
/*!40000 ALTER TABLE `system_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_notice`
--

DROP TABLE IF EXISTS `system_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_notice` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '公告标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '公告内容',
  `type` tinyint NOT NULL COMMENT '公告类型（1通知 2公告）',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通知公告表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_notice`
--

LOCK TABLES `system_notice` WRITE;
/*!40000 ALTER TABLE `system_notice` DISABLE KEYS */;
INSERT INTO `system_notice` VALUES (2,'光何集团系统例行维护通知','<p>系统将于每周日凌晨 02:00 - 04:00 进行例行维护，请提前保存好数据。</p>',2,0,'admin','2021-01-05 17:03:48','admin','2026-01-05 09:00:00',_binary '\0',1);
/*!40000 ALTER TABLE `system_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_notify_message`
--

DROP TABLE IF EXISTS `system_notify_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_notify_message` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `user_type` tinyint NOT NULL COMMENT '用户类型',
  `template_id` bigint NOT NULL COMMENT '模版编号',
  `template_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板编码',
  `template_nickname` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模版发送人名称',
  `template_content` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模版内容',
  `template_type` int NOT NULL COMMENT '模版类型',
  `template_params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模版参数',
  `read_status` bit(1) NOT NULL COMMENT '是否已读',
  `read_time` datetime DEFAULT NULL COMMENT '阅读时间',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id_user_type_read_status` (`user_id`,`user_type`,`read_status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='站内信消息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_notify_message`
--

LOCK TABLES `system_notify_message` WRITE;
/*!40000 ALTER TABLE `system_notify_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_notify_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_notify_template`
--

DROP TABLE IF EXISTS `system_notify_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_notify_template` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板名称',
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模版编码',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '发送人名称',
  `content` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模版内容',
  `type` tinyint NOT NULL COMMENT '类型',
  `params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '参数数组',
  `status` tinyint NOT NULL COMMENT '状态',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1062143 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='站内信模板表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_notify_template`
--

LOCK TABLES `system_notify_template` WRITE;
/*!40000 ALTER TABLE `system_notify_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_notify_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_oauth2_access_token`
--

DROP TABLE IF EXISTS `system_oauth2_access_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_oauth2_access_token` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `user_type` tinyint NOT NULL COMMENT '用户类型',
  `user_info` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户信息',
  `access_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '访问令牌',
  `refresh_token` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '刷新令牌',
  `client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端编号',
  `scopes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '授权范围',
  `expires_time` datetime NOT NULL COMMENT '过期时间',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_access_token` (`access_token`) USING BTREE,
  KEY `idx_refresh_token` (`refresh_token`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=118891 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='OAuth2 访问令牌';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_oauth2_access_token`
--

LOCK TABLES `system_oauth2_access_token` WRITE;
/*!40000 ALTER TABLE `system_oauth2_access_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_oauth2_access_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_oauth2_approve`
--

DROP TABLE IF EXISTS `system_oauth2_approve`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_oauth2_approve` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `user_type` tinyint NOT NULL COMMENT '用户类型',
  `client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端编号',
  `scope` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '授权范围',
  `approved` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否接受',
  `expires_time` datetime NOT NULL COMMENT '过期时间',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id_user_type_client_id` (`user_id`,`user_type`,`client_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='OAuth2 批准表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_oauth2_approve`
--

LOCK TABLES `system_oauth2_approve` WRITE;
/*!40000 ALTER TABLE `system_oauth2_approve` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_oauth2_approve` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_oauth2_client`
--

DROP TABLE IF EXISTS `system_oauth2_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_oauth2_client` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端编号',
  `secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端密钥',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用名',
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用图标',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '应用描述',
  `status` tinyint NOT NULL COMMENT '状态',
  `access_token_validity_seconds` int NOT NULL COMMENT '访问令牌的有效期',
  `refresh_token_validity_seconds` int NOT NULL COMMENT '刷新令牌的有效期',
  `redirect_uris` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '可重定向的 URI 地址',
  `authorized_grant_types` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '授权类型',
  `scopes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '授权范围',
  `auto_approve_scopes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自动通过的授权范围',
  `authorities` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '权限',
  `resource_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '资源',
  `additional_information` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '附加信息',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_client_id` (`client_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='OAuth2 客户端表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_oauth2_client`
--

LOCK TABLES `system_oauth2_client` WRITE;
/*!40000 ALTER TABLE `system_oauth2_client` DISABLE KEYS */;
INSERT INTO `system_oauth2_client` VALUES (1,'default','admin123','光何','/logo.png','我是描述',0,1800,2592000,'[\"https://github.com/guangheUlti/gsite\",\"https://github.com/guangheUlti/gsite\"]','[\"password\",\"authorization_code\",\"implicit\",\"refresh_token\",\"client_credentials\"]','[\"user.read\",\"user.write\"]','[]','[\"user.read\",\"user.write\"]','[]','{}','1','2022-05-11 21:47:12','1','2026-08-29 11:34:46',_binary '\0');
/*!40000 ALTER TABLE `system_oauth2_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_oauth2_code`
--

DROP TABLE IF EXISTS `system_oauth2_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_oauth2_code` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `user_type` tinyint NOT NULL COMMENT '用户类型',
  `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '授权码',
  `client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端编号',
  `scopes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '授权范围',
  `expires_time` datetime NOT NULL COMMENT '过期时间',
  `redirect_uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '可重定向的 URI 地址',
  `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '状态',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_code` (`code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='OAuth2 授权码表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_oauth2_code`
--

LOCK TABLES `system_oauth2_code` WRITE;
/*!40000 ALTER TABLE `system_oauth2_code` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_oauth2_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_oauth2_refresh_token`
--

DROP TABLE IF EXISTS `system_oauth2_refresh_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_oauth2_refresh_token` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `refresh_token` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '刷新令牌',
  `user_type` tinyint NOT NULL COMMENT '用户类型',
  `client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端编号',
  `scopes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '授权范围',
  `expires_time` datetime NOT NULL COMMENT '过期时间',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_refresh_token` (`refresh_token`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5147 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='OAuth2 刷新令牌';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_oauth2_refresh_token`
--

LOCK TABLES `system_oauth2_refresh_token` WRITE;
/*!40000 ALTER TABLE `system_oauth2_refresh_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_oauth2_refresh_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_operate_log`
--

DROP TABLE IF EXISTS `system_operate_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_operate_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `trace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '链路追踪编号',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `user_type` tinyint NOT NULL DEFAULT '0' COMMENT '用户类型',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '操作模块类型',
  `sub_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '操作名',
  `biz_id` bigint NOT NULL COMMENT '操作数据模块编号',
  `action` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '操作内容',
  `success` bit(1) NOT NULL DEFAULT b'1' COMMENT '操作结果',
  `extra` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '拓展字段',
  `request_method` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '请求方法名',
  `request_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '请求地址',
  `user_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户 IP',
  `user_agent` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '浏览器 UA',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10012 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='操作日志记录 V2 版本';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_operate_log`
--

LOCK TABLES `system_operate_log` WRITE;
/*!40000 ALTER TABLE `system_operate_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_operate_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_post`
--

DROP TABLE IF EXISTS `system_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_post` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '岗位编码',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '岗位名称',
  `sort` int NOT NULL COMMENT '显示顺序',
  `status` tinyint NOT NULL COMMENT '状态（0正常 1停用）',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='岗位信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_post`
--

LOCK TABLES `system_post` WRITE;
/*!40000 ALTER TABLE `system_post` DISABLE KEYS */;
INSERT INTO `system_post` VALUES
(1,'ceo','总经理',1,0,'集团经营管理与决策','admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,'cto','技术总监',2,0,'技术战略、架构与研发团队管理','admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(3,'pm','产品经理',3,0,'需求分析、产品规划与迭代管理','admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(4,'pjm','项目经理',4,0,'项目计划、交付进度与风险管理','admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(5,'java_dev','Java 开发工程师',5,0,'后端服务设计与开发','admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(6,'fe_dev','前端开发工程师',6,0,'Web 与管理端界面开发','admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(7,'qa','测试工程师',7,0,'测试用例设计、功能与回归测试','admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(8,'ops','运维工程师',8,0,'部署、监控与生产环境保障','admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(9,'ui','UI 设计师',9,0,'界面视觉与交互设计','admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(10,'sales','销售经理',10,0,'客户拓展与合同签订','admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(11,'presales','售前顾问',11,0,'方案讲解与投标支持','admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(12,'cs','客户成功专员',12,0,'客户培训、答疑与续约维护','admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(13,'finance','财务专员',13,0,'账务处理、报销与成本核算','admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(14,'hr','人力资源专员',14,0,'招聘、入离职与员工关系','admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(15,'admin_staff','行政专员',15,0,'办公行政与后勤保障','admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1);
/*!40000 ALTER TABLE `system_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_role`
--

DROP TABLE IF EXISTS `system_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_role` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色名称',
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色权限字符串',
  `sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` tinyint NOT NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `data_scope_dept_ids` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据范围(指定部门数组)',
  `status` tinyint NOT NULL COMMENT '角色状态（0正常 1停用）',
  `type` tinyint NOT NULL COMMENT '角色类型',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=164 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_role`
--

LOCK TABLES `system_role` WRITE;
/*!40000 ALTER TABLE `system_role` DISABLE KEYS */;
INSERT INTO `system_role` VALUES
(1,'超级管理员','super_admin',1,1,'',0,1,'系统内置角色，拥有全部权限','admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,'系统管理员','sys_admin',2,1,'',0,2,'负责系统配置、账号与权限维护','admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(3,'部门经理','dept_manager',3,4,'',0,2,'查看本部门及下级部门数据，管理所属成员','admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(4,'研发工程师','developer',4,5,'',0,2,'研发条线人员，可查看代码生成与接口文档','admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(5,'测试工程师','tester',5,5,'',0,2,'测试条线人员，仅本人数据权限','admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(6,'运维工程师','ops',6,5,'',0,2,'负责定时任务、配置与监控中心','admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(7,'产品经理','product',7,5,'',0,2,'产品条线人员，仅本人数据权限','admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(8,'销售人员','sales',8,5,'',0,2,'销售条线人员，仅本人数据权限','admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(9,'财务人员','finance',9,5,'',0,2,'财务条线人员，仅本人数据权限','admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(10,'人事专员','hr',10,5,'',0,2,'维护员工账号、部门与岗位信息','admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(11,'普通员工','employee',11,5,'',0,2,'默认角色，仅可访问工作台','admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1);
/*!40000 ALTER TABLE `system_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_role_menu`
--

DROP TABLE IF EXISTS `system_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_role_menu` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增编号',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_role_id` (`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8710 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色和菜单关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_role_menu`
--

LOCK TABLES `system_role_menu` WRITE;
/*!40000 ALTER TABLE `system_role_menu` DISABLE KEYS */;
INSERT INTO `system_role_menu` (`role_id`,`menu_id`,`creator`,`create_time`,`updater`,`update_time`,`deleted`,`tenant_id`) VALUES
(2,1,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,4,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,5,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,6,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,7,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,8,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,9,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,772,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,11,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,98,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,99,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,104,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,111,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,318,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,319,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,324,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,329,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,332,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,333,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,339,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,12,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,21,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,22,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,201,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,202,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,13,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,529,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,530,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,535,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,2027,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,181,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,129,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,182,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,271,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,2,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,19,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,83,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,537,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,543,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,549,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,555,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,536,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,195,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,18,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,20,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,88,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,86,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,89,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,565,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,193,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,187,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,95,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,14,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,10,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,773,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,15,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,17,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,16,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(2,85,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1);
INSERT INTO `system_role_menu` (`role_id`,`menu_id`,`creator`,`create_time`,`updater`,`update_time`,`deleted`,`tenant_id`) VALUES
(3,1,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(3,4,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(3,7,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(3,8,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(3,12,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(3,21,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(3,22,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1);
INSERT INTO `system_role_menu` (`role_id`,`menu_id`,`creator`,`create_time`,`updater`,`update_time`,`deleted`,`tenant_id`) VALUES
(4,2,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(4,19,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(4,20,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(4,193,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(4,187,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(4,95,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1);
INSERT INTO `system_role_menu` (`role_id`,`menu_id`,`creator`,`create_time`,`updater`,`update_time`,`deleted`,`tenant_id`) VALUES
(6,2,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(6,14,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(6,10,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(6,773,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(6,15,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(6,17,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(6,16,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(6,85,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(6,88,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(6,86,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(6,89,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(6,193,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(6,187,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(6,95,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(6,20,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1);
INSERT INTO `system_role_menu` (`role_id`,`menu_id`,`creator`,`create_time`,`updater`,`update_time`,`deleted`,`tenant_id`) VALUES
(10,1,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(10,4,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(10,7,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(10,8,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1);
/*!40000 ALTER TABLE `system_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_sms_channel`
--

DROP TABLE IF EXISTS `system_sms_channel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_sms_channel` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `signature` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信签名',
  `code` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '渠道编码',
  `status` tinyint NOT NULL COMMENT '开启状态',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `api_key` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信 API 的账号',
  `api_secret` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '短信 API 的秘钥',
  `callback_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '短信发送回调 URL',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='短信渠道';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_sms_channel`
--

LOCK TABLES `system_sms_channel` WRITE;
/*!40000 ALTER TABLE `system_sms_channel` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_sms_channel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_sms_code`
--

DROP TABLE IF EXISTS `system_sms_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_sms_code` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '手机号',
  `code` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '验证码',
  `create_ip` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建 IP',
  `scene` tinyint NOT NULL COMMENT '发送场景',
  `today_index` tinyint NOT NULL COMMENT '今日发送的第几条',
  `used` tinyint NOT NULL COMMENT '是否使用',
  `used_time` datetime DEFAULT NULL COMMENT '使用时间',
  `used_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '使用 IP',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_mobile` (`mobile`) USING BTREE COMMENT '手机号'
) ENGINE=InnoDB AUTO_INCREMENT=694 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='手机验证码';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_sms_code`
--

LOCK TABLES `system_sms_code` WRITE;
/*!40000 ALTER TABLE `system_sms_code` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_sms_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_sms_log`
--

DROP TABLE IF EXISTS `system_sms_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_sms_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `channel_id` bigint NOT NULL COMMENT '短信渠道编号',
  `channel_code` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信渠道编码',
  `template_id` bigint NOT NULL COMMENT '模板编号',
  `template_code` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板编码',
  `template_type` tinyint NOT NULL COMMENT '短信类型',
  `template_content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信内容',
  `template_params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信参数',
  `api_template_id` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信 API 的模板编号',
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '手机号',
  `user_id` bigint DEFAULT NULL COMMENT '用户编号',
  `user_type` tinyint DEFAULT NULL COMMENT '用户类型',
  `send_status` tinyint NOT NULL DEFAULT '0' COMMENT '发送状态',
  `send_time` datetime DEFAULT NULL COMMENT '发送时间',
  `api_send_code` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '短信 API 发送结果的编码',
  `api_send_msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '短信 API 发送失败的提示',
  `api_request_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '短信 API 发送返回的唯一请求 ID',
  `api_serial_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '短信 API 发送返回的序号',
  `receive_status` tinyint NOT NULL DEFAULT '0' COMMENT '接收状态',
  `receive_time` datetime DEFAULT NULL COMMENT '接收时间',
  `api_receive_code` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'API 接收结果的编码',
  `api_receive_msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'API 接收结果的说明',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1581 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='短信日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_sms_log`
--

LOCK TABLES `system_sms_log` WRITE;
/*!40000 ALTER TABLE `system_sms_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_sms_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_sms_template`
--

DROP TABLE IF EXISTS `system_sms_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_sms_template` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `type` tinyint NOT NULL COMMENT '模板类型',
  `status` tinyint NOT NULL COMMENT '开启状态',
  `code` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板编码',
  `name` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板名称',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板内容',
  `params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参数数组',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `api_template_id` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信 API 的模板编号',
  `channel_id` bigint NOT NULL COMMENT '短信渠道编号',
  `channel_code` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信渠道编码',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='短信模板';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_sms_template`
--

LOCK TABLES `system_sms_template` WRITE;
/*!40000 ALTER TABLE `system_sms_template` DISABLE KEYS */;
INSERT INTO `system_sms_template` VALUES (18,1,0,'admin-reset-password','后台用户 - 忘记密码','您的验证码{code}，该验证码 5 分钟内有效，请勿泄漏于他人！','[\"code\"]','','null',4,'DEBUG_DING_TALK','1','2025-03-16 14:19:34','1','2025-03-16 14:19:45',_binary '\0');
INSERT INTO `system_sms_template` VALUES (19,1,0,'admin-sms-login','后台用户短信登录','您的验证码是{code}','[\"code\"]','','4372216',4,'DEBUG_DING_TALK','1','2025-04-08 09:36:03','1','2025-04-08 09:36:17',_binary '\0');
/*!40000 ALTER TABLE `system_sms_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_social_client`
--

DROP TABLE IF EXISTS `system_social_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_social_client` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用名',
  `social_type` tinyint NOT NULL COMMENT '社交平台的类型',
  `user_type` tinyint NOT NULL COMMENT '用户类型',
  `client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端编号',
  `client_secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端密钥',
  `agent_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '代理编号',
  `public_key` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'publicKey 公钥',
  `status` tinyint NOT NULL COMMENT '状态',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='社交客户端表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_social_client`
--

LOCK TABLES `system_social_client` WRITE;
/*!40000 ALTER TABLE `system_social_client` DISABLE KEYS */;
INSERT INTO `system_social_client` VALUES (1,'钉钉',20,2,'<scrubbed>','<scrubbed>',NULL,NULL,0,'','2023-10-18 11:21:18','1','2026-08-29 22:01:21',_binary '',1);
INSERT INTO `system_social_client` VALUES (3,'微信公众号',31,1,'<scrubbed>','<scrubbed>',NULL,NULL,0,'','2023-10-18 16:07:46','1','2026-08-29 22:01:21',_binary '',1);
INSERT INTO `system_social_client` VALUES (43,'微信小程序',34,1,'<scrubbed>','<scrubbed>',NULL,NULL,0,'','2023-10-19 13:37:41','1','2026-08-29 22:01:21',_binary '',1);
/*!40000 ALTER TABLE `system_social_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_social_user`
--

DROP TABLE IF EXISTS `system_social_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_social_user` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键(自增策略)',
  `type` tinyint NOT NULL COMMENT '社交平台的类型',
  `openid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '社交 openid',
  `token` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '社交 token',
  `raw_token_info` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '原始 Token 数据，一般是 JSON 格式',
  `nickname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户昵称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户头像',
  `raw_user_info` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '原始用户数据，一般是 JSON 格式',
  `code` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '最后一次的认证 code',
  `state` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '最后一次的认证 state',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_type_openid` (`type`,`openid`) USING BTREE,
  KEY `idx_type_code_state` (`type`,`code`,`state`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='社交用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_social_user`
--

LOCK TABLES `system_social_user` WRITE;
/*!40000 ALTER TABLE `system_social_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_social_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_social_user_bind`
--

DROP TABLE IF EXISTS `system_social_user_bind`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_social_user_bind` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键(自增策略)',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `user_type` tinyint NOT NULL COMMENT '用户类型',
  `social_type` tinyint NOT NULL COMMENT '社交平台的类型',
  `social_user_id` bigint NOT NULL COMMENT '社交用户的编号',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_type_social_user_id` (`user_type`,`social_user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='社交绑定表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_social_user_bind`
--

LOCK TABLES `system_social_user_bind` WRITE;
/*!40000 ALTER TABLE `system_social_user_bind` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_social_user_bind` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_tenant`
--

DROP TABLE IF EXISTS `system_tenant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_tenant` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '租户编号',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '租户名',
  `contact_user_id` bigint DEFAULT NULL COMMENT '联系人的用户编号',
  `contact_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '联系人',
  `contact_mobile` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系手机',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '租户状态',
  `websites` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '绑定域名数组',
  `package_id` bigint NOT NULL COMMENT '租户套餐编号',
  `expire_time` datetime NOT NULL COMMENT '过期时间',
  `account_count` int NOT NULL COMMENT '账号数量',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='租户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_tenant`
--

LOCK TABLES `system_tenant` WRITE;
/*!40000 ALTER TABLE `system_tenant` DISABLE KEYS */;
INSERT INTO `system_tenant` VALUES (1,'光何',NULL,'光何','17321315478',0,'127.0.0.1:3000',0,'2099-02-19 17:14:16',9999,'1','2021-01-05 17:03:47','1','2026-08-29 11:34:46',_binary '\0');
/*!40000 ALTER TABLE `system_tenant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_tenant_package`
--

DROP TABLE IF EXISTS `system_tenant_package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_tenant_package` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '套餐编号',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '套餐名',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '租户状态（0正常 1停用）',
  `remark` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '备注',
  `menu_ids` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '关联的菜单编号',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='租户套餐表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_tenant_package`
--

LOCK TABLES `system_tenant_package` WRITE;
/*!40000 ALTER TABLE `system_tenant_package` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_tenant_package` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_user_post`
--

DROP TABLE IF EXISTS `system_user_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_user_post` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT '用户ID',
  `post_id` bigint NOT NULL DEFAULT '0' COMMENT '岗位ID',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户岗位表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_user_post`
--

LOCK TABLES `system_user_post` WRITE;
/*!40000 ALTER TABLE `system_user_post` DISABLE KEYS */;
INSERT INTO `system_user_post` (`user_id`,`post_id`,`creator`,`create_time`,`updater`,`update_time`,`deleted`,`tenant_id`) VALUES
(1001,1,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1002,14,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1003,13,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1004,15,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1005,2,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1006,5,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1007,5,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1008,5,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1009,4,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1010,6,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1011,6,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1012,7,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1013,7,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1014,3,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1015,9,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1016,8,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1017,11,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1018,10,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1019,12,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1020,5,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1021,7,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1022,4,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1023,12,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1);
/*!40000 ALTER TABLE `system_user_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_user_role`
--

DROP TABLE IF EXISTS `system_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_user_role` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增编号',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户和角色关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_user_role`
--

LOCK TABLES `system_user_role` WRITE;
/*!40000 ALTER TABLE `system_user_role` DISABLE KEYS */;
INSERT INTO `system_user_role` (`user_id`,`role_id`,`creator`,`create_time`,`updater`,`update_time`,`deleted`,`tenant_id`) VALUES
(1,1,'','2021-01-05 17:03:47','','2026-01-05 09:00:00',_binary '\0',1),
(1001,3,'','2026-01-05 09:00:00','','2026-01-05 09:00:00',_binary '\0',1),
(1002,10,'','2026-01-05 09:00:00','','2026-01-05 09:00:00',_binary '\0',1),
(1003,9,'','2026-01-05 09:00:00','','2026-01-05 09:00:00',_binary '\0',1),
(1004,11,'','2026-01-05 09:00:00','','2026-01-05 09:00:00',_binary '\0',1),
(1005,3,'','2026-01-05 09:00:00','','2026-01-05 09:00:00',_binary '\0',1),
(1006,4,'','2026-01-05 09:00:00','','2026-01-05 09:00:00',_binary '\0',1),
(1007,4,'','2026-01-05 09:00:00','','2026-01-05 09:00:00',_binary '\0',1),
(1008,4,'','2026-01-05 09:00:00','','2026-01-05 09:00:00',_binary '\0',1),
(1009,3,'','2026-01-05 09:00:00','','2026-01-05 09:00:00',_binary '\0',1),
(1010,4,'','2026-01-05 09:00:00','','2026-01-05 09:00:00',_binary '\0',1),
(1011,4,'','2026-01-05 09:00:00','','2026-01-05 09:00:00',_binary '\0',1),
(1012,5,'','2026-01-05 09:00:00','','2026-01-05 09:00:00',_binary '\0',1),
(1013,5,'','2026-01-05 09:00:00','','2026-01-05 09:00:00',_binary '\0',1),
(1014,7,'','2026-01-05 09:00:00','','2026-01-05 09:00:00',_binary '\0',1),
(1015,11,'','2026-01-05 09:00:00','','2026-01-05 09:00:00',_binary '\0',1),
(1016,6,'','2026-01-05 09:00:00','','2026-01-05 09:00:00',_binary '\0',1),
(1017,11,'','2026-01-05 09:00:00','','2026-01-05 09:00:00',_binary '\0',1),
(1018,8,'','2026-01-05 09:00:00','','2026-01-05 09:00:00',_binary '\0',1),
(1019,11,'','2026-01-05 09:00:00','','2026-01-05 09:00:00',_binary '\0',1),
(1020,4,'','2026-01-05 09:00:00','','2026-01-05 09:00:00',_binary '\0',1),
(1021,5,'','2026-01-05 09:00:00','','2026-01-05 09:00:00',_binary '\0',1),
(1022,3,'','2026-01-05 09:00:00','','2026-01-05 09:00:00',_binary '\0',1),
(1023,11,'','2026-01-05 09:00:00','','2026-01-05 09:00:00',_binary '\0',1);
/*!40000 ALTER TABLE `system_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_users`
--

DROP TABLE IF EXISTS `system_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_users` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户账号',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码',
  `nickname` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户昵称',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `dept_id` bigint DEFAULT NULL COMMENT '部门ID',
  `post_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '岗位编号数组',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '用户邮箱',
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '手机号码',
  `sex` tinyint DEFAULT '0' COMMENT '用户性别',
  `avatar` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '头像地址',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `login_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_username` (`username`) USING BTREE,
  KEY `idx_mobile` (`mobile`) USING BTREE,
  KEY `idx_email` (`email`) USING BTREE,
  KEY `idx_dept_id` (`dept_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_users`
--

LOCK TABLES `system_users` WRITE;
/*!40000 ALTER TABLE `system_users` DISABLE KEYS */;
INSERT INTO `system_users` VALUES
(1,'admin','$2a$04$EMZp7AaE2aG7M0sjmKRvS.fCn8Q3YcwctZvXSpG/IHc4SYle9UKv6','光何','管理员',101,'[]','admin@guanghe.com.cn','13800100000',1,NULL,0,NULL,NULL,'admin','2021-01-05 17:03:47','admin','2026-01-05 09:00:00',_binary '\0',1),
(1001,'liubei','$2a$04$EMZp7AaE2aG7M0sjmKRvS.fCn8Q3YcwctZvXSpG/IHc4SYle9UKv6','刘备','集团总经理',101,'[1]','liubei@guanghe.com.cn','13800100001',1,NULL,0,NULL,NULL,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1002,'sunshangxiang','$2a$04$EMZp7AaE2aG7M0sjmKRvS.fCn8Q3YcwctZvXSpG/IHc4SYle9UKv6','孙尚香','人力资源部 人力资源专员',121,'[14]','sunshangxiang@guanghe.com.cn','13800100002',2,NULL,0,NULL,NULL,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1003,'xunyu','$2a$04$EMZp7AaE2aG7M0sjmKRvS.fCn8Q3YcwctZvXSpG/IHc4SYle9UKv6','荀彧','财务部 财务专员',120,'[13]','xunyu@guanghe.com.cn','13800100003',1,NULL,0,NULL,NULL,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1004,'xiaoqiao','$2a$04$EMZp7AaE2aG7M0sjmKRvS.fCn8Q3YcwctZvXSpG/IHc4SYle9UKv6','小乔','行政部 行政专员',122,'[15]','xiaoqiao@guanghe.com.cn','13800100004',2,NULL,0,NULL,NULL,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1005,'zhugeliang','$2a$04$EMZp7AaE2aG7M0sjmKRvS.fCn8Q3YcwctZvXSpG/IHc4SYle9UKv6','诸葛亮','研发中心 技术总监',110,'[2]','zhugeliang@guanghe.com.cn','13800100005',1,NULL,0,NULL,NULL,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1006,'guanyu','$2a$04$EMZp7AaE2aG7M0sjmKRvS.fCn8Q3YcwctZvXSpG/IHc4SYle9UKv6','关羽','平台研发部 Java 开发工程师',111,'[5]','guanyu@guanghe.com.cn','13800100006',1,NULL,0,NULL,NULL,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1007,'zhangfei','$2a$04$EMZp7AaE2aG7M0sjmKRvS.fCn8Q3YcwctZvXSpG/IHc4SYle9UKv6','张飞','平台研发部 Java 开发工程师',111,'[5]','zhangfei@guanghe.com.cn','13800100007',1,NULL,0,NULL,NULL,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1008,'zhaoyun','$2a$04$EMZp7AaE2aG7M0sjmKRvS.fCn8Q3YcwctZvXSpG/IHc4SYle9UKv6','赵云','应用研发部 Java 开发工程师',112,'[5]','zhaoyun@guanghe.com.cn','13800100008',1,NULL,0,NULL,NULL,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1009,'machao','$2a$04$EMZp7AaE2aG7M0sjmKRvS.fCn8Q3YcwctZvXSpG/IHc4SYle9UKv6','马超','应用研发部 项目经理',112,'[4]','machao@guanghe.com.cn','13800100009',1,NULL,0,NULL,NULL,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1010,'huangzhong','$2a$04$EMZp7AaE2aG7M0sjmKRvS.fCn8Q3YcwctZvXSpG/IHc4SYle9UKv6','黄忠','前端研发部 前端开发工程师',113,'[6]','huangzhong@guanghe.com.cn','13800100010',1,NULL,0,NULL,NULL,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1011,'diaochan','$2a$04$EMZp7AaE2aG7M0sjmKRvS.fCn8Q3YcwctZvXSpG/IHc4SYle9UKv6','貂蝉','前端研发部 前端开发工程师',113,'[6]','diaochan@guanghe.com.cn','13800100011',2,NULL,0,NULL,NULL,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1012,'daqiao','$2a$04$EMZp7AaE2aG7M0sjmKRvS.fCn8Q3YcwctZvXSpG/IHc4SYle9UKv6','大乔','测试部 测试工程师',114,'[7]','daqiao@guanghe.com.cn','13800100012',2,NULL,0,NULL,NULL,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1013,'weiyan','$2a$04$EMZp7AaE2aG7M0sjmKRvS.fCn8Q3YcwctZvXSpG/IHc4SYle9UKv6','魏延','测试部 测试工程师',114,'[7]','weiyan@guanghe.com.cn','13800100013',1,NULL,0,NULL,NULL,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1014,'pangtong','$2a$04$EMZp7AaE2aG7M0sjmKRvS.fCn8Q3YcwctZvXSpG/IHc4SYle9UKv6','庞统','产品部 产品经理',115,'[3]','pangtong@guanghe.com.cn','13800100014',1,NULL,0,NULL,NULL,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1015,'caiwenji','$2a$04$EMZp7AaE2aG7M0sjmKRvS.fCn8Q3YcwctZvXSpG/IHc4SYle9UKv6','蔡文姬','产品部 UI 设计师',115,'[9]','caiwenji@guanghe.com.cn','13800100015',2,NULL,0,NULL,NULL,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1016,'zhangliao','$2a$04$EMZp7AaE2aG7M0sjmKRvS.fCn8Q3YcwctZvXSpG/IHc4SYle9UKv6','张辽','运维部 运维工程师',116,'[8]','zhangliao@guanghe.com.cn','13800100016',1,NULL,0,NULL,NULL,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1017,'lusu','$2a$04$EMZp7AaE2aG7M0sjmKRvS.fCn8Q3YcwctZvXSpG/IHc4SYle9UKv6','鲁肃','市场部 售前顾问',117,'[11]','lusu@guanghe.com.cn','13800100017',1,NULL,0,NULL,NULL,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1018,'caocao','$2a$04$EMZp7AaE2aG7M0sjmKRvS.fCn8Q3YcwctZvXSpG/IHc4SYle9UKv6','曹操','销售部 销售经理',118,'[10]','caocao@guanghe.com.cn','13800100018',1,NULL,0,NULL,NULL,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1019,'huangyueying','$2a$04$EMZp7AaE2aG7M0sjmKRvS.fCn8Q3YcwctZvXSpG/IHc4SYle9UKv6','黄月英','客户服务部 客户成功专员',119,'[12]','huangyueying@guanghe.com.cn','13800100019',2,NULL,0,NULL,NULL,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1020,'jiangwei','$2a$04$EMZp7AaE2aG7M0sjmKRvS.fCn8Q3YcwctZvXSpG/IHc4SYle9UKv6','姜维','上海研发部 Java 开发工程师',130,'[5]','jiangwei@guanghe.com.cn','13800100020',1,NULL,0,NULL,NULL,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1021,'zhurong','$2a$04$EMZp7AaE2aG7M0sjmKRvS.fCn8Q3YcwctZvXSpG/IHc4SYle9UKv6','祝融','上海研发部 测试工程师',130,'[7]','zhurong@guanghe.com.cn','13800100021',2,NULL,0,NULL,NULL,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1022,'luxun','$2a$04$EMZp7AaE2aG7M0sjmKRvS.fCn8Q3YcwctZvXSpG/IHc4SYle9UKv6','陆逊','上海交付部 项目经理',131,'[4]','luxun@guanghe.com.cn','13800100022',1,NULL,0,NULL,NULL,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1),
(1023,'zhouyu','$2a$04$EMZp7AaE2aG7M0sjmKRvS.fCn8Q3YcwctZvXSpG/IHc4SYle9UKv6','周瑜','上海市场部 客户成功专员',132,'[12]','zhouyu@guanghe.com.cn','13800100023',1,NULL,0,NULL,NULL,'admin','2026-01-05 09:00:00','admin','2026-01-05 09:00:00',_binary '\0',1);
/*!40000 ALTER TABLE `system_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed
