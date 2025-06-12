-- 创建数据库
CREATE DATABASE sweeping_platform;

-- 切换到数据库
USE sweeping_platform;

/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50741
Source Host           : localhost:3306
Source Database       : sweeping_platform

Target Server Type    : MYSQL
Target Server Version : 50741
File Encoding         : 65001

Date: 2025-04-30 10:24:44
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `auth_group`
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for `auth_group_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for `auth_permission`
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', 'Can add log entry', '1', 'add_logentry');
INSERT INTO `auth_permission` VALUES ('2', 'Can change log entry', '1', 'change_logentry');
INSERT INTO `auth_permission` VALUES ('3', 'Can delete log entry', '1', 'delete_logentry');
INSERT INTO `auth_permission` VALUES ('4', 'Can view log entry', '1', 'view_logentry');
INSERT INTO `auth_permission` VALUES ('5', 'Can add permission', '2', 'add_permission');
INSERT INTO `auth_permission` VALUES ('6', 'Can change permission', '2', 'change_permission');
INSERT INTO `auth_permission` VALUES ('7', 'Can delete permission', '2', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('8', 'Can view permission', '2', 'view_permission');
INSERT INTO `auth_permission` VALUES ('9', 'Can add group', '3', 'add_group');
INSERT INTO `auth_permission` VALUES ('10', 'Can change group', '3', 'change_group');
INSERT INTO `auth_permission` VALUES ('11', 'Can delete group', '3', 'delete_group');
INSERT INTO `auth_permission` VALUES ('12', 'Can view group', '3', 'view_group');
INSERT INTO `auth_permission` VALUES ('13', 'Can add content type', '4', 'add_contenttype');
INSERT INTO `auth_permission` VALUES ('14', 'Can change content type', '4', 'change_contenttype');
INSERT INTO `auth_permission` VALUES ('15', 'Can delete content type', '4', 'delete_contenttype');
INSERT INTO `auth_permission` VALUES ('16', 'Can view content type', '4', 'view_contenttype');
INSERT INTO `auth_permission` VALUES ('17', 'Can add session', '5', 'add_session');
INSERT INTO `auth_permission` VALUES ('18', 'Can change session', '5', 'change_session');
INSERT INTO `auth_permission` VALUES ('19', 'Can delete session', '5', 'delete_session');
INSERT INTO `auth_permission` VALUES ('20', 'Can view session', '5', 'view_session');
INSERT INTO `auth_permission` VALUES ('21', 'Can add user', '6', 'add_user');
INSERT INTO `auth_permission` VALUES ('22', 'Can change user', '6', 'change_user');
INSERT INTO `auth_permission` VALUES ('23', 'Can delete user', '6', 'delete_user');
INSERT INTO `auth_permission` VALUES ('24', 'Can view user', '6', 'view_user');
INSERT INTO `auth_permission` VALUES ('25', 'Can add 车辆', '7', 'add_vehicle');
INSERT INTO `auth_permission` VALUES ('26', 'Can change 车辆', '7', 'change_vehicle');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete 车辆', '7', 'delete_vehicle');
INSERT INTO `auth_permission` VALUES ('28', 'Can view 车辆', '7', 'view_vehicle');
INSERT INTO `auth_permission` VALUES ('29', 'Can add 调度记录', '8', 'add_schedule');
INSERT INTO `auth_permission` VALUES ('30', 'Can change 调度记录', '8', 'change_schedule');
INSERT INTO `auth_permission` VALUES ('31', 'Can delete 调度记录', '8', 'delete_schedule');
INSERT INTO `auth_permission` VALUES ('32', 'Can view 调度记录', '8', 'view_schedule');
INSERT INTO `auth_permission` VALUES ('33', 'Can add 作业记录', '9', 'add_operation');
INSERT INTO `auth_permission` VALUES ('34', 'Can change 作业记录', '9', 'change_operation');
INSERT INTO `auth_permission` VALUES ('35', 'Can delete 作业记录', '9', 'delete_operation');
INSERT INTO `auth_permission` VALUES ('36', 'Can view 作业记录', '9', 'view_operation');

-- ----------------------------
-- Table structure for `django_admin_log`
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_sweeping_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_sweeping_user_id` FOREIGN KEY (`user_id`) REFERENCES `sweeping_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES ('1', '2025-02-27 03:28:11.444273', '2', 'test', '1', '[{\"added\": {}}]', '6', '1');

-- ----------------------------
-- Table structure for `django_content_type`
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('1', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('3', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('2', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('4', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('5', 'sessions', 'session');
INSERT INTO `django_content_type` VALUES ('9', 'sweeping', 'operation');
INSERT INTO `django_content_type` VALUES ('8', 'sweeping', 'schedule');
INSERT INTO `django_content_type` VALUES ('6', 'sweeping', 'user');
INSERT INTO `django_content_type` VALUES ('7', 'sweeping', 'vehicle');

-- ----------------------------
-- Table structure for `django_migrations`
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'contenttypes', '0001_initial', '2025-02-26 08:02:14.996966');
INSERT INTO `django_migrations` VALUES ('2', 'contenttypes', '0002_remove_content_type_name', '2025-02-26 08:02:15.107542');
INSERT INTO `django_migrations` VALUES ('3', 'auth', '0001_initial', '2025-02-26 08:02:15.459174');
INSERT INTO `django_migrations` VALUES ('4', 'auth', '0002_alter_permission_name_max_length', '2025-02-26 08:02:15.533787');
INSERT INTO `django_migrations` VALUES ('5', 'auth', '0003_alter_user_email_max_length', '2025-02-26 08:02:15.541159');
INSERT INTO `django_migrations` VALUES ('6', 'auth', '0004_alter_user_username_opts', '2025-02-26 08:02:15.549795');
INSERT INTO `django_migrations` VALUES ('7', 'auth', '0005_alter_user_last_login_null', '2025-02-26 08:02:15.557429');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0006_require_contenttypes_0002', '2025-02-26 08:02:15.561842');
INSERT INTO `django_migrations` VALUES ('9', 'auth', '0007_alter_validators_add_error_messages', '2025-02-26 08:02:15.569012');
INSERT INTO `django_migrations` VALUES ('10', 'auth', '0008_alter_user_username_max_length', '2025-02-26 08:02:15.575430');
INSERT INTO `django_migrations` VALUES ('11', 'auth', '0009_alter_user_last_name_max_length', '2025-02-26 08:02:15.582913');
INSERT INTO `django_migrations` VALUES ('12', 'auth', '0010_alter_group_name_max_length', '2025-02-26 08:02:15.598331');
INSERT INTO `django_migrations` VALUES ('13', 'auth', '0011_update_proxy_permissions', '2025-02-26 08:02:15.606043');
INSERT INTO `django_migrations` VALUES ('14', 'auth', '0012_alter_user_first_name_max_length', '2025-02-26 08:02:15.614197');
INSERT INTO `django_migrations` VALUES ('15', 'sweeping', '0001_initial', '2025-02-26 08:02:16.425907');
INSERT INTO `django_migrations` VALUES ('16', 'admin', '0001_initial', '2025-02-26 08:02:16.598420');
INSERT INTO `django_migrations` VALUES ('17', 'admin', '0002_logentry_remove_auto_add', '2025-02-26 08:02:16.608419');
INSERT INTO `django_migrations` VALUES ('18', 'admin', '0003_logentry_add_action_flag_choices', '2025-02-26 08:02:16.618424');
INSERT INTO `django_migrations` VALUES ('19', 'sessions', '0001_initial', '2025-02-26 08:02:16.680421');

-- ----------------------------
-- Table structure for `django_session`
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('6s7k4kjbynnnpbfay73g2gnwcmco65n0', '.eJxVjEEOwiAQRe_C2hDowBRcuu8ZCDCjVA0kpV0Z765NutDtf-_9lwhxW0vYOi9hJnEWWpx-txTzg-sO6B7rrcnc6rrMSe6KPGiXUyN-Xg7376DEXr61uybkjN5HBrSWcyanoyXQMHiLoPMI2hqlAVmRGwlQAZEZDKL1Ton3B9kjNrw:1u6mgf:Lw8KiIANoJ1xlWXK4oD5UqNI-Zz80mam4JDxbmj6Rfs', '2025-05-05 08:39:33.335658');
INSERT INTO `django_session` VALUES ('dv1jhmt4nzr3w8tp9pnnlmeelhigjvtk', '.eJxVjEEOwiAQRe_C2hDowBRcuu8ZCDCjVA0kpV0Z765NutDtf-_9lwhxW0vYOi9hJnEWWpx-txTzg-sO6B7rrcnc6rrMSe6KPGiXUyN-Xg7376DEXr61uybkjN5HBrSWcyanoyXQMHiLoPMI2hqlAVmRGwlQAZEZDKL1Ton3B9kjNrw:1u7pwq:Dq6xV-fWSh5NtFyy7ksuVqxE_MZyWG_gyVoNzrgvLpw', '2025-05-08 06:20:36.869623');
INSERT INTO `django_session` VALUES ('lowrrjq4b6ft7duf6t1x77qnqvity6iu', '.eJxVjEEOwiAQRe_C2hBgyhRcuu8ZCDCjVA0kpV0Z765NutDtf-_9lwhxW0vYOi9hJnEWRpx-txTzg-sO6B7rrcnc6rrMSe6KPGiXUyN-Xg7376DEXr61uybkjN5HBrSWcyanoyXQYLxF0HkEbQelAVmRGwlQAdFgBkTrnRLvD9m8Nr0:1tnUav:ItRyoGav2Kt-HhQfqa3STKsXaOHDHfX96IPku3kpa6I', '2025-03-13 03:29:53.940653');
INSERT INTO `django_session` VALUES ('mlxob2swd0e0ln5afwcbl5i5puyqhpk1', '.eJxVjEEOwiAQRe_C2hDowBRcuu8ZCDCjVA0kpV0Z765NutDtf-_9lwhxW0vYOi9hJnEWWpx-txTzg-sO6B7rrcnc6rrMSe6KPGiXUyN-Xg7376DEXr61uybkjN5HBrSWcyanoyXQMHiLoPMI2hqlAVmRGwlQAZEZDKL1Ton3B9kjNrw:1u2PDA:JFF4w3HWV0zcM7fVlSlFBKugwddjIJcPpDirKWgZ5ws', '2025-04-23 06:47:00.818783');
INSERT INTO `django_session` VALUES ('ztonyqvczzfx6y8v1881ihbnoj4kpi50', '.eJxVjEEOwiAQRe_C2hDowBRcuu8ZCDCjVA0kpV0Z765NutDtf-_9lwhxW0vYOi9hJnEWWpx-txTzg-sO6B7rrcnc6rrMSe6KPGiXUyN-Xg7376DEXr61uybkjN5HBrSWcyanoyXQMHiLoPMI2hqlAVmRGwlQAZEZDKL1Ton3B9kjNrw:1tnCVw:S-xwP6CTBC7lBjv4oEjbBnyZh9PuEWTc8lQxfRfXewg', '2025-03-12 08:11:32.372113');

-- ----------------------------
-- Table structure for `sweeping_electronic_fence`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_electronic_fence`;
CREATE TABLE `sweeping_electronic_fence` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL COMMENT '电子围栏名称',
  `path_file_name` varchar(100) NOT NULL COMMENT '电子围栏文件名称',
  `path_file_url` varchar(110) NOT NULL COMMENT '电子围栏文件链接',
  `created_at` datetime(6) NOT NULL COMMENT '创建时间',
  `update_at` datetime(6) NOT NULL COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL COMMENT '创建人用户id',
  PRIMARY KEY (`id`),
  KEY `sweeping_electronic_fence_name` (`name`),
  KEY `sweeping_electronic_fence_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='电子围栏设置表';

-- ----------------------------
-- Records of sweeping_electronic_fence
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_operation`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_operation`;
CREATE TABLE `sweeping_operation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `operation_date` date NOT NULL,
  `duration` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `schedule_id` bigint(20) NOT NULL,
  `vehicle_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sweeping_operation_schedule_id_30c6aff0_fk_sweeping_schedule_id` (`schedule_id`),
  KEY `sweeping_operation_vehicle_id_c5dec5d8_fk_sweeping_vehicle_id` (`vehicle_id`),
  CONSTRAINT `sweeping_operation_schedule_id_30c6aff0_fk_sweeping_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `sweeping_schedule` (`id`),
  CONSTRAINT `sweeping_operation_vehicle_id_c5dec5d8_fk_sweeping_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `sweeping_vehicle` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sweeping_operation
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_schedule`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_schedule`;
CREATE TABLE `sweeping_schedule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `schedule_id` char(32) NOT NULL,
  `route_file_url` varchar(200) NOT NULL,
  `route_name` varchar(100) NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `vehicle_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sweeping_schedule_vehicle_id_7265d971_fk_sweeping_vehicle_id` (`vehicle_id`),
  CONSTRAINT `sweeping_schedule_vehicle_id_7265d971_fk_sweeping_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `sweeping_vehicle` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sweeping_schedule
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_ship`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_ship`;
CREATE TABLE `sweeping_ship` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `imo` varchar(17) NOT NULL COMMENT '国际海事组织识别码',
  `mmsi` varchar(17) NOT NULL COMMENT '水上移动通信标识码',
  `official_number` varchar(20) NOT NULL COMMENT '船舶登记号',
  `ship_number` varchar(10) NOT NULL COMMENT '船体号',
  `ship_name` varchar(10) NOT NULL COMMENT '船舶名称',
  `manufacturer` varchar(50) NOT NULL COMMENT '生产商',
  `brand` varchar(50) NOT NULL COMMENT '品牌',
  `model` varchar(50) DEFAULT NULL COMMENT '型号',
  `operation_date` date NOT NULL COMMENT '投入运营日期',
  `created_at` datetime(6) NOT NULL COMMENT '创建时间',
  `update_at` datetime(6) NOT NULL COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `official_number` (`official_number`),
  KEY `sweeping_ship_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='清洁船表';

-- ----------------------------
-- Records of sweeping_ship
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_ship_active_take_over_apply`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_ship_active_take_over_apply`;
CREATE TABLE `sweeping_ship_active_take_over_apply` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `apply_user_id` bigint(20) NOT NULL COMMENT '申请用户id',
  `apply_user_name` varchar(20) NOT NULL COMMENT '申请用户名称',
  `client_id` bigint(20) DEFAULT NULL COMMENT '终端id',
  `client_official_number` varchar(20) NOT NULL COMMENT '终端登记号',
  `client_name` varchar(30) DEFAULT NULL COMMENT '终端名称',
  `take_over_reason` varchar(100) DEFAULT NULL COMMENT '接管原因',
  `examine_status` int(1) NOT NULL COMMENT '申请审核状态',
  `examine_user_id` bigint(20) NOT NULL COMMENT '审核用户id',
  `examine_user_name` varchar(20) NOT NULL COMMENT '审核用户名称',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_official_number` (`client_official_number`),
  KEY `apply_user_name` (`apply_user_name`),
  KEY `sweeping_ship_active_take_over_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='无人清洁船主动接管授权申请表';

-- ----------------------------
-- Records of sweeping_ship_active_take_over_apply
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_ship_active_take_over_authorize`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_ship_active_take_over_authorize`;
CREATE TABLE `sweeping_ship_active_take_over_authorize` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `apply_id` bigint(20) NOT NULL COMMENT '授权申请id',
  `apply_user_id` bigint(20) NOT NULL COMMENT '申请用户id',
  `apply_user_name` varchar(20) NOT NULL COMMENT '申请用户名称',
  `client_id` bigint(20) DEFAULT NULL COMMENT '终端id',
  `client_official_number` varchar(20) NOT NULL COMMENT '终端登记号',
  `client_name` varchar(30) DEFAULT NULL COMMENT '终端名称',
  `take_over_reason` varchar(100) DEFAULT NULL COMMENT '接管原因',
  `authorize_code` varchar(20) NOT NULL COMMENT '授权码',
  `expire` datetime NOT NULL COMMENT '授权码过期时间',
  `take_over_begin_time` datetime NOT NULL COMMENT '接管开始时间',
  `take_over_end_time` datetime NOT NULL COMMENT '接管结束时间',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_official_number` (`client_official_number`),
  KEY `apply_user_name` (`apply_user_name`),
  KEY `sweeping_uav_electronic_fence_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='无人清洁船主动接管授权表';

-- ----------------------------
-- Records of sweeping_ship_active_take_over_authorize
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_ship_dispatch_path`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_ship_dispatch_path`;
CREATE TABLE `sweeping_ship_dispatch_path` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(30) NOT NULL COMMENT '线路名称',
  `path_file_name` varchar(100) NOT NULL COMMENT '线路文件名称',
  `path_file_url` varchar(110) NOT NULL COMMENT '线路文件链接',
  `created_at` datetime(6) NOT NULL COMMENT '创建时间',
  `update_at` datetime(6) NOT NULL COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL COMMENT '创建人用户id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `dispatch_path_sweeping_ship_name` (`name`),
  KEY `dispatch_path_sweeping_ship_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='清洁船清扫线路表';

-- ----------------------------
-- Records of sweeping_ship_dispatch_path
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_ship_electronic_fence`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_ship_electronic_fence`;
CREATE TABLE `sweeping_ship_electronic_fence` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `electronic_fence_id` varchar(60) NOT NULL COMMENT '电子围栏id',
  `electronic_fence_name` varchar(20) DEFAULT NULL COMMENT '电子围栏名称',
  `client_id` bigint(20) DEFAULT NULL COMMENT '终端id',
  `client_official_number` varchar(20) NOT NULL COMMENT '终端登记号',
  `client_name` varchar(30) DEFAULT NULL COMMENT '终端名称',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `electronic_fence_id_and_client_id` (`electronic_fence_id`,`client_id`),
  KEY `sweeping_ship_client_name` (`client_name`),
  KEY `sweeping_ship_electronic_fence_name` (`electronic_fence_name`),
  KEY `sweeping_ship_electronic_fence_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='无人清洁船电子围栏设置表';

-- ----------------------------
-- Records of sweeping_ship_electronic_fence
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_ship_monitor_stream`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_ship_monitor_stream`;
CREATE TABLE `sweeping_ship_monitor_stream` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ship_id` bigint(20) NOT NULL COMMENT '清洁船id',
  `ship_official_number` varchar(17) NOT NULL COMMENT '清洁船登记号',
  `ship_name` varchar(30) NOT NULL COMMENT '清洁船名称',
  `stream_url` varchar(120) NOT NULL COMMENT '监控推流地址',
  `app_key` varchar(17) NOT NULL COMMENT '推流地址访问密钥',
  `created_at` datetime(6) NOT NULL COMMENT '创建时间',
  `update_at` datetime(6) NOT NULL COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sweeping_ship_id` (`ship_id`),
  KEY `sweeping_ship_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='无人清洁船监控推流设置表';

-- ----------------------------
-- Records of sweeping_ship_monitor_stream
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_ship_passive_take_over_apply`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_ship_passive_take_over_apply`;
CREATE TABLE `sweeping_ship_passive_take_over_apply` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `apply_client_id` bigint(20) NOT NULL COMMENT '申请终端id',
  `apply_client_official_number` varchar(20) NOT NULL COMMENT '申请终端登记号',
  `apply_client_name` varchar(20) NOT NULL COMMENT '申请终端名称',
  `take_over_reason` varchar(100) DEFAULT NULL COMMENT '接管原因',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `apply_client_official_number` (`apply_client_official_number`),
  KEY `apply_client_id` (`apply_client_id`),
  KEY `sweeping_ship_passive_take_over_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='无人清洁船被动接管授权申请表';

-- ----------------------------
-- Records of sweeping_ship_passive_take_over_apply
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_ship_passive_take_over_authorize`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_ship_passive_take_over_authorize`;
CREATE TABLE `sweeping_ship_passive_take_over_authorize` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `apply_id` bigint(20) NOT NULL COMMENT '授权申请id',
  `apply_client_id` bigint(20) NOT NULL COMMENT '申请终端id',
  `apply_client_official_number` varchar(20) NOT NULL COMMENT '申请终端登记号',
  `apply_client_name` varchar(20) NOT NULL COMMENT '申请终端名称',
  `take_over_user_id` bigint(20) DEFAULT NULL COMMENT '接管人id',
  `take_over_name` varchar(20) DEFAULT NULL COMMENT '接管人姓名',
  `take_over_reason` varchar(100) DEFAULT NULL COMMENT '接管原因',
  `authorize_code` varchar(20) NOT NULL COMMENT '授权码',
  `expire` datetime NOT NULL COMMENT '授权码过期时间',
  `take_over_begin_time` datetime NOT NULL COMMENT '接管开始时间',
  `take_over_end_time` datetime NOT NULL COMMENT '接管结束时间',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `apply_id` (`apply_id`),
  KEY `apply_client_id` (`apply_client_id`),
  KEY `take_over_name` (`take_over_name`),
  KEY `sweeping_ship_passive_take_over_authorize_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='无人清洁船被动接管授权表';

-- ----------------------------
-- Records of sweeping_ship_passive_take_over_authorize
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_ship_repair_record`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_ship_repair_record`;
CREATE TABLE `sweeping_ship_repair_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `official_number` varchar(20) NOT NULL COMMENT '船舶登记号',
  `ship_number` varchar(10) NOT NULL COMMENT '船体号',
  `fault_type` varchar(20) NOT NULL COMMENT '故障类型：动力系统故障、控制系统故障、电气系统故障、传感器故障、清扫系统故障',
  `description` varchar(150) NOT NULL COMMENT '故障描述',
  `repair_begin_date` date NOT NULL COMMENT '维修开始日期',
  `repair_end_date` date DEFAULT NULL COMMENT '维修结束日期',
  `created_at` datetime(6) NOT NULL COMMENT '创建时间',
  `update_at` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `official_number` (`official_number`),
  KEY `sweeping_ship_repair_record_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='无人清洁船维修记录表';

-- ----------------------------
-- Records of sweeping_ship_repair_record
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_ship_sensor`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_ship_sensor`;
CREATE TABLE `sweeping_ship_sensor` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ship_id` bigint(20) NOT NULL COMMENT '清洁船id',
  `ship_official_number` varchar(17) NOT NULL COMMENT '清洁船登记号',
  `ship_name` varchar(17) NOT NULL COMMENT '清洁船名称',
  `device_type` varchar(20) NOT NULL COMMENT '设备类型：相机、毫米波雷达、激光雷达、惯导、超声波雷达、其它',
  `device_sn` varchar(17) NOT NULL COMMENT '设备序列号',
  `device_name` varchar(17) NOT NULL COMMENT '设备名称',
  `manufacturer` varchar(50) NOT NULL COMMENT '生产商',
  `brand` varchar(50) NOT NULL COMMENT '品牌',
  `model` varchar(50) NOT NULL COMMENT '型号',
  `created_at` datetime(6) NOT NULL COMMENT '创建时间',
  `update_at` datetime(6) NOT NULL COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `device_sn` (`device_sn`) USING BTREE,
  KEY `sweeping_ship_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='无人清洁船传感器设备表';

-- ----------------------------
-- Records of sweeping_ship_sensor
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_ship_task`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_ship_task`;
CREATE TABLE `sweeping_ship_task` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `name` varchar(30) NOT NULL COMMENT '任务名称',
  `id_path` bigint(20) NOT NULL COMMENT '线路表ID',
  `name_path` varchar(110) NOT NULL COMMENT '线路名称',
  `path_file_name` varchar(100) NOT NULL COMMENT '线路文件名称',
  `path_file_url` varchar(110) NOT NULL COMMENT '线路文件链接',
  `duration` float(20,2) NOT NULL COMMENT '任务时长，单位小时',
  `created_at` datetime(6) NOT NULL COMMENT '创建时间',
  `update_at` datetime(6) NOT NULL COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL COMMENT '创建人用户id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sweeping_ship_task_name` (`name`),
  KEY `sweeping_ship_task_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='清洁船任务表';

-- ----------------------------
-- Records of sweeping_ship_task
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_ship_task_record`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_ship_task_record`;
CREATE TABLE `sweeping_ship_task_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bid` varchar(60) NOT NULL COMMENT '业务id：uuid',
  `tid` varchar(60) NOT NULL COMMENT '事务id：uuid',
  `task_id` varchar(60) NOT NULL COMMENT '任务id',
  `task_name` varchar(20) DEFAULT NULL COMMENT '任务名称',
  `client_id` bigint(20) DEFAULT NULL COMMENT '终端id',
  `client_official_number` varchar(20) NOT NULL COMMENT '终端登记号',
  `client_name` varchar(30) DEFAULT NULL COMMENT '终端名称',
  `task_status` int(3) NOT NULL COMMENT '任务状态：0-未执行，1-执行中，2-已完成，3-暂停，4-终止',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sweeping_ship_client_official_number` (`client_official_number`),
  KEY `sweeping_ship_task_name` (`task_name`),
  KEY `sweeping_ship_task_record_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='无人清洁船任务记录表';

-- ----------------------------
-- Records of sweeping_ship_task_record
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_uav`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_uav`;
CREATE TABLE `sweeping_uav` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `device_sn` varchar(17) NOT NULL COMMENT '设备序列号',
  `device_callsign` varchar(17) NOT NULL COMMENT '设备在组织中的名称',
  `organization_id` varchar(20) NOT NULL COMMENT '组织id',
  `organization_name` varchar(10) NOT NULL COMMENT '组织名称',
  `manufacturer` varchar(50) NOT NULL COMMENT '生产商',
  `brand` varchar(50) NOT NULL COMMENT '品牌',
  `model` varchar(50) NOT NULL COMMENT '型号',
  `operation_date` date NOT NULL COMMENT '投入运营日期',
  `created_at` datetime(6) NOT NULL COMMENT '创建时间',
  `update_at` datetime(6) NOT NULL COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `device_sn` (`device_sn`) USING BTREE,
  KEY `sweeping_ship_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='环卫监测无人机设备表';

-- ----------------------------
-- Records of sweeping_uav
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_uav_active_take_over_apply`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_uav_active_take_over_apply`;
CREATE TABLE `sweeping_uav_active_take_over_apply` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `apply_user_id` bigint(20) NOT NULL COMMENT '申请用户id',
  `apply_user_name` varchar(20) NOT NULL COMMENT '申请用户名称',
  `client_id` bigint(20) DEFAULT NULL COMMENT '终端id',
  `client_device_sn` varchar(20) NOT NULL COMMENT '终端设备序列号',
  `client_device_callsign` varchar(30) DEFAULT NULL COMMENT '终端设备名称',
  `take_over_reason` varchar(100) DEFAULT NULL COMMENT '接管原因',
  `examine_status` int(1) NOT NULL COMMENT '申请审核状态',
  `examine_user_id` bigint(20) NOT NULL COMMENT '审核用户id',
  `examine_user_name` varchar(20) NOT NULL COMMENT '审核用户名称',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_device_callsign` (`client_device_callsign`),
  KEY `apply_user_name` (`apply_user_name`),
  KEY `sweeping_uav_active_take_over_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='无人机主动接管授权申请表';

-- ----------------------------
-- Records of sweeping_uav_active_take_over_apply
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_uav_active_take_over_authorize`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_uav_active_take_over_authorize`;
CREATE TABLE `sweeping_uav_active_take_over_authorize` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `apply_id` bigint(20) NOT NULL COMMENT '授权申请id',
  `apply_user_id` bigint(20) NOT NULL COMMENT '申请用户id',
  `apply_user_name` varchar(20) NOT NULL COMMENT '申请用户名称',
  `client_id` bigint(20) DEFAULT NULL COMMENT '终端id',
  `client_device_sn` varchar(20) NOT NULL COMMENT '终端设备序列号',
  `client_device_callsign` varchar(30) DEFAULT NULL COMMENT '终端设备名称',
  `take_over_reason` varchar(100) DEFAULT NULL COMMENT '接管原因',
  `authorize_code` varchar(20) NOT NULL COMMENT '授权码',
  `expire` datetime NOT NULL COMMENT '授权码过期时间',
  `take_over_begin_time` datetime NOT NULL COMMENT '接管开始时间',
  `take_over_end_time` datetime NOT NULL COMMENT '接管结束时间',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_device_callsign` (`client_device_callsign`),
  KEY `apply_user_name` (`apply_user_name`),
  KEY `sweeping_uav_electronic_fence_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='无人机主动接管授权表';

-- ----------------------------
-- Records of sweeping_uav_active_take_over_authorize
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_uav_dispatch_path`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_uav_dispatch_path`;
CREATE TABLE `sweeping_uav_dispatch_path` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(30) NOT NULL COMMENT '线路名称',
  `path_file_name` varchar(100) NOT NULL COMMENT '线路文件名称',
  `path_file_url` varchar(110) NOT NULL COMMENT '线路文件链接',
  `created_at` datetime(6) NOT NULL COMMENT '创建时间',
  `update_at` datetime(6) NOT NULL COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL COMMENT '创建人用户id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `dispatch_path_sweeping_uav_name` (`name`),
  KEY `dispatch_path_sweeping_uav_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='环卫监控无人机飞行线路表';

-- ----------------------------
-- Records of sweeping_uav_dispatch_path
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_uav_electronic_fence`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_uav_electronic_fence`;
CREATE TABLE `sweeping_uav_electronic_fence` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `electronic_fence_id` varchar(60) NOT NULL COMMENT '电子围栏id',
  `electronic_fence_name` varchar(20) DEFAULT NULL COMMENT '电子围栏名称',
  `client_id` bigint(20) DEFAULT NULL COMMENT '终端id',
  `client_device_sn` varchar(20) NOT NULL COMMENT '终端设备序列号',
  `client_device_callsign` varchar(30) DEFAULT NULL COMMENT '终端设备名称',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `electronic_fence_id_and_client_id` (`electronic_fence_id`,`client_id`),
  KEY `sweeping_uav_client_device_callsign` (`client_device_callsign`),
  KEY `sweeping_uav_electronic_fence_name` (`electronic_fence_name`),
  KEY `sweeping_uav_electronic_fence_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='无人清扫车电子围栏设置表';

-- ----------------------------
-- Records of sweeping_uav_electronic_fence
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_uav_monitor_stream`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_uav_monitor_stream`;
CREATE TABLE `sweeping_uav_monitor_stream` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uav_id` varchar(17) NOT NULL COMMENT '无人机id',
  `uav_device_sn` varchar(17) NOT NULL COMMENT '无人机序列号',
  `uav_device_callsign` varchar(17) NOT NULL COMMENT '无人机名称',
  `stream_url` varchar(120) NOT NULL COMMENT '监控推流地址',
  `app_key` varchar(17) NOT NULL COMMENT '推流地址访问密钥',
  `created_at` datetime(6) NOT NULL COMMENT '创建时间',
  `update_at` datetime(6) NOT NULL COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sweeping_uav_id` (`uav_id`),
  KEY `sweeping_uav_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='无人机监控推流设置表';

-- ----------------------------
-- Records of sweeping_uav_monitor_stream
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_uav_passive_take_over_authorize`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_uav_passive_take_over_authorize`;
CREATE TABLE `sweeping_uav_passive_take_over_authorize` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `apply_id` bigint(20) NOT NULL COMMENT '授权申请id',
  `apply_client_id` bigint(20) NOT NULL COMMENT '申请终端id',
  `apply_client_device_sn` varchar(20) NOT NULL COMMENT '申请终端设备序列号',
  `apply_client_device_callsign` varchar(20) NOT NULL COMMENT '申请终端设备名称',
  `take_over_user_id` bigint(20) DEFAULT NULL COMMENT '接管人id',
  `take_over_name` varchar(20) DEFAULT NULL COMMENT '接管人姓名',
  `take_over_reason` varchar(100) DEFAULT NULL COMMENT '接管原因',
  `authorize_code` varchar(20) NOT NULL COMMENT '授权码',
  `expire` datetime NOT NULL COMMENT '授权码过期时间',
  `take_over_begin_time` datetime NOT NULL COMMENT '接管开始时间',
  `take_over_end_time` datetime NOT NULL COMMENT '接管结束时间',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `apply_id` (`apply_id`),
  KEY `apply_client_id` (`apply_client_id`),
  KEY `take_over_name` (`take_over_name`),
  KEY `sweeping_uav_passive_take_over_authorize_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='无人机被动接管授权表';

-- ----------------------------
-- Records of sweeping_uav_passive_take_over_authorize
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_uav_repair_record`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_uav_repair_record`;
CREATE TABLE `sweeping_uav_repair_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `device_sn` varchar(17) NOT NULL COMMENT '设备序列号',
  `device_callsign` varchar(17) NOT NULL COMMENT '设备在组织中的名称',
  `fault_type` varchar(20) NOT NULL COMMENT '故障类型：动力系统故障、飞控系统故障、通信系统故障、结构故障',
  `description` varchar(150) NOT NULL COMMENT '故障描述',
  `repair_begin_date` date NOT NULL COMMENT '维修开始日期',
  `repair_end_date` date DEFAULT NULL COMMENT '维修结束日期',
  `created_at` datetime(6) NOT NULL COMMENT '创建时间',
  `update_at` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `device_sn` (`device_sn`),
  KEY `sweeping_uav_repair_record_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='环卫监控无人机维修记录表';

-- ----------------------------
-- Records of sweeping_uav_repair_record
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_uav_sensor`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_uav_sensor`;
CREATE TABLE `sweeping_uav_sensor` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uav_id` varchar(17) NOT NULL COMMENT '无人机设备id',
  `uav_device_sn` varchar(17) NOT NULL COMMENT '无人机设备序列号',
  `uav_device_callsign` varchar(17) NOT NULL COMMENT '无人机的名称',
  `device_type` varchar(20) NOT NULL COMMENT '设备类型：相机、毫米波雷达、激光雷达、惯导、超声波雷达、其它',
  `device_sn` varchar(17) NOT NULL COMMENT '设备序列号',
  `device_name` varchar(17) NOT NULL COMMENT '设备名称',
  `manufacturer` varchar(50) NOT NULL COMMENT '生产商',
  `brand` varchar(50) NOT NULL COMMENT '品牌',
  `model` varchar(50) NOT NULL COMMENT '型号',
  `created_at` datetime(6) NOT NULL COMMENT '创建时间',
  `update_at` datetime(6) NOT NULL COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `device_sn` (`device_sn`) USING BTREE,
  KEY `sweeping_ship_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='无人机传感器设备表';

-- ----------------------------
-- Records of sweeping_uav_sensor
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_uav_task`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_uav_task`;
CREATE TABLE `sweeping_uav_task` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `name` varchar(30) NOT NULL COMMENT '任务名称',
  `id_path` bigint(20) NOT NULL COMMENT '线路表ID',
  `name_path` varchar(110) NOT NULL COMMENT '线路名称',
  `path_file_name` varchar(100) NOT NULL COMMENT '线路文件名称',
  `path_file_url` varchar(110) NOT NULL COMMENT '线路文件链接',
  `passing_point_job` int(1) NOT NULL COMMENT '途经点任务：0-拍照，1-投掷',
  `created_at` datetime(6) NOT NULL COMMENT '创建时间',
  `update_at` datetime(6) NOT NULL COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL COMMENT '创建人用户id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sweeping_uav_task_name` (`name`),
  KEY `sweeping_uav_task_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='无人机任务表';

-- ----------------------------
-- Records of sweeping_uav_task
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_uav_task_record`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_uav_task_record`;
CREATE TABLE `sweeping_uav_task_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bid` varchar(60) NOT NULL COMMENT '业务id：uuid',
  `tid` varchar(60) NOT NULL COMMENT '事务id：uuid',
  `task_id` varchar(60) NOT NULL COMMENT '任务id',
  `task_name` varchar(20) DEFAULT NULL COMMENT '任务名称',
  `client_id` bigint(20) DEFAULT NULL COMMENT '终端id',
  `client_device_sn` varchar(20) NOT NULL COMMENT '终端设备序列号',
  `client_callsign` varchar(30) DEFAULT NULL COMMENT '终端名称',
  `task_status` int(3) NOT NULL COMMENT '任务状态：0-未执行，1-执行中，2-已完成，3-暂停，4-终止',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sweeping_uav_task_name` (`task_name`) USING BTREE,
  KEY `sweeping_uav_task_record_user_id` (`user_id`) USING BTREE,
  KEY `sweeping_uav_client_device_sn` (`client_device_sn`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='环卫监测无人机任务记录表';

-- ----------------------------
-- Records of sweeping_uav_task_record
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_user`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_user`;
CREATE TABLE `sweeping_user` (
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(17) NOT NULL,
  `password` varchar(180) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sweeping_user
-- ----------------------------
INSERT INTO `sweeping_user` VALUES ('2025-04-24 06:20:36.858364', '1', '', '', '123@qq.com', '1', '1', '2025-02-26 08:06:41.262209', '1', 'admin', 'pbkdf2_sha256$390000$Hb4HFSVgOULm5rYkFodX2v$1YylCzNcX/SoFrpo+nWdmOTTwS7t7qzZIJSK72FwGHo=', '2025-02-26 08:06:41.372203', '2025-02-26 08:06:41.372203');
INSERT INTO `sweeping_user` VALUES ('2025-02-27 03:29:53.936168', '0', 'test', 'test', 'test@qq.com', '0', '1', '2025-02-27 03:27:00.000000', '2', 'test', 'pbkdf2_sha256$390000$Hb4HFSVgOULm5rYkFodX2v$1YylCzNcX/SoFrpo+nWdmOTTwS7t7qzZIJSK72FwGHo=', '2025-02-27 03:28:11.411810', '2025-02-27 03:28:11.411810');

-- ----------------------------
-- Table structure for `sweeping_user_groups`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_user_groups`;
CREATE TABLE `sweeping_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sweeping_user_groups_user_id_group_id_3d0dee91_uniq` (`user_id`,`group_id`),
  KEY `sweeping_user_groups_group_id_b60264d6_fk_auth_group_id` (`group_id`),
  CONSTRAINT `sweeping_user_groups_group_id_b60264d6_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `sweeping_user_groups_user_id_65cda669_fk_sweeping_user_id` FOREIGN KEY (`user_id`) REFERENCES `sweeping_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sweeping_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_user_user_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_user_user_permissions`;
CREATE TABLE `sweeping_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sweeping_user_user_permi_user_id_permission_id_4f890652_uniq` (`user_id`,`permission_id`),
  KEY `sweeping_user_user_p_permission_id_048ecd91_fk_auth_perm` (`permission_id`),
  CONSTRAINT `sweeping_user_user_p_permission_id_048ecd91_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `sweeping_user_user_p_user_id_7c43028d_fk_sweeping_` FOREIGN KEY (`user_id`) REFERENCES `sweeping_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sweeping_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_calibration_parameter`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_calibration_parameter`;
CREATE TABLE `sweeping_calibration_parameter` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL COMMENT '参数名称',
    `code` VARCHAR(30) NOT NULL COMMENT '参数代码',
    `param_BODH` VARCHAR(9) NOT NULL COMMENT '进制',
    `value` VARCHAR(100) NOT NULL COMMENT '参数值',
        `unit` VARCHAR(10) NOT NULL DEFAULT '' COMMENT '单位',
    `description` VARCHAR(200) NULL COMMENT '参数描述',
    `is_active` BOOLEAN NOT NULL DEFAULT TRUE COMMENT '是否启用',
    `State` VARCHAR(1) NOT NULL COMMENT '参数状态',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `device_id` BIGINT NULL COMMENT '关联设备ID',
    `device_type` VARCHAR(20) NOT NULL COMMENT '设备类型'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='校准参数';

-- ----------------------------
-- Records of sweeping_calibration_parameter
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_calibration_history`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_calibration_history`;
CREATE TABLE `sweeping_calibration_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parameter_id` bigint(20) NOT NULL COMMENT '参数id',
  `old_value` varchar(100) NOT NULL COMMENT '原参数值',
  `new_value` varchar(100) NOT NULL COMMENT '新参数值',
  `operation_type` varchar(20) NOT NULL COMMENT '操作类型(创建/修改/删除)',
  `operation_user_id` bigint(20) NOT NULL COMMENT '操作用户id',
  `operation_user_name` varchar(20) NOT NULL COMMENT '操作用户名称',
  `created_at` datetime(6) NOT NULL COMMENT '操作时间',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `sweeping_calibration_history_parameter_id` (`parameter_id`),
  KEY `sweeping_calibration_history_operation_user_id` (`operation_user_id`),
  CONSTRAINT `sweeping_calibration_history_parameter_id_fk` FOREIGN KEY (`parameter_id`) REFERENCES `sweeping_calibration_parameter` (`id`),
  CONSTRAINT `sweeping_calibration_history_operation_user_id_fk` FOREIGN KEY (`operation_user_id`) REFERENCES `sweeping_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='标定历史记录表';

-- ----------------------------
-- Records of sweeping_calibration_history
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_calibration_config`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_calibration_config`;
CREATE TABLE `sweeping_calibration_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '配置名称',
  `parameter_ids` varchar(500) NOT NULL COMMENT '关联参数id列表(逗号分隔)',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认配置',
  `created_at` datetime(6) NOT NULL COMMENT '创建时间',
  `update_at` datetime(6) NOT NULL COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL COMMENT '创建人用户id',
  PRIMARY KEY (`id`),
  KEY `sweeping_calibration_config_user_id` (`user_id`),
  CONSTRAINT `sweeping_calibration_config_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `sweeping_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='标定配置表';

-- ----------------------------
-- Records of sweeping_calibration_config
-- ----------------------------

-- ----------------------------
-- Records of sweeping_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_vehicle`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_vehicle`;
CREATE TABLE `sweeping_vehicle` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `vin_code` varchar(17) NOT NULL,
  `vehicle_number` varchar(20) NOT NULL,
  `license_plate` varchar(10) NOT NULL,
  `manufacturer` varchar(50) NOT NULL,
  `brand` varchar(50) NOT NULL,
  `operation_date` date NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `vin_code` (`vin_code`),
  KEY `sweeping_vehicle_user_id_346c2eb6_fk_sweeping_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sweeping_vehicle
-- ----------------------------
INSERT INTO `sweeping_vehicle` VALUES ('3', '222', '1', '333333', '4', '5', '2025-04-22', '2025-04-22 05:41:30.100304', null);

-- ----------------------------
-- Table structure for `sweeping_vehicle_active_take_over_apply`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_vehicle_active_take_over_apply`;
CREATE TABLE `sweeping_vehicle_active_take_over_apply` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `apply_user_id` bigint(20) NOT NULL COMMENT '申请用户id',
  `apply_user_name` varchar(20) NOT NULL COMMENT '申请用户名称',
  `client_id` bigint(20) DEFAULT NULL COMMENT '终端id',
  `client_vin_code` varchar(20) NOT NULL COMMENT '终端车架号',
  `client_license_plate` varchar(30) DEFAULT NULL COMMENT '终端车牌号',
  `take_over_reason` varchar(100) DEFAULT NULL COMMENT '接管原因',
  `examine_status` int(1) NOT NULL COMMENT '申请审核状态',
  `examine_user_id` bigint(20) NOT NULL COMMENT '审核用户id',
  `examine_user_name` varchar(20) NOT NULL COMMENT '审核用户名称',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_license_plate` (`client_license_plate`),
  KEY `apply_user_name` (`apply_user_name`),
  KEY `sweeping_vehicle_active_take_over_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='无人清扫车主动接管授权申请表';

-- ----------------------------
-- Records of sweeping_vehicle_active_take_over_apply
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_vehicle_active_take_over_authorize`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_vehicle_active_take_over_authorize`;
CREATE TABLE `sweeping_vehicle_active_take_over_authorize` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `apply_id` bigint(20) NOT NULL COMMENT '授权申请id',
  `apply_user_id` bigint(20) NOT NULL COMMENT '申请用户id',
  `apply_user_name` varchar(20) NOT NULL COMMENT '申请用户名称',
  `client_id` bigint(20) DEFAULT NULL COMMENT '终端id',
  `client_vin_code` varchar(20) NOT NULL COMMENT '终端车架号',
  `client_license_plate` varchar(30) DEFAULT NULL COMMENT '终端车牌号',
  `take_over_reason` varchar(100) DEFAULT NULL COMMENT '接管原因',
  `authorize_code` varchar(20) NOT NULL COMMENT '授权码',
  `expire` datetime NOT NULL COMMENT '授权码过期时间',
  `take_over_begin_time` datetime NOT NULL COMMENT '接管开始时间',
  `take_over_end_time` datetime NOT NULL COMMENT '接管结束时间',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  KEY `client_license_plate` (`client_license_plate`),
  KEY `apply_user_name` (`apply_user_name`),
  KEY `sweeping_vehicle_active_take_over_authorize_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='无人清扫车主动接管授权表';

-- ----------------------------
-- Records of sweeping_vehicle_active_take_over_authorize
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_vehicle_dispatch_path`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_vehicle_dispatch_path`;
CREATE TABLE `sweeping_vehicle_dispatch_path` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(30) NOT NULL COMMENT '线路名称',
  `path_file_name` varchar(100) NOT NULL COMMENT '线路文件名称',
  `path_file_url` varchar(110) NOT NULL COMMENT '线路文件链接',
  `created_at` datetime(6) NOT NULL COMMENT '创建时间',
  `update_at` datetime(6) NOT NULL COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL COMMENT '创建人用户id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `dispatch_path_sweeping_vehicle_name` (`name`),
  KEY `dispatch_path_sweeping_vehicle_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='清扫车清扫线路表';

-- ----------------------------
-- Records of sweeping_vehicle_dispatch_path
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_vehicle_electronic_fence`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_vehicle_electronic_fence`;
CREATE TABLE `sweeping_vehicle_electronic_fence` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `electronic_fence_id` varchar(60) NOT NULL COMMENT '电子围栏id',
  `electronic_fence_name` varchar(20) DEFAULT NULL COMMENT '电子围栏名称',
  `client_id` bigint(20) DEFAULT NULL COMMENT '终端id',
  `client_vin_number` varchar(20) NOT NULL COMMENT '终端登记号',
  `client_license_plate` varchar(30) DEFAULT NULL COMMENT '终端车牌号',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `electronic_fence_id_and_client_id` (`electronic_fence_id`,`client_id`),
  KEY `sweeping_vehicle_client_license_plate` (`client_license_plate`),
  KEY `sweeping_vehicle_electronic_fence_name` (`electronic_fence_name`),
  KEY `sweeping_vehicle_electronic_fence_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='无人清扫车电子围栏设置表';

-- ----------------------------
-- Records of sweeping_vehicle_electronic_fence
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_vehicle_monitor_stream`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_vehicle_monitor_stream`;
CREATE TABLE `sweeping_vehicle_monitor_stream` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `vehicle_id` bigint(20) NOT NULL COMMENT '清扫车id',
  `vehicle_vin_code` varchar(17) NOT NULL COMMENT '清扫车车架号',
  `vehicle_license_plate` varchar(17) NOT NULL COMMENT '清扫车车牌号',
  `stream_url` varchar(120) NOT NULL COMMENT '监控推流地址',
  `app_key` varchar(17) NOT NULL COMMENT '推流地址访问密钥',
  `created_at` datetime(6) NOT NULL COMMENT '创建时间',
  `update_at` datetime(6) NOT NULL COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sweeping_vehicle_id` (`vehicle_id`),
  KEY `sweeping_vehicle_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='无人清扫车监控推流设置表';

-- ----------------------------
-- Records of sweeping_vehicle_monitor_stream
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_vehicle_passive_take_over_apply`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_vehicle_passive_take_over_apply`;
CREATE TABLE `sweeping_vehicle_passive_take_over_apply` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `apply_client_id` bigint(20) NOT NULL COMMENT '申请终端id',
  `apply_client_vin_code` varchar(20) NOT NULL COMMENT '申请终端车架号',
  `apply_client_license_plate` varchar(20) NOT NULL COMMENT '申请终端车牌号',
  `take_over_reason` varchar(100) DEFAULT NULL COMMENT '接管原因',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `apply_client_license_plate` (`apply_client_license_plate`),
  KEY `apply_client_id` (`apply_client_id`),
  KEY `sweeping_vehicle_active_take_over_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='无人清扫车被动接管授权申请表';

-- ----------------------------
-- Records of sweeping_vehicle_passive_take_over_apply
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_vehicle_passive_take_over_authorize`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_vehicle_passive_take_over_authorize`;
CREATE TABLE `sweeping_vehicle_passive_take_over_authorize` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `apply_id` bigint(20) NOT NULL COMMENT '授权申请id',
  `apply_client_id` bigint(20) NOT NULL COMMENT '申请终端id',
  `apply_client_vin_code` varchar(20) NOT NULL COMMENT '申请终端车架号',
  `apply_client_license_plate` varchar(20) NOT NULL COMMENT '申请终端车牌号',
  `take_over_user_id` bigint(20) DEFAULT NULL COMMENT '接管人id',
  `take_over_name` varchar(20) DEFAULT NULL COMMENT '接管人姓名',
  `take_over_reason` varchar(100) DEFAULT NULL COMMENT '接管原因',
  `authorize_code` varchar(20) NOT NULL COMMENT '授权码',
  `expire` datetime NOT NULL COMMENT '授权码过期时间',
  `take_over_begin_time` datetime NOT NULL COMMENT '接管开始时间',
  `take_over_end_time` datetime NOT NULL COMMENT '接管结束时间',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `apply_id` (`apply_id`),
  KEY `apply_client_id` (`apply_client_id`),
  KEY `take_over_name` (`take_over_name`),
  KEY `sweeping_vehicle_active_take_over_authorize_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='无人清扫车被动接管授权表';

-- ----------------------------
-- Records of sweeping_vehicle_passive_take_over_authorize
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_vehicle_repair_record`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_vehicle_repair_record`;
CREATE TABLE `sweeping_vehicle_repair_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `vin_code` varchar(20) NOT NULL COMMENT '车架号',
  `license_plate` varchar(10) NOT NULL COMMENT '车牌号',
  `fault_type` varchar(20) NOT NULL COMMENT '故障类型：动力系统故障、控制系统故障、电气系统故障、传感器故障、清扫系统故障',
  `description` varchar(150) NOT NULL COMMENT '故障描述',
  `repair_begin_date` date NOT NULL COMMENT '维修开始日期',
  `repair_end_date` date DEFAULT NULL COMMENT '维修结束日期',
  `created_at` datetime(6) NOT NULL COMMENT '创建时间',
  `update_at` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `vin_code` (`vin_code`),
  KEY `sweeping_vehicle_repair_record_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='无人清扫车维修记录表';

-- ----------------------------
-- Records of sweeping_vehicle_repair_record
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_vehicle_sensor`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_vehicle_sensor`;
CREATE TABLE `sweeping_vehicle_sensor` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `vehicle_id` bigint(20) NOT NULL COMMENT '清扫车id',
  `vehicle_vin_code` varchar(17) NOT NULL COMMENT '清扫车车架号',
  `vehicle_license_plate` varchar(17) NOT NULL COMMENT '清扫车车牌号',
  `device_type` varchar(20) NOT NULL COMMENT '设备类型：相机、毫米波雷达、激光雷达、惯导、超声波雷达、其它',
  `device_sn` varchar(17) NOT NULL COMMENT '设备序列号',
  `device_name` varchar(17) NOT NULL COMMENT '设备名称',
  `manufacturer` varchar(50) NOT NULL COMMENT '生产商',
  `brand` varchar(50) NOT NULL COMMENT '品牌',
  `model` varchar(50) NOT NULL COMMENT '型号',
  `created_at` datetime(6) NOT NULL COMMENT '创建时间',
  `update_at` datetime(6) NOT NULL COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `device_sn` (`device_sn`) USING BTREE,
  KEY `sweeping_vehicle_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='无人清扫车传感器设备表';

-- ----------------------------
-- Records of sweeping_vehicle_sensor
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_vehicle_task`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_vehicle_task`;
CREATE TABLE `sweeping_vehicle_task` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `name` varchar(30) NOT NULL COMMENT '任务名称',
  `id_path` bigint(20) NOT NULL COMMENT '线路表ID',
  `name_path` varchar(110) NOT NULL COMMENT '线路名称',
  `path_file_name` varchar(100) NOT NULL COMMENT '线路文件名称',
  `path_file_url` varchar(110) NOT NULL COMMENT '线路文件链接',
  `job_type` int(1) NOT NULL COMMENT '作业类型：0-清扫，1-垃圾倾倒',
  `running_speed` float(20,2) NOT NULL COMMENT '行进速度km/h',
  `sweeping_speed` int(1) NOT NULL COMMENT '刷头转速：0-低，1-中，2-高',
  `created_at` datetime(6) NOT NULL COMMENT '创建时间',
  `update_at` datetime(6) NOT NULL COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL COMMENT '创建人用户id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sweeping_vehicle_task_name` (`name`),
  KEY `sweeping_vehicle_task_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='清扫车任务表';

-- ----------------------------
-- Records of sweeping_vehicle_task
-- ----------------------------

-- ----------------------------
-- Table structure for `sweeping_vehicle_task_record`
-- ----------------------------
DROP TABLE IF EXISTS `sweeping_vehicle_task_record`;
CREATE TABLE `sweeping_vehicle_task_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bid` varchar(60) NOT NULL COMMENT '业务id：uuid',
  `tid` varchar(60) NOT NULL COMMENT '事务id：uuid',
  `task_id` varchar(60) NOT NULL COMMENT '任务id',
  `task_name` varchar(20) DEFAULT NULL COMMENT '任务名称',
  `client_id` bigint(20) DEFAULT NULL COMMENT '终端id',
  `client_vin_code` varchar(20) NOT NULL COMMENT '终端车架号',
  `client_license_plate` varchar(30) DEFAULT NULL COMMENT '终端车牌号',
  `task_status` int(3) NOT NULL COMMENT '任务状态：0-未执行，1-执行中，2-已完成，3-暂停，4-终止',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_license_plate` (`client_license_plate`),
  KEY `task_name` (`task_name`),
  KEY `sweeping_vehicle_task_record_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='无人清扫车任务记录表';

-- ----------------------------
-- Records of sweeping_vehicle_task_record
-- ----------------------------
