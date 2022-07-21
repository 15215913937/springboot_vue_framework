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

 Date: 22/07/2022 01:56:08
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
) ENGINE = MyISAM AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '图书信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (1, '从0到1搭建自动化测试框架', '蔡超', '计算机/软件测试', NULL, '机械工业出版社', '沈奇男', 63.96, '2022-02-07', NULL, 'http://localhost:9090/files/5193c07851f74969a23b414bd642601d');
INSERT INTO `book` VALUES (30, '134', '143', '12341', '234143', '21243', '4312', 3142.00, '2022-03-09', NULL, NULL);
INSERT INTO `book` VALUES (29, '123', '123', '123', '123', '1231', '32', 132.00, '2022-07-17', NULL, NULL);
INSERT INTO `book` VALUES (28, '123', '132', '123', '123', '12312', '3', 213.00, '2022-05-18', NULL, NULL);

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
) ENGINE = MyISAM AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of events
-- ----------------------------
INSERT INTO `events` VALUES (12, '我要结婚啦', '<p>天气好，适合结婚</p>', '沈奇亚', '2022-07-03 16:38:37');
INSERT INTO `events` VALUES (18, '21', '<p>123</p>', '沈奇男', '2022-07-03 16:41:56');
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
) ENGINE = MyISAM AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of files
-- ----------------------------
INSERT INTO `files` VALUES (28, '小手4.jpg', 'jpg', 252, 'http://localhost:9090/files/test/d2e79b368ea94da3b5b42a3bffc93624.jpg', 'ba73e12e42c99c33a0bc9f8d0d1a07fa', 0, 1);
INSERT INTO `files` VALUES (27, '小手4.jpg', 'jpg', 252, 'http://localhost:9090/files/test/d2e79b368ea94da3b5b42a3bffc93624.jpg', 'ba73e12e42c99c33a0bc9f8d0d1a07fa', 0, 1);
INSERT INTO `files` VALUES (29, 'tx2.jpeg', 'jpeg', 61, 'http://localhost:9090/files/test/0e77b99fe15a4912a8b2cefb6381b1dc.jpeg', 'baef13857388301f8e784ffeee230550', 0, 1);
INSERT INTO `files` VALUES (30, 'tx1.jpeg', 'jpeg', 83, 'http://localhost:9090/files/test/073039f7053449eaafaba2bd01149911.jpeg', '3e647ca495ddad8d3c52f63eef8bec50', 0, 1);

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
INSERT INTO `menu` VALUES (14, '测试菜单', '/testPage', 'PieChart', '为了测试', NULL, 'TestPage');

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
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

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
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色：1管理员，2普通成员',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (18, 'sqn', '123', '沈奇男', '1997-10-01', '男', 'http://localhost:9090/files/test/0e77b99fe15a4912a8b2cefb6381b1dc.jpeg', NULL, 'ROLE_ADMIN');
INSERT INTO `user` VALUES (20, 'sqy', '123', '沈奇亚', '1997-03-07', '女', NULL, NULL, 'ROLE_ADMIN');
INSERT INTO `user` VALUES (22, 'dumeijun', '123', '杜梅军', '1971-07-14', '女', NULL, NULL, 'ROLE_USER');
INSERT INTO `user` VALUES (23, 'shenjianxiang', '123456', '沈建祥', '1974-03-22', '男', NULL, NULL, 'ROLE_USER');
INSERT INTO `user` VALUES (24, 'shenjianying', '123456', '沈建英', NULL, '女', NULL, NULL, 'ROLE_USER');
INSERT INTO `user` VALUES (25, 'shenronger', '123456', '沈蓉儿', '2000-11-19', '女', NULL, NULL, 'ROLE_USER');
INSERT INTO `user` VALUES (26, 'bianzhenyu', '123456', '边震宇', '2008-08-30', '男', NULL, NULL, 'ROLE_USER');
INSERT INTO `user` VALUES (31, 'ts', '123', '小测试', '2022-07-14', '男', 'http://localhost:9090/files/test/073039f7053449eaafaba2bd01149911.jpeg', '2022-07-19 01:35:13', 'ROLE_TESTER');

SET FOREIGN_KEY_CHECKS = 1;
