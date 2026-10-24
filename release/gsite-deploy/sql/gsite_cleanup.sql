-- ============================================================
-- 演示数据清理：只保留系统/基础设施两个模块真正会用到的数据
-- 说明：
--   1) 幂等脚本，可重复执行
--   2) 清理 AI / IoT 模块（已从代码中裁剪）残留的字典
--   3) 清理各菜单下的测试数据：三方登录、OAuth2 客户端、短信/邮件模板、
--      通知公告、参数配置、定时任务、文件配置、日志与令牌
-- ============================================================

SET NAMES utf8mb4;

START TRANSACTION;

-- ---------------- 字典：删除已裁剪模块（AI / IoT）的类型与数据 ----------------
DELETE FROM `system_dict_data` WHERE `dict_type` LIKE 'ai\_%' OR `dict_type` LIKE 'iot\_%';
DELETE FROM `system_dict_type` WHERE `type` LIKE 'ai\_%' OR `type` LIKE 'iot\_%';

-- 补齐代码里引用、但字典类型表缺失的两项（数据本身已存在）
DELETE FROM `system_dict_type` WHERE `type` IN ('system_menu_type', 'system_data_scope');
INSERT INTO `system_dict_type`
(`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`)
VALUES
(116, '菜单类型', 'system_menu_type', 0, '菜单的类型：目录、菜单、按钮', 'admin', '2026-01-05 09:00:00', 'admin', '2026-01-05 09:00:00', _binary '\0'),
(117, '数据范围', 'system_data_scope', 0, '角色可访问的数据范围', 'admin', '2026-01-05 09:00:00', 'admin', '2026-01-05 09:00:00', _binary '\0');

-- ---------------- OAuth 2.0：删除测试与 SSO 演示客户端 ----------------
DELETE FROM `system_oauth2_client`
WHERE `client_id` IN ('test', 'guanghe-sso-demo-by-code', 'guanghe-sso-demo-by-password');

-- ---------------- 三方登录：删除名称为 1 / 123 的测试配置 ----------------
DELETE FROM `system_social_client` WHERE `id` IN (44, 45, 46, 47);

-- ---------------- 消息中心：短信渠道、模板、邮件、站内信 ----------------
DELETE FROM `system_sms_channel`;
DELETE FROM `system_sms_template` WHERE `code` NOT IN ('admin-reset-password', 'admin-sms-login');
DELETE FROM `system_sms_log`;
DELETE FROM `system_mail_account`;
DELETE FROM `system_mail_template` WHERE `code` = 'test_01' OR `name` = '3';
DELETE FROM `system_mail_log`;
DELETE FROM `system_notify_message`;

-- ---------------- 通知公告：删除测试公告，保留并规范维护通知 ----------------
DELETE FROM `system_notice` WHERE `id` = 1;
UPDATE `system_notice`
SET `title` = '光何集团系统例行维护通知',
    `content` = '<p>系统将于每周日凌晨 02:00 - 04:00 进行例行维护，请提前保存好数据。</p>',
    `status` = 0,
    `updater` = 'admin',
    `update_time` = '2026-01-05 09:00:00'
WHERE `id` = 2;

-- ---------------- 基础设施：参数、定时任务、文件配置 ----------------
DELETE FROM `infra_config` WHERE `config_key` IN ('test2', 'test3', 'test4');
UPDATE `infra_config`
SET `category` = 'biz', `updater` = 'admin', `update_time` = '2026-01-05 09:00:00'
WHERE `config_key` = 'system.user.register-enabled';

DELETE FROM `infra_job` WHERE `id` = 33;
DELETE FROM `infra_job_log`;

-- 示例存储器（都是假的 AccessKey，留着只会误导）全部清掉，由运维按需新增
DELETE FROM `infra_file_config`;
DELETE FROM `infra_file`;

-- ---------------- 日志与令牌：清空历史记录 ----------------
DELETE FROM `infra_api_access_log`;
DELETE FROM `infra_api_error_log`;
DELETE FROM `system_login_log`;
DELETE FROM `system_operate_log`;
DELETE FROM `system_oauth2_access_token`;
DELETE FROM `system_oauth2_refresh_token`;

COMMIT;
