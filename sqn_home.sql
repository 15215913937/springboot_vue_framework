/*
 Navicat Premium Data Transfer

 Source Server         : test
 Source Server Type    : MySQL
 Source Server Version : 80012
 Source Host           : localhost:3306
 Source Schema         : sqn_home

 Target Server Type    : MySQL
 Target Server Version : 80012
 File Encoding         : 65001

 Date: 25/07/2022 17:52:52
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
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '作者',
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '类别',
  `version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '版本',
  `publishing_house` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '出版社',
  `purchaser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '购买人',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '价格',
  `buy_date` date NULL DEFAULT NULL COMMENT '购书日期',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '封面地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 40 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '图书信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (1, '从0到1搭建自动化测试框架', '蔡超', '计算机/软件测试', NULL, '机械工业出版社', '沈奇男', 63.96, '2022-02-07', '从架构设计、工作原理、设计原则、代码实现、工程实践等维度，深入分析如何从0到1搭建自动化测试框架。\n', 'http://localhost:9090/files/5b1381331f414144b56007e7535e55dc');
INSERT INTO `book` VALUES (31, '不战之困', '戴旭', '军事理论', NULL, '武汉出版社', '沈建祥', 45.00, '2012-04-23', '一部影响中国军队30年变革的思想库，\n50部改变中外军事格局的军事文件首度曝光。', '');
INSERT INTO `book` VALUES (32, '全栈自动化测试实战', '卢家涛', '信息技术', '2020年3月第1版', '电子工业出版社', '沈奇男', 79.00, '2021-10-31', '基于TestNG、HttpClient、Selenium和Appium', '');
INSERT INTO `book` VALUES (33, '金融的价值', '黄益平', '金融理论', '2021年12月第1版', '中信出版集团', '沈建祥', 69.00, '2022-07-22', '与宏观分析趋势，于底层掌握逻辑', '');
INSERT INTO `book` VALUES (34, '李东生 向生而生', '李海东', '企业家研究丛书', NULL, '中国友谊出版公司', '沈建祥', 48.00, '2022-07-22', '经历痛苦的蜕变，才能如“鹰”般重生。', '');

-- ----------------------------
-- Table structure for dict
-- ----------------------------
DROP TABLE IF EXISTS `dict`;
CREATE TABLE `dict`  (
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内容',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '类型'
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dict
-- ----------------------------
INSERT INTO `dict` VALUES ('home', 'PieChart', 'icon');
INSERT INTO `dict` VALUES ('events', 'Ship', 'icon');
INSERT INTO `dict` VALUES ('book', 'Notebook', 'icon');
INSERT INTO `dict` VALUES ('file', 'Folder', 'icon');
INSERT INTO `dict` VALUES ('role', 'UserFilled', 'icon');
INSERT INTO `dict` VALUES ('menu', 'List', 'icon');
INSERT INTO `dict` VALUES ('system', 'Setting', 'icon');
INSERT INTO `dict` VALUES ('affair', 'SetUp', 'icon');
INSERT INTO `dict` VALUES ('testIcon', 'Aim', 'icon');

-- ----------------------------
-- Table structure for events
-- ----------------------------
DROP TABLE IF EXISTS `events`;
CREATE TABLE `events`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内容',
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '编者',
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of events
-- ----------------------------
INSERT INTO `events` VALUES (12, '我要结婚啦', '<p>天气好，适合结婚</p>', '沈奇亚', '2022-07-03 16:38:37');
INSERT INTO `events` VALUES (16, '我师兄猪猪', '<p>我是大猪猪我是大猪猪我是大猪猪我是大猪猪我是大猪猪我是大猪猪我是大猪猪我是大猪猪</p>', '沈奇亚', '2022-07-03 16:39:24');
INSERT INTO `events` VALUES (21, '我附带图片', '<p><img src=\"http://localhost:9090/files/49b091e6eb034642b9c3866273b0e414\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/a7f5ba8e7e1f4c3b8d794df1cc7d0e3b\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', '沈奇男', '2022-07-03 22:08:57');
INSERT INTO `events` VALUES (22, '我是妈妈', '<p>我抱孙子啦，<span style=\"color: var(--w-e-textarea-color); font-size: var(--el-dialog-content-font-size);\">😁</span></p>', '杜梅军', '2022-07-03 23:19:58');
INSERT INTO `events` VALUES (24, '老沈爱我的表现1', '<p>老沈昨天掐了我三下，说是爱我的表现<span style=\"color: var(--w-e-textarea-color); font-size: var(--el-dialog-content-font-size);\">😤</span></p>', '沈奇男', '2022-07-16 01:40:10');
INSERT INTO `events` VALUES (25, '老沈新语1', '<p>老沈说：“有女人的地方就有江湖”<span style=\"color: var(--w-e-textarea-color); font-size: var(--el-dialog-content-font-size);\">👏</span></p>', '沈奇男', '2022-07-20 23:46:03');

-- ----------------------------
-- Table structure for files
-- ----------------------------
DROP TABLE IF EXISTS `files`;
CREATE TABLE `files`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件名称',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件类型',
  `size` bigint(20) NULL DEFAULT NULL COMMENT '文件大小',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '下载链接',
  `md5` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件MD5',
  `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除（假删除）：‘0’表示未删除',
  `enable` tinyint(1) NULL DEFAULT 1 COMMENT '是否禁用：‘1’表示可用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of files
-- ----------------------------
INSERT INTO `files` VALUES (34, '1.mp4', 'mp4', 664, 'http://localhost:9090/files/test/8dd16f53ed9a497ea9dae37b399e6936.mp4', '4fc33dbb0d7d924f2d056033cbb51bbb', 0, 1);
INSERT INTO `files` VALUES (33, '床垫.jpg', 'jpg', 39, 'http://localhost:9090/files/test/0447a6d1fb914ec4ada3d5937ce3683d.jpg', 'b45baff3600e5caaeceadce9b720dc1a', 0, 1);

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '菜单名称',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '路径',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图标',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '描述',
  `pid` int(11) NULL DEFAULT NULL COMMENT '父级id',
  `page_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '页面路径',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (2, '全局概览', '/home', 'PieChart', '', NULL, 'Home');
INSERT INTO `menu` VALUES (5, '事务管理', NULL, 'SetUp', NULL, NULL, NULL);
INSERT INTO `menu` VALUES (6, '系统管理', NULL, 'Setting', NULL, NULL, NULL);
INSERT INTO `menu` VALUES (7, '书籍管理', '/book', 'Notebook', NULL, 5, 'Book');
INSERT INTO `menu` VALUES (8, '事件论坛', '/events', 'Ship', NULL, 5, 'Events');
INSERT INTO `menu` VALUES (9, '文件管理', '/file', 'Folder', NULL, 5, 'File');
INSERT INTO `menu` VALUES (10, '成员管理', '/user', 'Avatar', NULL, 6, 'User');
INSERT INTO `menu` VALUES (11, '角色管理', '/role', 'UserFilled', NULL, 6, 'Role');
INSERT INTO `menu` VALUES (12, '菜单管理', '/menu', 'List', NULL, 6, 'Menu');
INSERT INTO `menu` VALUES (14, '测试菜单', '/testPage', 'Aim', '为了测试', NULL, 'TestPage');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '描述',
  `flag` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '唯一标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '管理员', '拥有系统最高操作权限', 'ROLE_ADMIN');
INSERT INTO `role` VALUES (3, '普通成员', '一般成员，可操作事务管理内容', 'ROLE_USER');
INSERT INTO `role` VALUES (4, '测试员', '对系统进行测试', 'ROLE_TESTER');

-- ----------------------------
-- Table structure for role_menu
-- ----------------------------
DROP TABLE IF EXISTS `role_menu`;
CREATE TABLE `role_menu`  (
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `menu_id` int(11) NOT NULL COMMENT '菜单id',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of role_menu
-- ----------------------------
INSERT INTO `role_menu` VALUES (1, 2);
INSERT INTO `role_menu` VALUES (1, 5);
INSERT INTO `role_menu` VALUES (1, 6);
INSERT INTO `role_menu` VALUES (1, 7);
INSERT INTO `role_menu` VALUES (1, 8);
INSERT INTO `role_menu` VALUES (1, 9);
INSERT INTO `role_menu` VALUES (1, 10);
INSERT INTO `role_menu` VALUES (1, 11);
INSERT INTO `role_menu` VALUES (1, 12);
INSERT INTO `role_menu` VALUES (3, 2);
INSERT INTO `role_menu` VALUES (3, 5);
INSERT INTO `role_menu` VALUES (3, 7);
INSERT INTO `role_menu` VALUES (3, 8);
INSERT INTO `role_menu` VALUES (3, 9);
INSERT INTO `role_menu` VALUES (4, 2);
INSERT INTO `role_menu` VALUES (4, 5);
INSERT INTO `role_menu` VALUES (4, 6);
INSERT INTO `role_menu` VALUES (4, 7);
INSERT INTO `role_menu` VALUES (4, 8);
INSERT INTO `role_menu` VALUES (4, 9);
INSERT INTO `role_menu` VALUES (4, 10);
INSERT INTO `role_menu` VALUES (4, 11);
INSERT INTO `role_menu` VALUES (4, 12);
INSERT INTO `role_menu` VALUES (4, 14);
INSERT INTO `role_menu` VALUES (4, 15);

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
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色：1管理员，2普通成员',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (18, 'sqn', '$2a$10$H2J9WNSf23tlfIp04m7H/eRDLq2nrDKs4.E7Z/wKTFiILMTlNrYMG', '沈奇男', '1997-10-01', '男', 'http://localhost:9090/files/test/d8480d3df4a14449a6a10e3dc1d38565.jpg', NULL, 'ROLE_ADMIN');
INSERT INTO `user` VALUES (20, 'sqy', '$2a$10$8uvEzLdjK73MGIVoSpquCueIjMrsFCNTgItRWyhfTcXSfl1et2y8C', '沈奇亚', '1997-03-07', '女', 'http://localhost:9090/files/test/d8480d3df4a14449a6a10e3dc1d38565.jpg', NULL, 'ROLE_ADMIN');
INSERT INTO `user` VALUES (22, 'dumeijun', '$2a$10$nzLEq3iPuHGJEeaSw28e4OGnMBZJkdg0gUo1EqGYXcGFUdUO8c4JC', '杜梅军', '1971-07-14', '女', NULL, NULL, 'ROLE_USER');
INSERT INTO `user` VALUES (23, 'sjx', '$2a$10$4C.fY6XUAZx2rHQupHkXGeJY8B.GeeScO1a1oycRN1XD1zD12z45a', '沈建祥', '1974-03-22', '男', NULL, NULL, 'ROLE_USER');
INSERT INTO `user` VALUES (24, 'shenjianying', '$2a$10$rndZhSh9o4LiPVtqL6aEcumUNJ86teXZ8mCEZVo0DEd8OMa0QOVlK', '沈建英', NULL, '女', NULL, NULL, 'ROLE_USER');
INSERT INTO `user` VALUES (25, 'shenronger', '$2a$10$oFn4XA6mjkqxV4hgNmRBKOtDB1Tb58LuVws3ECnhKuW3Asc8w23Py', '沈蓉儿', '2000-11-19', '女', NULL, NULL, 'ROLE_USER');
INSERT INTO `user` VALUES (26, 'bianzhenyu', '$2a$10$/K9F7KQ3jrakwLHDmkyjc.dsjyUii/g/yrIu9xN5xYe6Q9r0paob.', '边震宇', '2008-08-30', '男', NULL, NULL, 'ROLE_USER');
INSERT INTO `user` VALUES (31, 'ts', '$2a$10$rfoalwpbxX82692CWs0EROMg8kD6VsHz63WtFcUa2hYnRaUpya14S', '小测试', '2022-07-14', '男', 'http://localhost:9090/files/test/073039f7053449eaafaba2bd01149911.jpeg', '2022-07-19 01:35:13', 'ROLE_TESTER');
INSERT INTO `user` VALUES (38, '123', '$2a$10$UygtUzxaOGJy5uXO4T7P2..jSqF3Emj9D4SRqVDtmzZQRkxIwjjbS', '123', NULL, NULL, NULL, '2022-07-25 17:14:51', 'ROLE_USER');
INSERT INTO `user` VALUES (33, 'admin', '$2a$10$0RZH6X/xAuRS2jHzBwEnqemaSfDPu8l7BcHc/q9xXlkv0gJy1obo6', 'admin', NULL, NULL, NULL, '2022-07-25 11:55:55', 'ROLE_ADMIN');

SET FOREIGN_KEY_CHECKS = 1;
