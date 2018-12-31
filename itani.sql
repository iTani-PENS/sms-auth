/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MariaDB
 Source Server Version : 100311
 Source Host           : localhost:3306
 Source Schema         : itani

 Target Server Type    : MariaDB
 Target Server Version : 100311
 File Encoding         : 65001

 Date: 31/12/2018 16:49:38
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bumdes
-- ----------------------------
DROP TABLE IF EXISTS `bumdes`;
CREATE TABLE `bumdes`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(64) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nomor_telpon` varchar(14) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `foto` blob NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bumdes
-- ----------------------------
INSERT INTO `bumdes` VALUES (1, 'aji laksono', '6282120402431', NULL);

-- ----------------------------
-- Table structure for bumdes_session
-- ----------------------------
DROP TABLE IF EXISTS `bumdes_session`;
CREATE TABLE `bumdes_session`  (
  `id_bumdes` int(11) NOT NULL,
  `code` varchar(6) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `code_verify` varchar(6) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `date` date NULL DEFAULT NULL,
  PRIMARY KEY (`id_bumdes`) USING BTREE,
  CONSTRAINT `auth_bumdes` FOREIGN KEY (`id_bumdes`) REFERENCES `bumdes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bumdes_verify
-- ----------------------------
DROP TABLE IF EXISTS `bumdes_verify`;
CREATE TABLE `bumdes_verify`  (
  `id_bumdes` int(11) NOT NULL,
  `code` varchar(6) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` enum('unverified','verified') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `date` datetime(0) NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_bumdes`) USING BTREE,
  CONSTRAINT `verify_bumdes` FOREIGN KEY (`id_bumdes`) REFERENCES `bumdes` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bumdes_verify
-- ----------------------------
INSERT INTO `bumdes_verify` VALUES (1, '432454', 'verified', '2018-12-31 16:47:06');

SET FOREIGN_KEY_CHECKS = 1;
