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

 Date: 05/07/2022 01:08:03
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '图书ID',
  `bookname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '书名',
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '作者',
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '类别',
  `version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '版本',
  `publishing_house` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '出版社',
  `purchaser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '购买人',
  `price` decimal(10, 2) NOT NULL COMMENT '价格',
  `buy_date` date NULL DEFAULT NULL COMMENT '购书日期',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '封面地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '图书信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (1, '从0到1搭建自动化测试框架', '蔡超', '计算机/软件测试', NULL, '机械工业出版社', '沈奇男', 63.96, '2022-02-07', NULL, 'http://localhost:9090/files/5193c07851f74969a23b414bd642601d');
INSERT INTO `book` VALUES (18, '123', '123', '123', '123', '123', '杜梅军', 12.00, '2022-07-05', NULL, NULL);
INSERT INTO `book` VALUES (19, 'qwe', 'wqe', 'qwe', 'wqe', 'qew', '沈奇男', 123.00, '2022-07-05', NULL, NULL);

-- ----------------------------
-- Table structure for events
-- ----------------------------
DROP TABLE IF EXISTS `events`;
CREATE TABLE `events`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内容',
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '编者',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of events
-- ----------------------------
INSERT INTO `events` VALUES (12, '我要结婚啦', '<p>天气好，适合结婚</p>', '沈奇亚', '2022-07-03 16:38:37');
INSERT INTO `events` VALUES (18, '21', '<p>123</p>', '沈奇男', '2022-07-03 16:41:56');
INSERT INTO `events` VALUES (16, '我师兄猪猪', '<p>我是大猪猪我是大猪猪我是大猪猪我是大猪猪我是大猪猪我是大猪猪我是大猪猪我是大猪猪</p>', '沈奇亚', '2022-07-03 16:39:24');
INSERT INTO `events` VALUES (17, 'qweeqe', '<p>qeqwew433214</p>', '沈奇亚', '2022-07-03 16:40:52');
INSERT INTO `events` VALUES (19, '1234', '<p>12313244132</p>', '沈奇男', '2022-07-03 16:42:06');
INSERT INTO `events` VALUES (20, 'qweqwe', '<p>123132123</p>', '沈奇男', '2022-07-03 16:53:21');
INSERT INTO `events` VALUES (21, '我附带图片', '<p><img src=\"http://localhost:9090/files/49b091e6eb034642b9c3866273b0e414\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/a7f5ba8e7e1f4c3b8d794df1cc7d0e3b\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', '沈奇男', '2022-07-03 22:08:57');
INSERT INTO `events` VALUES (22, '我是妈妈', '<p>我抱孙子啦，<span style=\"color: var(--w-e-textarea-color); font-size: var(--el-dialog-content-font-size);\">😁</span></p>', '杜梅军', '2022-07-03 23:19:58');

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  `path` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '资源路径',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `icon` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图标',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES (1, 'Home', '/home', '主页', 'el-icon-house');
INSERT INTO `permission` VALUES (2, 'Book', '/book', '书籍管理', 'el-icon-files');
INSERT INTO `permission` VALUES (5, 'Events', '/events', '事件管理', 'el-icon-news');
INSERT INTO `permission` VALUES (9, 'User', '/user', '用户管理', 'el-icon-user');
INSERT INTO `permission` VALUES (13, 'Person', '/person', '个人信息', '');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '性别',
  `avater` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `role` int(11) NULL DEFAULT NULL COMMENT '角色：1管理员，2普通成员',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (18, 'sqn', '123', '沈奇男', '1997-10-01', '男', NULL, NULL, 1);
INSERT INTO `user` VALUES (20, 'sqy', '123', '沈奇亚', '1997-03-07', '女', NULL, NULL, 1);
INSERT INTO `user` VALUES (22, 'dumeijun', '123456', '杜梅军', '1971-07-14', '女', NULL, NULL, 2);
INSERT INTO `user` VALUES (23, 'shenjianxiang', '123456', '沈建祥', '1974-03-22', '男', NULL, NULL, 2);
INSERT INTO `user` VALUES (24, 'shenjianying', '123456', '沈建英', NULL, '女', NULL, NULL, 2);
INSERT INTO `user` VALUES (25, 'shenronger', '123456', '沈蓉儿', '2000-11-19', '女', NULL, NULL, 2);
INSERT INTO `user` VALUES (26, 'bianzhenyu', '123456', '边震宇', '2008-08-30', '男', NULL, NULL, 2);

SET FOREIGN_KEY_CHECKS = 1;
