SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ab_application
-- ----------------------------
DROP TABLE IF EXISTS `ab_application`;
CREATE TABLE `ab_application` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `creator` varchar(64) NOT NULL DEFAULT '' COMMENT '创建人',
  `modifier` varchar(64) NOT NULL DEFAULT '' COMMENT '修改人',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除。0: 未删除, 1: 已删除',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='应用';

-- ----------------------------
-- Table structure for ab_domain
-- ----------------------------
-- 当创建应用的时候会创建一个默认域和默认层，默认域和层拥有所有流量和参数
DROP TABLE IF EXISTS `ab_domain`;
CREATE TABLE `ab_domain` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(32) DEFAULT NULL COMMENT '名称',
  `desc` varchar(256) DEFAULT NULL COMMENT '描述',
  `condition` varchar(64) DEFAULT NULL COMMENT '分流条件',
  `layer_id` bigint NOT NULL DEFAULT '0' COMMENT '层 id',
  `is_default` tinyint NOT NULL DEFAULT '0' COMMENT '默认域。0: 不是，1: 默认域',
  `creator` varchar(64) NOT NULL DEFAULT '' COMMENT '创建人',
  `modifier` varchar(64) NOT NULL DEFAULT '' COMMENT '修改人',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除。0: 未删除, 1: 已删除',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='AB 域';

-- ----------------------------
-- Table structure for ab_experiment
-- ----------------------------
-- 实验只能使用每一层的参数，可以修改 0 或多个参数值
DROP TABLE IF EXISTS `ab_experiment`;
CREATE TABLE `ab_experiment` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(32) DEFAULT NULL COMMENT '名称',
  `desc` varchar(256) DEFAULT NULL COMMENT '描述',
  `layer_id` bigint NOT NULL COMMENT '层 id',
  `parameter_value_group_id` bigint NOT NULL COMMENT '参数值组 id',
  `creator` varchar(64) NOT NULL DEFAULT '' COMMENT '创建人',
  `modifier` varchar(64) NOT NULL DEFAULT '' COMMENT '修改人',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除。0: 未删除, 1: 已删除',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='AB 实验';

-- ----------------------------
-- Table structure for ab_layer
-- ----------------------------
-- 参数最多只能在一个发布层和一个正常层（实验层，或域层）
DROP TABLE IF EXISTS `ab_layer`;
CREATE TABLE `ab_layer` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(32) DEFAULT NULL COMMENT '名称',
  `desc` varchar(256) DEFAULT NULL COMMENT '描述',
  `diversion_type` varchar(64) DEFAULT NULL COMMENT '流量分配策略',
  `domain_id` bigint NOT NULL DEFAULT '0' COMMENT '域 id',
  `parameter_group_id` bigint NOT NULL COMMENT '参数组 id',
  `is_default` tinyint NOT NULL DEFAULT '0' COMMENT '默认层。0: 不是，1: 默认层',
  `is_launch` tinyint NOT NULL DEFAULT '0' COMMENT '发布层。0: 不是，1: 发布层',
  `creator` varchar(64) NOT NULL DEFAULT '' COMMENT '创建人',
  `modifier` varchar(64) NOT NULL DEFAULT '' COMMENT '修改人',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除。0: 未删除, 1: 已删除',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='AB 层';

-- ----------------------------
-- Table structure for ab_namespace
-- ----------------------------
DROP TABLE IF EXISTS `ab_namespace`;
CREATE TABLE `ab_namespace` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `creator` varchar(64) NOT NULL DEFAULT '' COMMENT '创建人',
  `modifier` varchar(64) NOT NULL DEFAULT '' COMMENT '修改人',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除。0: 未删除, 1: 已删除',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='命名空间';

-- ----------------------------
-- Table structure for ab_parameter
-- ----------------------------
-- 参数
DROP TABLE IF EXISTS `ab_parameter`;
CREATE TABLE `ab_parameter` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(32) DEFAULT NULL COMMENT '名称',
  `desc` varchar(256) DEFAULT NULL COMMENT '描述',
  `allow_null` tinyint DEFAULT NULL COMMENT '允许为 null',
  `default_value` varchar(32) DEFAULT NULL COMMENT '默认参数值',
  `value_type` tinyint DEFAULT NULL COMMENT '参数值类型',
  `creator` varchar(64) NOT NULL DEFAULT '' COMMENT '创建人',
  `modifier` varchar(64) NOT NULL DEFAULT '' COMMENT '修改人',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除。0: 未删除, 1: 已删除',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='AB 参数';

-- ----------------------------
-- Table structure for ab_parameter_group
-- ----------------------------
-- 参数分组
DROP TABLE IF EXISTS `ab_parameter_group`;
CREATE TABLE `ab_parameter_group` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(32) DEFAULT NULL COMMENT '名称',
  `desc` varchar(256) DEFAULT NULL COMMENT '描述',
  `creator` varchar(64) NOT NULL DEFAULT '' COMMENT '创建人',
  `modifier` varchar(64) NOT NULL DEFAULT '' COMMENT '修改人',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除。0: 未删除, 1: 已删除',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='AB 参数分组';

-- ----------------------------
-- Table structure for ab_parameter_group_relation
-- ----------------------------
DROP TABLE IF EXISTS `ab_parameter_group_relation`;
CREATE TABLE `ab_parameter_group_relation` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `parameter_id` bigint DEFAULT NULL COMMENT '参数 id',
  `parameter_group_id` bigint DEFAULT NULL COMMENT '参数分组 id',
  `creator` varchar(64) NOT NULL DEFAULT '' COMMENT '创建人',
  `modifier` varchar(64) NOT NULL DEFAULT '' COMMENT '修改人',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除。0: 未删除, 1: 已删除',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='AB 参数分组关联';

-- ----------------------------
-- Table structure for ab_parameter_value
-- ----------------------------
-- 参数
DROP TABLE IF EXISTS `ab_parameter_value`;
CREATE TABLE `ab_parameter_value` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `value` varchar(32) DEFAULT NULL COMMENT '参数值',
  `is_null` tinyint DEFAULT NULL COMMENT '是否为 null。0: 不是，1: null',
  `parameter_id` bigint DEFAULT NULL COMMENT '参数 id',
  `creator` varchar(64) NOT NULL DEFAULT '' COMMENT '创建人',
  `modifier` varchar(64) NOT NULL DEFAULT '' COMMENT '修改人',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除。0: 未删除, 1: 已删除',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='AB 参数值';

-- ----------------------------
-- Table structure for ab_parameter_value_group
-- ----------------------------
-- 参数分组
DROP TABLE IF EXISTS `ab_parameter_value_group`;
CREATE TABLE `ab_parameter_value_group` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `parameter_group_id` bigint DEFAULT NULL COMMENT '参数分组 id',
  `creator` varchar(64) NOT NULL DEFAULT '' COMMENT '创建人',
  `modifier` varchar(64) NOT NULL DEFAULT '' COMMENT '修改人',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除。0: 未删除, 1: 已删除',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='AB 参数值分组';

-- ----------------------------
-- Table structure for ab_parameter_value_group_relation
-- ----------------------------
DROP TABLE IF EXISTS `ab_parameter_value_group_relation`;
CREATE TABLE `ab_parameter_value_group_relation` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `parameter_value_id` bigint DEFAULT NULL COMMENT '参数值 id',
  `parameter_value_group_id` bigint DEFAULT NULL COMMENT '参数值分组 id',
  `creator` varchar(64) NOT NULL DEFAULT '' COMMENT '创建人',
  `modifier` varchar(64) NOT NULL DEFAULT '' COMMENT '修改人',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除。0: 未删除, 1: 已删除',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='AB 参数值分组关联';

SET FOREIGN_KEY_CHECKS = 1;
