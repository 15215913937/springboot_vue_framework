/*
 Navicat Premium Data Transfer

 Source Server         : mydata
 Source Server Type    : MySQL
 Source Server Version : 80012
 Source Host           : localhost:3306
 Source Schema         : springboot-vue

 Target Server Type    : MySQL
 Target Server Version : 80012
 File Encoding         : 65001

 Date: 26/06/2022 00:12:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `nick_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '昵称',
  `age` int(11) NULL DEFAULT NULL COMMENT '年龄',
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '性别',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (2, '沈奇男', '123456', 'sqn', 23, '男', '浙江省绍兴市柯桥区柯桥街道滨河花园1幢3单元506室');
INSERT INTO `user` VALUES (3, '沈大奇1', '123456', 'dq', 12, '男', '浙江省温州市');
INSERT INTO `user` VALUES (4, '沈小奇2', '123456', '32', 19, '女', '浙江省绍兴市稽东镇');
INSERT INTO `user` VALUES (10, '沈小奇3', '123456', '32', 19, '女', '浙江省绍兴市稽东镇');
INSERT INTO `user` VALUES (9, '沈小奇4', '123456', '32', 19, '女', '浙江省绍兴市稽东镇');
INSERT INTO `user` VALUES (8, '沈小奇5', '123456', '32', 19, '女', '浙江省绍兴市稽东镇');
INSERT INTO `user` VALUES (11, '沈小奇6', '123456', '32', 19, '女', '浙江省绍兴市稽东镇');
INSERT INTO `user` VALUES (12, '沈小奇7', '123456', '32', 19, '女', '浙江省绍兴市稽东镇');
INSERT INTO `user` VALUES (14, '沈小奇12', '123456', '32', 19, '女', '浙江省绍兴市稽东镇');
INSERT INTO `user` VALUES (15, '沈小奇123', '123456', '32', 19, '女', '浙江省绍兴市稽东镇');
INSERT INTO `user` VALUES (16, '沈小奇1234', '123456', '32', 19, '女', '浙江省绍兴市稽东镇');
INSERT INTO `user` VALUES (17, '沈小奇12345', '123456', '32', 19, '女', '浙江省绍兴市稽东镇');

SET FOREIGN_KEY_CHECKS = 1;
