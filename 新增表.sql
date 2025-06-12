-- sweeping_platform.sweeping_calibration_config definition

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


-- sweeping_platform.sweeping_calibration_history definition

CREATE TABLE `sweeping_calibration_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parameter_id` bigint(20) NOT NULL COMMENT '参数id',
  `old_value` varchar(100) NOT NULL COMMENT '原参数值',
  `new_value` varchar(100) NOT NULL COMMENT '新参数值',
  `operation_user_id` bigint(20) NOT NULL COMMENT '操作用户id',
  `operation_user_name` varchar(20) NOT NULL COMMENT '操作用户名称',
  `created_at` datetime(6) NOT NULL COMMENT '操作时间',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `sweeping_calibration_history_parameter_id` (`parameter_id`),
  KEY `sweeping_calibration_history_operation_user_id` (`operation_user_id`),
  CONSTRAINT `sweeping_calibration_history_operation_user_id_fk` FOREIGN KEY (`operation_user_id`) REFERENCES `sweeping_user` (`id`),
  CONSTRAINT `sweeping_calibration_history_parameter_id_fk` FOREIGN KEY (`parameter_id`) REFERENCES `sweeping_calibration_parameter` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='标定历史记录表';

-- sweeping_platform.sweeping_calibration_parameter definition

CREATE TABLE `sweeping_calibration_parameter` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参数名称',
  `code` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参数代码',
  `param_BODH` varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '进制',
  `value` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参数值',
  `unit` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '单位',
  `description` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '参数描述',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  `State` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参数状态',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `device_id` bigint(20) DEFAULT NULL COMMENT '关联设备ID',
  `device_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '设备类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='校准参数';


-- sweeping_platform.sweeping_parameters definition

CREATE TABLE `sweeping_parameters` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'NID',
  `name` varchar(99) NOT NULL COMMENT '参数名',
  `code` varchar(5) NOT NULL COMMENT '数据类型',
  `nst` varchar(1) NOT NULL COMMENT '进制',
  `value` varchar(99) NOT NULL COMMENT '参数值',
  `unit` varchar(9) NOT NULL COMMENT '单位',
  `state` varchar(1) NOT NULL COMMENT '参数状态',
  `created_at` datetime(6) NOT NULL COMMENT '创建时间',
  `update_at` datetime(6) NOT NULL COMMENT '更新时间',
  `oid` bigint(20) NOT NULL DEFAULT '-1' COMMENT '上一记录',
  `cid` bigint(20) NOT NULL DEFAULT '-1' COMMENT '下一记录',
  `user_id` bigint(20) DEFAULT NULL COMMENT '操作人',
  `device_id` bigint(20) NOT NULL COMMENT '目标ID',
  `device_type` varchar(7) NOT NULL COMMENT '目标类型',
  `description` varchar(200) DEFAULT NULL COMMENT '用户描述',
  `is_active` tinyint(1) DEFAULT NULL COMMENT '启用标志',
  PRIMARY KEY (`id`),
  KEY `parameters_user_id_e493f260_fk_sweeping_user_id` (`user_id`),
  CONSTRAINT `parameters_user_id_e493f260_fk_sweeping_user_id` FOREIGN KEY (`user_id`) REFERENCES `sweeping_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4;


-- sweeping_platform.sweeping_parameter_history definition

CREATE TABLE `sweeping_parameter_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `old_value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `new_value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `parameter_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sweeping_parameter_h_parameter_id_86b5a1a9_fk_sweeping_` (`parameter_id`),
  KEY `sweeping_parameter_h_updated_by_id_9b0260b5_fk_sweeping_` (`updated_by_id`),
  CONSTRAINT `sweeping_parameter_h_parameter_id_86b5a1a9_fk_sweeping_` FOREIGN KEY (`parameter_id`) REFERENCES `sweeping_parameters` (`id`),
  CONSTRAINT `sweeping_parameter_h_updated_by_id_9b0260b5_fk_sweeping_` FOREIGN KEY (`updated_by_id`) REFERENCES `sweeping_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- sweeping_platform.sweeping_schedule definition

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