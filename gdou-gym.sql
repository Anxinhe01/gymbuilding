/*
 Navicat Premium Data Transfer

 Source Server         : MyDB
 Source Server Type    : MySQL
 Source Server Version : 80036
 Source Host           : localhost:3306
 Source Schema         : gdou-gym

 Target Server Type    : MySQL
 Target Server Version : 80036
 File Encoding         : 65001

 Date: 09/05/2024 18:08:57
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for announcement
-- ----------------------------
DROP TABLE IF EXISTS `announcement`;
CREATE TABLE `announcement`  (
  `aid` int NOT NULL AUTO_INCREMENT COMMENT '公告id',
  `uid` int NULL DEFAULT NULL COMMENT '操作者',
  `type` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '公告类型',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告内容',
  `createDate` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updateDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`aid`) USING BTREE,
  INDEX `AnnouncementUid_fk`(`uid` ASC) USING BTREE,
  CONSTRAINT `AnnouncementUid_fk` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of announcement
-- ----------------------------
INSERT INTO `announcement` VALUES (31, 1, '场地', '注意安全', '2024-05-08 11:06:26', '2024-05-08 16:54:04');
INSERT INTO `announcement` VALUES (32, 1, '馆内罚款', '请及时付款', '2024-05-08 16:53:37', '2024-05-08 16:53:37');

-- ----------------------------
-- Table structure for competition
-- ----------------------------
DROP TABLE IF EXISTS `competition`;
CREATE TABLE `competition`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '赛事id',
  `uid` int NOT NULL COMMENT '申请人Id',
  `name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '赛事名称',
  `competition_time` timestamp NOT NULL COMMENT '赛事时间',
  `event_length` int NULL DEFAULT NULL COMMENT '赛事时长，按分钟计算',
  `introduction` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '赛事简介',
  `money` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '赛事注册费用',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '赛事创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `Competition_User_id_fk`(`uid` ASC) USING BTREE,
  CONSTRAINT `Competition_User_id_fk` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '赛事表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of competition
-- ----------------------------
INSERT INTO `competition` VALUES (17, 1, '123', '2024-05-09 00:00:00', 60, 'test', 0.00, '2024-05-08 16:47:56');
INSERT INTO `competition` VALUES (18, 1, '测试2', '2024-05-12 14:00:00', 60, '测试赛事', 0.00, '2024-05-09 12:51:57');

-- ----------------------------
-- Table structure for competition_cancel
-- ----------------------------
DROP TABLE IF EXISTS `competition_cancel`;
CREATE TABLE `competition_cancel`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `cid` int NOT NULL COMMENT '赛事id',
  `uid` int NOT NULL COMMENT '取消的用户',
  `reasons` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '无' COMMENT '取消的理由',
  `cancellation_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '取消的时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `Cancellation_events_user_FK`(`uid` ASC) USING BTREE,
  INDEX `Competition_cancel_Competition_id_fk`(`cid` ASC) USING BTREE,
  CONSTRAINT `Cancellation_events_user_FK` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Competition_cancel_Competition_id_fk` FOREIGN KEY (`cid`) REFERENCES `competition` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '赛事取消' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of competition_cancel
-- ----------------------------

-- ----------------------------
-- Table structure for competition_check
-- ----------------------------
DROP TABLE IF EXISTS `competition_check`;
CREATE TABLE `competition_check`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `cid` int NOT NULL COMMENT '赛事id',
  `uid` int NULL DEFAULT NULL COMMENT '审核人',
  `reason` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '审核理由',
  `status` char(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '待审核' COMMENT '审核状态',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建审核时间',
  `check_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '审核时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `Competition_check_User_id_fk`(`uid` ASC) USING BTREE,
  INDEX `Competition_check_Competition_id_fk`(`cid` ASC) USING BTREE,
  CONSTRAINT `Competition_check_Competition_id_fk` FOREIGN KEY (`cid`) REFERENCES `competition` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Competition_check_User_id_fk` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `check_status` CHECK (`status` in (_utf8mb4'待审核',_utf8mb4'审核通过',_utf8mb4'审核未通过',_utf8mb4'审核取消',_utf8mb4'重新审核'))
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '赛事审核表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of competition_check
-- ----------------------------
INSERT INTO `competition_check` VALUES (15, 17, 1, '时间错误', '审核取消', '2024-05-08 16:47:56', '2024-05-09 12:51:03');
INSERT INTO `competition_check` VALUES (16, 18, 1, '可', '审核通过', '2024-05-09 12:51:57', '2024-05-09 17:49:06');

-- ----------------------------
-- Table structure for competition_equipment
-- ----------------------------
DROP TABLE IF EXISTS `competition_equipment`;
CREATE TABLE `competition_equipment`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `cfid` int NOT NULL COMMENT '赛事场地id',
  `eid` int NOT NULL COMMENT '器材id',
  `number` int NOT NULL DEFAULT 0 COMMENT '器材数量',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `Competition_equipment_Equipment_id_fk`(`eid` ASC) USING BTREE,
  INDEX `Competition_equipment_Competition_field_id_fk`(`cfid` ASC) USING BTREE,
  CONSTRAINT `Competition_equipment_Competition_field_id_fk` FOREIGN KEY (`cfid`) REFERENCES `competition_field` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Competition_equipment_Equipment_id_fk` FOREIGN KEY (`eid`) REFERENCES `equipment` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '赛事器材表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of competition_equipment
-- ----------------------------
INSERT INTO `competition_equipment` VALUES (22, 10, 10, 2);
INSERT INTO `competition_equipment` VALUES (23, 10, 11, 2);

-- ----------------------------
-- Table structure for competition_field
-- ----------------------------
DROP TABLE IF EXISTS `competition_field`;
CREATE TABLE `competition_field`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '赛事场地Id',
  `cid` int NOT NULL COMMENT '赛事id',
  `fcId` int NOT NULL COMMENT '场地审核id',
  `uid` int NULL DEFAULT NULL COMMENT '裁判id',
  `introduction` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '裁判简介',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `Com_set_UserInfo_uid_fk`(`uid` ASC) USING BTREE,
  INDEX `Competition_field_ibfk_1`(`fcId` ASC) USING BTREE,
  INDEX `Competition_field_Competition_id_fk`(`cid` ASC) USING BTREE,
  CONSTRAINT `Com_set_UserInfo_uid_fk` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Competition_field_Competition_id_fk` FOREIGN KEY (`cid`) REFERENCES `competition` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Competition_field_ibfk_1` FOREIGN KEY (`fcId`) REFERENCES `field_check` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '赛事场地表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of competition_field
-- ----------------------------
INSERT INTO `competition_field` VALUES (10, 18, 34, 15, '主裁判moyu', '2024-05-09 17:50:16');

-- ----------------------------
-- Table structure for equipment
-- ----------------------------
DROP TABLE IF EXISTS `equipment`;
CREATE TABLE `equipment`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '器材id',
  `types` char(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '器材种类',
  `name` char(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '器材名称',
  `number` int NOT NULL COMMENT '器材数量',
  `price` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '器材价格',
  `rentPrice` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '器材租用价格',
  `maxRentTime` int NULL DEFAULT 5 COMMENT '器材最大租用时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = 'Equipment修改maxRentTime属性' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of equipment
-- ----------------------------
INSERT INTO `equipment` VALUES (10, '球类', '篮球', 120, 60.00, 3.00, 90);
INSERT INTO `equipment` VALUES (11, '球类', '乒乓球', 300, 10.00, 1.00, 60);

-- ----------------------------
-- Table structure for equipment_rent_standard
-- ----------------------------
DROP TABLE IF EXISTS `equipment_rent_standard`;
CREATE TABLE `equipment_rent_standard`  (
  `erid` int NOT NULL AUTO_INCREMENT COMMENT '器材租用标准ID',
  `eid` int NOT NULL COMMENT '器材ID',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '器材名称',
  `price` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '器材租用费用元/h',
  `maxRentTime` int NULL DEFAULT NULL COMMENT '最大租用时间',
  PRIMARY KEY (`erid`, `eid`) USING BTREE,
  INDEX `eid`(`eid` ASC) USING BTREE,
  CONSTRAINT `Equipment_rent_standard_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `equipment` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '修改price的属性decimal（10,0）为（10,2）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of equipment_rent_standard
-- ----------------------------

-- ----------------------------
-- Table structure for field
-- ----------------------------
DROP TABLE IF EXISTS `field`;
CREATE TABLE `field`  (
  `fid` int NOT NULL AUTO_INCREMENT COMMENT '场地id',
  `tid` int NOT NULL COMMENT '场地类型',
  `money` decimal(10, 2) NOT NULL COMMENT '收费标准',
  `description` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '场地描述',
  `num` int NULL DEFAULT NULL COMMENT '场地数量',
  `is_del` int NULL DEFAULT 0 COMMENT '场地删除标识符',
  PRIMARY KEY (`fid`, `tid`) USING BTREE,
  INDEX `tid`(`tid` ASC) USING BTREE,
  CONSTRAINT `Field_ibfk_1` FOREIGN KEY (`tid`) REFERENCES `field_type` (`tid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '场地表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of field
-- ----------------------------
INSERT INTO `field` VALUES (10, 5, 5.00, '乒乓球001', 6, 0);
INSERT INTO `field` VALUES (11, 5, 10.00, '乒乓球002', 4, 0);
INSERT INTO `field` VALUES (12, 6, 5.00, '中区篮球场', 4, 0);
INSERT INTO `field` VALUES (13, 6, 5.00, '东区篮球场', 5, 0);
INSERT INTO `field` VALUES (14, 6, 5.00, '西区篮球场', 4, 0);
INSERT INTO `field` VALUES (15, 7, 5.00, '东区排球场', 4, 0);
INSERT INTO `field` VALUES (16, 7, 5.00, '中区排球场', 2, 0);

-- ----------------------------
-- Table structure for field_check
-- ----------------------------
DROP TABLE IF EXISTS `field_check`;
CREATE TABLE `field_check`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '审核表id',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '提交时间',
  `money` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '费用',
  `status` char(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '审核状态',
  `uid` int NULL DEFAULT NULL COMMENT '用户id',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '审核标题',
  `card` char(18) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '一卡通号码',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid` ASC) USING BTREE,
  INDEX `Field_check_UserInfo_id_fk`(`card` ASC) USING BTREE,
  CONSTRAINT `Field_check_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '预约审核表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of field_check
-- ----------------------------
INSERT INTO `field_check` VALUES (30, '2024-05-08 15:32:22', 5.00, '已完成', 1, '中区篮球场篮3', '202111701452');
INSERT INTO `field_check` VALUES (31, '2024-05-08 16:50:15', 5.00, '已完成', 1, '东区篮球场篮0', '202111701452');
INSERT INTO `field_check` VALUES (32, '2024-05-08 17:01:48', 5.00, '已完成', 1, '东区篮球场篮0', '202111701452');
INSERT INTO `field_check` VALUES (33, '2024-05-09 00:12:28', 5.00, '待支付', 1, '东区篮球场篮0', '202111701452');
INSERT INTO `field_check` VALUES (34, '2024-05-09 17:47:34', 0.00, '审核中', 1, '西区篮球场篮2 ', '202111701452');

-- ----------------------------
-- Table structure for field_date
-- ----------------------------
DROP TABLE IF EXISTS `field_date`;
CREATE TABLE `field_date`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '日期表id',
  `inode` int NULL DEFAULT NULL COMMENT '索引，方便操作',
  `date` date NULL DEFAULT NULL COMMENT '日期',
  `fid` int NULL DEFAULT NULL COMMENT '场地id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fid`(`fid` ASC) USING BTREE,
  CONSTRAINT `Field_date_ibfk_1` FOREIGN KEY (`fid`) REFERENCES `field` (`fid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 238 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '日期表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of field_date
-- ----------------------------
INSERT INTO `field_date` VALUES (168, 0, '2024-05-09', 10);
INSERT INTO `field_date` VALUES (169, 1, '2024-05-09', 10);
INSERT INTO `field_date` VALUES (170, 2, '2024-05-09', 10);
INSERT INTO `field_date` VALUES (171, 3, '2024-05-09', 10);
INSERT INTO `field_date` VALUES (172, 4, '2024-05-09', 10);
INSERT INTO `field_date` VALUES (173, 5, '2024-05-09', 10);
INSERT INTO `field_date` VALUES (174, 0, '2024-05-10', 10);
INSERT INTO `field_date` VALUES (175, 1, '2024-05-10', 10);
INSERT INTO `field_date` VALUES (176, 2, '2024-05-10', 10);
INSERT INTO `field_date` VALUES (177, 3, '2024-05-10', 10);
INSERT INTO `field_date` VALUES (178, 4, '2024-05-10', 10);
INSERT INTO `field_date` VALUES (179, 5, '2024-05-10', 10);
INSERT INTO `field_date` VALUES (180, 0, '2024-05-11', 10);
INSERT INTO `field_date` VALUES (181, 1, '2024-05-11', 10);
INSERT INTO `field_date` VALUES (182, 2, '2024-05-11', 10);
INSERT INTO `field_date` VALUES (183, 3, '2024-05-11', 10);
INSERT INTO `field_date` VALUES (184, 4, '2024-05-11', 10);
INSERT INTO `field_date` VALUES (185, 5, '2024-05-11', 10);
INSERT INTO `field_date` VALUES (186, 0, '2024-05-12', 10);
INSERT INTO `field_date` VALUES (187, 1, '2024-05-12', 10);
INSERT INTO `field_date` VALUES (188, 2, '2024-05-12', 10);
INSERT INTO `field_date` VALUES (189, 3, '2024-05-12', 10);
INSERT INTO `field_date` VALUES (190, 4, '2024-05-12', 10);
INSERT INTO `field_date` VALUES (191, 5, '2024-05-12', 10);
INSERT INTO `field_date` VALUES (192, 0, '2024-05-13', 10);
INSERT INTO `field_date` VALUES (193, 1, '2024-05-13', 10);
INSERT INTO `field_date` VALUES (194, 2, '2024-05-13', 10);
INSERT INTO `field_date` VALUES (195, 3, '2024-05-13', 10);
INSERT INTO `field_date` VALUES (196, 4, '2024-05-13', 10);
INSERT INTO `field_date` VALUES (197, 5, '2024-05-13', 10);
INSERT INTO `field_date` VALUES (198, 0, '2024-05-14', 10);
INSERT INTO `field_date` VALUES (199, 1, '2024-05-14', 10);
INSERT INTO `field_date` VALUES (200, 2, '2024-05-14', 10);
INSERT INTO `field_date` VALUES (201, 3, '2024-05-14', 10);
INSERT INTO `field_date` VALUES (202, 4, '2024-05-14', 10);
INSERT INTO `field_date` VALUES (203, 5, '2024-05-14', 10);
INSERT INTO `field_date` VALUES (204, 0, '2024-05-15', 10);
INSERT INTO `field_date` VALUES (205, 1, '2024-05-15', 10);
INSERT INTO `field_date` VALUES (206, 2, '2024-05-15', 10);
INSERT INTO `field_date` VALUES (207, 3, '2024-05-15', 10);
INSERT INTO `field_date` VALUES (208, 4, '2024-05-15', 10);
INSERT INTO `field_date` VALUES (209, 5, '2024-05-15', 10);
INSERT INTO `field_date` VALUES (210, 0, '2024-05-09', 11);
INSERT INTO `field_date` VALUES (211, 1, '2024-05-09', 11);
INSERT INTO `field_date` VALUES (212, 2, '2024-05-09', 11);
INSERT INTO `field_date` VALUES (213, 3, '2024-05-09', 11);
INSERT INTO `field_date` VALUES (214, 0, '2024-05-09', 15);
INSERT INTO `field_date` VALUES (215, 1, '2024-05-09', 15);
INSERT INTO `field_date` VALUES (216, 2, '2024-05-09', 15);
INSERT INTO `field_date` VALUES (217, 3, '2024-05-09', 15);
INSERT INTO `field_date` VALUES (218, 0, '2024-05-10', 15);
INSERT INTO `field_date` VALUES (219, 1, '2024-05-10', 15);
INSERT INTO `field_date` VALUES (220, 2, '2024-05-10', 15);
INSERT INTO `field_date` VALUES (221, 3, '2024-05-10', 15);
INSERT INTO `field_date` VALUES (222, 0, '2024-05-09', 13);
INSERT INTO `field_date` VALUES (223, 1, '2024-05-09', 13);
INSERT INTO `field_date` VALUES (224, 2, '2024-05-09', 13);
INSERT INTO `field_date` VALUES (225, 3, '2024-05-09', 13);
INSERT INTO `field_date` VALUES (226, 4, '2024-05-09', 13);
INSERT INTO `field_date` VALUES (227, 0, '2024-05-09', 12);
INSERT INTO `field_date` VALUES (228, 1, '2024-05-09', 12);
INSERT INTO `field_date` VALUES (229, 2, '2024-05-09', 12);
INSERT INTO `field_date` VALUES (230, 3, '2024-05-09', 12);
INSERT INTO `field_date` VALUES (231, 0, '2024-05-10', 12);
INSERT INTO `field_date` VALUES (232, 1, '2024-05-10', 12);
INSERT INTO `field_date` VALUES (233, 2, '2024-05-10', 12);
INSERT INTO `field_date` VALUES (234, 3, '2024-05-10', 12);
INSERT INTO `field_date` VALUES (235, 0, '2024-05-09', 14);
INSERT INTO `field_date` VALUES (236, 1, '2024-05-09', 14);
INSERT INTO `field_date` VALUES (237, 2, '2024-05-09', 14);
INSERT INTO `field_date` VALUES (238, 3, '2024-05-09', 14);
INSERT INTO `field_date` VALUES (239, 0, '2024-05-10', 13);
INSERT INTO `field_date` VALUES (240, 1, '2024-05-10', 13);
INSERT INTO `field_date` VALUES (241, 2, '2024-05-10', 13);
INSERT INTO `field_date` VALUES (242, 3, '2024-05-10', 13);
INSERT INTO `field_date` VALUES (243, 4, '2024-05-10', 13);
INSERT INTO `field_date` VALUES (244, 0, '2024-05-16', 10);
INSERT INTO `field_date` VALUES (245, 1, '2024-05-16', 10);
INSERT INTO `field_date` VALUES (246, 2, '2024-05-16', 10);
INSERT INTO `field_date` VALUES (247, 3, '2024-05-16', 10);
INSERT INTO `field_date` VALUES (248, 4, '2024-05-16', 10);
INSERT INTO `field_date` VALUES (249, 5, '2024-05-16', 10);
INSERT INTO `field_date` VALUES (250, 0, '2024-05-11', 11);
INSERT INTO `field_date` VALUES (251, 1, '2024-05-11', 11);
INSERT INTO `field_date` VALUES (252, 2, '2024-05-11', 11);
INSERT INTO `field_date` VALUES (253, 3, '2024-05-11', 11);
INSERT INTO `field_date` VALUES (254, 0, '2024-05-10', 11);
INSERT INTO `field_date` VALUES (255, 1, '2024-05-10', 11);
INSERT INTO `field_date` VALUES (256, 2, '2024-05-10', 11);
INSERT INTO `field_date` VALUES (257, 3, '2024-05-10', 11);
INSERT INTO `field_date` VALUES (258, 0, '2024-05-10', 14);
INSERT INTO `field_date` VALUES (259, 1, '2024-05-10', 14);
INSERT INTO `field_date` VALUES (260, 2, '2024-05-10', 14);
INSERT INTO `field_date` VALUES (261, 3, '2024-05-10', 14);
INSERT INTO `field_date` VALUES (262, 0, '2024-05-12', 14);
INSERT INTO `field_date` VALUES (263, 1, '2024-05-12', 14);
INSERT INTO `field_date` VALUES (264, 2, '2024-05-12', 14);
INSERT INTO `field_date` VALUES (265, 3, '2024-05-12', 14);

-- ----------------------------
-- Table structure for field_type
-- ----------------------------
DROP TABLE IF EXISTS `field_type`;
CREATE TABLE `field_type`  (
  `tid` int NOT NULL AUTO_INCREMENT COMMENT '场地类型id',
  `type_name` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '场地类型名称',
  `is_del` int NULL DEFAULT 0 COMMENT '场地类型删除标识符',
  PRIMARY KEY (`tid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '场地类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of field_type
-- ----------------------------
INSERT INTO `field_type` VALUES (5, '乒乓球', 0);
INSERT INTO `field_type` VALUES (6, '篮球场', 0);
INSERT INTO `field_type` VALUES (7, '排球场', 0);

-- ----------------------------
-- Table structure for fix_equipment
-- ----------------------------
DROP TABLE IF EXISTS `fix_equipment`;
CREATE TABLE `fix_equipment`  (
  `fid` int NOT NULL COMMENT '器材维修id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '器材名称',
  `number` int NULL DEFAULT NULL COMMENT '器材数量',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '器材种类',
  PRIMARY KEY (`fid`) USING BTREE,
  CONSTRAINT `Fix_equipment_ibfk_1` FOREIGN KEY (`fid`) REFERENCES `equipment` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '为Fix_equipment表属性添加注释' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fix_equipment
-- ----------------------------

-- ----------------------------
-- Table structure for fix_equipment_bill
-- ----------------------------
DROP TABLE IF EXISTS `fix_equipment_bill`;
CREATE TABLE `fix_equipment_bill`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '器材维修账单id',
  `eid` int NULL DEFAULT NULL COMMENT '器材id',
  `number` int NULL DEFAULT NULL COMMENT '已维修的器材数量',
  `price` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '单个器材的维修价格（器材价格/2）',
  `fixDate` date NULL DEFAULT NULL COMMENT '器材维修日期',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `eid`(`eid` ASC) USING BTREE,
  CONSTRAINT `Fix_equipment_bill_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `equipment` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '修改price的默认值为0.00' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fix_equipment_bill
-- ----------------------------

-- ----------------------------
-- Table structure for order_item
-- ----------------------------
DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item`  (
  `oid` int NOT NULL AUTO_INCREMENT COMMENT '审核，具体安排关联表id',
  `fcid` int NOT NULL COMMENT '审核表id',
  `time_id` int NOT NULL COMMENT '时间安排表id',
  PRIMARY KEY (`oid`) USING BTREE,
  INDEX `fcid`(`fcid` ASC) USING BTREE,
  INDEX `time_id`(`time_id` ASC) USING BTREE,
  CONSTRAINT `Order_item_ibfk_1` FOREIGN KEY (`fcid`) REFERENCES `field_check` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Order_item_ibfk_2` FOREIGN KEY (`time_id`) REFERENCES `time_arrange` (`time_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '场地订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_item
-- ----------------------------
INSERT INTO `order_item` VALUES (33, 30, 3134);
INSERT INTO `order_item` VALUES (34, 31, 3021);
INSERT INTO `order_item` VALUES (35, 32, 3024);
INSERT INTO `order_item` VALUES (36, 33, 3242);
INSERT INTO `order_item` VALUES (37, 34, 3558);
INSERT INTO `order_item` VALUES (38, 34, 3559);

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `id` int NOT NULL,
  `pname` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限名称',
  `pid` int NULL DEFAULT NULL COMMENT '权限值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES (1, '查询用户个人信息', 1);
INSERT INTO `permission` VALUES (2, '修改密码', 2);
INSERT INTO `permission` VALUES (3, '修改密码_强制', 4);
INSERT INTO `permission` VALUES (4, '导入学生信息', 8);
INSERT INTO `permission` VALUES (5, '导入教师信息', 16);
INSERT INTO `permission` VALUES (6, '查询管理员信息', 32);
INSERT INTO `permission` VALUES (7, '更新管理员角色', 64);
INSERT INTO `permission` VALUES (8, '收支处理', 128);
INSERT INTO `permission` VALUES (9, '查询器材', 256);
INSERT INTO `permission` VALUES (10, '新增器材', 512);
INSERT INTO `permission` VALUES (11, '申请维护器材', 1024);
INSERT INTO `permission` VALUES (12, '查询维修器材', 2048);
INSERT INTO `permission` VALUES (13, '维护器材', 4096);
INSERT INTO `permission` VALUES (14, '器材废弃', 8192);
INSERT INTO `permission` VALUES (15, '申请回收器材', 16384);
INSERT INTO `permission` VALUES (16, '查询回收器材', 32768);
INSERT INTO `permission` VALUES (17, '回收器材审核', 65536);
INSERT INTO `permission` VALUES (18, '租用器材', 131072);
INSERT INTO `permission` VALUES (19, '赛事创建(预告)', 262144);
INSERT INTO `permission` VALUES (20, '赛事取消', 524288);
INSERT INTO `permission` VALUES (21, '赛事查询', 1048576);
INSERT INTO `permission` VALUES (22, '比赛场地安排', 2097152);
INSERT INTO `permission` VALUES (23, '裁判简介公告', 4194304);
INSERT INTO `permission` VALUES (24, '查询最新公告', 8388608);
INSERT INTO `permission` VALUES (25, '赛事器材申请', 16777216);
INSERT INTO `permission` VALUES (26, '查询赛事审核', 33554432);
INSERT INTO `permission` VALUES (27, '赛事审核', 67108864);
INSERT INTO `permission` VALUES (28, '创建公告', 134217728);
INSERT INTO `permission` VALUES (29, '修改公告', 268435456);
INSERT INTO `permission` VALUES (30, '查询公告历史记录', 536870912);

-- ----------------------------
-- Table structure for recycle_equipment
-- ----------------------------
DROP TABLE IF EXISTS `recycle_equipment`;
CREATE TABLE `recycle_equipment`  (
  `reid` int NOT NULL COMMENT '回收器材id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '器材名称',
  `number` int NULL DEFAULT NULL COMMENT '器材数量',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '器材种类',
  PRIMARY KEY (`reid`) USING BTREE,
  CONSTRAINT `Recycle_equipment_Competition_id_fk` FOREIGN KEY (`reid`) REFERENCES `equipment` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '修改Recycle_equipment表的外键' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of recycle_equipment
-- ----------------------------

-- ----------------------------
-- Table structure for rent_equipment
-- ----------------------------
DROP TABLE IF EXISTS `rent_equipment`;
CREATE TABLE `rent_equipment`  (
  `rid` int NOT NULL AUTO_INCREMENT,
  `eid` int NULL DEFAULT NULL,
  `eName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `uid` int NULL DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `rentTime` int NULL DEFAULT NULL,
  `number` int NULL DEFAULT NULL,
  `rentDate` date NULL DEFAULT NULL,
  `status` int NULL DEFAULT 0 COMMENT '器材租用状态，0代表未归还，1代表归还',
  PRIMARY KEY (`rid`) USING BTREE,
  INDEX `eid`(`eid` ASC) USING BTREE,
  INDEX `uid`(`uid` ASC) USING BTREE,
  CONSTRAINT `Rent_equipment_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `equipment` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Rent_equipment_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '增加status属性，判断该器材是否归还' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rent_equipment
-- ----------------------------
INSERT INTO `rent_equipment` VALUES (16, 10, '篮球', 1, 'Morty', 0, 1, '2024-05-08', 1);
INSERT INTO `rent_equipment` VALUES (17, 10, '篮球', 1, 'Morty', 1, 1, '2024-05-08', 1);
INSERT INTO `rent_equipment` VALUES (18, 10, '篮球', 15, 'moyu', 1, 1, '2024-05-08', 1);
INSERT INTO `rent_equipment` VALUES (19, 10, '篮球', 1, 'Morty', 1, 1, '2024-05-09', 1);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `info` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `permissions` int NULL DEFAULT 1 COMMENT '权限二进制',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '超级管理员', '', 1073741823);
INSERT INTO `role` VALUES (2, '用户管理员', 'UM', 570312063);
INSERT INTO `role` VALUES (3, '场地管理员', 'PM', 972965251);
INSERT INTO `role` VALUES (4, '赛事管理员', 'AM', 1073628419);
INSERT INTO `role` VALUES (5, '器材管理员', 'EM', 973045635);
INSERT INTO `role` VALUES (6, '学生', 'Student', 570311939);
INSERT INTO `role` VALUES (7, '教师', 'Teacher', 570311939);

-- ----------------------------
-- Table structure for time_arrange
-- ----------------------------
DROP TABLE IF EXISTS `time_arrange`;
CREATE TABLE `time_arrange`  (
  `time_id` int NOT NULL AUTO_INCREMENT COMMENT '时间表id',
  `start_time` time NOT NULL COMMENT '开始时间',
  `end_time` time NOT NULL COMMENT '结束时间',
  `inode` int NULL DEFAULT NULL COMMENT '索引，方便操作',
  `status` char(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '状态',
  `fdid` int NULL DEFAULT NULL COMMENT '日期表id',
  PRIMARY KEY (`time_id`) USING BTREE,
  INDEX `fdid`(`fdid` ASC) USING BTREE,
  CONSTRAINT `Time_arrange_ibfk_1` FOREIGN KEY (`fdid`) REFERENCES `field_date` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3239 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '时间安排表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of time_arrange
-- ----------------------------
INSERT INTO `time_arrange` VALUES (2317, '08:00:00', '09:00:00', 0, '空闲', 168);
INSERT INTO `time_arrange` VALUES (2318, '09:00:00', '10:00:00', 1, '空闲', 168);
INSERT INTO `time_arrange` VALUES (2319, '10:00:00', '11:00:00', 2, '空闲', 168);
INSERT INTO `time_arrange` VALUES (2320, '11:00:00', '12:00:00', 3, '空闲', 168);
INSERT INTO `time_arrange` VALUES (2321, '12:00:00', '13:00:00', 4, '空闲', 168);
INSERT INTO `time_arrange` VALUES (2322, '13:00:00', '14:00:00', 5, '空闲', 168);
INSERT INTO `time_arrange` VALUES (2323, '14:00:00', '15:00:00', 6, '空闲', 168);
INSERT INTO `time_arrange` VALUES (2324, '15:00:00', '16:00:00', 7, '空闲', 168);
INSERT INTO `time_arrange` VALUES (2325, '16:00:00', '17:00:00', 8, '空闲', 168);
INSERT INTO `time_arrange` VALUES (2326, '17:00:00', '18:00:00', 9, '空闲', 168);
INSERT INTO `time_arrange` VALUES (2327, '18:00:00', '19:00:00', 10, '空闲', 168);
INSERT INTO `time_arrange` VALUES (2328, '19:00:00', '20:00:00', 11, '空闲', 168);
INSERT INTO `time_arrange` VALUES (2329, '20:00:00', '21:00:00', 12, '空闲', 168);
INSERT INTO `time_arrange` VALUES (2330, '08:00:00', '09:00:00', 0, '空闲', 169);
INSERT INTO `time_arrange` VALUES (2331, '09:00:00', '10:00:00', 1, '空闲', 169);
INSERT INTO `time_arrange` VALUES (2332, '10:00:00', '11:00:00', 2, '空闲', 169);
INSERT INTO `time_arrange` VALUES (2333, '11:00:00', '12:00:00', 3, '空闲', 169);
INSERT INTO `time_arrange` VALUES (2334, '12:00:00', '13:00:00', 4, '空闲', 169);
INSERT INTO `time_arrange` VALUES (2335, '13:00:00', '14:00:00', 5, '空闲', 169);
INSERT INTO `time_arrange` VALUES (2336, '14:00:00', '15:00:00', 6, '空闲', 169);
INSERT INTO `time_arrange` VALUES (2337, '15:00:00', '16:00:00', 7, '空闲', 169);
INSERT INTO `time_arrange` VALUES (2338, '16:00:00', '17:00:00', 8, '空闲', 169);
INSERT INTO `time_arrange` VALUES (2339, '17:00:00', '18:00:00', 9, '空闲', 169);
INSERT INTO `time_arrange` VALUES (2340, '18:00:00', '19:00:00', 10, '空闲', 169);
INSERT INTO `time_arrange` VALUES (2341, '19:00:00', '20:00:00', 11, '空闲', 169);
INSERT INTO `time_arrange` VALUES (2342, '20:00:00', '21:00:00', 12, '空闲', 169);
INSERT INTO `time_arrange` VALUES (2343, '08:00:00', '09:00:00', 0, '空闲', 170);
INSERT INTO `time_arrange` VALUES (2344, '09:00:00', '10:00:00', 1, '空闲', 170);
INSERT INTO `time_arrange` VALUES (2345, '10:00:00', '11:00:00', 2, '空闲', 170);
INSERT INTO `time_arrange` VALUES (2346, '11:00:00', '12:00:00', 3, '空闲', 170);
INSERT INTO `time_arrange` VALUES (2347, '12:00:00', '13:00:00', 4, '空闲', 170);
INSERT INTO `time_arrange` VALUES (2348, '13:00:00', '14:00:00', 5, '空闲', 170);
INSERT INTO `time_arrange` VALUES (2349, '14:00:00', '15:00:00', 6, '空闲', 170);
INSERT INTO `time_arrange` VALUES (2350, '15:00:00', '16:00:00', 7, '空闲', 170);
INSERT INTO `time_arrange` VALUES (2351, '16:00:00', '17:00:00', 8, '空闲', 170);
INSERT INTO `time_arrange` VALUES (2352, '17:00:00', '18:00:00', 9, '空闲', 170);
INSERT INTO `time_arrange` VALUES (2353, '18:00:00', '19:00:00', 10, '空闲', 170);
INSERT INTO `time_arrange` VALUES (2354, '19:00:00', '20:00:00', 11, '空闲', 170);
INSERT INTO `time_arrange` VALUES (2355, '20:00:00', '21:00:00', 12, '空闲', 170);
INSERT INTO `time_arrange` VALUES (2356, '08:00:00', '09:00:00', 0, '空闲', 171);
INSERT INTO `time_arrange` VALUES (2357, '09:00:00', '10:00:00', 1, '空闲', 171);
INSERT INTO `time_arrange` VALUES (2358, '10:00:00', '11:00:00', 2, '空闲', 171);
INSERT INTO `time_arrange` VALUES (2359, '11:00:00', '12:00:00', 3, '空闲', 171);
INSERT INTO `time_arrange` VALUES (2360, '12:00:00', '13:00:00', 4, '空闲', 171);
INSERT INTO `time_arrange` VALUES (2361, '13:00:00', '14:00:00', 5, '空闲', 171);
INSERT INTO `time_arrange` VALUES (2362, '14:00:00', '15:00:00', 6, '空闲', 171);
INSERT INTO `time_arrange` VALUES (2363, '15:00:00', '16:00:00', 7, '空闲', 171);
INSERT INTO `time_arrange` VALUES (2364, '16:00:00', '17:00:00', 8, '空闲', 171);
INSERT INTO `time_arrange` VALUES (2365, '17:00:00', '18:00:00', 9, '空闲', 171);
INSERT INTO `time_arrange` VALUES (2366, '18:00:00', '19:00:00', 10, '空闲', 171);
INSERT INTO `time_arrange` VALUES (2367, '19:00:00', '20:00:00', 11, '空闲', 171);
INSERT INTO `time_arrange` VALUES (2368, '20:00:00', '21:00:00', 12, '空闲', 171);
INSERT INTO `time_arrange` VALUES (2369, '08:00:00', '09:00:00', 0, '空闲', 172);
INSERT INTO `time_arrange` VALUES (2370, '09:00:00', '10:00:00', 1, '空闲', 172);
INSERT INTO `time_arrange` VALUES (2371, '10:00:00', '11:00:00', 2, '空闲', 172);
INSERT INTO `time_arrange` VALUES (2372, '11:00:00', '12:00:00', 3, '空闲', 172);
INSERT INTO `time_arrange` VALUES (2373, '12:00:00', '13:00:00', 4, '空闲', 172);
INSERT INTO `time_arrange` VALUES (2374, '13:00:00', '14:00:00', 5, '空闲', 172);
INSERT INTO `time_arrange` VALUES (2375, '14:00:00', '15:00:00', 6, '空闲', 172);
INSERT INTO `time_arrange` VALUES (2376, '15:00:00', '16:00:00', 7, '空闲', 172);
INSERT INTO `time_arrange` VALUES (2377, '16:00:00', '17:00:00', 8, '空闲', 172);
INSERT INTO `time_arrange` VALUES (2378, '17:00:00', '18:00:00', 9, '空闲', 172);
INSERT INTO `time_arrange` VALUES (2379, '18:00:00', '19:00:00', 10, '空闲', 172);
INSERT INTO `time_arrange` VALUES (2380, '19:00:00', '20:00:00', 11, '空闲', 172);
INSERT INTO `time_arrange` VALUES (2381, '20:00:00', '21:00:00', 12, '空闲', 172);
INSERT INTO `time_arrange` VALUES (2382, '08:00:00', '09:00:00', 0, '空闲', 173);
INSERT INTO `time_arrange` VALUES (2383, '09:00:00', '10:00:00', 1, '空闲', 173);
INSERT INTO `time_arrange` VALUES (2384, '10:00:00', '11:00:00', 2, '空闲', 173);
INSERT INTO `time_arrange` VALUES (2385, '11:00:00', '12:00:00', 3, '空闲', 173);
INSERT INTO `time_arrange` VALUES (2386, '12:00:00', '13:00:00', 4, '空闲', 173);
INSERT INTO `time_arrange` VALUES (2387, '13:00:00', '14:00:00', 5, '空闲', 173);
INSERT INTO `time_arrange` VALUES (2388, '14:00:00', '15:00:00', 6, '空闲', 173);
INSERT INTO `time_arrange` VALUES (2389, '15:00:00', '16:00:00', 7, '空闲', 173);
INSERT INTO `time_arrange` VALUES (2390, '16:00:00', '17:00:00', 8, '空闲', 173);
INSERT INTO `time_arrange` VALUES (2391, '17:00:00', '18:00:00', 9, '空闲', 173);
INSERT INTO `time_arrange` VALUES (2392, '18:00:00', '19:00:00', 10, '空闲', 173);
INSERT INTO `time_arrange` VALUES (2393, '19:00:00', '20:00:00', 11, '空闲', 173);
INSERT INTO `time_arrange` VALUES (2394, '20:00:00', '21:00:00', 12, '空闲', 173);
INSERT INTO `time_arrange` VALUES (2395, '08:00:00', '09:00:00', 0, '空闲', 174);
INSERT INTO `time_arrange` VALUES (2396, '09:00:00', '10:00:00', 1, '空闲', 174);
INSERT INTO `time_arrange` VALUES (2397, '10:00:00', '11:00:00', 2, '空闲', 174);
INSERT INTO `time_arrange` VALUES (2398, '11:00:00', '12:00:00', 3, '空闲', 174);
INSERT INTO `time_arrange` VALUES (2399, '12:00:00', '13:00:00', 4, '空闲', 174);
INSERT INTO `time_arrange` VALUES (2400, '13:00:00', '14:00:00', 5, '空闲', 174);
INSERT INTO `time_arrange` VALUES (2401, '14:00:00', '15:00:00', 6, '空闲', 174);
INSERT INTO `time_arrange` VALUES (2402, '15:00:00', '16:00:00', 7, '空闲', 174);
INSERT INTO `time_arrange` VALUES (2403, '16:00:00', '17:00:00', 8, '空闲', 174);
INSERT INTO `time_arrange` VALUES (2404, '17:00:00', '18:00:00', 9, '空闲', 174);
INSERT INTO `time_arrange` VALUES (2405, '18:00:00', '19:00:00', 10, '空闲', 174);
INSERT INTO `time_arrange` VALUES (2406, '19:00:00', '20:00:00', 11, '空闲', 174);
INSERT INTO `time_arrange` VALUES (2407, '20:00:00', '21:00:00', 12, '空闲', 174);
INSERT INTO `time_arrange` VALUES (2408, '08:00:00', '09:00:00', 0, '空闲', 175);
INSERT INTO `time_arrange` VALUES (2409, '09:00:00', '10:00:00', 1, '空闲', 175);
INSERT INTO `time_arrange` VALUES (2410, '10:00:00', '11:00:00', 2, '空闲', 175);
INSERT INTO `time_arrange` VALUES (2411, '11:00:00', '12:00:00', 3, '空闲', 175);
INSERT INTO `time_arrange` VALUES (2412, '12:00:00', '13:00:00', 4, '空闲', 175);
INSERT INTO `time_arrange` VALUES (2413, '13:00:00', '14:00:00', 5, '空闲', 175);
INSERT INTO `time_arrange` VALUES (2414, '14:00:00', '15:00:00', 6, '空闲', 175);
INSERT INTO `time_arrange` VALUES (2415, '15:00:00', '16:00:00', 7, '空闲', 175);
INSERT INTO `time_arrange` VALUES (2416, '16:00:00', '17:00:00', 8, '空闲', 175);
INSERT INTO `time_arrange` VALUES (2417, '17:00:00', '18:00:00', 9, '空闲', 175);
INSERT INTO `time_arrange` VALUES (2418, '18:00:00', '19:00:00', 10, '空闲', 175);
INSERT INTO `time_arrange` VALUES (2419, '19:00:00', '20:00:00', 11, '空闲', 175);
INSERT INTO `time_arrange` VALUES (2420, '20:00:00', '21:00:00', 12, '空闲', 175);
INSERT INTO `time_arrange` VALUES (2421, '08:00:00', '09:00:00', 0, '空闲', 176);
INSERT INTO `time_arrange` VALUES (2422, '09:00:00', '10:00:00', 1, '空闲', 176);
INSERT INTO `time_arrange` VALUES (2423, '10:00:00', '11:00:00', 2, '空闲', 176);
INSERT INTO `time_arrange` VALUES (2424, '11:00:00', '12:00:00', 3, '空闲', 176);
INSERT INTO `time_arrange` VALUES (2425, '12:00:00', '13:00:00', 4, '空闲', 176);
INSERT INTO `time_arrange` VALUES (2426, '13:00:00', '14:00:00', 5, '空闲', 176);
INSERT INTO `time_arrange` VALUES (2427, '14:00:00', '15:00:00', 6, '空闲', 176);
INSERT INTO `time_arrange` VALUES (2428, '15:00:00', '16:00:00', 7, '空闲', 176);
INSERT INTO `time_arrange` VALUES (2429, '16:00:00', '17:00:00', 8, '空闲', 176);
INSERT INTO `time_arrange` VALUES (2430, '17:00:00', '18:00:00', 9, '空闲', 176);
INSERT INTO `time_arrange` VALUES (2431, '18:00:00', '19:00:00', 10, '空闲', 176);
INSERT INTO `time_arrange` VALUES (2432, '19:00:00', '20:00:00', 11, '空闲', 176);
INSERT INTO `time_arrange` VALUES (2433, '20:00:00', '21:00:00', 12, '空闲', 176);
INSERT INTO `time_arrange` VALUES (2434, '08:00:00', '09:00:00', 0, '空闲', 177);
INSERT INTO `time_arrange` VALUES (2435, '09:00:00', '10:00:00', 1, '空闲', 177);
INSERT INTO `time_arrange` VALUES (2436, '10:00:00', '11:00:00', 2, '空闲', 177);
INSERT INTO `time_arrange` VALUES (2437, '11:00:00', '12:00:00', 3, '空闲', 177);
INSERT INTO `time_arrange` VALUES (2438, '12:00:00', '13:00:00', 4, '空闲', 177);
INSERT INTO `time_arrange` VALUES (2439, '13:00:00', '14:00:00', 5, '空闲', 177);
INSERT INTO `time_arrange` VALUES (2440, '14:00:00', '15:00:00', 6, '空闲', 177);
INSERT INTO `time_arrange` VALUES (2441, '15:00:00', '16:00:00', 7, '空闲', 177);
INSERT INTO `time_arrange` VALUES (2442, '16:00:00', '17:00:00', 8, '空闲', 177);
INSERT INTO `time_arrange` VALUES (2443, '17:00:00', '18:00:00', 9, '空闲', 177);
INSERT INTO `time_arrange` VALUES (2444, '18:00:00', '19:00:00', 10, '空闲', 177);
INSERT INTO `time_arrange` VALUES (2445, '19:00:00', '20:00:00', 11, '空闲', 177);
INSERT INTO `time_arrange` VALUES (2446, '20:00:00', '21:00:00', 12, '空闲', 177);
INSERT INTO `time_arrange` VALUES (2447, '08:00:00', '09:00:00', 0, '空闲', 178);
INSERT INTO `time_arrange` VALUES (2448, '09:00:00', '10:00:00', 1, '空闲', 178);
INSERT INTO `time_arrange` VALUES (2449, '10:00:00', '11:00:00', 2, '空闲', 178);
INSERT INTO `time_arrange` VALUES (2450, '11:00:00', '12:00:00', 3, '空闲', 178);
INSERT INTO `time_arrange` VALUES (2451, '12:00:00', '13:00:00', 4, '空闲', 178);
INSERT INTO `time_arrange` VALUES (2452, '13:00:00', '14:00:00', 5, '空闲', 178);
INSERT INTO `time_arrange` VALUES (2453, '14:00:00', '15:00:00', 6, '空闲', 178);
INSERT INTO `time_arrange` VALUES (2454, '15:00:00', '16:00:00', 7, '空闲', 178);
INSERT INTO `time_arrange` VALUES (2455, '16:00:00', '17:00:00', 8, '空闲', 178);
INSERT INTO `time_arrange` VALUES (2456, '17:00:00', '18:00:00', 9, '空闲', 178);
INSERT INTO `time_arrange` VALUES (2457, '18:00:00', '19:00:00', 10, '空闲', 178);
INSERT INTO `time_arrange` VALUES (2458, '19:00:00', '20:00:00', 11, '空闲', 178);
INSERT INTO `time_arrange` VALUES (2459, '20:00:00', '21:00:00', 12, '空闲', 178);
INSERT INTO `time_arrange` VALUES (2460, '08:00:00', '09:00:00', 0, '空闲', 179);
INSERT INTO `time_arrange` VALUES (2461, '09:00:00', '10:00:00', 1, '空闲', 179);
INSERT INTO `time_arrange` VALUES (2462, '10:00:00', '11:00:00', 2, '空闲', 179);
INSERT INTO `time_arrange` VALUES (2463, '11:00:00', '12:00:00', 3, '空闲', 179);
INSERT INTO `time_arrange` VALUES (2464, '12:00:00', '13:00:00', 4, '空闲', 179);
INSERT INTO `time_arrange` VALUES (2465, '13:00:00', '14:00:00', 5, '空闲', 179);
INSERT INTO `time_arrange` VALUES (2466, '14:00:00', '15:00:00', 6, '空闲', 179);
INSERT INTO `time_arrange` VALUES (2467, '15:00:00', '16:00:00', 7, '空闲', 179);
INSERT INTO `time_arrange` VALUES (2468, '16:00:00', '17:00:00', 8, '空闲', 179);
INSERT INTO `time_arrange` VALUES (2469, '17:00:00', '18:00:00', 9, '空闲', 179);
INSERT INTO `time_arrange` VALUES (2470, '18:00:00', '19:00:00', 10, '空闲', 179);
INSERT INTO `time_arrange` VALUES (2471, '19:00:00', '20:00:00', 11, '空闲', 179);
INSERT INTO `time_arrange` VALUES (2472, '20:00:00', '21:00:00', 12, '空闲', 179);
INSERT INTO `time_arrange` VALUES (2473, '08:00:00', '09:00:00', 0, '空闲', 180);
INSERT INTO `time_arrange` VALUES (2474, '09:00:00', '10:00:00', 1, '空闲', 180);
INSERT INTO `time_arrange` VALUES (2475, '10:00:00', '11:00:00', 2, '空闲', 180);
INSERT INTO `time_arrange` VALUES (2476, '11:00:00', '12:00:00', 3, '空闲', 180);
INSERT INTO `time_arrange` VALUES (2477, '12:00:00', '13:00:00', 4, '空闲', 180);
INSERT INTO `time_arrange` VALUES (2478, '13:00:00', '14:00:00', 5, '空闲', 180);
INSERT INTO `time_arrange` VALUES (2479, '14:00:00', '15:00:00', 6, '空闲', 180);
INSERT INTO `time_arrange` VALUES (2480, '15:00:00', '16:00:00', 7, '空闲', 180);
INSERT INTO `time_arrange` VALUES (2481, '16:00:00', '17:00:00', 8, '空闲', 180);
INSERT INTO `time_arrange` VALUES (2482, '17:00:00', '18:00:00', 9, '空闲', 180);
INSERT INTO `time_arrange` VALUES (2483, '18:00:00', '19:00:00', 10, '空闲', 180);
INSERT INTO `time_arrange` VALUES (2484, '19:00:00', '20:00:00', 11, '空闲', 180);
INSERT INTO `time_arrange` VALUES (2485, '20:00:00', '21:00:00', 12, '空闲', 180);
INSERT INTO `time_arrange` VALUES (2486, '08:00:00', '09:00:00', 0, '空闲', 181);
INSERT INTO `time_arrange` VALUES (2487, '09:00:00', '10:00:00', 1, '空闲', 181);
INSERT INTO `time_arrange` VALUES (2488, '10:00:00', '11:00:00', 2, '空闲', 181);
INSERT INTO `time_arrange` VALUES (2489, '11:00:00', '12:00:00', 3, '空闲', 181);
INSERT INTO `time_arrange` VALUES (2490, '12:00:00', '13:00:00', 4, '空闲', 181);
INSERT INTO `time_arrange` VALUES (2491, '13:00:00', '14:00:00', 5, '空闲', 181);
INSERT INTO `time_arrange` VALUES (2492, '14:00:00', '15:00:00', 6, '空闲', 181);
INSERT INTO `time_arrange` VALUES (2493, '15:00:00', '16:00:00', 7, '空闲', 181);
INSERT INTO `time_arrange` VALUES (2494, '16:00:00', '17:00:00', 8, '空闲', 181);
INSERT INTO `time_arrange` VALUES (2495, '17:00:00', '18:00:00', 9, '空闲', 181);
INSERT INTO `time_arrange` VALUES (2496, '18:00:00', '19:00:00', 10, '空闲', 181);
INSERT INTO `time_arrange` VALUES (2497, '19:00:00', '20:00:00', 11, '空闲', 181);
INSERT INTO `time_arrange` VALUES (2498, '20:00:00', '21:00:00', 12, '空闲', 181);
INSERT INTO `time_arrange` VALUES (2499, '08:00:00', '09:00:00', 0, '空闲', 182);
INSERT INTO `time_arrange` VALUES (2500, '09:00:00', '10:00:00', 1, '空闲', 182);
INSERT INTO `time_arrange` VALUES (2501, '10:00:00', '11:00:00', 2, '空闲', 182);
INSERT INTO `time_arrange` VALUES (2502, '11:00:00', '12:00:00', 3, '空闲', 182);
INSERT INTO `time_arrange` VALUES (2503, '12:00:00', '13:00:00', 4, '空闲', 182);
INSERT INTO `time_arrange` VALUES (2504, '13:00:00', '14:00:00', 5, '空闲', 182);
INSERT INTO `time_arrange` VALUES (2505, '14:00:00', '15:00:00', 6, '空闲', 182);
INSERT INTO `time_arrange` VALUES (2506, '15:00:00', '16:00:00', 7, '空闲', 182);
INSERT INTO `time_arrange` VALUES (2507, '16:00:00', '17:00:00', 8, '空闲', 182);
INSERT INTO `time_arrange` VALUES (2508, '17:00:00', '18:00:00', 9, '空闲', 182);
INSERT INTO `time_arrange` VALUES (2509, '18:00:00', '19:00:00', 10, '空闲', 182);
INSERT INTO `time_arrange` VALUES (2510, '19:00:00', '20:00:00', 11, '空闲', 182);
INSERT INTO `time_arrange` VALUES (2511, '20:00:00', '21:00:00', 12, '空闲', 182);
INSERT INTO `time_arrange` VALUES (2512, '08:00:00', '09:00:00', 0, '空闲', 183);
INSERT INTO `time_arrange` VALUES (2513, '09:00:00', '10:00:00', 1, '空闲', 183);
INSERT INTO `time_arrange` VALUES (2514, '10:00:00', '11:00:00', 2, '空闲', 183);
INSERT INTO `time_arrange` VALUES (2515, '11:00:00', '12:00:00', 3, '空闲', 183);
INSERT INTO `time_arrange` VALUES (2516, '12:00:00', '13:00:00', 4, '空闲', 183);
INSERT INTO `time_arrange` VALUES (2517, '13:00:00', '14:00:00', 5, '空闲', 183);
INSERT INTO `time_arrange` VALUES (2518, '14:00:00', '15:00:00', 6, '空闲', 183);
INSERT INTO `time_arrange` VALUES (2519, '15:00:00', '16:00:00', 7, '空闲', 183);
INSERT INTO `time_arrange` VALUES (2520, '16:00:00', '17:00:00', 8, '空闲', 183);
INSERT INTO `time_arrange` VALUES (2521, '17:00:00', '18:00:00', 9, '空闲', 183);
INSERT INTO `time_arrange` VALUES (2522, '18:00:00', '19:00:00', 10, '空闲', 183);
INSERT INTO `time_arrange` VALUES (2523, '19:00:00', '20:00:00', 11, '空闲', 183);
INSERT INTO `time_arrange` VALUES (2524, '20:00:00', '21:00:00', 12, '空闲', 183);
INSERT INTO `time_arrange` VALUES (2525, '08:00:00', '09:00:00', 0, '空闲', 184);
INSERT INTO `time_arrange` VALUES (2526, '09:00:00', '10:00:00', 1, '空闲', 184);
INSERT INTO `time_arrange` VALUES (2527, '10:00:00', '11:00:00', 2, '空闲', 184);
INSERT INTO `time_arrange` VALUES (2528, '11:00:00', '12:00:00', 3, '空闲', 184);
INSERT INTO `time_arrange` VALUES (2529, '12:00:00', '13:00:00', 4, '空闲', 184);
INSERT INTO `time_arrange` VALUES (2530, '13:00:00', '14:00:00', 5, '空闲', 184);
INSERT INTO `time_arrange` VALUES (2531, '14:00:00', '15:00:00', 6, '空闲', 184);
INSERT INTO `time_arrange` VALUES (2532, '15:00:00', '16:00:00', 7, '空闲', 184);
INSERT INTO `time_arrange` VALUES (2533, '16:00:00', '17:00:00', 8, '空闲', 184);
INSERT INTO `time_arrange` VALUES (2534, '17:00:00', '18:00:00', 9, '空闲', 184);
INSERT INTO `time_arrange` VALUES (2535, '18:00:00', '19:00:00', 10, '空闲', 184);
INSERT INTO `time_arrange` VALUES (2536, '19:00:00', '20:00:00', 11, '空闲', 184);
INSERT INTO `time_arrange` VALUES (2537, '20:00:00', '21:00:00', 12, '空闲', 184);
INSERT INTO `time_arrange` VALUES (2538, '08:00:00', '09:00:00', 0, '空闲', 185);
INSERT INTO `time_arrange` VALUES (2539, '09:00:00', '10:00:00', 1, '空闲', 185);
INSERT INTO `time_arrange` VALUES (2540, '10:00:00', '11:00:00', 2, '空闲', 185);
INSERT INTO `time_arrange` VALUES (2541, '11:00:00', '12:00:00', 3, '空闲', 185);
INSERT INTO `time_arrange` VALUES (2542, '12:00:00', '13:00:00', 4, '空闲', 185);
INSERT INTO `time_arrange` VALUES (2543, '13:00:00', '14:00:00', 5, '空闲', 185);
INSERT INTO `time_arrange` VALUES (2544, '14:00:00', '15:00:00', 6, '空闲', 185);
INSERT INTO `time_arrange` VALUES (2545, '15:00:00', '16:00:00', 7, '空闲', 185);
INSERT INTO `time_arrange` VALUES (2546, '16:00:00', '17:00:00', 8, '空闲', 185);
INSERT INTO `time_arrange` VALUES (2547, '17:00:00', '18:00:00', 9, '空闲', 185);
INSERT INTO `time_arrange` VALUES (2548, '18:00:00', '19:00:00', 10, '空闲', 185);
INSERT INTO `time_arrange` VALUES (2549, '19:00:00', '20:00:00', 11, '空闲', 185);
INSERT INTO `time_arrange` VALUES (2550, '20:00:00', '21:00:00', 12, '空闲', 185);
INSERT INTO `time_arrange` VALUES (2551, '08:00:00', '09:00:00', 0, '空闲', 186);
INSERT INTO `time_arrange` VALUES (2552, '09:00:00', '10:00:00', 1, '空闲', 186);
INSERT INTO `time_arrange` VALUES (2553, '10:00:00', '11:00:00', 2, '空闲', 186);
INSERT INTO `time_arrange` VALUES (2554, '11:00:00', '12:00:00', 3, '空闲', 186);
INSERT INTO `time_arrange` VALUES (2555, '12:00:00', '13:00:00', 4, '空闲', 186);
INSERT INTO `time_arrange` VALUES (2556, '13:00:00', '14:00:00', 5, '空闲', 186);
INSERT INTO `time_arrange` VALUES (2557, '14:00:00', '15:00:00', 6, '空闲', 186);
INSERT INTO `time_arrange` VALUES (2558, '15:00:00', '16:00:00', 7, '空闲', 186);
INSERT INTO `time_arrange` VALUES (2559, '16:00:00', '17:00:00', 8, '空闲', 186);
INSERT INTO `time_arrange` VALUES (2560, '17:00:00', '18:00:00', 9, '空闲', 186);
INSERT INTO `time_arrange` VALUES (2561, '18:00:00', '19:00:00', 10, '空闲', 186);
INSERT INTO `time_arrange` VALUES (2562, '19:00:00', '20:00:00', 11, '空闲', 186);
INSERT INTO `time_arrange` VALUES (2563, '20:00:00', '21:00:00', 12, '空闲', 186);
INSERT INTO `time_arrange` VALUES (2564, '08:00:00', '09:00:00', 0, '空闲', 187);
INSERT INTO `time_arrange` VALUES (2565, '09:00:00', '10:00:00', 1, '空闲', 187);
INSERT INTO `time_arrange` VALUES (2566, '10:00:00', '11:00:00', 2, '空闲', 187);
INSERT INTO `time_arrange` VALUES (2567, '11:00:00', '12:00:00', 3, '空闲', 187);
INSERT INTO `time_arrange` VALUES (2568, '12:00:00', '13:00:00', 4, '空闲', 187);
INSERT INTO `time_arrange` VALUES (2569, '13:00:00', '14:00:00', 5, '空闲', 187);
INSERT INTO `time_arrange` VALUES (2570, '14:00:00', '15:00:00', 6, '空闲', 187);
INSERT INTO `time_arrange` VALUES (2571, '15:00:00', '16:00:00', 7, '空闲', 187);
INSERT INTO `time_arrange` VALUES (2572, '16:00:00', '17:00:00', 8, '空闲', 187);
INSERT INTO `time_arrange` VALUES (2573, '17:00:00', '18:00:00', 9, '空闲', 187);
INSERT INTO `time_arrange` VALUES (2574, '18:00:00', '19:00:00', 10, '空闲', 187);
INSERT INTO `time_arrange` VALUES (2575, '19:00:00', '20:00:00', 11, '空闲', 187);
INSERT INTO `time_arrange` VALUES (2576, '20:00:00', '21:00:00', 12, '空闲', 187);
INSERT INTO `time_arrange` VALUES (2577, '08:00:00', '09:00:00', 0, '空闲', 188);
INSERT INTO `time_arrange` VALUES (2578, '09:00:00', '10:00:00', 1, '空闲', 188);
INSERT INTO `time_arrange` VALUES (2579, '10:00:00', '11:00:00', 2, '空闲', 188);
INSERT INTO `time_arrange` VALUES (2580, '11:00:00', '12:00:00', 3, '空闲', 188);
INSERT INTO `time_arrange` VALUES (2581, '12:00:00', '13:00:00', 4, '空闲', 188);
INSERT INTO `time_arrange` VALUES (2582, '13:00:00', '14:00:00', 5, '空闲', 188);
INSERT INTO `time_arrange` VALUES (2583, '14:00:00', '15:00:00', 6, '空闲', 188);
INSERT INTO `time_arrange` VALUES (2584, '15:00:00', '16:00:00', 7, '空闲', 188);
INSERT INTO `time_arrange` VALUES (2585, '16:00:00', '17:00:00', 8, '空闲', 188);
INSERT INTO `time_arrange` VALUES (2586, '17:00:00', '18:00:00', 9, '空闲', 188);
INSERT INTO `time_arrange` VALUES (2587, '18:00:00', '19:00:00', 10, '空闲', 188);
INSERT INTO `time_arrange` VALUES (2588, '19:00:00', '20:00:00', 11, '空闲', 188);
INSERT INTO `time_arrange` VALUES (2589, '20:00:00', '21:00:00', 12, '空闲', 188);
INSERT INTO `time_arrange` VALUES (2590, '08:00:00', '09:00:00', 0, '空闲', 189);
INSERT INTO `time_arrange` VALUES (2591, '09:00:00', '10:00:00', 1, '空闲', 189);
INSERT INTO `time_arrange` VALUES (2592, '10:00:00', '11:00:00', 2, '空闲', 189);
INSERT INTO `time_arrange` VALUES (2593, '11:00:00', '12:00:00', 3, '空闲', 189);
INSERT INTO `time_arrange` VALUES (2594, '12:00:00', '13:00:00', 4, '空闲', 189);
INSERT INTO `time_arrange` VALUES (2595, '13:00:00', '14:00:00', 5, '空闲', 189);
INSERT INTO `time_arrange` VALUES (2596, '14:00:00', '15:00:00', 6, '空闲', 189);
INSERT INTO `time_arrange` VALUES (2597, '15:00:00', '16:00:00', 7, '空闲', 189);
INSERT INTO `time_arrange` VALUES (2598, '16:00:00', '17:00:00', 8, '空闲', 189);
INSERT INTO `time_arrange` VALUES (2599, '17:00:00', '18:00:00', 9, '空闲', 189);
INSERT INTO `time_arrange` VALUES (2600, '18:00:00', '19:00:00', 10, '空闲', 189);
INSERT INTO `time_arrange` VALUES (2601, '19:00:00', '20:00:00', 11, '空闲', 189);
INSERT INTO `time_arrange` VALUES (2602, '20:00:00', '21:00:00', 12, '空闲', 189);
INSERT INTO `time_arrange` VALUES (2603, '08:00:00', '09:00:00', 0, '空闲', 190);
INSERT INTO `time_arrange` VALUES (2604, '09:00:00', '10:00:00', 1, '空闲', 190);
INSERT INTO `time_arrange` VALUES (2605, '10:00:00', '11:00:00', 2, '空闲', 190);
INSERT INTO `time_arrange` VALUES (2606, '11:00:00', '12:00:00', 3, '空闲', 190);
INSERT INTO `time_arrange` VALUES (2607, '12:00:00', '13:00:00', 4, '空闲', 190);
INSERT INTO `time_arrange` VALUES (2608, '13:00:00', '14:00:00', 5, '空闲', 190);
INSERT INTO `time_arrange` VALUES (2609, '14:00:00', '15:00:00', 6, '空闲', 190);
INSERT INTO `time_arrange` VALUES (2610, '15:00:00', '16:00:00', 7, '空闲', 190);
INSERT INTO `time_arrange` VALUES (2611, '16:00:00', '17:00:00', 8, '空闲', 190);
INSERT INTO `time_arrange` VALUES (2612, '17:00:00', '18:00:00', 9, '空闲', 190);
INSERT INTO `time_arrange` VALUES (2613, '18:00:00', '19:00:00', 10, '空闲', 190);
INSERT INTO `time_arrange` VALUES (2614, '19:00:00', '20:00:00', 11, '空闲', 190);
INSERT INTO `time_arrange` VALUES (2615, '20:00:00', '21:00:00', 12, '空闲', 190);
INSERT INTO `time_arrange` VALUES (2616, '08:00:00', '09:00:00', 0, '空闲', 191);
INSERT INTO `time_arrange` VALUES (2617, '09:00:00', '10:00:00', 1, '空闲', 191);
INSERT INTO `time_arrange` VALUES (2618, '10:00:00', '11:00:00', 2, '空闲', 191);
INSERT INTO `time_arrange` VALUES (2619, '11:00:00', '12:00:00', 3, '空闲', 191);
INSERT INTO `time_arrange` VALUES (2620, '12:00:00', '13:00:00', 4, '空闲', 191);
INSERT INTO `time_arrange` VALUES (2621, '13:00:00', '14:00:00', 5, '空闲', 191);
INSERT INTO `time_arrange` VALUES (2622, '14:00:00', '15:00:00', 6, '空闲', 191);
INSERT INTO `time_arrange` VALUES (2623, '15:00:00', '16:00:00', 7, '空闲', 191);
INSERT INTO `time_arrange` VALUES (2624, '16:00:00', '17:00:00', 8, '空闲', 191);
INSERT INTO `time_arrange` VALUES (2625, '17:00:00', '18:00:00', 9, '空闲', 191);
INSERT INTO `time_arrange` VALUES (2626, '18:00:00', '19:00:00', 10, '空闲', 191);
INSERT INTO `time_arrange` VALUES (2627, '19:00:00', '20:00:00', 11, '空闲', 191);
INSERT INTO `time_arrange` VALUES (2628, '20:00:00', '21:00:00', 12, '空闲', 191);
INSERT INTO `time_arrange` VALUES (2629, '08:00:00', '09:00:00', 0, '空闲', 192);
INSERT INTO `time_arrange` VALUES (2630, '09:00:00', '10:00:00', 1, '空闲', 192);
INSERT INTO `time_arrange` VALUES (2631, '10:00:00', '11:00:00', 2, '空闲', 192);
INSERT INTO `time_arrange` VALUES (2632, '11:00:00', '12:00:00', 3, '空闲', 192);
INSERT INTO `time_arrange` VALUES (2633, '12:00:00', '13:00:00', 4, '空闲', 192);
INSERT INTO `time_arrange` VALUES (2634, '13:00:00', '14:00:00', 5, '空闲', 192);
INSERT INTO `time_arrange` VALUES (2635, '14:00:00', '15:00:00', 6, '空闲', 192);
INSERT INTO `time_arrange` VALUES (2636, '15:00:00', '16:00:00', 7, '空闲', 192);
INSERT INTO `time_arrange` VALUES (2637, '16:00:00', '17:00:00', 8, '空闲', 192);
INSERT INTO `time_arrange` VALUES (2638, '17:00:00', '18:00:00', 9, '空闲', 192);
INSERT INTO `time_arrange` VALUES (2639, '18:00:00', '19:00:00', 10, '空闲', 192);
INSERT INTO `time_arrange` VALUES (2640, '19:00:00', '20:00:00', 11, '空闲', 192);
INSERT INTO `time_arrange` VALUES (2641, '20:00:00', '21:00:00', 12, '空闲', 192);
INSERT INTO `time_arrange` VALUES (2642, '08:00:00', '09:00:00', 0, '空闲', 193);
INSERT INTO `time_arrange` VALUES (2643, '09:00:00', '10:00:00', 1, '空闲', 193);
INSERT INTO `time_arrange` VALUES (2644, '10:00:00', '11:00:00', 2, '空闲', 193);
INSERT INTO `time_arrange` VALUES (2645, '11:00:00', '12:00:00', 3, '空闲', 193);
INSERT INTO `time_arrange` VALUES (2646, '12:00:00', '13:00:00', 4, '空闲', 193);
INSERT INTO `time_arrange` VALUES (2647, '13:00:00', '14:00:00', 5, '空闲', 193);
INSERT INTO `time_arrange` VALUES (2648, '14:00:00', '15:00:00', 6, '空闲', 193);
INSERT INTO `time_arrange` VALUES (2649, '15:00:00', '16:00:00', 7, '空闲', 193);
INSERT INTO `time_arrange` VALUES (2650, '16:00:00', '17:00:00', 8, '空闲', 193);
INSERT INTO `time_arrange` VALUES (2651, '17:00:00', '18:00:00', 9, '空闲', 193);
INSERT INTO `time_arrange` VALUES (2652, '18:00:00', '19:00:00', 10, '空闲', 193);
INSERT INTO `time_arrange` VALUES (2653, '19:00:00', '20:00:00', 11, '空闲', 193);
INSERT INTO `time_arrange` VALUES (2654, '20:00:00', '21:00:00', 12, '空闲', 193);
INSERT INTO `time_arrange` VALUES (2655, '08:00:00', '09:00:00', 0, '空闲', 194);
INSERT INTO `time_arrange` VALUES (2656, '09:00:00', '10:00:00', 1, '空闲', 194);
INSERT INTO `time_arrange` VALUES (2657, '10:00:00', '11:00:00', 2, '空闲', 194);
INSERT INTO `time_arrange` VALUES (2658, '11:00:00', '12:00:00', 3, '空闲', 194);
INSERT INTO `time_arrange` VALUES (2659, '12:00:00', '13:00:00', 4, '空闲', 194);
INSERT INTO `time_arrange` VALUES (2660, '13:00:00', '14:00:00', 5, '空闲', 194);
INSERT INTO `time_arrange` VALUES (2661, '14:00:00', '15:00:00', 6, '空闲', 194);
INSERT INTO `time_arrange` VALUES (2662, '15:00:00', '16:00:00', 7, '空闲', 194);
INSERT INTO `time_arrange` VALUES (2663, '16:00:00', '17:00:00', 8, '空闲', 194);
INSERT INTO `time_arrange` VALUES (2664, '17:00:00', '18:00:00', 9, '空闲', 194);
INSERT INTO `time_arrange` VALUES (2665, '18:00:00', '19:00:00', 10, '空闲', 194);
INSERT INTO `time_arrange` VALUES (2666, '19:00:00', '20:00:00', 11, '空闲', 194);
INSERT INTO `time_arrange` VALUES (2667, '20:00:00', '21:00:00', 12, '空闲', 194);
INSERT INTO `time_arrange` VALUES (2668, '08:00:00', '09:00:00', 0, '空闲', 195);
INSERT INTO `time_arrange` VALUES (2669, '09:00:00', '10:00:00', 1, '空闲', 195);
INSERT INTO `time_arrange` VALUES (2670, '10:00:00', '11:00:00', 2, '空闲', 195);
INSERT INTO `time_arrange` VALUES (2671, '11:00:00', '12:00:00', 3, '空闲', 195);
INSERT INTO `time_arrange` VALUES (2672, '12:00:00', '13:00:00', 4, '空闲', 195);
INSERT INTO `time_arrange` VALUES (2673, '13:00:00', '14:00:00', 5, '空闲', 195);
INSERT INTO `time_arrange` VALUES (2674, '14:00:00', '15:00:00', 6, '空闲', 195);
INSERT INTO `time_arrange` VALUES (2675, '15:00:00', '16:00:00', 7, '空闲', 195);
INSERT INTO `time_arrange` VALUES (2676, '16:00:00', '17:00:00', 8, '空闲', 195);
INSERT INTO `time_arrange` VALUES (2677, '17:00:00', '18:00:00', 9, '空闲', 195);
INSERT INTO `time_arrange` VALUES (2678, '18:00:00', '19:00:00', 10, '空闲', 195);
INSERT INTO `time_arrange` VALUES (2679, '19:00:00', '20:00:00', 11, '空闲', 195);
INSERT INTO `time_arrange` VALUES (2680, '20:00:00', '21:00:00', 12, '空闲', 195);
INSERT INTO `time_arrange` VALUES (2681, '08:00:00', '09:00:00', 0, '空闲', 196);
INSERT INTO `time_arrange` VALUES (2682, '09:00:00', '10:00:00', 1, '空闲', 196);
INSERT INTO `time_arrange` VALUES (2683, '10:00:00', '11:00:00', 2, '空闲', 196);
INSERT INTO `time_arrange` VALUES (2684, '11:00:00', '12:00:00', 3, '空闲', 196);
INSERT INTO `time_arrange` VALUES (2685, '12:00:00', '13:00:00', 4, '空闲', 196);
INSERT INTO `time_arrange` VALUES (2686, '13:00:00', '14:00:00', 5, '空闲', 196);
INSERT INTO `time_arrange` VALUES (2687, '14:00:00', '15:00:00', 6, '空闲', 196);
INSERT INTO `time_arrange` VALUES (2688, '15:00:00', '16:00:00', 7, '空闲', 196);
INSERT INTO `time_arrange` VALUES (2689, '16:00:00', '17:00:00', 8, '空闲', 196);
INSERT INTO `time_arrange` VALUES (2690, '17:00:00', '18:00:00', 9, '空闲', 196);
INSERT INTO `time_arrange` VALUES (2691, '18:00:00', '19:00:00', 10, '空闲', 196);
INSERT INTO `time_arrange` VALUES (2692, '19:00:00', '20:00:00', 11, '空闲', 196);
INSERT INTO `time_arrange` VALUES (2693, '20:00:00', '21:00:00', 12, '空闲', 196);
INSERT INTO `time_arrange` VALUES (2694, '08:00:00', '09:00:00', 0, '空闲', 197);
INSERT INTO `time_arrange` VALUES (2695, '09:00:00', '10:00:00', 1, '空闲', 197);
INSERT INTO `time_arrange` VALUES (2696, '10:00:00', '11:00:00', 2, '空闲', 197);
INSERT INTO `time_arrange` VALUES (2697, '11:00:00', '12:00:00', 3, '空闲', 197);
INSERT INTO `time_arrange` VALUES (2698, '12:00:00', '13:00:00', 4, '空闲', 197);
INSERT INTO `time_arrange` VALUES (2699, '13:00:00', '14:00:00', 5, '空闲', 197);
INSERT INTO `time_arrange` VALUES (2700, '14:00:00', '15:00:00', 6, '空闲', 197);
INSERT INTO `time_arrange` VALUES (2701, '15:00:00', '16:00:00', 7, '空闲', 197);
INSERT INTO `time_arrange` VALUES (2702, '16:00:00', '17:00:00', 8, '空闲', 197);
INSERT INTO `time_arrange` VALUES (2703, '17:00:00', '18:00:00', 9, '空闲', 197);
INSERT INTO `time_arrange` VALUES (2704, '18:00:00', '19:00:00', 10, '空闲', 197);
INSERT INTO `time_arrange` VALUES (2705, '19:00:00', '20:00:00', 11, '空闲', 197);
INSERT INTO `time_arrange` VALUES (2706, '20:00:00', '21:00:00', 12, '空闲', 197);
INSERT INTO `time_arrange` VALUES (2707, '08:00:00', '09:00:00', 0, '空闲', 198);
INSERT INTO `time_arrange` VALUES (2708, '09:00:00', '10:00:00', 1, '空闲', 198);
INSERT INTO `time_arrange` VALUES (2709, '10:00:00', '11:00:00', 2, '空闲', 198);
INSERT INTO `time_arrange` VALUES (2710, '11:00:00', '12:00:00', 3, '空闲', 198);
INSERT INTO `time_arrange` VALUES (2711, '12:00:00', '13:00:00', 4, '空闲', 198);
INSERT INTO `time_arrange` VALUES (2712, '13:00:00', '14:00:00', 5, '空闲', 198);
INSERT INTO `time_arrange` VALUES (2713, '14:00:00', '15:00:00', 6, '空闲', 198);
INSERT INTO `time_arrange` VALUES (2714, '15:00:00', '16:00:00', 7, '空闲', 198);
INSERT INTO `time_arrange` VALUES (2715, '16:00:00', '17:00:00', 8, '空闲', 198);
INSERT INTO `time_arrange` VALUES (2716, '17:00:00', '18:00:00', 9, '空闲', 198);
INSERT INTO `time_arrange` VALUES (2717, '18:00:00', '19:00:00', 10, '空闲', 198);
INSERT INTO `time_arrange` VALUES (2718, '19:00:00', '20:00:00', 11, '空闲', 198);
INSERT INTO `time_arrange` VALUES (2719, '20:00:00', '21:00:00', 12, '空闲', 198);
INSERT INTO `time_arrange` VALUES (2720, '08:00:00', '09:00:00', 0, '空闲', 199);
INSERT INTO `time_arrange` VALUES (2721, '09:00:00', '10:00:00', 1, '空闲', 199);
INSERT INTO `time_arrange` VALUES (2722, '10:00:00', '11:00:00', 2, '空闲', 199);
INSERT INTO `time_arrange` VALUES (2723, '11:00:00', '12:00:00', 3, '空闲', 199);
INSERT INTO `time_arrange` VALUES (2724, '12:00:00', '13:00:00', 4, '空闲', 199);
INSERT INTO `time_arrange` VALUES (2725, '13:00:00', '14:00:00', 5, '空闲', 199);
INSERT INTO `time_arrange` VALUES (2726, '14:00:00', '15:00:00', 6, '空闲', 199);
INSERT INTO `time_arrange` VALUES (2727, '15:00:00', '16:00:00', 7, '空闲', 199);
INSERT INTO `time_arrange` VALUES (2728, '16:00:00', '17:00:00', 8, '空闲', 199);
INSERT INTO `time_arrange` VALUES (2729, '17:00:00', '18:00:00', 9, '空闲', 199);
INSERT INTO `time_arrange` VALUES (2730, '18:00:00', '19:00:00', 10, '空闲', 199);
INSERT INTO `time_arrange` VALUES (2731, '19:00:00', '20:00:00', 11, '空闲', 199);
INSERT INTO `time_arrange` VALUES (2732, '20:00:00', '21:00:00', 12, '空闲', 199);
INSERT INTO `time_arrange` VALUES (2733, '08:00:00', '09:00:00', 0, '空闲', 200);
INSERT INTO `time_arrange` VALUES (2734, '09:00:00', '10:00:00', 1, '空闲', 200);
INSERT INTO `time_arrange` VALUES (2735, '10:00:00', '11:00:00', 2, '空闲', 200);
INSERT INTO `time_arrange` VALUES (2736, '11:00:00', '12:00:00', 3, '空闲', 200);
INSERT INTO `time_arrange` VALUES (2737, '12:00:00', '13:00:00', 4, '空闲', 200);
INSERT INTO `time_arrange` VALUES (2738, '13:00:00', '14:00:00', 5, '空闲', 200);
INSERT INTO `time_arrange` VALUES (2739, '14:00:00', '15:00:00', 6, '空闲', 200);
INSERT INTO `time_arrange` VALUES (2740, '15:00:00', '16:00:00', 7, '空闲', 200);
INSERT INTO `time_arrange` VALUES (2741, '16:00:00', '17:00:00', 8, '空闲', 200);
INSERT INTO `time_arrange` VALUES (2742, '17:00:00', '18:00:00', 9, '空闲', 200);
INSERT INTO `time_arrange` VALUES (2743, '18:00:00', '19:00:00', 10, '空闲', 200);
INSERT INTO `time_arrange` VALUES (2744, '19:00:00', '20:00:00', 11, '空闲', 200);
INSERT INTO `time_arrange` VALUES (2745, '20:00:00', '21:00:00', 12, '空闲', 200);
INSERT INTO `time_arrange` VALUES (2746, '08:00:00', '09:00:00', 0, '空闲', 201);
INSERT INTO `time_arrange` VALUES (2747, '09:00:00', '10:00:00', 1, '空闲', 201);
INSERT INTO `time_arrange` VALUES (2748, '10:00:00', '11:00:00', 2, '空闲', 201);
INSERT INTO `time_arrange` VALUES (2749, '11:00:00', '12:00:00', 3, '空闲', 201);
INSERT INTO `time_arrange` VALUES (2750, '12:00:00', '13:00:00', 4, '空闲', 201);
INSERT INTO `time_arrange` VALUES (2751, '13:00:00', '14:00:00', 5, '空闲', 201);
INSERT INTO `time_arrange` VALUES (2752, '14:00:00', '15:00:00', 6, '空闲', 201);
INSERT INTO `time_arrange` VALUES (2753, '15:00:00', '16:00:00', 7, '空闲', 201);
INSERT INTO `time_arrange` VALUES (2754, '16:00:00', '17:00:00', 8, '空闲', 201);
INSERT INTO `time_arrange` VALUES (2755, '17:00:00', '18:00:00', 9, '空闲', 201);
INSERT INTO `time_arrange` VALUES (2756, '18:00:00', '19:00:00', 10, '空闲', 201);
INSERT INTO `time_arrange` VALUES (2757, '19:00:00', '20:00:00', 11, '空闲', 201);
INSERT INTO `time_arrange` VALUES (2758, '20:00:00', '21:00:00', 12, '空闲', 201);
INSERT INTO `time_arrange` VALUES (2759, '08:00:00', '09:00:00', 0, '空闲', 202);
INSERT INTO `time_arrange` VALUES (2760, '09:00:00', '10:00:00', 1, '空闲', 202);
INSERT INTO `time_arrange` VALUES (2761, '10:00:00', '11:00:00', 2, '空闲', 202);
INSERT INTO `time_arrange` VALUES (2762, '11:00:00', '12:00:00', 3, '空闲', 202);
INSERT INTO `time_arrange` VALUES (2763, '12:00:00', '13:00:00', 4, '空闲', 202);
INSERT INTO `time_arrange` VALUES (2764, '13:00:00', '14:00:00', 5, '空闲', 202);
INSERT INTO `time_arrange` VALUES (2765, '14:00:00', '15:00:00', 6, '空闲', 202);
INSERT INTO `time_arrange` VALUES (2766, '15:00:00', '16:00:00', 7, '空闲', 202);
INSERT INTO `time_arrange` VALUES (2767, '16:00:00', '17:00:00', 8, '空闲', 202);
INSERT INTO `time_arrange` VALUES (2768, '17:00:00', '18:00:00', 9, '空闲', 202);
INSERT INTO `time_arrange` VALUES (2769, '18:00:00', '19:00:00', 10, '空闲', 202);
INSERT INTO `time_arrange` VALUES (2770, '19:00:00', '20:00:00', 11, '空闲', 202);
INSERT INTO `time_arrange` VALUES (2771, '20:00:00', '21:00:00', 12, '空闲', 202);
INSERT INTO `time_arrange` VALUES (2772, '08:00:00', '09:00:00', 0, '空闲', 203);
INSERT INTO `time_arrange` VALUES (2773, '09:00:00', '10:00:00', 1, '空闲', 203);
INSERT INTO `time_arrange` VALUES (2774, '10:00:00', '11:00:00', 2, '空闲', 203);
INSERT INTO `time_arrange` VALUES (2775, '11:00:00', '12:00:00', 3, '空闲', 203);
INSERT INTO `time_arrange` VALUES (2776, '12:00:00', '13:00:00', 4, '空闲', 203);
INSERT INTO `time_arrange` VALUES (2777, '13:00:00', '14:00:00', 5, '空闲', 203);
INSERT INTO `time_arrange` VALUES (2778, '14:00:00', '15:00:00', 6, '空闲', 203);
INSERT INTO `time_arrange` VALUES (2779, '15:00:00', '16:00:00', 7, '空闲', 203);
INSERT INTO `time_arrange` VALUES (2780, '16:00:00', '17:00:00', 8, '空闲', 203);
INSERT INTO `time_arrange` VALUES (2781, '17:00:00', '18:00:00', 9, '空闲', 203);
INSERT INTO `time_arrange` VALUES (2782, '18:00:00', '19:00:00', 10, '空闲', 203);
INSERT INTO `time_arrange` VALUES (2783, '19:00:00', '20:00:00', 11, '空闲', 203);
INSERT INTO `time_arrange` VALUES (2784, '20:00:00', '21:00:00', 12, '空闲', 203);
INSERT INTO `time_arrange` VALUES (2785, '08:00:00', '09:00:00', 0, '空闲', 204);
INSERT INTO `time_arrange` VALUES (2786, '09:00:00', '10:00:00', 1, '空闲', 204);
INSERT INTO `time_arrange` VALUES (2787, '10:00:00', '11:00:00', 2, '空闲', 204);
INSERT INTO `time_arrange` VALUES (2788, '11:00:00', '12:00:00', 3, '空闲', 204);
INSERT INTO `time_arrange` VALUES (2789, '12:00:00', '13:00:00', 4, '空闲', 204);
INSERT INTO `time_arrange` VALUES (2790, '13:00:00', '14:00:00', 5, '空闲', 204);
INSERT INTO `time_arrange` VALUES (2791, '14:00:00', '15:00:00', 6, '空闲', 204);
INSERT INTO `time_arrange` VALUES (2792, '15:00:00', '16:00:00', 7, '空闲', 204);
INSERT INTO `time_arrange` VALUES (2793, '16:00:00', '17:00:00', 8, '空闲', 204);
INSERT INTO `time_arrange` VALUES (2794, '17:00:00', '18:00:00', 9, '空闲', 204);
INSERT INTO `time_arrange` VALUES (2795, '18:00:00', '19:00:00', 10, '空闲', 204);
INSERT INTO `time_arrange` VALUES (2796, '19:00:00', '20:00:00', 11, '空闲', 204);
INSERT INTO `time_arrange` VALUES (2797, '20:00:00', '21:00:00', 12, '空闲', 204);
INSERT INTO `time_arrange` VALUES (2798, '08:00:00', '09:00:00', 0, '空闲', 205);
INSERT INTO `time_arrange` VALUES (2799, '09:00:00', '10:00:00', 1, '空闲', 205);
INSERT INTO `time_arrange` VALUES (2800, '10:00:00', '11:00:00', 2, '空闲', 205);
INSERT INTO `time_arrange` VALUES (2801, '11:00:00', '12:00:00', 3, '空闲', 205);
INSERT INTO `time_arrange` VALUES (2802, '12:00:00', '13:00:00', 4, '空闲', 205);
INSERT INTO `time_arrange` VALUES (2803, '13:00:00', '14:00:00', 5, '空闲', 205);
INSERT INTO `time_arrange` VALUES (2804, '14:00:00', '15:00:00', 6, '空闲', 205);
INSERT INTO `time_arrange` VALUES (2805, '15:00:00', '16:00:00', 7, '空闲', 205);
INSERT INTO `time_arrange` VALUES (2806, '16:00:00', '17:00:00', 8, '空闲', 205);
INSERT INTO `time_arrange` VALUES (2807, '17:00:00', '18:00:00', 9, '空闲', 205);
INSERT INTO `time_arrange` VALUES (2808, '18:00:00', '19:00:00', 10, '空闲', 205);
INSERT INTO `time_arrange` VALUES (2809, '19:00:00', '20:00:00', 11, '空闲', 205);
INSERT INTO `time_arrange` VALUES (2810, '20:00:00', '21:00:00', 12, '空闲', 205);
INSERT INTO `time_arrange` VALUES (2811, '08:00:00', '09:00:00', 0, '空闲', 206);
INSERT INTO `time_arrange` VALUES (2812, '09:00:00', '10:00:00', 1, '空闲', 206);
INSERT INTO `time_arrange` VALUES (2813, '10:00:00', '11:00:00', 2, '空闲', 206);
INSERT INTO `time_arrange` VALUES (2814, '11:00:00', '12:00:00', 3, '空闲', 206);
INSERT INTO `time_arrange` VALUES (2815, '12:00:00', '13:00:00', 4, '空闲', 206);
INSERT INTO `time_arrange` VALUES (2816, '13:00:00', '14:00:00', 5, '空闲', 206);
INSERT INTO `time_arrange` VALUES (2817, '14:00:00', '15:00:00', 6, '空闲', 206);
INSERT INTO `time_arrange` VALUES (2818, '15:00:00', '16:00:00', 7, '空闲', 206);
INSERT INTO `time_arrange` VALUES (2819, '16:00:00', '17:00:00', 8, '空闲', 206);
INSERT INTO `time_arrange` VALUES (2820, '17:00:00', '18:00:00', 9, '空闲', 206);
INSERT INTO `time_arrange` VALUES (2821, '18:00:00', '19:00:00', 10, '空闲', 206);
INSERT INTO `time_arrange` VALUES (2822, '19:00:00', '20:00:00', 11, '空闲', 206);
INSERT INTO `time_arrange` VALUES (2823, '20:00:00', '21:00:00', 12, '空闲', 206);
INSERT INTO `time_arrange` VALUES (2824, '08:00:00', '09:00:00', 0, '空闲', 207);
INSERT INTO `time_arrange` VALUES (2825, '09:00:00', '10:00:00', 1, '空闲', 207);
INSERT INTO `time_arrange` VALUES (2826, '10:00:00', '11:00:00', 2, '空闲', 207);
INSERT INTO `time_arrange` VALUES (2827, '11:00:00', '12:00:00', 3, '空闲', 207);
INSERT INTO `time_arrange` VALUES (2828, '12:00:00', '13:00:00', 4, '空闲', 207);
INSERT INTO `time_arrange` VALUES (2829, '13:00:00', '14:00:00', 5, '空闲', 207);
INSERT INTO `time_arrange` VALUES (2830, '14:00:00', '15:00:00', 6, '空闲', 207);
INSERT INTO `time_arrange` VALUES (2831, '15:00:00', '16:00:00', 7, '空闲', 207);
INSERT INTO `time_arrange` VALUES (2832, '16:00:00', '17:00:00', 8, '空闲', 207);
INSERT INTO `time_arrange` VALUES (2833, '17:00:00', '18:00:00', 9, '空闲', 207);
INSERT INTO `time_arrange` VALUES (2834, '18:00:00', '19:00:00', 10, '空闲', 207);
INSERT INTO `time_arrange` VALUES (2835, '19:00:00', '20:00:00', 11, '空闲', 207);
INSERT INTO `time_arrange` VALUES (2836, '20:00:00', '21:00:00', 12, '空闲', 207);
INSERT INTO `time_arrange` VALUES (2837, '08:00:00', '09:00:00', 0, '空闲', 208);
INSERT INTO `time_arrange` VALUES (2838, '09:00:00', '10:00:00', 1, '空闲', 208);
INSERT INTO `time_arrange` VALUES (2839, '10:00:00', '11:00:00', 2, '空闲', 208);
INSERT INTO `time_arrange` VALUES (2840, '11:00:00', '12:00:00', 3, '空闲', 208);
INSERT INTO `time_arrange` VALUES (2841, '12:00:00', '13:00:00', 4, '空闲', 208);
INSERT INTO `time_arrange` VALUES (2842, '13:00:00', '14:00:00', 5, '空闲', 208);
INSERT INTO `time_arrange` VALUES (2843, '14:00:00', '15:00:00', 6, '空闲', 208);
INSERT INTO `time_arrange` VALUES (2844, '15:00:00', '16:00:00', 7, '空闲', 208);
INSERT INTO `time_arrange` VALUES (2845, '16:00:00', '17:00:00', 8, '空闲', 208);
INSERT INTO `time_arrange` VALUES (2846, '17:00:00', '18:00:00', 9, '空闲', 208);
INSERT INTO `time_arrange` VALUES (2847, '18:00:00', '19:00:00', 10, '空闲', 208);
INSERT INTO `time_arrange` VALUES (2848, '19:00:00', '20:00:00', 11, '空闲', 208);
INSERT INTO `time_arrange` VALUES (2849, '20:00:00', '21:00:00', 12, '空闲', 208);
INSERT INTO `time_arrange` VALUES (2850, '08:00:00', '09:00:00', 0, '空闲', 209);
INSERT INTO `time_arrange` VALUES (2851, '09:00:00', '10:00:00', 1, '空闲', 209);
INSERT INTO `time_arrange` VALUES (2852, '10:00:00', '11:00:00', 2, '空闲', 209);
INSERT INTO `time_arrange` VALUES (2853, '11:00:00', '12:00:00', 3, '空闲', 209);
INSERT INTO `time_arrange` VALUES (2854, '12:00:00', '13:00:00', 4, '空闲', 209);
INSERT INTO `time_arrange` VALUES (2855, '13:00:00', '14:00:00', 5, '空闲', 209);
INSERT INTO `time_arrange` VALUES (2856, '14:00:00', '15:00:00', 6, '空闲', 209);
INSERT INTO `time_arrange` VALUES (2857, '15:00:00', '16:00:00', 7, '空闲', 209);
INSERT INTO `time_arrange` VALUES (2858, '16:00:00', '17:00:00', 8, '空闲', 209);
INSERT INTO `time_arrange` VALUES (2859, '17:00:00', '18:00:00', 9, '空闲', 209);
INSERT INTO `time_arrange` VALUES (2860, '18:00:00', '19:00:00', 10, '空闲', 209);
INSERT INTO `time_arrange` VALUES (2861, '19:00:00', '20:00:00', 11, '空闲', 209);
INSERT INTO `time_arrange` VALUES (2862, '20:00:00', '21:00:00', 12, '空闲', 209);
INSERT INTO `time_arrange` VALUES (2863, '08:00:00', '09:00:00', 0, '空闲', 210);
INSERT INTO `time_arrange` VALUES (2864, '09:00:00', '10:00:00', 1, '空闲', 210);
INSERT INTO `time_arrange` VALUES (2865, '10:00:00', '11:00:00', 2, '空闲', 210);
INSERT INTO `time_arrange` VALUES (2866, '11:00:00', '12:00:00', 3, '空闲', 210);
INSERT INTO `time_arrange` VALUES (2867, '12:00:00', '13:00:00', 4, '空闲', 210);
INSERT INTO `time_arrange` VALUES (2868, '13:00:00', '14:00:00', 5, '空闲', 210);
INSERT INTO `time_arrange` VALUES (2869, '14:00:00', '15:00:00', 6, '空闲', 210);
INSERT INTO `time_arrange` VALUES (2870, '15:00:00', '16:00:00', 7, '空闲', 210);
INSERT INTO `time_arrange` VALUES (2871, '16:00:00', '17:00:00', 8, '空闲', 210);
INSERT INTO `time_arrange` VALUES (2872, '17:00:00', '18:00:00', 9, '空闲', 210);
INSERT INTO `time_arrange` VALUES (2873, '18:00:00', '19:00:00', 10, '空闲', 210);
INSERT INTO `time_arrange` VALUES (2874, '19:00:00', '20:00:00', 11, '空闲', 210);
INSERT INTO `time_arrange` VALUES (2875, '20:00:00', '21:00:00', 12, '空闲', 210);
INSERT INTO `time_arrange` VALUES (2876, '08:00:00', '09:00:00', 0, '空闲', 211);
INSERT INTO `time_arrange` VALUES (2877, '09:00:00', '10:00:00', 1, '空闲', 211);
INSERT INTO `time_arrange` VALUES (2878, '10:00:00', '11:00:00', 2, '空闲', 211);
INSERT INTO `time_arrange` VALUES (2879, '11:00:00', '12:00:00', 3, '空闲', 211);
INSERT INTO `time_arrange` VALUES (2880, '12:00:00', '13:00:00', 4, '空闲', 211);
INSERT INTO `time_arrange` VALUES (2881, '13:00:00', '14:00:00', 5, '空闲', 211);
INSERT INTO `time_arrange` VALUES (2882, '14:00:00', '15:00:00', 6, '空闲', 211);
INSERT INTO `time_arrange` VALUES (2883, '15:00:00', '16:00:00', 7, '空闲', 211);
INSERT INTO `time_arrange` VALUES (2884, '16:00:00', '17:00:00', 8, '空闲', 211);
INSERT INTO `time_arrange` VALUES (2885, '17:00:00', '18:00:00', 9, '空闲', 211);
INSERT INTO `time_arrange` VALUES (2886, '18:00:00', '19:00:00', 10, '空闲', 211);
INSERT INTO `time_arrange` VALUES (2887, '19:00:00', '20:00:00', 11, '空闲', 211);
INSERT INTO `time_arrange` VALUES (2888, '20:00:00', '21:00:00', 12, '空闲', 211);
INSERT INTO `time_arrange` VALUES (2889, '08:00:00', '09:00:00', 0, '空闲', 212);
INSERT INTO `time_arrange` VALUES (2890, '09:00:00', '10:00:00', 1, '空闲', 212);
INSERT INTO `time_arrange` VALUES (2891, '10:00:00', '11:00:00', 2, '空闲', 212);
INSERT INTO `time_arrange` VALUES (2892, '11:00:00', '12:00:00', 3, '空闲', 212);
INSERT INTO `time_arrange` VALUES (2893, '12:00:00', '13:00:00', 4, '空闲', 212);
INSERT INTO `time_arrange` VALUES (2894, '13:00:00', '14:00:00', 5, '空闲', 212);
INSERT INTO `time_arrange` VALUES (2895, '14:00:00', '15:00:00', 6, '空闲', 212);
INSERT INTO `time_arrange` VALUES (2896, '15:00:00', '16:00:00', 7, '空闲', 212);
INSERT INTO `time_arrange` VALUES (2897, '16:00:00', '17:00:00', 8, '空闲', 212);
INSERT INTO `time_arrange` VALUES (2898, '17:00:00', '18:00:00', 9, '空闲', 212);
INSERT INTO `time_arrange` VALUES (2899, '18:00:00', '19:00:00', 10, '空闲', 212);
INSERT INTO `time_arrange` VALUES (2900, '19:00:00', '20:00:00', 11, '空闲', 212);
INSERT INTO `time_arrange` VALUES (2901, '20:00:00', '21:00:00', 12, '空闲', 212);
INSERT INTO `time_arrange` VALUES (2902, '08:00:00', '09:00:00', 0, '空闲', 213);
INSERT INTO `time_arrange` VALUES (2903, '09:00:00', '10:00:00', 1, '空闲', 213);
INSERT INTO `time_arrange` VALUES (2904, '10:00:00', '11:00:00', 2, '空闲', 213);
INSERT INTO `time_arrange` VALUES (2905, '11:00:00', '12:00:00', 3, '空闲', 213);
INSERT INTO `time_arrange` VALUES (2906, '12:00:00', '13:00:00', 4, '空闲', 213);
INSERT INTO `time_arrange` VALUES (2907, '13:00:00', '14:00:00', 5, '空闲', 213);
INSERT INTO `time_arrange` VALUES (2908, '14:00:00', '15:00:00', 6, '空闲', 213);
INSERT INTO `time_arrange` VALUES (2909, '15:00:00', '16:00:00', 7, '空闲', 213);
INSERT INTO `time_arrange` VALUES (2910, '16:00:00', '17:00:00', 8, '空闲', 213);
INSERT INTO `time_arrange` VALUES (2911, '17:00:00', '18:00:00', 9, '空闲', 213);
INSERT INTO `time_arrange` VALUES (2912, '18:00:00', '19:00:00', 10, '空闲', 213);
INSERT INTO `time_arrange` VALUES (2913, '19:00:00', '20:00:00', 11, '空闲', 213);
INSERT INTO `time_arrange` VALUES (2914, '20:00:00', '21:00:00', 12, '空闲', 213);
INSERT INTO `time_arrange` VALUES (2915, '08:00:00', '09:00:00', 0, '空闲', 214);
INSERT INTO `time_arrange` VALUES (2916, '09:00:00', '10:00:00', 1, '空闲', 214);
INSERT INTO `time_arrange` VALUES (2917, '10:00:00', '11:00:00', 2, '空闲', 214);
INSERT INTO `time_arrange` VALUES (2918, '11:00:00', '12:00:00', 3, '空闲', 214);
INSERT INTO `time_arrange` VALUES (2919, '12:00:00', '13:00:00', 4, '空闲', 214);
INSERT INTO `time_arrange` VALUES (2920, '13:00:00', '14:00:00', 5, '空闲', 214);
INSERT INTO `time_arrange` VALUES (2921, '14:00:00', '15:00:00', 6, '空闲', 214);
INSERT INTO `time_arrange` VALUES (2922, '15:00:00', '16:00:00', 7, '空闲', 214);
INSERT INTO `time_arrange` VALUES (2923, '16:00:00', '17:00:00', 8, '空闲', 214);
INSERT INTO `time_arrange` VALUES (2924, '17:00:00', '18:00:00', 9, '空闲', 214);
INSERT INTO `time_arrange` VALUES (2925, '18:00:00', '19:00:00', 10, '空闲', 214);
INSERT INTO `time_arrange` VALUES (2926, '19:00:00', '20:00:00', 11, '空闲', 214);
INSERT INTO `time_arrange` VALUES (2927, '20:00:00', '21:00:00', 12, '空闲', 214);
INSERT INTO `time_arrange` VALUES (2928, '08:00:00', '09:00:00', 0, '空闲', 215);
INSERT INTO `time_arrange` VALUES (2929, '09:00:00', '10:00:00', 1, '空闲', 215);
INSERT INTO `time_arrange` VALUES (2930, '10:00:00', '11:00:00', 2, '空闲', 215);
INSERT INTO `time_arrange` VALUES (2931, '11:00:00', '12:00:00', 3, '空闲', 215);
INSERT INTO `time_arrange` VALUES (2932, '12:00:00', '13:00:00', 4, '空闲', 215);
INSERT INTO `time_arrange` VALUES (2933, '13:00:00', '14:00:00', 5, '空闲', 215);
INSERT INTO `time_arrange` VALUES (2934, '14:00:00', '15:00:00', 6, '空闲', 215);
INSERT INTO `time_arrange` VALUES (2935, '15:00:00', '16:00:00', 7, '空闲', 215);
INSERT INTO `time_arrange` VALUES (2936, '16:00:00', '17:00:00', 8, '空闲', 215);
INSERT INTO `time_arrange` VALUES (2937, '17:00:00', '18:00:00', 9, '空闲', 215);
INSERT INTO `time_arrange` VALUES (2938, '18:00:00', '19:00:00', 10, '空闲', 215);
INSERT INTO `time_arrange` VALUES (2939, '19:00:00', '20:00:00', 11, '空闲', 215);
INSERT INTO `time_arrange` VALUES (2940, '20:00:00', '21:00:00', 12, '空闲', 215);
INSERT INTO `time_arrange` VALUES (2941, '08:00:00', '09:00:00', 0, '空闲', 216);
INSERT INTO `time_arrange` VALUES (2942, '09:00:00', '10:00:00', 1, '空闲', 216);
INSERT INTO `time_arrange` VALUES (2943, '10:00:00', '11:00:00', 2, '空闲', 216);
INSERT INTO `time_arrange` VALUES (2944, '11:00:00', '12:00:00', 3, '空闲', 216);
INSERT INTO `time_arrange` VALUES (2945, '12:00:00', '13:00:00', 4, '空闲', 216);
INSERT INTO `time_arrange` VALUES (2946, '13:00:00', '14:00:00', 5, '空闲', 216);
INSERT INTO `time_arrange` VALUES (2947, '14:00:00', '15:00:00', 6, '空闲', 216);
INSERT INTO `time_arrange` VALUES (2948, '15:00:00', '16:00:00', 7, '空闲', 216);
INSERT INTO `time_arrange` VALUES (2949, '16:00:00', '17:00:00', 8, '空闲', 216);
INSERT INTO `time_arrange` VALUES (2950, '17:00:00', '18:00:00', 9, '空闲', 216);
INSERT INTO `time_arrange` VALUES (2951, '18:00:00', '19:00:00', 10, '空闲', 216);
INSERT INTO `time_arrange` VALUES (2952, '19:00:00', '20:00:00', 11, '空闲', 216);
INSERT INTO `time_arrange` VALUES (2953, '20:00:00', '21:00:00', 12, '空闲', 216);
INSERT INTO `time_arrange` VALUES (2954, '08:00:00', '09:00:00', 0, '空闲', 217);
INSERT INTO `time_arrange` VALUES (2955, '09:00:00', '10:00:00', 1, '空闲', 217);
INSERT INTO `time_arrange` VALUES (2956, '10:00:00', '11:00:00', 2, '空闲', 217);
INSERT INTO `time_arrange` VALUES (2957, '11:00:00', '12:00:00', 3, '空闲', 217);
INSERT INTO `time_arrange` VALUES (2958, '12:00:00', '13:00:00', 4, '空闲', 217);
INSERT INTO `time_arrange` VALUES (2959, '13:00:00', '14:00:00', 5, '空闲', 217);
INSERT INTO `time_arrange` VALUES (2960, '14:00:00', '15:00:00', 6, '空闲', 217);
INSERT INTO `time_arrange` VALUES (2961, '15:00:00', '16:00:00', 7, '空闲', 217);
INSERT INTO `time_arrange` VALUES (2962, '16:00:00', '17:00:00', 8, '空闲', 217);
INSERT INTO `time_arrange` VALUES (2963, '17:00:00', '18:00:00', 9, '空闲', 217);
INSERT INTO `time_arrange` VALUES (2964, '18:00:00', '19:00:00', 10, '空闲', 217);
INSERT INTO `time_arrange` VALUES (2965, '19:00:00', '20:00:00', 11, '空闲', 217);
INSERT INTO `time_arrange` VALUES (2966, '20:00:00', '21:00:00', 12, '空闲', 217);
INSERT INTO `time_arrange` VALUES (2967, '08:00:00', '09:00:00', 0, '空闲', 218);
INSERT INTO `time_arrange` VALUES (2968, '09:00:00', '10:00:00', 1, '空闲', 218);
INSERT INTO `time_arrange` VALUES (2969, '10:00:00', '11:00:00', 2, '空闲', 218);
INSERT INTO `time_arrange` VALUES (2970, '11:00:00', '12:00:00', 3, '空闲', 218);
INSERT INTO `time_arrange` VALUES (2971, '12:00:00', '13:00:00', 4, '空闲', 218);
INSERT INTO `time_arrange` VALUES (2972, '13:00:00', '14:00:00', 5, '空闲', 218);
INSERT INTO `time_arrange` VALUES (2973, '14:00:00', '15:00:00', 6, '空闲', 218);
INSERT INTO `time_arrange` VALUES (2974, '15:00:00', '16:00:00', 7, '空闲', 218);
INSERT INTO `time_arrange` VALUES (2975, '16:00:00', '17:00:00', 8, '空闲', 218);
INSERT INTO `time_arrange` VALUES (2976, '17:00:00', '18:00:00', 9, '空闲', 218);
INSERT INTO `time_arrange` VALUES (2977, '18:00:00', '19:00:00', 10, '空闲', 218);
INSERT INTO `time_arrange` VALUES (2978, '19:00:00', '20:00:00', 11, '空闲', 218);
INSERT INTO `time_arrange` VALUES (2979, '20:00:00', '21:00:00', 12, '空闲', 218);
INSERT INTO `time_arrange` VALUES (2980, '08:00:00', '09:00:00', 0, '空闲', 219);
INSERT INTO `time_arrange` VALUES (2981, '09:00:00', '10:00:00', 1, '空闲', 219);
INSERT INTO `time_arrange` VALUES (2982, '10:00:00', '11:00:00', 2, '空闲', 219);
INSERT INTO `time_arrange` VALUES (2983, '11:00:00', '12:00:00', 3, '空闲', 219);
INSERT INTO `time_arrange` VALUES (2984, '12:00:00', '13:00:00', 4, '空闲', 219);
INSERT INTO `time_arrange` VALUES (2985, '13:00:00', '14:00:00', 5, '空闲', 219);
INSERT INTO `time_arrange` VALUES (2986, '14:00:00', '15:00:00', 6, '空闲', 219);
INSERT INTO `time_arrange` VALUES (2987, '15:00:00', '16:00:00', 7, '空闲', 219);
INSERT INTO `time_arrange` VALUES (2988, '16:00:00', '17:00:00', 8, '空闲', 219);
INSERT INTO `time_arrange` VALUES (2989, '17:00:00', '18:00:00', 9, '空闲', 219);
INSERT INTO `time_arrange` VALUES (2990, '18:00:00', '19:00:00', 10, '空闲', 219);
INSERT INTO `time_arrange` VALUES (2991, '19:00:00', '20:00:00', 11, '空闲', 219);
INSERT INTO `time_arrange` VALUES (2992, '20:00:00', '21:00:00', 12, '空闲', 219);
INSERT INTO `time_arrange` VALUES (2993, '08:00:00', '09:00:00', 0, '空闲', 220);
INSERT INTO `time_arrange` VALUES (2994, '09:00:00', '10:00:00', 1, '空闲', 220);
INSERT INTO `time_arrange` VALUES (2995, '10:00:00', '11:00:00', 2, '空闲', 220);
INSERT INTO `time_arrange` VALUES (2996, '11:00:00', '12:00:00', 3, '空闲', 220);
INSERT INTO `time_arrange` VALUES (2997, '12:00:00', '13:00:00', 4, '空闲', 220);
INSERT INTO `time_arrange` VALUES (2998, '13:00:00', '14:00:00', 5, '空闲', 220);
INSERT INTO `time_arrange` VALUES (2999, '14:00:00', '15:00:00', 6, '空闲', 220);
INSERT INTO `time_arrange` VALUES (3000, '15:00:00', '16:00:00', 7, '空闲', 220);
INSERT INTO `time_arrange` VALUES (3001, '16:00:00', '17:00:00', 8, '空闲', 220);
INSERT INTO `time_arrange` VALUES (3002, '17:00:00', '18:00:00', 9, '空闲', 220);
INSERT INTO `time_arrange` VALUES (3003, '18:00:00', '19:00:00', 10, '空闲', 220);
INSERT INTO `time_arrange` VALUES (3004, '19:00:00', '20:00:00', 11, '空闲', 220);
INSERT INTO `time_arrange` VALUES (3005, '20:00:00', '21:00:00', 12, '空闲', 220);
INSERT INTO `time_arrange` VALUES (3006, '08:00:00', '09:00:00', 0, '空闲', 221);
INSERT INTO `time_arrange` VALUES (3007, '09:00:00', '10:00:00', 1, '空闲', 221);
INSERT INTO `time_arrange` VALUES (3008, '10:00:00', '11:00:00', 2, '空闲', 221);
INSERT INTO `time_arrange` VALUES (3009, '11:00:00', '12:00:00', 3, '空闲', 221);
INSERT INTO `time_arrange` VALUES (3010, '12:00:00', '13:00:00', 4, '空闲', 221);
INSERT INTO `time_arrange` VALUES (3011, '13:00:00', '14:00:00', 5, '空闲', 221);
INSERT INTO `time_arrange` VALUES (3012, '14:00:00', '15:00:00', 6, '空闲', 221);
INSERT INTO `time_arrange` VALUES (3013, '15:00:00', '16:00:00', 7, '空闲', 221);
INSERT INTO `time_arrange` VALUES (3014, '16:00:00', '17:00:00', 8, '空闲', 221);
INSERT INTO `time_arrange` VALUES (3015, '17:00:00', '18:00:00', 9, '空闲', 221);
INSERT INTO `time_arrange` VALUES (3016, '18:00:00', '19:00:00', 10, '空闲', 221);
INSERT INTO `time_arrange` VALUES (3017, '19:00:00', '20:00:00', 11, '空闲', 221);
INSERT INTO `time_arrange` VALUES (3018, '20:00:00', '21:00:00', 12, '空闲', 221);
INSERT INTO `time_arrange` VALUES (3019, '08:00:00', '09:00:00', 0, '空闲', 222);
INSERT INTO `time_arrange` VALUES (3020, '09:00:00', '10:00:00', 1, '空闲', 222);
INSERT INTO `time_arrange` VALUES (3021, '10:00:00', '11:00:00', 2, '占用', 222);
INSERT INTO `time_arrange` VALUES (3022, '11:00:00', '12:00:00', 3, '空闲', 222);
INSERT INTO `time_arrange` VALUES (3023, '12:00:00', '13:00:00', 4, '空闲', 222);
INSERT INTO `time_arrange` VALUES (3024, '13:00:00', '14:00:00', 5, '占用', 222);
INSERT INTO `time_arrange` VALUES (3025, '14:00:00', '15:00:00', 6, '空闲', 222);
INSERT INTO `time_arrange` VALUES (3026, '15:00:00', '16:00:00', 7, '空闲', 222);
INSERT INTO `time_arrange` VALUES (3027, '16:00:00', '17:00:00', 8, '空闲', 222);
INSERT INTO `time_arrange` VALUES (3028, '17:00:00', '18:00:00', 9, '空闲', 222);
INSERT INTO `time_arrange` VALUES (3029, '18:00:00', '19:00:00', 10, '空闲', 222);
INSERT INTO `time_arrange` VALUES (3030, '19:00:00', '20:00:00', 11, '空闲', 222);
INSERT INTO `time_arrange` VALUES (3031, '20:00:00', '21:00:00', 12, '空闲', 222);
INSERT INTO `time_arrange` VALUES (3032, '08:00:00', '09:00:00', 0, '空闲', 223);
INSERT INTO `time_arrange` VALUES (3033, '09:00:00', '10:00:00', 1, '空闲', 223);
INSERT INTO `time_arrange` VALUES (3034, '10:00:00', '11:00:00', 2, '空闲', 223);
INSERT INTO `time_arrange` VALUES (3035, '11:00:00', '12:00:00', 3, '空闲', 223);
INSERT INTO `time_arrange` VALUES (3036, '12:00:00', '13:00:00', 4, '空闲', 223);
INSERT INTO `time_arrange` VALUES (3037, '13:00:00', '14:00:00', 5, '空闲', 223);
INSERT INTO `time_arrange` VALUES (3038, '14:00:00', '15:00:00', 6, '空闲', 223);
INSERT INTO `time_arrange` VALUES (3039, '15:00:00', '16:00:00', 7, '空闲', 223);
INSERT INTO `time_arrange` VALUES (3040, '16:00:00', '17:00:00', 8, '空闲', 223);
INSERT INTO `time_arrange` VALUES (3041, '17:00:00', '18:00:00', 9, '空闲', 223);
INSERT INTO `time_arrange` VALUES (3042, '18:00:00', '19:00:00', 10, '空闲', 223);
INSERT INTO `time_arrange` VALUES (3043, '19:00:00', '20:00:00', 11, '空闲', 223);
INSERT INTO `time_arrange` VALUES (3044, '20:00:00', '21:00:00', 12, '空闲', 223);
INSERT INTO `time_arrange` VALUES (3045, '08:00:00', '09:00:00', 0, '空闲', 224);
INSERT INTO `time_arrange` VALUES (3046, '09:00:00', '10:00:00', 1, '空闲', 224);
INSERT INTO `time_arrange` VALUES (3047, '10:00:00', '11:00:00', 2, '空闲', 224);
INSERT INTO `time_arrange` VALUES (3048, '11:00:00', '12:00:00', 3, '空闲', 224);
INSERT INTO `time_arrange` VALUES (3049, '12:00:00', '13:00:00', 4, '空闲', 224);
INSERT INTO `time_arrange` VALUES (3050, '13:00:00', '14:00:00', 5, '空闲', 224);
INSERT INTO `time_arrange` VALUES (3051, '14:00:00', '15:00:00', 6, '空闲', 224);
INSERT INTO `time_arrange` VALUES (3052, '15:00:00', '16:00:00', 7, '空闲', 224);
INSERT INTO `time_arrange` VALUES (3053, '16:00:00', '17:00:00', 8, '空闲', 224);
INSERT INTO `time_arrange` VALUES (3054, '17:00:00', '18:00:00', 9, '空闲', 224);
INSERT INTO `time_arrange` VALUES (3055, '18:00:00', '19:00:00', 10, '空闲', 224);
INSERT INTO `time_arrange` VALUES (3056, '19:00:00', '20:00:00', 11, '空闲', 224);
INSERT INTO `time_arrange` VALUES (3057, '20:00:00', '21:00:00', 12, '空闲', 224);
INSERT INTO `time_arrange` VALUES (3058, '08:00:00', '09:00:00', 0, '空闲', 225);
INSERT INTO `time_arrange` VALUES (3059, '09:00:00', '10:00:00', 1, '空闲', 225);
INSERT INTO `time_arrange` VALUES (3060, '10:00:00', '11:00:00', 2, '空闲', 225);
INSERT INTO `time_arrange` VALUES (3061, '11:00:00', '12:00:00', 3, '空闲', 225);
INSERT INTO `time_arrange` VALUES (3062, '12:00:00', '13:00:00', 4, '空闲', 225);
INSERT INTO `time_arrange` VALUES (3063, '13:00:00', '14:00:00', 5, '空闲', 225);
INSERT INTO `time_arrange` VALUES (3064, '14:00:00', '15:00:00', 6, '空闲', 225);
INSERT INTO `time_arrange` VALUES (3065, '15:00:00', '16:00:00', 7, '空闲', 225);
INSERT INTO `time_arrange` VALUES (3066, '16:00:00', '17:00:00', 8, '空闲', 225);
INSERT INTO `time_arrange` VALUES (3067, '17:00:00', '18:00:00', 9, '空闲', 225);
INSERT INTO `time_arrange` VALUES (3068, '18:00:00', '19:00:00', 10, '空闲', 225);
INSERT INTO `time_arrange` VALUES (3069, '19:00:00', '20:00:00', 11, '空闲', 225);
INSERT INTO `time_arrange` VALUES (3070, '20:00:00', '21:00:00', 12, '空闲', 225);
INSERT INTO `time_arrange` VALUES (3071, '08:00:00', '09:00:00', 0, '空闲', 226);
INSERT INTO `time_arrange` VALUES (3072, '09:00:00', '10:00:00', 1, '空闲', 226);
INSERT INTO `time_arrange` VALUES (3073, '10:00:00', '11:00:00', 2, '空闲', 226);
INSERT INTO `time_arrange` VALUES (3074, '11:00:00', '12:00:00', 3, '空闲', 226);
INSERT INTO `time_arrange` VALUES (3075, '12:00:00', '13:00:00', 4, '空闲', 226);
INSERT INTO `time_arrange` VALUES (3076, '13:00:00', '14:00:00', 5, '空闲', 226);
INSERT INTO `time_arrange` VALUES (3077, '14:00:00', '15:00:00', 6, '空闲', 226);
INSERT INTO `time_arrange` VALUES (3078, '15:00:00', '16:00:00', 7, '空闲', 226);
INSERT INTO `time_arrange` VALUES (3079, '16:00:00', '17:00:00', 8, '空闲', 226);
INSERT INTO `time_arrange` VALUES (3080, '17:00:00', '18:00:00', 9, '空闲', 226);
INSERT INTO `time_arrange` VALUES (3081, '18:00:00', '19:00:00', 10, '空闲', 226);
INSERT INTO `time_arrange` VALUES (3082, '19:00:00', '20:00:00', 11, '空闲', 226);
INSERT INTO `time_arrange` VALUES (3083, '20:00:00', '21:00:00', 12, '空闲', 226);
INSERT INTO `time_arrange` VALUES (3084, '08:00:00', '09:00:00', 0, '空闲', 227);
INSERT INTO `time_arrange` VALUES (3085, '09:00:00', '10:00:00', 1, '空闲', 227);
INSERT INTO `time_arrange` VALUES (3086, '10:00:00', '11:00:00', 2, '空闲', 227);
INSERT INTO `time_arrange` VALUES (3087, '11:00:00', '12:00:00', 3, '空闲', 227);
INSERT INTO `time_arrange` VALUES (3088, '12:00:00', '13:00:00', 4, '空闲', 227);
INSERT INTO `time_arrange` VALUES (3089, '13:00:00', '14:00:00', 5, '空闲', 227);
INSERT INTO `time_arrange` VALUES (3090, '14:00:00', '15:00:00', 6, '空闲', 227);
INSERT INTO `time_arrange` VALUES (3091, '15:00:00', '16:00:00', 7, '空闲', 227);
INSERT INTO `time_arrange` VALUES (3092, '16:00:00', '17:00:00', 8, '空闲', 227);
INSERT INTO `time_arrange` VALUES (3093, '17:00:00', '18:00:00', 9, '空闲', 227);
INSERT INTO `time_arrange` VALUES (3094, '18:00:00', '19:00:00', 10, '空闲', 227);
INSERT INTO `time_arrange` VALUES (3095, '19:00:00', '20:00:00', 11, '空闲', 227);
INSERT INTO `time_arrange` VALUES (3096, '20:00:00', '21:00:00', 12, '空闲', 227);
INSERT INTO `time_arrange` VALUES (3097, '08:00:00', '09:00:00', 0, '空闲', 228);
INSERT INTO `time_arrange` VALUES (3098, '09:00:00', '10:00:00', 1, '空闲', 228);
INSERT INTO `time_arrange` VALUES (3099, '10:00:00', '11:00:00', 2, '空闲', 228);
INSERT INTO `time_arrange` VALUES (3100, '11:00:00', '12:00:00', 3, '空闲', 228);
INSERT INTO `time_arrange` VALUES (3101, '12:00:00', '13:00:00', 4, '空闲', 228);
INSERT INTO `time_arrange` VALUES (3102, '13:00:00', '14:00:00', 5, '空闲', 228);
INSERT INTO `time_arrange` VALUES (3103, '14:00:00', '15:00:00', 6, '空闲', 228);
INSERT INTO `time_arrange` VALUES (3104, '15:00:00', '16:00:00', 7, '空闲', 228);
INSERT INTO `time_arrange` VALUES (3105, '16:00:00', '17:00:00', 8, '空闲', 228);
INSERT INTO `time_arrange` VALUES (3106, '17:00:00', '18:00:00', 9, '空闲', 228);
INSERT INTO `time_arrange` VALUES (3107, '18:00:00', '19:00:00', 10, '空闲', 228);
INSERT INTO `time_arrange` VALUES (3108, '19:00:00', '20:00:00', 11, '空闲', 228);
INSERT INTO `time_arrange` VALUES (3109, '20:00:00', '21:00:00', 12, '空闲', 228);
INSERT INTO `time_arrange` VALUES (3110, '08:00:00', '09:00:00', 0, '空闲', 229);
INSERT INTO `time_arrange` VALUES (3111, '09:00:00', '10:00:00', 1, '空闲', 229);
INSERT INTO `time_arrange` VALUES (3112, '10:00:00', '11:00:00', 2, '空闲', 229);
INSERT INTO `time_arrange` VALUES (3113, '11:00:00', '12:00:00', 3, '空闲', 229);
INSERT INTO `time_arrange` VALUES (3114, '12:00:00', '13:00:00', 4, '空闲', 229);
INSERT INTO `time_arrange` VALUES (3115, '13:00:00', '14:00:00', 5, '空闲', 229);
INSERT INTO `time_arrange` VALUES (3116, '14:00:00', '15:00:00', 6, '空闲', 229);
INSERT INTO `time_arrange` VALUES (3117, '15:00:00', '16:00:00', 7, '空闲', 229);
INSERT INTO `time_arrange` VALUES (3118, '16:00:00', '17:00:00', 8, '空闲', 229);
INSERT INTO `time_arrange` VALUES (3119, '17:00:00', '18:00:00', 9, '空闲', 229);
INSERT INTO `time_arrange` VALUES (3120, '18:00:00', '19:00:00', 10, '空闲', 229);
INSERT INTO `time_arrange` VALUES (3121, '19:00:00', '20:00:00', 11, '空闲', 229);
INSERT INTO `time_arrange` VALUES (3122, '20:00:00', '21:00:00', 12, '空闲', 229);
INSERT INTO `time_arrange` VALUES (3123, '08:00:00', '09:00:00', 0, '空闲', 230);
INSERT INTO `time_arrange` VALUES (3124, '09:00:00', '10:00:00', 1, '空闲', 230);
INSERT INTO `time_arrange` VALUES (3125, '10:00:00', '11:00:00', 2, '空闲', 230);
INSERT INTO `time_arrange` VALUES (3126, '11:00:00', '12:00:00', 3, '空闲', 230);
INSERT INTO `time_arrange` VALUES (3127, '12:00:00', '13:00:00', 4, '空闲', 230);
INSERT INTO `time_arrange` VALUES (3128, '13:00:00', '14:00:00', 5, '空闲', 230);
INSERT INTO `time_arrange` VALUES (3129, '14:00:00', '15:00:00', 6, '空闲', 230);
INSERT INTO `time_arrange` VALUES (3130, '15:00:00', '16:00:00', 7, '空闲', 230);
INSERT INTO `time_arrange` VALUES (3131, '16:00:00', '17:00:00', 8, '空闲', 230);
INSERT INTO `time_arrange` VALUES (3132, '17:00:00', '18:00:00', 9, '空闲', 230);
INSERT INTO `time_arrange` VALUES (3133, '18:00:00', '19:00:00', 10, '空闲', 230);
INSERT INTO `time_arrange` VALUES (3134, '19:00:00', '20:00:00', 11, '占用', 230);
INSERT INTO `time_arrange` VALUES (3135, '20:00:00', '21:00:00', 12, '空闲', 230);
INSERT INTO `time_arrange` VALUES (3136, '08:00:00', '09:00:00', 0, '空闲', 231);
INSERT INTO `time_arrange` VALUES (3137, '09:00:00', '10:00:00', 1, '空闲', 231);
INSERT INTO `time_arrange` VALUES (3138, '10:00:00', '11:00:00', 2, '空闲', 231);
INSERT INTO `time_arrange` VALUES (3139, '11:00:00', '12:00:00', 3, '空闲', 231);
INSERT INTO `time_arrange` VALUES (3140, '12:00:00', '13:00:00', 4, '空闲', 231);
INSERT INTO `time_arrange` VALUES (3141, '13:00:00', '14:00:00', 5, '空闲', 231);
INSERT INTO `time_arrange` VALUES (3142, '14:00:00', '15:00:00', 6, '空闲', 231);
INSERT INTO `time_arrange` VALUES (3143, '15:00:00', '16:00:00', 7, '空闲', 231);
INSERT INTO `time_arrange` VALUES (3144, '16:00:00', '17:00:00', 8, '空闲', 231);
INSERT INTO `time_arrange` VALUES (3145, '17:00:00', '18:00:00', 9, '空闲', 231);
INSERT INTO `time_arrange` VALUES (3146, '18:00:00', '19:00:00', 10, '空闲', 231);
INSERT INTO `time_arrange` VALUES (3147, '19:00:00', '20:00:00', 11, '空闲', 231);
INSERT INTO `time_arrange` VALUES (3148, '20:00:00', '21:00:00', 12, '空闲', 231);
INSERT INTO `time_arrange` VALUES (3149, '08:00:00', '09:00:00', 0, '空闲', 232);
INSERT INTO `time_arrange` VALUES (3150, '09:00:00', '10:00:00', 1, '空闲', 232);
INSERT INTO `time_arrange` VALUES (3151, '10:00:00', '11:00:00', 2, '空闲', 232);
INSERT INTO `time_arrange` VALUES (3152, '11:00:00', '12:00:00', 3, '空闲', 232);
INSERT INTO `time_arrange` VALUES (3153, '12:00:00', '13:00:00', 4, '空闲', 232);
INSERT INTO `time_arrange` VALUES (3154, '13:00:00', '14:00:00', 5, '空闲', 232);
INSERT INTO `time_arrange` VALUES (3155, '14:00:00', '15:00:00', 6, '空闲', 232);
INSERT INTO `time_arrange` VALUES (3156, '15:00:00', '16:00:00', 7, '空闲', 232);
INSERT INTO `time_arrange` VALUES (3157, '16:00:00', '17:00:00', 8, '空闲', 232);
INSERT INTO `time_arrange` VALUES (3158, '17:00:00', '18:00:00', 9, '空闲', 232);
INSERT INTO `time_arrange` VALUES (3159, '18:00:00', '19:00:00', 10, '空闲', 232);
INSERT INTO `time_arrange` VALUES (3160, '19:00:00', '20:00:00', 11, '空闲', 232);
INSERT INTO `time_arrange` VALUES (3161, '20:00:00', '21:00:00', 12, '空闲', 232);
INSERT INTO `time_arrange` VALUES (3162, '08:00:00', '09:00:00', 0, '空闲', 233);
INSERT INTO `time_arrange` VALUES (3163, '09:00:00', '10:00:00', 1, '空闲', 233);
INSERT INTO `time_arrange` VALUES (3164, '10:00:00', '11:00:00', 2, '空闲', 233);
INSERT INTO `time_arrange` VALUES (3165, '11:00:00', '12:00:00', 3, '空闲', 233);
INSERT INTO `time_arrange` VALUES (3166, '12:00:00', '13:00:00', 4, '空闲', 233);
INSERT INTO `time_arrange` VALUES (3167, '13:00:00', '14:00:00', 5, '空闲', 233);
INSERT INTO `time_arrange` VALUES (3168, '14:00:00', '15:00:00', 6, '空闲', 233);
INSERT INTO `time_arrange` VALUES (3169, '15:00:00', '16:00:00', 7, '空闲', 233);
INSERT INTO `time_arrange` VALUES (3170, '16:00:00', '17:00:00', 8, '空闲', 233);
INSERT INTO `time_arrange` VALUES (3171, '17:00:00', '18:00:00', 9, '空闲', 233);
INSERT INTO `time_arrange` VALUES (3172, '18:00:00', '19:00:00', 10, '空闲', 233);
INSERT INTO `time_arrange` VALUES (3173, '19:00:00', '20:00:00', 11, '空闲', 233);
INSERT INTO `time_arrange` VALUES (3174, '20:00:00', '21:00:00', 12, '空闲', 233);
INSERT INTO `time_arrange` VALUES (3175, '08:00:00', '09:00:00', 0, '空闲', 234);
INSERT INTO `time_arrange` VALUES (3176, '09:00:00', '10:00:00', 1, '空闲', 234);
INSERT INTO `time_arrange` VALUES (3177, '10:00:00', '11:00:00', 2, '空闲', 234);
INSERT INTO `time_arrange` VALUES (3178, '11:00:00', '12:00:00', 3, '空闲', 234);
INSERT INTO `time_arrange` VALUES (3179, '12:00:00', '13:00:00', 4, '空闲', 234);
INSERT INTO `time_arrange` VALUES (3180, '13:00:00', '14:00:00', 5, '空闲', 234);
INSERT INTO `time_arrange` VALUES (3181, '14:00:00', '15:00:00', 6, '空闲', 234);
INSERT INTO `time_arrange` VALUES (3182, '15:00:00', '16:00:00', 7, '空闲', 234);
INSERT INTO `time_arrange` VALUES (3183, '16:00:00', '17:00:00', 8, '空闲', 234);
INSERT INTO `time_arrange` VALUES (3184, '17:00:00', '18:00:00', 9, '空闲', 234);
INSERT INTO `time_arrange` VALUES (3185, '18:00:00', '19:00:00', 10, '空闲', 234);
INSERT INTO `time_arrange` VALUES (3186, '19:00:00', '20:00:00', 11, '空闲', 234);
INSERT INTO `time_arrange` VALUES (3187, '20:00:00', '21:00:00', 12, '空闲', 234);
INSERT INTO `time_arrange` VALUES (3188, '08:00:00', '09:00:00', 0, '空闲', 235);
INSERT INTO `time_arrange` VALUES (3189, '09:00:00', '10:00:00', 1, '空闲', 235);
INSERT INTO `time_arrange` VALUES (3190, '10:00:00', '11:00:00', 2, '空闲', 235);
INSERT INTO `time_arrange` VALUES (3191, '11:00:00', '12:00:00', 3, '空闲', 235);
INSERT INTO `time_arrange` VALUES (3192, '12:00:00', '13:00:00', 4, '空闲', 235);
INSERT INTO `time_arrange` VALUES (3193, '13:00:00', '14:00:00', 5, '空闲', 235);
INSERT INTO `time_arrange` VALUES (3194, '14:00:00', '15:00:00', 6, '空闲', 235);
INSERT INTO `time_arrange` VALUES (3195, '15:00:00', '16:00:00', 7, '空闲', 235);
INSERT INTO `time_arrange` VALUES (3196, '16:00:00', '17:00:00', 8, '空闲', 235);
INSERT INTO `time_arrange` VALUES (3197, '17:00:00', '18:00:00', 9, '空闲', 235);
INSERT INTO `time_arrange` VALUES (3198, '18:00:00', '19:00:00', 10, '空闲', 235);
INSERT INTO `time_arrange` VALUES (3199, '19:00:00', '20:00:00', 11, '空闲', 235);
INSERT INTO `time_arrange` VALUES (3200, '20:00:00', '21:00:00', 12, '空闲', 235);
INSERT INTO `time_arrange` VALUES (3201, '08:00:00', '09:00:00', 0, '空闲', 236);
INSERT INTO `time_arrange` VALUES (3202, '09:00:00', '10:00:00', 1, '空闲', 236);
INSERT INTO `time_arrange` VALUES (3203, '10:00:00', '11:00:00', 2, '空闲', 236);
INSERT INTO `time_arrange` VALUES (3204, '11:00:00', '12:00:00', 3, '空闲', 236);
INSERT INTO `time_arrange` VALUES (3205, '12:00:00', '13:00:00', 4, '空闲', 236);
INSERT INTO `time_arrange` VALUES (3206, '13:00:00', '14:00:00', 5, '空闲', 236);
INSERT INTO `time_arrange` VALUES (3207, '14:00:00', '15:00:00', 6, '空闲', 236);
INSERT INTO `time_arrange` VALUES (3208, '15:00:00', '16:00:00', 7, '空闲', 236);
INSERT INTO `time_arrange` VALUES (3209, '16:00:00', '17:00:00', 8, '空闲', 236);
INSERT INTO `time_arrange` VALUES (3210, '17:00:00', '18:00:00', 9, '空闲', 236);
INSERT INTO `time_arrange` VALUES (3211, '18:00:00', '19:00:00', 10, '空闲', 236);
INSERT INTO `time_arrange` VALUES (3212, '19:00:00', '20:00:00', 11, '空闲', 236);
INSERT INTO `time_arrange` VALUES (3213, '20:00:00', '21:00:00', 12, '空闲', 236);
INSERT INTO `time_arrange` VALUES (3214, '08:00:00', '09:00:00', 0, '空闲', 237);
INSERT INTO `time_arrange` VALUES (3215, '09:00:00', '10:00:00', 1, '空闲', 237);
INSERT INTO `time_arrange` VALUES (3216, '10:00:00', '11:00:00', 2, '空闲', 237);
INSERT INTO `time_arrange` VALUES (3217, '11:00:00', '12:00:00', 3, '空闲', 237);
INSERT INTO `time_arrange` VALUES (3218, '12:00:00', '13:00:00', 4, '空闲', 237);
INSERT INTO `time_arrange` VALUES (3219, '13:00:00', '14:00:00', 5, '空闲', 237);
INSERT INTO `time_arrange` VALUES (3220, '14:00:00', '15:00:00', 6, '空闲', 237);
INSERT INTO `time_arrange` VALUES (3221, '15:00:00', '16:00:00', 7, '空闲', 237);
INSERT INTO `time_arrange` VALUES (3222, '16:00:00', '17:00:00', 8, '空闲', 237);
INSERT INTO `time_arrange` VALUES (3223, '17:00:00', '18:00:00', 9, '空闲', 237);
INSERT INTO `time_arrange` VALUES (3224, '18:00:00', '19:00:00', 10, '空闲', 237);
INSERT INTO `time_arrange` VALUES (3225, '19:00:00', '20:00:00', 11, '空闲', 237);
INSERT INTO `time_arrange` VALUES (3226, '20:00:00', '21:00:00', 12, '空闲', 237);
INSERT INTO `time_arrange` VALUES (3227, '08:00:00', '09:00:00', 0, '空闲', 238);
INSERT INTO `time_arrange` VALUES (3228, '09:00:00', '10:00:00', 1, '空闲', 238);
INSERT INTO `time_arrange` VALUES (3229, '10:00:00', '11:00:00', 2, '空闲', 238);
INSERT INTO `time_arrange` VALUES (3230, '11:00:00', '12:00:00', 3, '空闲', 238);
INSERT INTO `time_arrange` VALUES (3231, '12:00:00', '13:00:00', 4, '空闲', 238);
INSERT INTO `time_arrange` VALUES (3232, '13:00:00', '14:00:00', 5, '空闲', 238);
INSERT INTO `time_arrange` VALUES (3233, '14:00:00', '15:00:00', 6, '空闲', 238);
INSERT INTO `time_arrange` VALUES (3234, '15:00:00', '16:00:00', 7, '空闲', 238);
INSERT INTO `time_arrange` VALUES (3235, '16:00:00', '17:00:00', 8, '空闲', 238);
INSERT INTO `time_arrange` VALUES (3236, '17:00:00', '18:00:00', 9, '空闲', 238);
INSERT INTO `time_arrange` VALUES (3237, '18:00:00', '19:00:00', 10, '空闲', 238);
INSERT INTO `time_arrange` VALUES (3238, '19:00:00', '20:00:00', 11, '空闲', 238);
INSERT INTO `time_arrange` VALUES (3239, '20:00:00', '21:00:00', 12, '空闲', 238);
INSERT INTO `time_arrange` VALUES (3240, '08:00:00', '09:00:00', 0, '空闲', 239);
INSERT INTO `time_arrange` VALUES (3241, '09:00:00', '10:00:00', 1, '空闲', 239);
INSERT INTO `time_arrange` VALUES (3242, '10:00:00', '11:00:00', 2, '占用', 239);
INSERT INTO `time_arrange` VALUES (3243, '11:00:00', '12:00:00', 3, '空闲', 239);
INSERT INTO `time_arrange` VALUES (3244, '12:00:00', '13:00:00', 4, '空闲', 239);
INSERT INTO `time_arrange` VALUES (3245, '13:00:00', '14:00:00', 5, '空闲', 239);
INSERT INTO `time_arrange` VALUES (3246, '14:00:00', '15:00:00', 6, '空闲', 239);
INSERT INTO `time_arrange` VALUES (3247, '15:00:00', '16:00:00', 7, '空闲', 239);
INSERT INTO `time_arrange` VALUES (3248, '16:00:00', '17:00:00', 8, '空闲', 239);
INSERT INTO `time_arrange` VALUES (3249, '17:00:00', '18:00:00', 9, '空闲', 239);
INSERT INTO `time_arrange` VALUES (3250, '18:00:00', '19:00:00', 10, '空闲', 239);
INSERT INTO `time_arrange` VALUES (3251, '19:00:00', '20:00:00', 11, '空闲', 239);
INSERT INTO `time_arrange` VALUES (3252, '20:00:00', '21:00:00', 12, '空闲', 239);
INSERT INTO `time_arrange` VALUES (3253, '08:00:00', '09:00:00', 0, '空闲', 240);
INSERT INTO `time_arrange` VALUES (3254, '09:00:00', '10:00:00', 1, '空闲', 240);
INSERT INTO `time_arrange` VALUES (3255, '10:00:00', '11:00:00', 2, '空闲', 240);
INSERT INTO `time_arrange` VALUES (3256, '11:00:00', '12:00:00', 3, '空闲', 240);
INSERT INTO `time_arrange` VALUES (3257, '12:00:00', '13:00:00', 4, '空闲', 240);
INSERT INTO `time_arrange` VALUES (3258, '13:00:00', '14:00:00', 5, '空闲', 240);
INSERT INTO `time_arrange` VALUES (3259, '14:00:00', '15:00:00', 6, '空闲', 240);
INSERT INTO `time_arrange` VALUES (3260, '15:00:00', '16:00:00', 7, '空闲', 240);
INSERT INTO `time_arrange` VALUES (3261, '16:00:00', '17:00:00', 8, '空闲', 240);
INSERT INTO `time_arrange` VALUES (3262, '17:00:00', '18:00:00', 9, '空闲', 240);
INSERT INTO `time_arrange` VALUES (3263, '18:00:00', '19:00:00', 10, '空闲', 240);
INSERT INTO `time_arrange` VALUES (3264, '19:00:00', '20:00:00', 11, '空闲', 240);
INSERT INTO `time_arrange` VALUES (3265, '20:00:00', '21:00:00', 12, '空闲', 240);
INSERT INTO `time_arrange` VALUES (3266, '08:00:00', '09:00:00', 0, '空闲', 241);
INSERT INTO `time_arrange` VALUES (3267, '09:00:00', '10:00:00', 1, '空闲', 241);
INSERT INTO `time_arrange` VALUES (3268, '10:00:00', '11:00:00', 2, '空闲', 241);
INSERT INTO `time_arrange` VALUES (3269, '11:00:00', '12:00:00', 3, '空闲', 241);
INSERT INTO `time_arrange` VALUES (3270, '12:00:00', '13:00:00', 4, '空闲', 241);
INSERT INTO `time_arrange` VALUES (3271, '13:00:00', '14:00:00', 5, '空闲', 241);
INSERT INTO `time_arrange` VALUES (3272, '14:00:00', '15:00:00', 6, '空闲', 241);
INSERT INTO `time_arrange` VALUES (3273, '15:00:00', '16:00:00', 7, '空闲', 241);
INSERT INTO `time_arrange` VALUES (3274, '16:00:00', '17:00:00', 8, '空闲', 241);
INSERT INTO `time_arrange` VALUES (3275, '17:00:00', '18:00:00', 9, '空闲', 241);
INSERT INTO `time_arrange` VALUES (3276, '18:00:00', '19:00:00', 10, '空闲', 241);
INSERT INTO `time_arrange` VALUES (3277, '19:00:00', '20:00:00', 11, '空闲', 241);
INSERT INTO `time_arrange` VALUES (3278, '20:00:00', '21:00:00', 12, '空闲', 241);
INSERT INTO `time_arrange` VALUES (3279, '08:00:00', '09:00:00', 0, '空闲', 242);
INSERT INTO `time_arrange` VALUES (3280, '09:00:00', '10:00:00', 1, '空闲', 242);
INSERT INTO `time_arrange` VALUES (3281, '10:00:00', '11:00:00', 2, '空闲', 242);
INSERT INTO `time_arrange` VALUES (3282, '11:00:00', '12:00:00', 3, '空闲', 242);
INSERT INTO `time_arrange` VALUES (3283, '12:00:00', '13:00:00', 4, '空闲', 242);
INSERT INTO `time_arrange` VALUES (3284, '13:00:00', '14:00:00', 5, '空闲', 242);
INSERT INTO `time_arrange` VALUES (3285, '14:00:00', '15:00:00', 6, '空闲', 242);
INSERT INTO `time_arrange` VALUES (3286, '15:00:00', '16:00:00', 7, '空闲', 242);
INSERT INTO `time_arrange` VALUES (3287, '16:00:00', '17:00:00', 8, '空闲', 242);
INSERT INTO `time_arrange` VALUES (3288, '17:00:00', '18:00:00', 9, '空闲', 242);
INSERT INTO `time_arrange` VALUES (3289, '18:00:00', '19:00:00', 10, '空闲', 242);
INSERT INTO `time_arrange` VALUES (3290, '19:00:00', '20:00:00', 11, '空闲', 242);
INSERT INTO `time_arrange` VALUES (3291, '20:00:00', '21:00:00', 12, '空闲', 242);
INSERT INTO `time_arrange` VALUES (3292, '08:00:00', '09:00:00', 0, '空闲', 243);
INSERT INTO `time_arrange` VALUES (3293, '09:00:00', '10:00:00', 1, '空闲', 243);
INSERT INTO `time_arrange` VALUES (3294, '10:00:00', '11:00:00', 2, '空闲', 243);
INSERT INTO `time_arrange` VALUES (3295, '11:00:00', '12:00:00', 3, '空闲', 243);
INSERT INTO `time_arrange` VALUES (3296, '12:00:00', '13:00:00', 4, '空闲', 243);
INSERT INTO `time_arrange` VALUES (3297, '13:00:00', '14:00:00', 5, '空闲', 243);
INSERT INTO `time_arrange` VALUES (3298, '14:00:00', '15:00:00', 6, '空闲', 243);
INSERT INTO `time_arrange` VALUES (3299, '15:00:00', '16:00:00', 7, '空闲', 243);
INSERT INTO `time_arrange` VALUES (3300, '16:00:00', '17:00:00', 8, '空闲', 243);
INSERT INTO `time_arrange` VALUES (3301, '17:00:00', '18:00:00', 9, '空闲', 243);
INSERT INTO `time_arrange` VALUES (3302, '18:00:00', '19:00:00', 10, '空闲', 243);
INSERT INTO `time_arrange` VALUES (3303, '19:00:00', '20:00:00', 11, '空闲', 243);
INSERT INTO `time_arrange` VALUES (3304, '20:00:00', '21:00:00', 12, '空闲', 243);
INSERT INTO `time_arrange` VALUES (3305, '08:00:00', '09:00:00', 0, '空闲', 244);
INSERT INTO `time_arrange` VALUES (3306, '09:00:00', '10:00:00', 1, '空闲', 244);
INSERT INTO `time_arrange` VALUES (3307, '10:00:00', '11:00:00', 2, '空闲', 244);
INSERT INTO `time_arrange` VALUES (3308, '11:00:00', '12:00:00', 3, '空闲', 244);
INSERT INTO `time_arrange` VALUES (3309, '12:00:00', '13:00:00', 4, '空闲', 244);
INSERT INTO `time_arrange` VALUES (3310, '13:00:00', '14:00:00', 5, '空闲', 244);
INSERT INTO `time_arrange` VALUES (3311, '14:00:00', '15:00:00', 6, '空闲', 244);
INSERT INTO `time_arrange` VALUES (3312, '15:00:00', '16:00:00', 7, '空闲', 244);
INSERT INTO `time_arrange` VALUES (3313, '16:00:00', '17:00:00', 8, '空闲', 244);
INSERT INTO `time_arrange` VALUES (3314, '17:00:00', '18:00:00', 9, '空闲', 244);
INSERT INTO `time_arrange` VALUES (3315, '18:00:00', '19:00:00', 10, '空闲', 244);
INSERT INTO `time_arrange` VALUES (3316, '19:00:00', '20:00:00', 11, '空闲', 244);
INSERT INTO `time_arrange` VALUES (3317, '20:00:00', '21:00:00', 12, '空闲', 244);
INSERT INTO `time_arrange` VALUES (3318, '08:00:00', '09:00:00', 0, '空闲', 245);
INSERT INTO `time_arrange` VALUES (3319, '09:00:00', '10:00:00', 1, '空闲', 245);
INSERT INTO `time_arrange` VALUES (3320, '10:00:00', '11:00:00', 2, '空闲', 245);
INSERT INTO `time_arrange` VALUES (3321, '11:00:00', '12:00:00', 3, '空闲', 245);
INSERT INTO `time_arrange` VALUES (3322, '12:00:00', '13:00:00', 4, '空闲', 245);
INSERT INTO `time_arrange` VALUES (3323, '13:00:00', '14:00:00', 5, '空闲', 245);
INSERT INTO `time_arrange` VALUES (3324, '14:00:00', '15:00:00', 6, '空闲', 245);
INSERT INTO `time_arrange` VALUES (3325, '15:00:00', '16:00:00', 7, '空闲', 245);
INSERT INTO `time_arrange` VALUES (3326, '16:00:00', '17:00:00', 8, '空闲', 245);
INSERT INTO `time_arrange` VALUES (3327, '17:00:00', '18:00:00', 9, '空闲', 245);
INSERT INTO `time_arrange` VALUES (3328, '18:00:00', '19:00:00', 10, '空闲', 245);
INSERT INTO `time_arrange` VALUES (3329, '19:00:00', '20:00:00', 11, '空闲', 245);
INSERT INTO `time_arrange` VALUES (3330, '20:00:00', '21:00:00', 12, '空闲', 245);
INSERT INTO `time_arrange` VALUES (3331, '08:00:00', '09:00:00', 0, '空闲', 246);
INSERT INTO `time_arrange` VALUES (3332, '09:00:00', '10:00:00', 1, '空闲', 246);
INSERT INTO `time_arrange` VALUES (3333, '10:00:00', '11:00:00', 2, '空闲', 246);
INSERT INTO `time_arrange` VALUES (3334, '11:00:00', '12:00:00', 3, '空闲', 246);
INSERT INTO `time_arrange` VALUES (3335, '12:00:00', '13:00:00', 4, '空闲', 246);
INSERT INTO `time_arrange` VALUES (3336, '13:00:00', '14:00:00', 5, '空闲', 246);
INSERT INTO `time_arrange` VALUES (3337, '14:00:00', '15:00:00', 6, '空闲', 246);
INSERT INTO `time_arrange` VALUES (3338, '15:00:00', '16:00:00', 7, '空闲', 246);
INSERT INTO `time_arrange` VALUES (3339, '16:00:00', '17:00:00', 8, '空闲', 246);
INSERT INTO `time_arrange` VALUES (3340, '17:00:00', '18:00:00', 9, '空闲', 246);
INSERT INTO `time_arrange` VALUES (3341, '18:00:00', '19:00:00', 10, '空闲', 246);
INSERT INTO `time_arrange` VALUES (3342, '19:00:00', '20:00:00', 11, '空闲', 246);
INSERT INTO `time_arrange` VALUES (3343, '20:00:00', '21:00:00', 12, '空闲', 246);
INSERT INTO `time_arrange` VALUES (3344, '08:00:00', '09:00:00', 0, '空闲', 247);
INSERT INTO `time_arrange` VALUES (3345, '09:00:00', '10:00:00', 1, '空闲', 247);
INSERT INTO `time_arrange` VALUES (3346, '10:00:00', '11:00:00', 2, '空闲', 247);
INSERT INTO `time_arrange` VALUES (3347, '11:00:00', '12:00:00', 3, '空闲', 247);
INSERT INTO `time_arrange` VALUES (3348, '12:00:00', '13:00:00', 4, '空闲', 247);
INSERT INTO `time_arrange` VALUES (3349, '13:00:00', '14:00:00', 5, '空闲', 247);
INSERT INTO `time_arrange` VALUES (3350, '14:00:00', '15:00:00', 6, '空闲', 247);
INSERT INTO `time_arrange` VALUES (3351, '15:00:00', '16:00:00', 7, '空闲', 247);
INSERT INTO `time_arrange` VALUES (3352, '16:00:00', '17:00:00', 8, '空闲', 247);
INSERT INTO `time_arrange` VALUES (3353, '17:00:00', '18:00:00', 9, '空闲', 247);
INSERT INTO `time_arrange` VALUES (3354, '18:00:00', '19:00:00', 10, '空闲', 247);
INSERT INTO `time_arrange` VALUES (3355, '19:00:00', '20:00:00', 11, '空闲', 247);
INSERT INTO `time_arrange` VALUES (3356, '20:00:00', '21:00:00', 12, '空闲', 247);
INSERT INTO `time_arrange` VALUES (3357, '08:00:00', '09:00:00', 0, '空闲', 248);
INSERT INTO `time_arrange` VALUES (3358, '09:00:00', '10:00:00', 1, '空闲', 248);
INSERT INTO `time_arrange` VALUES (3359, '10:00:00', '11:00:00', 2, '空闲', 248);
INSERT INTO `time_arrange` VALUES (3360, '11:00:00', '12:00:00', 3, '空闲', 248);
INSERT INTO `time_arrange` VALUES (3361, '12:00:00', '13:00:00', 4, '空闲', 248);
INSERT INTO `time_arrange` VALUES (3362, '13:00:00', '14:00:00', 5, '空闲', 248);
INSERT INTO `time_arrange` VALUES (3363, '14:00:00', '15:00:00', 6, '空闲', 248);
INSERT INTO `time_arrange` VALUES (3364, '15:00:00', '16:00:00', 7, '空闲', 248);
INSERT INTO `time_arrange` VALUES (3365, '16:00:00', '17:00:00', 8, '空闲', 248);
INSERT INTO `time_arrange` VALUES (3366, '17:00:00', '18:00:00', 9, '空闲', 248);
INSERT INTO `time_arrange` VALUES (3367, '18:00:00', '19:00:00', 10, '空闲', 248);
INSERT INTO `time_arrange` VALUES (3368, '19:00:00', '20:00:00', 11, '空闲', 248);
INSERT INTO `time_arrange` VALUES (3369, '20:00:00', '21:00:00', 12, '空闲', 248);
INSERT INTO `time_arrange` VALUES (3370, '08:00:00', '09:00:00', 0, '空闲', 249);
INSERT INTO `time_arrange` VALUES (3371, '09:00:00', '10:00:00', 1, '空闲', 249);
INSERT INTO `time_arrange` VALUES (3372, '10:00:00', '11:00:00', 2, '空闲', 249);
INSERT INTO `time_arrange` VALUES (3373, '11:00:00', '12:00:00', 3, '空闲', 249);
INSERT INTO `time_arrange` VALUES (3374, '12:00:00', '13:00:00', 4, '空闲', 249);
INSERT INTO `time_arrange` VALUES (3375, '13:00:00', '14:00:00', 5, '空闲', 249);
INSERT INTO `time_arrange` VALUES (3376, '14:00:00', '15:00:00', 6, '空闲', 249);
INSERT INTO `time_arrange` VALUES (3377, '15:00:00', '16:00:00', 7, '空闲', 249);
INSERT INTO `time_arrange` VALUES (3378, '16:00:00', '17:00:00', 8, '空闲', 249);
INSERT INTO `time_arrange` VALUES (3379, '17:00:00', '18:00:00', 9, '空闲', 249);
INSERT INTO `time_arrange` VALUES (3380, '18:00:00', '19:00:00', 10, '空闲', 249);
INSERT INTO `time_arrange` VALUES (3381, '19:00:00', '20:00:00', 11, '空闲', 249);
INSERT INTO `time_arrange` VALUES (3382, '20:00:00', '21:00:00', 12, '空闲', 249);
INSERT INTO `time_arrange` VALUES (3383, '08:00:00', '09:00:00', 0, '空闲', 250);
INSERT INTO `time_arrange` VALUES (3384, '09:00:00', '10:00:00', 1, '空闲', 250);
INSERT INTO `time_arrange` VALUES (3385, '10:00:00', '11:00:00', 2, '空闲', 250);
INSERT INTO `time_arrange` VALUES (3386, '11:00:00', '12:00:00', 3, '空闲', 250);
INSERT INTO `time_arrange` VALUES (3387, '12:00:00', '13:00:00', 4, '空闲', 250);
INSERT INTO `time_arrange` VALUES (3388, '13:00:00', '14:00:00', 5, '空闲', 250);
INSERT INTO `time_arrange` VALUES (3389, '14:00:00', '15:00:00', 6, '空闲', 250);
INSERT INTO `time_arrange` VALUES (3390, '15:00:00', '16:00:00', 7, '空闲', 250);
INSERT INTO `time_arrange` VALUES (3391, '16:00:00', '17:00:00', 8, '空闲', 250);
INSERT INTO `time_arrange` VALUES (3392, '17:00:00', '18:00:00', 9, '空闲', 250);
INSERT INTO `time_arrange` VALUES (3393, '18:00:00', '19:00:00', 10, '空闲', 250);
INSERT INTO `time_arrange` VALUES (3394, '19:00:00', '20:00:00', 11, '空闲', 250);
INSERT INTO `time_arrange` VALUES (3395, '20:00:00', '21:00:00', 12, '空闲', 250);
INSERT INTO `time_arrange` VALUES (3396, '08:00:00', '09:00:00', 0, '空闲', 251);
INSERT INTO `time_arrange` VALUES (3397, '09:00:00', '10:00:00', 1, '空闲', 251);
INSERT INTO `time_arrange` VALUES (3398, '10:00:00', '11:00:00', 2, '空闲', 251);
INSERT INTO `time_arrange` VALUES (3399, '11:00:00', '12:00:00', 3, '空闲', 251);
INSERT INTO `time_arrange` VALUES (3400, '12:00:00', '13:00:00', 4, '空闲', 251);
INSERT INTO `time_arrange` VALUES (3401, '13:00:00', '14:00:00', 5, '空闲', 251);
INSERT INTO `time_arrange` VALUES (3402, '14:00:00', '15:00:00', 6, '空闲', 251);
INSERT INTO `time_arrange` VALUES (3403, '15:00:00', '16:00:00', 7, '空闲', 251);
INSERT INTO `time_arrange` VALUES (3404, '16:00:00', '17:00:00', 8, '空闲', 251);
INSERT INTO `time_arrange` VALUES (3405, '17:00:00', '18:00:00', 9, '空闲', 251);
INSERT INTO `time_arrange` VALUES (3406, '18:00:00', '19:00:00', 10, '空闲', 251);
INSERT INTO `time_arrange` VALUES (3407, '19:00:00', '20:00:00', 11, '空闲', 251);
INSERT INTO `time_arrange` VALUES (3408, '20:00:00', '21:00:00', 12, '空闲', 251);
INSERT INTO `time_arrange` VALUES (3409, '08:00:00', '09:00:00', 0, '空闲', 252);
INSERT INTO `time_arrange` VALUES (3410, '09:00:00', '10:00:00', 1, '空闲', 252);
INSERT INTO `time_arrange` VALUES (3411, '10:00:00', '11:00:00', 2, '空闲', 252);
INSERT INTO `time_arrange` VALUES (3412, '11:00:00', '12:00:00', 3, '空闲', 252);
INSERT INTO `time_arrange` VALUES (3413, '12:00:00', '13:00:00', 4, '空闲', 252);
INSERT INTO `time_arrange` VALUES (3414, '13:00:00', '14:00:00', 5, '空闲', 252);
INSERT INTO `time_arrange` VALUES (3415, '14:00:00', '15:00:00', 6, '空闲', 252);
INSERT INTO `time_arrange` VALUES (3416, '15:00:00', '16:00:00', 7, '空闲', 252);
INSERT INTO `time_arrange` VALUES (3417, '16:00:00', '17:00:00', 8, '空闲', 252);
INSERT INTO `time_arrange` VALUES (3418, '17:00:00', '18:00:00', 9, '空闲', 252);
INSERT INTO `time_arrange` VALUES (3419, '18:00:00', '19:00:00', 10, '空闲', 252);
INSERT INTO `time_arrange` VALUES (3420, '19:00:00', '20:00:00', 11, '空闲', 252);
INSERT INTO `time_arrange` VALUES (3421, '20:00:00', '21:00:00', 12, '空闲', 252);
INSERT INTO `time_arrange` VALUES (3422, '08:00:00', '09:00:00', 0, '空闲', 253);
INSERT INTO `time_arrange` VALUES (3423, '09:00:00', '10:00:00', 1, '空闲', 253);
INSERT INTO `time_arrange` VALUES (3424, '10:00:00', '11:00:00', 2, '空闲', 253);
INSERT INTO `time_arrange` VALUES (3425, '11:00:00', '12:00:00', 3, '空闲', 253);
INSERT INTO `time_arrange` VALUES (3426, '12:00:00', '13:00:00', 4, '空闲', 253);
INSERT INTO `time_arrange` VALUES (3427, '13:00:00', '14:00:00', 5, '空闲', 253);
INSERT INTO `time_arrange` VALUES (3428, '14:00:00', '15:00:00', 6, '空闲', 253);
INSERT INTO `time_arrange` VALUES (3429, '15:00:00', '16:00:00', 7, '空闲', 253);
INSERT INTO `time_arrange` VALUES (3430, '16:00:00', '17:00:00', 8, '空闲', 253);
INSERT INTO `time_arrange` VALUES (3431, '17:00:00', '18:00:00', 9, '空闲', 253);
INSERT INTO `time_arrange` VALUES (3432, '18:00:00', '19:00:00', 10, '空闲', 253);
INSERT INTO `time_arrange` VALUES (3433, '19:00:00', '20:00:00', 11, '空闲', 253);
INSERT INTO `time_arrange` VALUES (3434, '20:00:00', '21:00:00', 12, '空闲', 253);
INSERT INTO `time_arrange` VALUES (3435, '08:00:00', '09:00:00', 0, '空闲', 254);
INSERT INTO `time_arrange` VALUES (3436, '09:00:00', '10:00:00', 1, '空闲', 254);
INSERT INTO `time_arrange` VALUES (3437, '10:00:00', '11:00:00', 2, '空闲', 254);
INSERT INTO `time_arrange` VALUES (3438, '11:00:00', '12:00:00', 3, '空闲', 254);
INSERT INTO `time_arrange` VALUES (3439, '12:00:00', '13:00:00', 4, '空闲', 254);
INSERT INTO `time_arrange` VALUES (3440, '13:00:00', '14:00:00', 5, '空闲', 254);
INSERT INTO `time_arrange` VALUES (3441, '14:00:00', '15:00:00', 6, '空闲', 254);
INSERT INTO `time_arrange` VALUES (3442, '15:00:00', '16:00:00', 7, '空闲', 254);
INSERT INTO `time_arrange` VALUES (3443, '16:00:00', '17:00:00', 8, '空闲', 254);
INSERT INTO `time_arrange` VALUES (3444, '17:00:00', '18:00:00', 9, '空闲', 254);
INSERT INTO `time_arrange` VALUES (3445, '18:00:00', '19:00:00', 10, '空闲', 254);
INSERT INTO `time_arrange` VALUES (3446, '19:00:00', '20:00:00', 11, '空闲', 254);
INSERT INTO `time_arrange` VALUES (3447, '20:00:00', '21:00:00', 12, '空闲', 254);
INSERT INTO `time_arrange` VALUES (3448, '08:00:00', '09:00:00', 0, '空闲', 255);
INSERT INTO `time_arrange` VALUES (3449, '09:00:00', '10:00:00', 1, '空闲', 255);
INSERT INTO `time_arrange` VALUES (3450, '10:00:00', '11:00:00', 2, '空闲', 255);
INSERT INTO `time_arrange` VALUES (3451, '11:00:00', '12:00:00', 3, '空闲', 255);
INSERT INTO `time_arrange` VALUES (3452, '12:00:00', '13:00:00', 4, '空闲', 255);
INSERT INTO `time_arrange` VALUES (3453, '13:00:00', '14:00:00', 5, '空闲', 255);
INSERT INTO `time_arrange` VALUES (3454, '14:00:00', '15:00:00', 6, '空闲', 255);
INSERT INTO `time_arrange` VALUES (3455, '15:00:00', '16:00:00', 7, '空闲', 255);
INSERT INTO `time_arrange` VALUES (3456, '16:00:00', '17:00:00', 8, '空闲', 255);
INSERT INTO `time_arrange` VALUES (3457, '17:00:00', '18:00:00', 9, '空闲', 255);
INSERT INTO `time_arrange` VALUES (3458, '18:00:00', '19:00:00', 10, '空闲', 255);
INSERT INTO `time_arrange` VALUES (3459, '19:00:00', '20:00:00', 11, '空闲', 255);
INSERT INTO `time_arrange` VALUES (3460, '20:00:00', '21:00:00', 12, '空闲', 255);
INSERT INTO `time_arrange` VALUES (3461, '08:00:00', '09:00:00', 0, '空闲', 256);
INSERT INTO `time_arrange` VALUES (3462, '09:00:00', '10:00:00', 1, '空闲', 256);
INSERT INTO `time_arrange` VALUES (3463, '10:00:00', '11:00:00', 2, '空闲', 256);
INSERT INTO `time_arrange` VALUES (3464, '11:00:00', '12:00:00', 3, '空闲', 256);
INSERT INTO `time_arrange` VALUES (3465, '12:00:00', '13:00:00', 4, '空闲', 256);
INSERT INTO `time_arrange` VALUES (3466, '13:00:00', '14:00:00', 5, '空闲', 256);
INSERT INTO `time_arrange` VALUES (3467, '14:00:00', '15:00:00', 6, '空闲', 256);
INSERT INTO `time_arrange` VALUES (3468, '15:00:00', '16:00:00', 7, '空闲', 256);
INSERT INTO `time_arrange` VALUES (3469, '16:00:00', '17:00:00', 8, '空闲', 256);
INSERT INTO `time_arrange` VALUES (3470, '17:00:00', '18:00:00', 9, '空闲', 256);
INSERT INTO `time_arrange` VALUES (3471, '18:00:00', '19:00:00', 10, '空闲', 256);
INSERT INTO `time_arrange` VALUES (3472, '19:00:00', '20:00:00', 11, '空闲', 256);
INSERT INTO `time_arrange` VALUES (3473, '20:00:00', '21:00:00', 12, '空闲', 256);
INSERT INTO `time_arrange` VALUES (3474, '08:00:00', '09:00:00', 0, '空闲', 257);
INSERT INTO `time_arrange` VALUES (3475, '09:00:00', '10:00:00', 1, '空闲', 257);
INSERT INTO `time_arrange` VALUES (3476, '10:00:00', '11:00:00', 2, '空闲', 257);
INSERT INTO `time_arrange` VALUES (3477, '11:00:00', '12:00:00', 3, '空闲', 257);
INSERT INTO `time_arrange` VALUES (3478, '12:00:00', '13:00:00', 4, '空闲', 257);
INSERT INTO `time_arrange` VALUES (3479, '13:00:00', '14:00:00', 5, '空闲', 257);
INSERT INTO `time_arrange` VALUES (3480, '14:00:00', '15:00:00', 6, '空闲', 257);
INSERT INTO `time_arrange` VALUES (3481, '15:00:00', '16:00:00', 7, '空闲', 257);
INSERT INTO `time_arrange` VALUES (3482, '16:00:00', '17:00:00', 8, '空闲', 257);
INSERT INTO `time_arrange` VALUES (3483, '17:00:00', '18:00:00', 9, '空闲', 257);
INSERT INTO `time_arrange` VALUES (3484, '18:00:00', '19:00:00', 10, '空闲', 257);
INSERT INTO `time_arrange` VALUES (3485, '19:00:00', '20:00:00', 11, '空闲', 257);
INSERT INTO `time_arrange` VALUES (3486, '20:00:00', '21:00:00', 12, '空闲', 257);
INSERT INTO `time_arrange` VALUES (3487, '08:00:00', '09:00:00', 0, '空闲', 258);
INSERT INTO `time_arrange` VALUES (3488, '09:00:00', '10:00:00', 1, '空闲', 258);
INSERT INTO `time_arrange` VALUES (3489, '10:00:00', '11:00:00', 2, '空闲', 258);
INSERT INTO `time_arrange` VALUES (3490, '11:00:00', '12:00:00', 3, '空闲', 258);
INSERT INTO `time_arrange` VALUES (3491, '12:00:00', '13:00:00', 4, '空闲', 258);
INSERT INTO `time_arrange` VALUES (3492, '13:00:00', '14:00:00', 5, '空闲', 258);
INSERT INTO `time_arrange` VALUES (3493, '14:00:00', '15:00:00', 6, '空闲', 258);
INSERT INTO `time_arrange` VALUES (3494, '15:00:00', '16:00:00', 7, '空闲', 258);
INSERT INTO `time_arrange` VALUES (3495, '16:00:00', '17:00:00', 8, '空闲', 258);
INSERT INTO `time_arrange` VALUES (3496, '17:00:00', '18:00:00', 9, '空闲', 258);
INSERT INTO `time_arrange` VALUES (3497, '18:00:00', '19:00:00', 10, '空闲', 258);
INSERT INTO `time_arrange` VALUES (3498, '19:00:00', '20:00:00', 11, '空闲', 258);
INSERT INTO `time_arrange` VALUES (3499, '20:00:00', '21:00:00', 12, '空闲', 258);
INSERT INTO `time_arrange` VALUES (3500, '08:00:00', '09:00:00', 0, '空闲', 259);
INSERT INTO `time_arrange` VALUES (3501, '09:00:00', '10:00:00', 1, '空闲', 259);
INSERT INTO `time_arrange` VALUES (3502, '10:00:00', '11:00:00', 2, '空闲', 259);
INSERT INTO `time_arrange` VALUES (3503, '11:00:00', '12:00:00', 3, '空闲', 259);
INSERT INTO `time_arrange` VALUES (3504, '12:00:00', '13:00:00', 4, '空闲', 259);
INSERT INTO `time_arrange` VALUES (3505, '13:00:00', '14:00:00', 5, '空闲', 259);
INSERT INTO `time_arrange` VALUES (3506, '14:00:00', '15:00:00', 6, '空闲', 259);
INSERT INTO `time_arrange` VALUES (3507, '15:00:00', '16:00:00', 7, '空闲', 259);
INSERT INTO `time_arrange` VALUES (3508, '16:00:00', '17:00:00', 8, '空闲', 259);
INSERT INTO `time_arrange` VALUES (3509, '17:00:00', '18:00:00', 9, '空闲', 259);
INSERT INTO `time_arrange` VALUES (3510, '18:00:00', '19:00:00', 10, '空闲', 259);
INSERT INTO `time_arrange` VALUES (3511, '19:00:00', '20:00:00', 11, '空闲', 259);
INSERT INTO `time_arrange` VALUES (3512, '20:00:00', '21:00:00', 12, '空闲', 259);
INSERT INTO `time_arrange` VALUES (3513, '08:00:00', '09:00:00', 0, '空闲', 260);
INSERT INTO `time_arrange` VALUES (3514, '09:00:00', '10:00:00', 1, '空闲', 260);
INSERT INTO `time_arrange` VALUES (3515, '10:00:00', '11:00:00', 2, '空闲', 260);
INSERT INTO `time_arrange` VALUES (3516, '11:00:00', '12:00:00', 3, '空闲', 260);
INSERT INTO `time_arrange` VALUES (3517, '12:00:00', '13:00:00', 4, '空闲', 260);
INSERT INTO `time_arrange` VALUES (3518, '13:00:00', '14:00:00', 5, '空闲', 260);
INSERT INTO `time_arrange` VALUES (3519, '14:00:00', '15:00:00', 6, '空闲', 260);
INSERT INTO `time_arrange` VALUES (3520, '15:00:00', '16:00:00', 7, '空闲', 260);
INSERT INTO `time_arrange` VALUES (3521, '16:00:00', '17:00:00', 8, '空闲', 260);
INSERT INTO `time_arrange` VALUES (3522, '17:00:00', '18:00:00', 9, '空闲', 260);
INSERT INTO `time_arrange` VALUES (3523, '18:00:00', '19:00:00', 10, '空闲', 260);
INSERT INTO `time_arrange` VALUES (3524, '19:00:00', '20:00:00', 11, '空闲', 260);
INSERT INTO `time_arrange` VALUES (3525, '20:00:00', '21:00:00', 12, '空闲', 260);
INSERT INTO `time_arrange` VALUES (3526, '08:00:00', '09:00:00', 0, '空闲', 261);
INSERT INTO `time_arrange` VALUES (3527, '09:00:00', '10:00:00', 1, '空闲', 261);
INSERT INTO `time_arrange` VALUES (3528, '10:00:00', '11:00:00', 2, '空闲', 261);
INSERT INTO `time_arrange` VALUES (3529, '11:00:00', '12:00:00', 3, '空闲', 261);
INSERT INTO `time_arrange` VALUES (3530, '12:00:00', '13:00:00', 4, '空闲', 261);
INSERT INTO `time_arrange` VALUES (3531, '13:00:00', '14:00:00', 5, '空闲', 261);
INSERT INTO `time_arrange` VALUES (3532, '14:00:00', '15:00:00', 6, '空闲', 261);
INSERT INTO `time_arrange` VALUES (3533, '15:00:00', '16:00:00', 7, '空闲', 261);
INSERT INTO `time_arrange` VALUES (3534, '16:00:00', '17:00:00', 8, '空闲', 261);
INSERT INTO `time_arrange` VALUES (3535, '17:00:00', '18:00:00', 9, '空闲', 261);
INSERT INTO `time_arrange` VALUES (3536, '18:00:00', '19:00:00', 10, '空闲', 261);
INSERT INTO `time_arrange` VALUES (3537, '19:00:00', '20:00:00', 11, '空闲', 261);
INSERT INTO `time_arrange` VALUES (3538, '20:00:00', '21:00:00', 12, '空闲', 261);
INSERT INTO `time_arrange` VALUES (3539, '08:00:00', '09:00:00', 0, '空闲', 262);
INSERT INTO `time_arrange` VALUES (3540, '09:00:00', '10:00:00', 1, '空闲', 262);
INSERT INTO `time_arrange` VALUES (3541, '10:00:00', '11:00:00', 2, '空闲', 262);
INSERT INTO `time_arrange` VALUES (3542, '11:00:00', '12:00:00', 3, '空闲', 262);
INSERT INTO `time_arrange` VALUES (3543, '12:00:00', '13:00:00', 4, '空闲', 262);
INSERT INTO `time_arrange` VALUES (3544, '13:00:00', '14:00:00', 5, '空闲', 262);
INSERT INTO `time_arrange` VALUES (3545, '14:00:00', '15:00:00', 6, '空闲', 262);
INSERT INTO `time_arrange` VALUES (3546, '15:00:00', '16:00:00', 7, '空闲', 262);
INSERT INTO `time_arrange` VALUES (3547, '16:00:00', '17:00:00', 8, '空闲', 262);
INSERT INTO `time_arrange` VALUES (3548, '17:00:00', '18:00:00', 9, '空闲', 262);
INSERT INTO `time_arrange` VALUES (3549, '18:00:00', '19:00:00', 10, '空闲', 262);
INSERT INTO `time_arrange` VALUES (3550, '19:00:00', '20:00:00', 11, '空闲', 262);
INSERT INTO `time_arrange` VALUES (3551, '20:00:00', '21:00:00', 12, '空闲', 262);
INSERT INTO `time_arrange` VALUES (3552, '08:00:00', '09:00:00', 0, '空闲', 263);
INSERT INTO `time_arrange` VALUES (3553, '09:00:00', '10:00:00', 1, '空闲', 263);
INSERT INTO `time_arrange` VALUES (3554, '10:00:00', '11:00:00', 2, '空闲', 263);
INSERT INTO `time_arrange` VALUES (3555, '11:00:00', '12:00:00', 3, '空闲', 263);
INSERT INTO `time_arrange` VALUES (3556, '12:00:00', '13:00:00', 4, '空闲', 263);
INSERT INTO `time_arrange` VALUES (3557, '13:00:00', '14:00:00', 5, '空闲', 263);
INSERT INTO `time_arrange` VALUES (3558, '14:00:00', '15:00:00', 6, '预约中', 263);
INSERT INTO `time_arrange` VALUES (3559, '15:00:00', '16:00:00', 7, '预约中', 263);
INSERT INTO `time_arrange` VALUES (3560, '16:00:00', '17:00:00', 8, '空闲', 263);
INSERT INTO `time_arrange` VALUES (3561, '17:00:00', '18:00:00', 9, '空闲', 263);
INSERT INTO `time_arrange` VALUES (3562, '18:00:00', '19:00:00', 10, '空闲', 263);
INSERT INTO `time_arrange` VALUES (3563, '19:00:00', '20:00:00', 11, '空闲', 263);
INSERT INTO `time_arrange` VALUES (3564, '20:00:00', '21:00:00', 12, '空闲', 263);
INSERT INTO `time_arrange` VALUES (3565, '08:00:00', '09:00:00', 0, '空闲', 264);
INSERT INTO `time_arrange` VALUES (3566, '09:00:00', '10:00:00', 1, '空闲', 264);
INSERT INTO `time_arrange` VALUES (3567, '10:00:00', '11:00:00', 2, '空闲', 264);
INSERT INTO `time_arrange` VALUES (3568, '11:00:00', '12:00:00', 3, '空闲', 264);
INSERT INTO `time_arrange` VALUES (3569, '12:00:00', '13:00:00', 4, '空闲', 264);
INSERT INTO `time_arrange` VALUES (3570, '13:00:00', '14:00:00', 5, '空闲', 264);
INSERT INTO `time_arrange` VALUES (3571, '14:00:00', '15:00:00', 6, '空闲', 264);
INSERT INTO `time_arrange` VALUES (3572, '15:00:00', '16:00:00', 7, '空闲', 264);
INSERT INTO `time_arrange` VALUES (3573, '16:00:00', '17:00:00', 8, '空闲', 264);
INSERT INTO `time_arrange` VALUES (3574, '17:00:00', '18:00:00', 9, '空闲', 264);
INSERT INTO `time_arrange` VALUES (3575, '18:00:00', '19:00:00', 10, '空闲', 264);
INSERT INTO `time_arrange` VALUES (3576, '19:00:00', '20:00:00', 11, '空闲', 264);
INSERT INTO `time_arrange` VALUES (3577, '20:00:00', '21:00:00', 12, '空闲', 264);
INSERT INTO `time_arrange` VALUES (3578, '08:00:00', '09:00:00', 0, '空闲', 265);
INSERT INTO `time_arrange` VALUES (3579, '09:00:00', '10:00:00', 1, '空闲', 265);
INSERT INTO `time_arrange` VALUES (3580, '10:00:00', '11:00:00', 2, '空闲', 265);
INSERT INTO `time_arrange` VALUES (3581, '11:00:00', '12:00:00', 3, '空闲', 265);
INSERT INTO `time_arrange` VALUES (3582, '12:00:00', '13:00:00', 4, '空闲', 265);
INSERT INTO `time_arrange` VALUES (3583, '13:00:00', '14:00:00', 5, '空闲', 265);
INSERT INTO `time_arrange` VALUES (3584, '14:00:00', '15:00:00', 6, '空闲', 265);
INSERT INTO `time_arrange` VALUES (3585, '15:00:00', '16:00:00', 7, '空闲', 265);
INSERT INTO `time_arrange` VALUES (3586, '16:00:00', '17:00:00', 8, '空闲', 265);
INSERT INTO `time_arrange` VALUES (3587, '17:00:00', '18:00:00', 9, '空闲', 265);
INSERT INTO `time_arrange` VALUES (3588, '18:00:00', '19:00:00', 10, '空闲', 265);
INSERT INTO `time_arrange` VALUES (3589, '19:00:00', '20:00:00', 11, '空闲', 265);
INSERT INTO `time_arrange` VALUES (3590, '20:00:00', '21:00:00', 12, '空闲', 265);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '密码',
  `role_id` int NOT NULL COMMENT '用户类型',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `UserRole_fk`(`role_id` ASC) USING BTREE,
  INDEX `name__index`(`name` ASC) USING BTREE,
  CONSTRAINT `UserRole_fk` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'Morty', '4QrcOUm6Wau+VuBX8g+IPg==', 1);
INSERT INTO `user` VALUES (15, 'moyu', '4QrcOUm6Wau+VuBX8g+IPg==', 6);

-- ----------------------------
-- Table structure for userinfo
-- ----------------------------
DROP TABLE IF EXISTS `userinfo`;
CREATE TABLE `userinfo`  (
  `id` char(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '学工号',
  `uid` int NULL DEFAULT NULL COMMENT '用户id',
  `uname` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `truename` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `sex` char(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `phone` char(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `idCard` char(18) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `birthday` timestamp NULL DEFAULT NULL,
  `class` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `UserInfo_name_fk`(`uname` ASC) USING BTREE,
  INDEX `userInfo_FK`(`uid` ASC) USING BTREE,
  CONSTRAINT `userInfo_FK` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `UserInfo_name_fk` FOREIGN KEY (`uname`) REFERENCES `user` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `UserInfo_chk_1` CHECK (`sex` in (_utf8mb3'男',_utf8mb3'女'))
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '用户联系方式' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of userinfo
-- ----------------------------
INSERT INTO `userinfo` VALUES ('202111701452', 1, 'Morty', '', '男', '12345678901', '123456789012345678', NULL, '');

-- ----------------------------
-- View structure for announcement_type
-- ----------------------------
DROP VIEW IF EXISTS `announcement_type`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `announcement_type` AS select distinct `announcement`.`type` AS `type` from `announcement`;

-- ----------------------------
-- View structure for competition_field_time
-- ----------------------------
DROP VIEW IF EXISTS `competition_field_time`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `competition_field_time` AS select `competition_field`.`id` AS `id`,`competition_field`.`cid` AS `cid`,`competition_field`.`fcId` AS `fcId`,`competition_field`.`uid` AS `uid`,`competition_field`.`introduction` AS `introduction`,`competition_field`.`time` AS `time`,`fd`.`fid` AS `fid`,timestamp(`fd`.`date`,`ta`.`start_time`) AS `startTime`,timestamp(`fd`.`date`,`ta`.`end_time`) AS `endTime` from (((`competition_field` left join `order_item` `oi` on((`competition_field`.`fcId` = `oi`.`fcid`))) left join `time_arrange` `ta` on((`oi`.`time_id` = `ta`.`time_id`))) left join `field_date` `fd` on((`ta`.`fdid` = `fd`.`id`)));

-- ----------------------------
-- View structure for competition_time
-- ----------------------------
DROP VIEW IF EXISTS `competition_time`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `competition_time` AS select `competition`.`id` AS `id`,`competition`.`uid` AS `uid`,`competition`.`name` AS `name`,`competition`.`competition_time` AS `competition_time`,`competition`.`event_length` AS `event_length`,`competition`.`introduction` AS `introduction`,`competition`.`money` AS `money`,`competition`.`create_time` AS `create_time`,(`competition`.`competition_time` + interval 60 minute) AS `competition_end_time` from `competition`;

-- ----------------------------
-- View structure for new_announcement
-- ----------------------------
DROP VIEW IF EXISTS `new_announcement`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `new_announcement` AS select `announcement`.`aid` AS `aid`,`announcement`.`uid` AS `uid`,`announcement`.`type` AS `type`,`announcement`.`content` AS `content`,`announcement`.`createDate` AS `createDate`,`announcement`.`updateDate` AS `updateDate` from ((select max(`announcement`.`aid`) AS `base_id`,max(`announcement`.`createDate`) AS `createtime` from `announcement` group by `announcement`.`type`) `max_tmp` left join `announcement` on(((`max_tmp`.`base_id` = `announcement`.`aid`) and (`max_tmp`.`createtime` = `announcement`.`createDate`)))) order by `announcement`.`createDate`,`announcement`.`updateDate`,`announcement`.`aid`;

-- ----------------------------
-- View structure for referee_announcements
-- ----------------------------
DROP VIEW IF EXISTS `referee_announcements`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `referee_announcements` AS select `competition_field`.`cid` AS `cid`,`competition_field`.`id` AS `cfId`,`competition_field`.`fcId` AS `fcId`,`competition_field`.`uid` AS `uid`,`ui`.`truename` AS `judgment`,`competition`.`name` AS `competition_name`,`fc`.`name` AS `field_name`,`competition_field`.`introduction` AS `introduction`,`competition`.`competition_time` AS `starttime`,(`competition`.`competition_time` + interval 60 minute) AS `endtime` from (((`competition_field` left join `competition` on((`competition_field`.`cid` = `competition`.`id`))) left join `userinfo` `ui` on((`competition_field`.`uid` = `ui`.`uid`))) left join `field_check` `fc` on((`competition_field`.`fcId` = `fc`.`id`))) where ((`competition_field`.`uid` is not null) and ((`competition`.`competition_time` + interval 60 minute) >= now())) order by `competition_field`.`cid`,`competition_field`.`fcId`;

-- ----------------------------
-- View structure for role_permissions
-- ----------------------------
DROP VIEW IF EXISTS `role_permissions`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `role_permissions` AS select `r`.`id` AS `id`,`r`.`role` AS `role`,group_concat(`permission`.`pname` separator ',') AS `permissions`,count(`permission`.`pname`) AS `cnt` from (`permission` join `role` `r` on(((`permission`.`pid` & `r`.`permissions`) = `permission`.`pid`))) group by `r`.`id`;

-- ----------------------------
-- View structure for user_info
-- ----------------------------
DROP VIEW IF EXISTS `user_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `user_info` AS select `userinfo`.`id` AS `id`,`userinfo`.`uid` AS `uid`,`userinfo`.`uname` AS `uname`,`userinfo`.`truename` AS `truename`,`userinfo`.`sex` AS `sex`,`userinfo`.`phone` AS `phone`,`userinfo`.`idCard` AS `idCard`,`userinfo`.`birthday` AS `birthday`,`userinfo`.`class` AS `class`,`user`.`password` AS `password`,`user`.`role_id` AS `role_id` from (`user` join `userinfo`) where (`user`.`id` = `userinfo`.`uid`);

-- ----------------------------
-- View structure for user_role_permissions
-- ----------------------------
DROP VIEW IF EXISTS `user_role_permissions`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `user_role_permissions` AS select `user`.`id` AS `uid`,`user`.`name` AS `name`,`rp`.`id` AS `rid`,`rp`.`permissions` AS `permissions`,`rp`.`cnt` AS `cnt` from (`user` join (select `r`.`id` AS `id`,`r`.`role` AS `role`,group_concat(`permission`.`pname` separator ',') AS `permissions`,count(`permission`.`pname`) AS `cnt` from (`permission` join `role` `r` on(((`permission`.`pid` & `r`.`permissions`) = `permission`.`pid`))) group by `r`.`id`) `rp` on((`user`.`role_id` = `rp`.`id`)));

SET FOREIGN_KEY_CHECKS = 1;
