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

 Date: 03/01/2024 23:37:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for activity
-- ----------------------------
DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '活动id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '活动名称',
  `unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '计量单位',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图标',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of activity
-- ----------------------------
INSERT INTO `activity` VALUES (1, '瑜伽', '分钟', NULL);
INSERT INTO `activity` VALUES (2, '乒乓球', '分钟', NULL);
INSERT INTO `activity` VALUES (3, '书法', '分钟', NULL);
INSERT INTO `activity` VALUES (4, '跳绳', '个', NULL);
INSERT INTO `activity` VALUES (5, '篮球', '分钟', NULL);
INSERT INTO `activity` VALUES (6, '羽毛球', '分钟', NULL);
INSERT INTO `activity` VALUES (7, '健身', '分钟', NULL);
INSERT INTO `activity` VALUES (8, '拳击', '分钟', NULL);
INSERT INTO `activity` VALUES (9, '游泳', '分钟', NULL);
INSERT INTO `activity` VALUES (10, '学习', '分钟', NULL);
INSERT INTO `activity` VALUES (20, '散步', NULL, NULL);
INSERT INTO `activity` VALUES (17, '跑步', NULL, NULL);
INSERT INTO `activity` VALUES (15, '跳舞', NULL, NULL);
INSERT INTO `activity` VALUES (16, '足球', NULL, NULL);
INSERT INTO `activity` VALUES (21, '开车', NULL, NULL);
INSERT INTO `activity` VALUES (23, '铁人三项', NULL, NULL);
INSERT INTO `activity` VALUES (24, '马拉松', NULL, NULL);

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '图书ID',
  `bookname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '书名',
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '作者',
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '类别',
  `version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '版本',
  `publishing_house` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '出版社',
  `uid` bigint(11) NULL DEFAULT NULL COMMENT '购买人',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '价格',
  `buy_date` date NULL DEFAULT NULL COMMENT '购书日期',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '封面地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 70 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '图书信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (1, '从0到1搭建自动化测试框架', '蔡超', '自动化技术、计算机技术', NULL, '机械工业出版社', 1, 63.96, '2022-02-07', '从架构设计、工作原理、设计原则、代码实现、工程实践等维度，深入分析如何从0到1搭建自动化测试框架。\n', 'http://localhost:9090/files/5193c07851f74969a23b414bd642601d');
INSERT INTO `book` VALUES (31, '不战之困', '戴旭', '军事', NULL, '武汉出版社', 23, 45.00, '2012-04-23', '一部影响中国军队30年变革的思想库，\n50部改变中外军事格局的军事文件首度曝光。', 'http://localhost:9090/files/4e8cc550907640fd9aecd5111ca0a30f');
INSERT INTO `book` VALUES (32, '全栈自动化测试实战', '卢家涛', '自动化技术、计算机技术', '2020年3月第1版', '电子工业出版社', 1, 79.00, '2021-10-31', '基于TestNG、HttpClient、Selenium和Appium', 'http://localhost:9090/files/851c041f164b4a269afb2ae535384344');
INSERT INTO `book` VALUES (33, '金融的价值', '黄益平', '经济', '2021年12月第1版', '中信出版集团', 23, 69.00, '2022-07-22', '与宏观分析趋势，于底层掌握逻辑', 'http://localhost:9090/files/36bac59e0cad4ba486b607f2c2e10606');
INSERT INTO `book` VALUES (34, '李东生 向生而生', '李海东', '综合性图书', NULL, '中国友谊出版公司', 23, 48.00, '2022-07-22', '经历痛苦的蜕变，才能如“鹰”般重生。', 'http://localhost:9090/files/1527646ef01140cdb33879e10321c591');
INSERT INTO `book` VALUES (59, '假如时间不存在？', '[意]卡尔罗·罗威利（Carlo Rovelli）', '科普/物理', '2013年5月北京第1版第1次印刷', '化学工业出版社', 23, 24.00, '2013-10-04', '--购书于秦皇岛。\n讲点颠覆常理的科学', 'http://localhost:9090/files/784e481472164d6183e47f3b30dc6703');
INSERT INTO `book` VALUES (60, '未来简史', '[以色列]尤瓦尔·赫拉利（Yuval Noah Harari））', '社会科学总论', '2017年2月第1版', '中信出版社', 23, 68.00, '2017-11-14', '--购书于阿拉善左旗。\nHome Deus A Brief History of Tomorrow\n从智人到智神', 'http://localhost:9090/files/0774edccebfd498e86debc789a06e3b0');
INSERT INTO `book` VALUES (61, '一本书读懂不良资产', '石佳华', '经济', NULL, '中国法制出版社', 23, 68.00, '2022-09-02', ' 多年从事银行信贷、不良资产收购与处置的页内专业人士带你揭开中国不良资产管理行业的神秘面纱', 'http://localhost:9090/files/a0da2e590694473ebd0182f3285e7287');
INSERT INTO `book` VALUES (65, '汉武帝和他的时代', '姜鹏', '历史、地理', '2022年3月第1版', '上海人民出版社、学林出版社', 23, 68.00, '2022-09-17', '回望中国历史上第一个狂飙突进的时代。\n感受风云际会中人物命运的跌宕起伏', 'http://localhost:9090/files/75f4673fab664f1da6ed0e980d2d6ce3');
INSERT INTO `book` VALUES (66, '商业模式全史', '[日]三谷宏治', '经济', '2016年1月第1版', '江苏凤凰文艺出版社', 23, 42.00, '2022-09-17', '以全球性眼光综合分析“大企业”盛衰兴废的力作。\n创业者、企业管理者、MBA课程学习者的好帮手。', 'http://localhost:9090/files/f39e96a9602b41a1b8f91629c56c5673');
INSERT INTO `book` VALUES (67, '决策与判断', '[美]斯科特·普劳斯（Scott Plous）', '综合性图书', '2020年3月第1版', '人民邮电出版社', 23, 88.00, '2022-09-17', NULL, 'http://localhost:9090/files/3ae625a900684293acef1477a9cd4057');
INSERT INTO `book` VALUES (68, 'Redis设计与实现', '黄健宏', '自动化技术、计算机技术', '2022年8月第1版第27次印刷', '机械工业出版社', 1, 42.00, '2022-10-20', '从源码角度解析Redis的架构设计、实现原理和工作机制，为高效使用Redis提供原理性指导', 'http://localhost:9090/files/e204bdd6e93e4f428476361879f3885c');

-- ----------------------------
-- Table structure for category_list
-- ----------------------------
DROP TABLE IF EXISTS `category_list`;
CREATE TABLE `category_list`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '书籍类别',
  `flag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '唯一标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 58 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '书籍类别字典' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category_list
-- ----------------------------
INSERT INTO `category_list` VALUES (34, '水利工程', 'TV');
INSERT INTO `category_list` VALUES (35, '交通运输', 'U');
INSERT INTO `category_list` VALUES (33, '建筑科学', 'TU');
INSERT INTO `category_list` VALUES (32, '轻工业、手工业', 'TS');
INSERT INTO `category_list` VALUES (31, '化学工业', 'TQ');
INSERT INTO `category_list` VALUES (29, '光线电电子学、电信技术', 'TN');
INSERT INTO `category_list` VALUES (28, '电工技术', 'TM');
INSERT INTO `category_list` VALUES (26, '能源与动力工程', 'TK');
INSERT INTO `category_list` VALUES (25, '武器工业', 'TJ');
INSERT INTO `category_list` VALUES (23, '金属学与金属工艺', 'TG');
INSERT INTO `category_list` VALUES (22, '冶金工业', 'TF');
INSERT INTO `category_list` VALUES (20, '矿业工程', 'TD');
INSERT INTO `category_list` VALUES (19, '一般工业技术', 'TB');
INSERT INTO `category_list` VALUES (17, '农业科学', 'S');
INSERT INTO `category_list` VALUES (16, '医药、卫生', 'R');
INSERT INTO `category_list` VALUES (14, '天文学、地球科学', 'P');
INSERT INTO `category_list` VALUES (13, '数理科学和化学', 'O');
INSERT INTO `category_list` VALUES (12, '自然科学总论', 'N');
INSERT INTO `category_list` VALUES (11, '历史、地理', 'K');
INSERT INTO `category_list` VALUES (9, '文学', 'I');
INSERT INTO `category_list` VALUES (8, '语言、文字', 'H');
INSERT INTO `category_list` VALUES (7, '文化科学、教育、体育', 'G');
INSERT INTO `category_list` VALUES (6, '经济', 'F');
INSERT INTO `category_list` VALUES (5, '军事', 'E');
INSERT INTO `category_list` VALUES (4, '政治、法律', 'D');
INSERT INTO `category_list` VALUES (3, '社会科学总论', 'C');
INSERT INTO `category_list` VALUES (2, '哲学、宗教', 'B');
INSERT INTO `category_list` VALUES (1, '哲学', 'A');
INSERT INTO `category_list` VALUES (30, '自动化技术、计算机技术', 'TP');
INSERT INTO `category_list` VALUES (27, '电子能技术', 'TL');
INSERT INTO `category_list` VALUES (24, '机械、仪表工业', 'TH');
INSERT INTO `category_list` VALUES (21, '石油、天然气工业', 'TE');
INSERT INTO `category_list` VALUES (18, '工业技术', 'T');
INSERT INTO `category_list` VALUES (15, '生物科学', 'Q');
INSERT INTO `category_list` VALUES (10, '艺术', 'J');
INSERT INTO `category_list` VALUES (36, '航空、航天', 'V');
INSERT INTO `category_list` VALUES (37, '环境科学、安全科学', 'X');
INSERT INTO `category_list` VALUES (38, '综合性图书', 'Z');
INSERT INTO `category_list` VALUES (57, '科普/物理', 'KW');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '评论id',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论内容',
  `user_id` bigint(11) NOT NULL COMMENT '评论人id',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `is_delete` tinyint(1) UNSIGNED ZEROFILL NOT NULL COMMENT '是否删除0：未删除；1：删除',
  `event_id` bigint(11) NULL DEFAULT NULL COMMENT '所属事件id',
  `parent_id` bigint(11) NULL DEFAULT NULL COMMENT '父评论id（被回复的评论）',
  `root_parent_id` bigint(11) NULL DEFAULT NULL COMMENT '根评论id（最顶级的评论）',
  `del_time` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 356 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (345, '狗屁！', 1, '2023-02-22 21:05:09', 0, 24, NULL, NULL, NULL);
INSERT INTO `comment` VALUES (346, '就是就是！', 42, '2023-02-22 21:05:40', 0, 24, 345, NULL, NULL);
INSERT INTO `comment` VALUES (349, '祝小奇亚写字水平日渐佳境(＾－＾)V', 1, '2023-02-24 21:29:31', 0, 44, NULL, NULL, NULL);
INSERT INTO `comment` VALUES (348, '嘻嘻嘻个屁', 22, '2023-02-22 21:07:34', 0, 28, NULL, NULL, NULL);
INSERT INTO `comment` VALUES (347, '很ok', 22, '2023-02-22 21:07:12', 0, 24, 345, NULL, NULL);
INSERT INTO `comment` VALUES (350, '你可真善良', 62, '2023-02-25 18:26:51', 0, 44, 349, NULL, NULL);
INSERT INTO `comment` VALUES (351, '真不错！', 62, '2023-02-25 18:27:19', 0, 44, NULL, NULL, NULL);
INSERT INTO `comment` VALUES (352, '阿巴阿巴', 62, '2023-03-17 15:33:03', 0, 48, NULL, NULL, NULL);
INSERT INTO `comment` VALUES (353, 'lala', 1, '2023-04-24 23:26:55', 1, 58, NULL, NULL, '2023-04-24 23:26:59');
INSERT INTO `comment` VALUES (354, '你要认真反思这种事情，做事要三思后行', 22, '2023-12-30 14:37:48', 0, 60, NULL, NULL, NULL);
INSERT INTO `comment` VALUES (355, '收到！', 1, '2023-12-30 14:38:36', 0, 60, 354, NULL, NULL);

-- ----------------------------
-- Table structure for consumer_details
-- ----------------------------
DROP TABLE IF EXISTS `consumer_details`;
CREATE TABLE `consumer_details`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `uid` bigint(11) NULL DEFAULT NULL COMMENT '用户ID',
  `cost` decimal(20, 2) NULL DEFAULT NULL COMMENT '金额',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '消费类型',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '消费类别',
  `createtime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 92 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '消费详情表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of consumer_details
-- ----------------------------
INSERT INTO `consumer_details` VALUES (2, 18, 300.00, '支出', '午饭', '理财', '2022-08-29 23:30:08');
INSERT INTO `consumer_details` VALUES (3, 18, 15.00, '收入', '午饭', '购物', '2022-08-29 23:30:11');
INSERT INTO `consumer_details` VALUES (13, 18, 2000.00, '收入', '午饭', '工资', '2022-08-31 14:53:50');
INSERT INTO `consumer_details` VALUES (14, 62, 123.00, '支出', '午饭', '转账', '2022-08-31 17:29:35');
INSERT INTO `consumer_details` VALUES (15, 62, 11.00, '支出', '午饭', '餐饮', '2022-08-31 17:30:11');
INSERT INTO `consumer_details` VALUES (16, 62, 33.00, '收入', '午饭', '服务', '2022-08-31 17:30:19');
INSERT INTO `consumer_details` VALUES (17, 62, 124.00, '支出', '午饭', '购物', '2022-08-31 17:30:26');
INSERT INTO `consumer_details` VALUES (18, 62, 1234.00, '支出', '午饭', '购物', '2022-08-31 17:30:41');
INSERT INTO `consumer_details` VALUES (29, 62, 123.00, '支出', '午饭', '服务', '2022-09-03 09:37:02');
INSERT INTO `consumer_details` VALUES (30, 62, 321.00, '支出', '午饭', '服饰', '2022-09-03 09:37:06');
INSERT INTO `consumer_details` VALUES (26, 62, 2131.00, '支出', '午饭', '餐饮', '2022-09-03 09:31:29');
INSERT INTO `consumer_details` VALUES (28, 62, 213.00, '收入', '午饭', '购物', '2022-09-03 09:36:57');
INSERT INTO `consumer_details` VALUES (31, 62, 123.00, '支出', '午饭', '购物', '2022-09-03 09:37:11');
INSERT INTO `consumer_details` VALUES (32, 62, 100.00, '收入', '话费充值', '生活缴费', '2022-09-15 13:25:47');
INSERT INTO `consumer_details` VALUES (33, 62, 19.00, '支出', '午饭', '餐饮', '2022-09-15 13:26:23');
INSERT INTO `consumer_details` VALUES (34, 62, 123.20, '支出', '1', '交通', '2022-09-15 15:58:22');
INSERT INTO `consumer_details` VALUES (35, 62, 123.20, '支出', '1', '交通', '2022-08-15 15:58:22');
INSERT INTO `consumer_details` VALUES (36, 62, 123.20, '收入', '1', '交通', '2022-07-15 15:58:22');
INSERT INTO `consumer_details` VALUES (37, 62, 123.20, '支出', '1', '交通', '2022-07-15 15:58:22');
INSERT INTO `consumer_details` VALUES (38, 62, 123.20, '支出', '1', '交通', '2022-06-15 15:58:22');
INSERT INTO `consumer_details` VALUES (39, 62, 123.20, '收入', '1', '交通', '2021-08-02 15:58:22');
INSERT INTO `consumer_details` VALUES (40, 62, 123.20, '支出', '1', '交通', '2022-07-15 15:58:22');
INSERT INTO `consumer_details` VALUES (41, 62, 123.20, '支出', '1', '交通', '2022-08-04 15:58:22');
INSERT INTO `consumer_details` VALUES (42, 62, 123.20, '支出', '1', '交通', '2022-06-21 15:58:22');
INSERT INTO `consumer_details` VALUES (43, 62, 100.00, '收入', 'PDD', '工资', '2022-09-15 23:47:29');
INSERT INTO `consumer_details` VALUES (44, 62, 1000.00, '支出', '买项链', '购物', '2022-09-15 23:47:46');
INSERT INTO `consumer_details` VALUES (47, 62, 100.00, '支出', '21', '餐饮', '2022-09-16 11:05:37');
INSERT INTO `consumer_details` VALUES (48, 62, 500.00, '收入', '13', '生活缴费', '2022-09-16 11:05:46');
INSERT INTO `consumer_details` VALUES (51, 1, 1029.00, '支出', '给母亲买洗衣机，淘宝消费，美的品牌', '购物', '2022-09-20 23:44:32');
INSERT INTO `consumer_details` VALUES (52, 1, 19.98, '支出', '午饭 梅菜扣肉饭是招牌（绍兴店）', '餐饮', '2022-09-21 13:22:06');
INSERT INTO `consumer_details` VALUES (53, 1, 5.50, '支出', '下班回家，骑小电驴', '交通', '2022-09-21 20:10:58');
INSERT INTO `consumer_details` VALUES (54, 1, 20.88, '支出', '晚饭 金鲜生外带寿司&日料食堂（越城店）', '餐饮', '2022-09-21 20:12:15');
INSERT INTO `consumer_details` VALUES (55, 1, 20.60, '支出', '午饭 小菜馆（世茂店）', '餐饮', '2022-09-22 11:32:38');
INSERT INTO `consumer_details` VALUES (56, 1, 29.80, '支出', '晚饭 肯德基', '餐饮', '2022-09-23 09:31:04');
INSERT INTO `consumer_details` VALUES (57, 1, 20.60, '支出', '午饭 小菜倌（世茂店）', '餐饮', '2022-09-24 10:48:24');
INSERT INTO `consumer_details` VALUES (58, 1, 93.00, '支出', '晚餐 周皇港式餐厅（世贸广场店）', '餐饮', '2022-09-24 10:49:37');
INSERT INTO `consumer_details` VALUES (59, 1, 15.49, '支出', '供销超市（燕甸园点）购买饮料', '购物', '2022-09-24 10:50:54');
INSERT INTO `consumer_details` VALUES (60, 1, 57.27, '支出', '午饭 叮咚买菜', '餐饮', '2022-09-24 11:19:03');
INSERT INTO `consumer_details` VALUES (61, 1, 21.50, '支出', '午饭 手撕烤鸭（绍兴店）', '餐饮', '2022-09-26 11:51:13');
INSERT INTO `consumer_details` VALUES (62, 1, 13.40, '支出', '供销超市（燕甸园店） 购物', '购物', '2022-09-26 15:32:51');
INSERT INTO `consumer_details` VALUES (63, 1, 4.00, '支出', '供销超市（燕甸园店） 购物', '购物', '2022-09-26 15:33:18');
INSERT INTO `consumer_details` VALUES (64, 1, 3.30, '收入', '支付宝扫码红包 实体店余额宝红包', '红包', '2022-09-26 15:35:28');
INSERT INTO `consumer_details` VALUES (65, 1, 50.00, '支出', '话费充值', '生活缴费', '2022-09-27 09:51:29');
INSERT INTO `consumer_details` VALUES (66, 1, 21.88, '支出', '午饭 味道野得很·江湖菜（绍兴店）', '餐饮', '2022-09-27 11:34:42');
INSERT INTO `consumer_details` VALUES (67, 1, 18.90, '支出', '午饭 郑给力·大块肥牛米线·拌粉（银泰店）', '餐饮', '2022-09-29 09:08:52');
INSERT INTO `consumer_details` VALUES (68, 1, 66.07, '支出', '供销超市（燕甸园） 购物', '购物', '2022-09-29 09:09:57');
INSERT INTO `consumer_details` VALUES (69, 1, 10.00, '支出', '停车费', '交通', '2022-09-29 09:10:16');
INSERT INTO `consumer_details` VALUES (70, 1, 20.76, '支出', '午饭 失控猫·元気烧肉饭（越城店）', '餐饮', '2022-09-29 11:48:51');
INSERT INTO `consumer_details` VALUES (71, 1, 5.00, '支出', '城南车管所停车费', '交通', '2022-09-30 09:46:02');
INSERT INTO `consumer_details` VALUES (72, 1, 10.00, '支出', '上班停车费', '交通', '2022-09-30 09:46:16');
INSERT INTO `consumer_details` VALUES (73, 1, 19.66, '支出', '午餐 失控猫·元気烧肉饭（越城店）', '餐饮', '2022-09-30 14:57:17');
INSERT INTO `consumer_details` VALUES (74, 1, 7.90, '支出', '给老婆买按摩捶 淘宝消费 Catch凯奇萌物馆', '购物', '2022-09-30 16:15:12');
INSERT INTO `consumer_details` VALUES (75, 1, 16.80, '支出', '美团 不限次单车套餐', '交通', '2022-09-30 16:15:12');
INSERT INTO `consumer_details` VALUES (76, 1, 218.00, '支出', '家里人聚餐 川渝部落（笛扬路店）', '餐饮', '2022-09-30 16:15:12');
INSERT INTO `consumer_details` VALUES (77, 1, 125.00, '支出', '家里人聚餐 川渝部落（笛扬路店）', '餐饮', '2022-09-30 16:15:12');
INSERT INTO `consumer_details` VALUES (78, 1, 130.00, '支出', '高中同学聚餐 AA', '餐饮', '2022-10-02 14:26:46');
INSERT INTO `consumer_details` VALUES (80, 1, 188.00, '收入', '本人生日，姑姑送的微信红包', '红包', '2022-10-02 14:27:36');
INSERT INTO `consumer_details` VALUES (81, 1, 27.80, '支出', '淘宝 老沈的面膜', '购物', '2022-10-02 14:29:39');
INSERT INTO `consumer_details` VALUES (82, 1, 36.00, '支出', '理发', '服务', '2022-10-02 14:29:56');
INSERT INTO `consumer_details` VALUES (83, 1, 10.00, '支出', '上班停车费', '交通', '2023-01-29 11:13:13');
INSERT INTO `consumer_details` VALUES (87, 1, 111.00, '收入', '213', '生活缴费', '2023-01-29 17:41:51');
INSERT INTO `consumer_details` VALUES (88, 1, 2.00, '支出', '123', '服务', '2023-01-29 17:42:16');
INSERT INTO `consumer_details` VALUES (89, 1, 23.00, '支出', '2', '餐饮', '2023-06-30 09:01:26');
INSERT INTO `consumer_details` VALUES (91, 1, 50.00, '支出', '主号花费', '生活缴费', '2023-07-18 15:24:43');

-- ----------------------------
-- Table structure for consumption_category
-- ----------------------------
DROP TABLE IF EXISTS `consumption_category`;
CREATE TABLE `consumption_category`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '类别名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '消费分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of consumption_category
-- ----------------------------
INSERT INTO `consumption_category` VALUES (1, '转账');
INSERT INTO `consumption_category` VALUES (2, '交通');
INSERT INTO `consumption_category` VALUES (3, '餐饮');
INSERT INTO `consumption_category` VALUES (4, '生活缴费');
INSERT INTO `consumption_category` VALUES (5, '服务');
INSERT INTO `consumption_category` VALUES (6, '购物');
INSERT INTO `consumption_category` VALUES (7, '服饰');
INSERT INTO `consumption_category` VALUES (8, '其他');
INSERT INTO `consumption_category` VALUES (9, '娱乐');
INSERT INTO `consumption_category` VALUES (10, '工资');
INSERT INTO `consumption_category` VALUES (11, '理财');
INSERT INTO `consumption_category` VALUES (12, '退款');
INSERT INTO `consumption_category` VALUES (13, '红包');

-- ----------------------------
-- Table structure for consumption_type
-- ----------------------------
DROP TABLE IF EXISTS `consumption_type`;
CREATE TABLE `consumption_type`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '类型名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '消费类型字典' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of consumption_type
-- ----------------------------
INSERT INTO `consumption_type` VALUES (15, '支出');
INSERT INTO `consumption_type` VALUES (1, '收入');

-- ----------------------------
-- Table structure for dict
-- ----------------------------
DROP TABLE IF EXISTS `dict`;
CREATE TABLE `dict`  (
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内容',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '类型'
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '菜单路径管理表' ROW_FORMAT = Dynamic;

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
INSERT INTO `dict` VALUES ('map', 'MapLocation', 'icon');
INSERT INTO `dict` VALUES ('localAim', 'Aim', 'icon');
INSERT INTO `dict` VALUES ('coffee', 'Coffee', 'icon');
INSERT INTO `dict` VALUES ('discount', 'Discount', 'icon');
INSERT INTO `dict` VALUES ('wallet', 'Wallet', 'icon');
INSERT INTO `dict` VALUES ('clock ', 'Clock', 'icon');
INSERT INTO `dict` VALUES ('chat', 'ChatLineSquare', 'icon');
INSERT INTO `dict` VALUES ('dataLine', 'DataLine', 'icon');
INSERT INTO `dict` VALUES ('stopwatch', 'Stopwatch', 'icon');
INSERT INTO `dict` VALUES ('checked', 'Checked', 'icon');

-- ----------------------------
-- Table structure for events
-- ----------------------------
DROP TABLE IF EXISTS `events`;
CREATE TABLE `events`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '正文',
  `author` bigint(11) NULL DEFAULT NULL COMMENT '编者 uid',
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `view_count` bigint(255) NULL DEFAULT 0 COMMENT '查看次数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 64 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '事件管理表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of events
-- ----------------------------
INSERT INTO `events` VALUES (28, '我是大漂酿', '<p>我是大漂酿<span style=\"color: var(--w-e-textarea-color); font-size: var(--el-dialog-content-font-size);\">👻</span></p>', 42, '2022-07-29 00:19:26', 253);
INSERT INTO `events` VALUES (24, '老沈爱我的表现1', '<p>老沈昨天掐了我三下，说是爱我的表现<span style=\"color: var(--w-e-textarea-color); font-size: var(--el-dialog-content-font-size);\">😤</span></p>', 1, '2022-07-16 01:40:10', 161);
INSERT INTO `events` VALUES (44, '老沈练书法的第一天', '<p>我家老沈第一天练字，加油！very good!<img src=\"http://localhost:9090/files/250d46c597f94157abf1c22074346fc3\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', 1, '2023-02-24 21:28:32', 11);
INSERT INTO `events` VALUES (47, '哼哼哼', '<p>今天沈奇男不让我学习，哼哼哼</p>', 42, '2023-03-08 22:10:37', 6);
INSERT INTO `events` VALUES (48, '沈奇男必须提醒我', '<p>明天要在我的宝座上做作业，<span style=\"color: var(--w-e-textarea-color);\">沈奇男必须提醒我，这个是沈奇男的监督任务，必须完成!!!</span></p>', 42, '2023-03-08 22:11:55', 9);
INSERT INTO `events` VALUES (57, '老沈今天吃不完银耳', '哈哈哈', 42, '2023-04-23 23:35:51', 21);
INSERT INTO `events` VALUES (60, '小沈做错事了', '<p>昨天晚上不小心烧掉了老沈的证件照，犯了大错，老沈很难受，我也很难受，对不起啦，老沈，我错了<span style=\"color: var(--w-e-textarea-color); font-size: var(--el-dialog-content-font-size);\">😭</span></p>', 1, '2023-12-30 14:01:50', 4);

-- ----------------------------
-- Table structure for files
-- ----------------------------
DROP TABLE IF EXISTS `files`;
CREATE TABLE `files`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件名称',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件类型',
  `size` bigint(20) NULL DEFAULT NULL COMMENT '文件大小',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '下载链接',
  `md5` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件MD5',
  `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除（假删除）：‘0’表示未删除',
  `enable` tinyint(1) NULL DEFAULT 1 COMMENT '是否禁用：‘1’表示可用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 56 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '文件管理表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of files
-- ----------------------------
INSERT INTO `files` VALUES (47, '哈头像.jpg', 'jpg', 7, 'http://localhost:9090/files/test/b25f4a7e765d4375aa9bde534e01e4c3.jpg', 'd0034dd1f891ee8446debade2142390c', 1, 1);
INSERT INTO `files` VALUES (48, '小沈.jpg', 'jpg', 434, 'http://localhost:9090/files/test/d3ddc566bbd3429293f35e77b382dae1.jpg', '6011acb83994d9c62f4a4a2ef29180be', 1, 1);
INSERT INTO `files` VALUES (49, '老沈.jpg', 'jpg', 34, 'http://localhost:9090/files/test/a73326ce64064c7f858881855638ee25.jpg', 'e3f851531cb8c035015dd190b2895f71', 1, 1);
INSERT INTO `files` VALUES (50, 'default.jpg', 'jpg', 13, 'http://localhost:9090/files/test/53f46cdcd3ce4132b46ba2bb4d3563c7.jpg', '834c7fa1fa9c8b62610250717e7b25c8', 1, 1);
INSERT INTO `files` VALUES (51, '背景1.jfif', 'jfif', 2778, 'http://localhost:9090/files/test/5222f97fc3f44ce093920a5a0bb3c753.jfif', 'df5f1222c820547de66bb8038efb3873', 1, 1);
INSERT INTO `files` VALUES (52, '哈头像.jpg', 'jpg', 32, 'http://localhost:9090/files/test/cdd762c6722a4daf81ea03e9a88c143a.jpg', 'aec84b4f31e1f72fde9d35695e02d5b4', 1, 1);
INSERT INTO `files` VALUES (53, '富士山.jpg', 'jpg', 91, 'http://localhost:9090/files/test/dd626ce6f5f441d8b34e4c9106d369eb.jpg', 'e1eabf7f2679f768743eba6669bb9d07', 1, 1);
INSERT INTO `files` VALUES (54, 'location.jpg', 'jpg', 50, 'http://localhost:9090/files/test/535af625316748d5b24bcd9a4b90482a.jpg', '8b47951fa0ed1d3708186bc35d0b7f48', 0, 1);
INSERT INTO `files` VALUES (55, '嗯？.jpg', 'jpg', 30, 'http://localhost:9090/files/test/afd19fa619034e1e80e26d466b8540af.jpg', 'dccc1a1e710d338ac67b64768b5b8921', 0, 1);

-- ----------------------------
-- Table structure for health
-- ----------------------------
DROP TABLE IF EXISTS `health`;
CREATE TABLE `health`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `uid` bigint(11) NOT NULL COMMENT '用户id',
  `height` int(11) NULL DEFAULT NULL COMMENT '身高',
  `weight` int(11) NULL DEFAULT NULL COMMENT '体重',
  `shoulder_wide` int(11) NULL DEFAULT NULL COMMENT '肩围',
  `bust` int(11) NULL DEFAULT NULL COMMENT '胸围',
  `waistline` int(11) NULL DEFAULT NULL COMMENT '腰围',
  `hipline` int(11) NULL DEFAULT NULL COMMENT '臀围',
  `activities` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '活动标签集',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建日期',
  `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除；0：未删除，1：已删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_id`(`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 156 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '健康管理\r\n除身高外，其余身材数据均被乘20' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of health
-- ----------------------------
INSERT INTO `health` VALUES (112, 1, 172, 1386, 0, 0, 0, 0, NULL, '2023-03-02 21:33:12', 0);
INSERT INTO `health` VALUES (63, 1, 163, 1120, 700, 1780, 1550, 1880, '1,2,3,4', '2023-02-27 22:42:44', 0);
INSERT INTO `health` VALUES (129, 62, 180, 1300, 1600, 1600, 1600, 1600, '4,23,24', '2023-03-04 22:21:27', 0);
INSERT INTO `health` VALUES (108, 1, 180, 1300, 0, 0, 0, 0, NULL, '2023-03-01 13:31:10', 0);
INSERT INTO `health` VALUES (109, 23, 180, 1300, 0, 0, 0, 0, '4', '2023-03-02 22:57:31', 0);
INSERT INTO `health` VALUES (130, 1, 172, 1360, 0, 0, 0, 0, '1', '2023-03-18 15:57:56', 0);
INSERT INTO `health` VALUES (114, 1, 163, 1120, 700, 1780, 1550, 1880, '5,6,7', '2023-02-27 23:41:44', 0);
INSERT INTO `health` VALUES (115, 1, 163, 1120, 700, 1780, 1550, 1880, '1,9', '2023-03-03 18:49:44', 0);
INSERT INTO `health` VALUES (116, 42, 163, 1120, 700, 1780, 1550, 1880, '2,7', '2023-03-03 22:49:44', 0);
INSERT INTO `health` VALUES (154, 22, 165, 1000, 0, 0, 0, 0, '9,15,1', '2023-03-19 17:47:22', 0);
INSERT INTO `health` VALUES (143, 22, 165, 1000, 0, 0, 0, 0, '1', '2023-03-18 23:43:21', 0);
INSERT INTO `health` VALUES (155, 1, 172, 1360, 0, 0, 0, 0, '', '2023-06-27 17:56:54', 0);

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '菜单名称',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '路径',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图标',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '描述',
  `pid` bigint(11) NULL DEFAULT NULL COMMENT '父级id',
  `page_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '页面路径',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 43 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '菜单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (2, '全局概览', '/home', 'PieChart', '', NULL, 'Home');
INSERT INTO `menu` VALUES (5, '事务管理', NULL, 'SetUp', NULL, NULL, NULL);
INSERT INTO `menu` VALUES (6, '系统管理', NULL, 'Setting', NULL, NULL, NULL);
INSERT INTO `menu` VALUES (7, '书籍管理', '/book', 'Notebook', NULL, 5, 'Book');
INSERT INTO `menu` VALUES (8, '事件发布', '/events', 'Ship', NULL, 5, 'Events');
INSERT INTO `menu` VALUES (9, '文件管理', '/file', 'Folder', NULL, 5, 'File');
INSERT INTO `menu` VALUES (10, '成员管理', '/user', 'Avatar', NULL, 6, 'User');
INSERT INTO `menu` VALUES (11, '角色管理', '/role', 'UserFilled', NULL, 6, 'Role');
INSERT INTO `menu` VALUES (12, '菜单管理', '/menu', 'List', NULL, 6, 'Menu');
INSERT INTO `menu` VALUES (14, '测试菜单', '/testPage', 'PieChart', '为了测试', NULL, 'TestPage');
INSERT INTO `menu` VALUES (22, '地图使用', '', 'MapLocation', '集成高德地图使用', NULL, 'AMap');
INSERT INTO `menu` VALUES (23, '当前位置', '/mapPath', 'Aim', '规划路线', 22, 'MapPath');
INSERT INTO `menu` VALUES (32, '健康管理', '/healthManagement', 'Clock', NULL, 5, 'HealthManagement');
INSERT INTO `menu` VALUES (30, '我的账单', '/bill', 'Wallet', NULL, 5, 'Bill');
INSERT INTO `menu` VALUES (33, '聊天室', '/imChat', 'ChatLineSquare', NULL, 5, 'ImChat');
INSERT INTO `menu` VALUES (35, '股市风云', '/stock', 'DataLine', NULL, NULL, 'Stock');
INSERT INTO `menu` VALUES (36, '压力传感器检测', '/dataacquisition', 'Stopwatch', NULL, 37, 'DataAcquisition');
INSERT INTO `menu` VALUES (37, '工作业务', NULL, 'Coffee', NULL, NULL, NULL);
INSERT INTO `menu` VALUES (39, '睡姿识别检测', '/sleepReg', 'Checked', '睡姿识别检测', 37, 'SleepReg');
INSERT INTO `menu` VALUES (42, '测试人员管理', '/testMemberManage', 'UserFilled', NULL, 37, 'TestMemberManage');

-- ----------------------------
-- Table structure for renhe_collect
-- ----------------------------
DROP TABLE IF EXISTS `renhe_collect`;
CREATE TABLE `renhe_collect`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '垫子编码关键位',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `pressure` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '压力',
  `bed_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '使用床垫',
  `mat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '垫子类型：stand;plus;pro',
  `batch` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '批次',
  `first_pressure` bigint(255) NULL DEFAULT NULL COMMENT '首次压力值',
  `final_pressure` bigint(255) NULL DEFAULT NULL COMMENT '前45压力总和',
  `coefficient` float NULL DEFAULT NULL COMMENT '系数：1；1.5',
  `status` int(255) NOT NULL DEFAULT 0 COMMENT '状态；默认未审核过0，合格1，不合格2',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 247 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of renhe_collect
-- ----------------------------
INSERT INTO `renhe_collect` VALUES (3, '237', '2023-12-11 16:25:03', '0,0,2,3,7,5,3,0,0,2,4,5,13,6,3,0,1,4,5,9,18,24,12,0,2,9,30,47,48,46,38,3,4,11,35,59,83,80,41,4,9,16,27,43,40,43,18,8,5,9,11,15,28,15,10,7,4,7,14,26,15,17,11,8,0,4,27,101,104,103,15,0,0,3,20,84,107,100,29,0,0,0,42,57,58,54,20,2,0,5,16,12,10,10,9,0,0,4,10,9,9,10,8,0,0,1,3,4,3,4,4,0,0,2,5,5,4,6,8,0,0,6,5,4,4,7,6,0,3,4,6,4,5,7,3,3,6,11,11,11,8,11,8,4,0,0,0,0,1,0,0,0,0,3,4,3,3,1,1,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', NULL, NULL, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (5, '430', '2023-12-11 16:38:56', '0,0,4,3,7,6,0,0,0,1,5,9,9,14,5,0,0,0,6,11,13,13,11,2,0,3,16,40,44,42,30,5,2,4,18,60,97,83,40,7,6,12,33,44,53,55,21,13,9,11,20,23,25,23,13,8,8,12,20,33,22,21,15,6,0,5,40,75,98,49,9,0,1,6,1,7,6,0,9,23,8,7,8,19,9,7,7,19,17,18,20,26,10,4,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', NULL, NULL, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (6, '262', '2023-12-11 16:42:37', '0,0,4,9,10,4,2,0,0,1,9,10,9,11,4,0,0,5,10,23,19,16,8,0,3,10,37,51,48,37,13,0,1,11,84,74,103,57,11,0,10,22,44,75,33,35,21,9,6,9,16,22,44,20,13,5,5,13,14,21,16,28,13,5,0,8,33,68,64,16,6,0,0,4,20,39,20,10,7,0,0,8,26,31,18,10,4,0,0,9,12,10,9,8,7,0,0,6,9,7,5,8,2,0,0,5,8,7,3,4,2,0,0,5,7,3,3,7,3,0,0,4,5,0,0,3,0,0,0,5,6,7,6,7,6,0,6,12,14,16,13,25,20,5,1,4,6,2,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', NULL, NULL, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (7, '378', '2023-12-11 16:44:19', '0,0,5,9,9,3,0,0,0,3,10,12,11,8,2,0,2,8,9,15,14,8,5,0,5,15,27,29,27,26,10,0,8,28,51,58,70,59,9,0,15,26,39,47,55,40,21,6,13,13,14,22,23,33,9,6,9,17,26,24,36,11,12,6,5,12,43,55,47,36,9,0,5,12,39,50,50,25,2,0,7,14,33,52,34,20,9,0,6,12,14,15,11,15,10,0,1,4,8,6,5,8,4,0,5,4,7,5,5,6,4,0,1,3,6,3,4,4,0,0,1,2,4,0,3,5,0,0,2,6,7,8,7,12,4,0,24,24,16,19,32,26,22,4,0,6,2,3,3,0,1,0,1,1,1,3,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', NULL, NULL, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (8, '260', '2023-12-11 16:46:00', '0,6,9,11,11,8,4,0,0,8,9,13,13,11,7,0,2,8,13,16,14,13,6,0,5,17,51,54,56,54,10,1,9,26,64,75,84,56,10,1,11,14,40,62,48,20,16,7,4,11,14,33,14,14,10,5,8,14,24,19,45,19,12,4,0,12,59,73,63,37,4,0,1,13,62,78,63,33,3,0,5,13,42,54,50,19,6,0,1,13,22,11,12,12,6,0,1,7,9,6,7,8,5,0,1,10,12,11,9,10,6,0,0,7,7,6,6,8,4,0,0,5,6,3,5,8,4,0,4,10,10,9,9,12,9,1,9,14,13,11,15,12,12,5,0,0,2,0,0,0,0,0,2,6,4,2,1,2,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', NULL, NULL, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (10, '210', '2023-12-11 16:51:10', '0,0,2,4,9,23,5,4,0,0,2,8,11,14,6,2,0,0,6,13,18,22,9,4,0,4,11,41,49,62,64,9,1,4,9,51,90,101,74,8,1,5,23,35,39,41,23,9,1,5,16,27,19,24,13,6,4,11,20,24,22,27,14,8,0,6,20,52,62,56,22,3,0,2,9,42,42,29,7,3,0,4,43,49,41,27,11,0,0,7,15,15,17,16,11,1,3,7,7,8,6,11,8,0,2,6,6,5,6,6,7,0,1,5,6,6,4,6,7,0,1,6,5,5,3,5,7,0,2,6,6,4,5,7,8,4,7,20,15,9,9,22,22,6,0,1,4,0,2,5,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', NULL, NULL, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (12, '225', '2023-12-11 17:08:28', '1,6,9,9,8,7,3,0,0,6,9,12,12,10,6,0,1,7,10,12,14,12,6,0,2,9,14,20,22,20,10,0,6,14,41,71,85,79,24,4,13,43,54,61,63,65,33,8,13,13,24,27,31,36,12,6,10,15,39,32,29,31,14,4,5,11,56,70,64,42,5,0,5,11,44,61,61,33,4,0,4,28,56,68,55,37,7,0,6,13,14,14,14,14,10,0,3,8,9,8,9,10,5,0,6,9,11,11,10,10,7,0,1,6,8,6,7,7,3,0,2,5,6,0,4,6,1,0,6,10,10,9,10,12,7,0,13,63,16,14,20,25,14,7,1,3,3,0,2,1,0,0,3,2,1,0,2,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', NULL, NULL, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (13, '273', '2023-12-11 17:15:31', '0,0,2,6,9,7,2,0,0,1,8,9,28,9,4,0,0,5,9,16,20,16,8,0,0,10,22,36,45,50,26,3,5,9,33,58,80,80,40,6,12,19,31,49,48,53,33,7,10,12,21,26,26,31,9,9,9,12,21,23,29,33,20,8,1,6,19,64,83,62,11,0,6,11,6,0,8,13,10,7,10,9,6,3,10,14,14,12,14,28,21,10,0,0,3,0,0,0,0,0,2,7,6,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', NULL, NULL, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (14, '407', '2023-12-11 17:17:23', '0,0,3,3,7,4,2,0,0,0,3,0,1,4,0,0,0,2,3,2,5,9,3,0,0,0,6,22,25,37,12,0,0,4,18,32,62,59,10,0,6,4,2,30,12,17,8,2,2,5,13,17,17,19,9,9,0,7,17,8,9,19,7,4,0,1,28,42,61,50,13,0,0,0,33,49,48,41,8,0,1,6,34,49,46,24,6,2,1,4,10,7,9,12,11,0,0,2,7,2,5,9,4,0,0,0,0,3,5,9,10,0,0,1,0,0,2,6,4,0,0,0,0,0,0,3,0,0,5,7,2,0,6,11,8,0,9,10,8,6,7,19,12,3,0,0,0,0,2,2,0,0,2,1,0,0,0,0,0,2,0,0,0,0,0,0,0,0', '2033', 'plus', '20', NULL, NULL, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (15, '431', '2023-12-11 17:19:04', '0,6,8,11,8,4,1,0,0,5,9,12,11,7,2,0,2,10,11,13,11,12,7,0,2,11,19,32,24,18,9,4,5,18,31,71,82,64,10,1,11,23,39,35,44,30,9,7,8,12,22,29,29,17,11,5,8,14,25,23,23,24,12,6,4,13,54,58,68,58,12,0,3,10,40,54,60,54,11,0,4,19,44,52,67,44,11,0,1,13,19,14,13,18,10,0,2,10,12,9,9,9,6,0,4,11,9,7,7,10,6,0,2,9,11,8,7,8,5,0,0,8,5,0,1,7,4,0,3,10,9,8,8,11,10,0,8,13,18,14,9,21,10,5,1,5,0,0,0,3,2,0,0,0,1,1,0,2,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', NULL, NULL, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (16, '483', '2023-12-11 17:20:45', '0,3,12,11,12,8,6,1,3,5,11,19,28,16,6,3,3,9,17,15,18,16,7,1,5,17,36,43,46,44,11,1,6,22,55,65,78,70,23,5,24,35,36,44,54,53,31,8,13,18,30,32,35,38,16,9,7,17,22,30,43,32,17,7,4,10,55,90,79,50,7,4,7,12,31,61,69,21,8,2,8,21,53,74,56,31,11,0,8,20,28,17,21,31,15,1,5,9,14,12,12,15,10,1,5,11,14,12,12,14,11,4,5,9,10,9,10,11,7,0,5,8,7,7,7,6,4,0,6,13,14,13,13,15,12,4,13,26,23,14,25,36,23,11,0,5,5,2,0,0,2,1,1,0,2,0,3,1,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', NULL, NULL, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (17, '298', '2023-12-11 17:23:57', '0,2,5,8,10,7,3,0,0,5,7,12,19,9,5,2,0,8,16,29,36,28,9,2,3,20,49,54,54,54,24,4,4,22,45,63,84,62,17,3,10,24,28,36,38,28,18,7,6,11,16,26,21,23,10,7,6,10,32,24,29,25,14,8,0,8,53,73,82,56,11,0,1,9,54,71,66,54,17,1,3,12,49,57,52,42,16,1,4,11,14,14,11,11,9,2,0,5,9,10,11,11,8,0,0,7,7,7,5,6,4,0,0,5,4,2,6,6,5,0,0,4,5,5,6,9,6,0,5,12,9,10,7,11,7,2,12,16,13,12,15,18,13,4,0,3,4,0,0,3,2,0,0,0,0,3,2,4,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', NULL, NULL, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (18, '228', '2023-12-11 17:25:37', '0,4,5,10,12,6,2,0,0,5,11,17,25,14,4,0,2,6,13,27,29,29,11,0,8,24,35,50,58,54,13,1,11,52,43,92,100,58,11,2,14,29,57,42,36,29,13,8,12,13,20,26,33,26,11,7,11,20,33,31,28,26,20,7,9,23,76,82,78,59,8,0,0,21,66,77,73,50,4,0,4,18,42,59,53,28,8,0,5,11,18,10,14,17,8,0,4,7,8,8,9,11,4,0,1,11,12,6,6,10,5,1,4,8,8,8,8,12,5,0,5,11,4,6,7,11,5,0,8,12,6,7,10,13,9,2,13,22,18,19,21,30,11,6,1,3,3,1,3,5,0,0,0,4,0,0,1,2,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', NULL, NULL, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (19, '222', '2023-12-11 17:27:18', '0,0,3,11,11,6,3,0,0,3,7,12,23,9,5,0,0,5,6,8,17,21,12,3,1,11,27,40,41,42,29,1,1,15,24,58,73,67,53,0,9,22,20,35,83,39,27,9,12,12,17,22,28,37,16,8,9,18,24,34,25,25,19,7,3,10,35,79,71,64,13,0,1,13,44,67,73,58,12,0,4,15,44,76,72,55,17,2,5,13,25,21,20,18,15,2,2,9,10,10,9,11,11,0,3,8,7,7,6,6,7,1,4,8,8,9,5,7,6,1,0,10,7,5,4,7,6,0,9,9,6,7,7,13,10,3,12,17,13,10,21,29,15,6,4,5,0,0,0,0,0,0,3,6,0,0,2,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', NULL, NULL, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (20, '195', '2023-12-11 17:29:19', '0,3,5,9,9,4,2,0,1,4,6,15,13,7,2,0,2,5,10,9,11,11,8,0,4,13,27,34,37,31,11,0,7,19,37,73,97,47,7,0,16,30,27,48,44,32,18,5,10,14,11,22,24,32,12,7,11,15,13,12,26,17,12,5,5,10,45,76,65,40,7,0,5,11,53,68,61,50,9,1,7,15,54,72,60,42,10,1,7,14,14,17,16,13,12,0,5,9,11,9,8,11,8,0,4,9,9,7,6,5,4,0,4,7,7,6,6,6,5,0,4,7,5,3,4,6,5,0,4,7,7,6,5,15,7,4,10,14,17,10,11,14,10,3,4,3,1,0,0,2,0,0,3,4,1,4,3,4,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', NULL, NULL, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (21, '414', '2023-12-11 17:30:59', '0,1,7,6,6,9,8,0,0,4,5,8,14,10,5,0,0,6,6,8,20,14,8,0,0,7,13,27,28,26,14,3,0,5,33,56,75,58,40,3,5,16,27,24,36,34,11,9,5,5,13,19,16,28,11,7,3,27,26,24,29,31,15,8,0,3,20,46,52,50,10,0,0,4,44,56,68,47,9,0,0,10,56,76,65,39,10,0,0,8,17,14,7,23,19,4,1,8,16,10,9,11,10,1,6,9,10,10,7,14,9,3,0,6,8,2,5,9,9,1,0,0,5,5,6,6,4,0,1,5,9,4,3,6,8,4,5,20,17,5,8,19,18,5,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0', '2033', 'plus', '20', NULL, NULL, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (22, '436', '2023-12-11 17:32:40', '0,5,6,7,8,8,4,0,1,4,9,9,13,13,9,0,3,7,21,17,14,11,13,0,2,13,21,28,33,32,26,2,5,13,30,60,77,74,31,3,11,20,32,40,43,45,28,10,8,11,16,26,23,29,16,7,10,11,35,31,25,32,19,8,0,10,34,55,69,52,11,0,1,9,24,81,73,46,14,0,6,14,40,60,64,36,11,0,7,13,12,14,22,18,12,1,6,8,10,9,9,11,6,0,2,7,10,12,10,11,8,0,3,3,7,7,8,11,7,0,3,4,2,3,2,2,0,0,4,12,11,10,9,13,11,1,13,32,16,13,16,25,19,7,6,4,3,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', NULL, NULL, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (23, '356', '2023-12-11 17:34:21', '4,4,5,0,1,1,0,5,0,1,6,8,9,6,3,0,0,4,8,10,11,11,7,0,1,9,14,26,28,26,11,0,0,10,25,46,61,57,22,0,11,21,17,20,21,30,17,6,7,7,10,14,13,16,10,7,10,13,25,32,21,23,12,7,3,9,30,62,81,48,11,0,2,9,47,62,60,40,13,0,4,14,51,63,52,40,15,2,4,13,14,13,13,13,11,4,2,6,8,8,8,9,8,1,2,10,11,9,7,6,5,0,4,6,5,6,4,6,4,0,2,4,5,2,1,3,4,0,4,9,8,4,6,8,6,0,8,9,10,8,9,17,12,6,5,3,5,1,2,3,5,1,5,4,4,5,0,1,1,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', NULL, NULL, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (24, '366', '2023-12-12 16:58:53', '0,0,4,6,7,4,0,0,0,2,6,8,12,6,4,0,0,6,10,21,19,14,7,2,1,10,32,38,41,50,16,4,0,10,32,53,76,60,21,1,8,15,21,23,31,25,15,6,8,12,17,25,15,17,10,6,6,13,22,22,28,24,9,4,5,13,37,66,66,54,10,0,0,5,21,40,49,38,6,0,1,7,32,45,38,36,7,0,2,8,11,11,8,10,5,0,2,7,7,7,9,9,5,0,0,5,4,3,6,5,2,0,0,4,6,3,4,5,1,0,0,4,5,5,4,7,3,0,3,6,6,5,6,8,4,0,7,20,15,13,21,23,19,4,3,4,4,4,4,7,5,0,3,3,5,2,1,3,3,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', NULL, NULL, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (25, '003', '2023-12-12 17:01:30', '0,1,10,13,10,8,1,0,0,3,10,12,17,12,7,0,0,4,14,23,21,18,10,0,0,10,33,50,55,42,12,0,5,23,47,82,107,67,18,4,10,24,68,40,46,50,18,8,10,17,27,30,25,30,13,5,6,18,26,18,23,19,8,4,1,11,56,66,69,40,5,0,1,12,51,63,55,35,3,0,0,14,50,53,44,27,5,0,1,14,19,14,17,14,12,0,0,7,10,7,10,6,2,0,0,7,10,9,7,2,7,0,0,5,9,7,6,8,6,0,3,8,10,7,8,9,7,0,1,10,12,11,11,13,11,1,11,22,28,20,24,27,22,8,1,6,4,3,0,0,0,0,0,3,3,0,3,5,2,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', NULL, NULL, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (26, '238', '2023-12-12 17:04:32', '0,2,5,8,8,5,3,0,0,3,6,8,10,7,2,0,2,6,8,17,19,15,8,0,6,10,37,57,55,51,12,0,6,12,38,72,87,54,9,0,8,20,34,34,37,31,12,5,6,6,7,11,9,15,7,5,3,10,21,15,18,20,8,4,0,7,49,71,70,49,6,0,0,8,59,87,85,67,6,0,1,8,47,62,46,38,8,2,2,7,19,10,8,6,5,1,2,5,10,9,8,9,6,1,0,4,6,4,4,4,4,0,1,3,6,5,4,7,4,0,0,4,6,4,7,8,2,0,1,4,7,7,7,8,5,2,5,9,9,11,10,14,8,4,2,4,2,1,1,0,0,0,3,6,8,6,4,4,2,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', NULL, NULL, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (27, '295', '2023-12-12 17:06:24', '0,0,4,6,7,5,2,0,0,5,7,11,14,8,5,0,3,5,15,16,21,15,7,0,4,25,54,36,38,40,17,0,8,25,38,46,53,45,6,0,14,27,33,37,41,40,18,6,9,11,25,31,18,20,10,6,9,19,33,25,29,29,22,6,5,17,63,75,73,45,7,0,4,15,62,67,63,38,6,0,3,21,54,57,57,28,9,0,5,13,16,13,10,19,9,2,1,9,8,7,8,13,8,0,1,8,9,8,6,5,5,1,0,6,8,6,7,8,4,0,2,5,7,6,7,6,5,0,3,7,9,6,8,9,7,0,4,7,10,14,15,18,8,2,3,0,2,2,3,1,0,0,3,6,4,4,4,4,3,3,0,0,0,0,0,0,0,0', '2033', 'plus', '20', NULL, NULL, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (28, '100', '2023-12-12 17:08:24', '0,1,3,6,10,6,3,0,0,3,7,9,11,10,6,0,0,5,10,12,14,11,8,3,1,7,17,29,30,30,20,3,1,7,29,43,61,59,30,2,8,18,27,36,41,42,27,8,9,10,13,15,13,22,14,6,6,9,13,11,14,19,14,4,2,5,15,58,64,59,13,2,1,8,33,64,74,61,19,3,4,8,46,62,53,35,15,2,5,12,14,11,11,13,10,5,1,8,7,7,5,9,6,3,1,9,9,6,5,6,5,2,1,4,4,2,4,2,5,1,1,6,7,4,4,7,7,0,4,6,8,5,8,8,8,7,7,11,17,11,13,13,14,7,0,3,0,0,0,0,0,0,1,3,4,0,0,1,3,1,0,0,0,0,0,0,0,0', '2033', 'plus', '20', NULL, NULL, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (29, '479', '2023-12-12 17:12:18', '0,2,6,9,6,4,2,0,0,1,6,14,17,8,3,0,1,4,12,15,13,12,8,0,3,20,32,42,55,28,9,0,4,29,49,72,73,46,9,0,20,28,43,62,62,47,23,6,7,13,27,24,29,25,10,4,8,16,33,30,31,28,14,5,1,13,56,73,61,31,3,0,3,17,62,75,67,38,3,0,6,27,45,64,67,42,8,0,5,14,22,19,20,18,12,0,0,7,9,9,9,11,5,0,2,8,9,9,9,8,8,0,0,7,6,7,7,5,2,0,1,7,9,6,6,8,2,0,2,10,7,8,9,10,5,0,6,17,25,23,23,24,11,4,6,3,2,2,4,5,1,0,1,2,3,4,2,2,1,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', NULL, NULL, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (30, '221', '2023-12-12 17:15:00', '0,5,10,12,12,12,7,0,0,6,11,11,15,19,9,2,1,11,14,26,29,25,15,4,4,19,43,59,62,58,25,6,6,19,38,60,85,72,20,7,14,28,36,45,59,45,30,9,12,19,26,30,28,32,14,11,9,25,38,35,36,32,22,8,1,12,49,92,93,65,14,0,0,11,55,73,80,68,14,1,2,16,38,46,47,45,14,0,3,13,16,13,14,14,12,0,0,6,9,9,8,11,7,0,0,9,10,10,11,14,9,0,2,9,11,11,10,13,7,0,2,10,9,7,10,12,6,0,6,13,14,13,12,16,12,6,13,13,21,25,33,36,19,8,0,4,0,0,0,0,0,0,2,4,5,4,8,6,1,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', NULL, NULL, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (31, '432', '2023-12-12 17:16:51', '0,1,4,6,8,5,2,0,0,3,10,9,10,7,4,0,0,4,9,12,12,13,9,2,2,11,15,21,34,35,18,2,4,8,22,33,101,80,29,2,10,17,23,25,30,26,19,10,8,11,14,14,17,17,13,5,7,11,13,17,19,23,14,5,0,6,43,63,69,63,10,0,1,9,51,65,66,54,12,0,2,13,41,54,50,45,11,1,3,13,14,12,13,14,12,0,0,6,10,9,8,7,5,0,0,6,10,8,6,7,4,0,0,7,8,7,8,8,2,0,1,7,7,5,5,7,0,0,4,10,10,7,10,11,7,2,7,15,19,11,14,15,9,4,1,1,0,1,1,0,0,0,0,4,3,2,2,6,1,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', NULL, NULL, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (32, '475', '2023-12-12 17:19:21', '0,1,6,7,8,6,2,0,0,4,6,7,15,9,5,0,0,5,7,11,19,14,6,1,1,8,21,33,31,25,15,5,2,7,33,37,70,97,30,4,8,25,25,29,38,34,25,8,10,13,19,28,31,30,14,5,6,12,22,19,29,26,13,6,3,9,24,39,51,46,12,0,5,10,20,32,47,31,10,0,1,9,31,57,51,42,10,0,3,13,29,20,23,28,13,0,4,9,12,12,11,14,8,0,3,8,9,7,8,7,5,0,3,5,9,6,6,7,2,0,0,4,6,4,5,6,3,0,2,5,7,6,9,11,6,1,6,27,12,13,20,24,16,4,3,5,6,3,1,5,2,2,2,3,5,4,1,3,2,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', NULL, NULL, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (33, '354', '2023-12-12 17:21:11', '0,2,3,5,7,5,2,0,0,3,7,8,10,6,3,1,2,7,14,17,32,23,7,0,3,12,18,32,36,41,12,2,9,17,31,58,98,43,8,0,12,14,20,27,29,21,10,6,10,9,20,18,23,22,9,6,9,13,31,26,29,28,14,6,4,14,67,77,73,39,6,0,1,18,56,63,60,28,7,0,2,14,41,32,42,24,6,0,1,12,13,12,12,14,11,0,1,4,7,5,6,8,7,0,0,9,10,7,9,9,6,1,2,7,9,8,9,10,5,0,2,6,7,6,7,11,5,0,4,9,7,8,10,10,7,2,6,10,14,13,11,12,9,3,1,3,2,0,1,2,0,0,4,0,0,1,4,1,2,1,0,0,0,0,0,0,0,0', '2033', 'plus', '20', NULL, NULL, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (37, '404', '2023-12-13 13:42:58', '0,0,1,3,6,5,2,0,0,0,2,4,6,5,3,0,0,0,3,8,10,14,7,2,0,1,6,28,39,39,29,7,0,0,5,53,74,77,63,8,0,5,29,43,39,52,34,7,0,3,5,17,18,26,17,6,0,4,13,12,14,15,6,4,0,0,8,48,64,58,9,0,0,2,19,50,58,56,15,0,0,4,27,47,49,40,13,2,1,5,8,11,11,8,6,0,0,5,9,9,8,9,8,0,0,3,4,5,4,6,6,0,0,3,5,7,5,6,6,0,0,3,5,4,4,7,5,0,0,3,4,4,6,8,8,2,3,8,9,9,10,12,10,2,2,5,3,1,0,0,0,0,1,4,4,2,1,2,3,2,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 902, 1389, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (38, '362', '2023-12-13 13:46:20', '0,2,3,6,11,10,4,0,0,3,4,8,12,9,4,0,0,1,11,20,25,20,9,0,0,6,21,37,40,38,26,5,0,4,26,106,103,87,31,3,0,10,27,54,47,39,20,5,5,11,24,30,25,24,14,6,6,14,30,32,33,31,23,8,0,5,45,71,60,45,8,0,0,8,46,61,45,39,12,1,2,12,43,67,44,34,10,0,1,12,26,20,14,17,11,0,4,7,10,8,10,9,5,2,0,8,7,6,5,5,3,0,0,5,5,6,8,7,2,0,0,5,5,3,6,9,3,0,2,7,8,9,9,9,6,0,4,17,16,14,19,21,10,4,0,2,4,0,4,5,2,0,1,6,1,5,2,3,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1485, 1739, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (39, '488', '2023-12-13 13:52:14', '3,6,6,10,13,9,4,0,0,7,10,10,29,10,4,3,0,11,13,14,22,17,8,0,5,18,36,45,47,46,17,4,12,27,54,88,99,101,48,5,17,29,40,64,75,64,30,6,12,12,28,32,31,31,11,7,9,20,32,48,37,29,20,9,0,11,37,66,69,48,12,0,6,12,49,59,59,54,9,0,4,12,60,80,72,56,11,3,7,18,26,28,19,25,12,0,7,10,17,14,10,8,6,0,9,12,14,15,5,6,3,2,8,10,10,12,12,8,3,0,6,7,5,8,6,8,1,0,6,20,8,12,11,10,5,0,7,23,38,10,12,22,6,4,6,10,6,6,2,4,2,0,2,7,7,2,2,5,4,1,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 2094, 2103, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (40, '307', '2023-12-13 14:00:36', '0,2,7,7,7,4,1,0,0,5,10,12,10,6,3,0,0,8,10,16,13,18,7,0,2,13,25,27,33,29,11,0,5,12,43,75,77,53,8,0,8,16,30,39,38,36,14,5,4,10,18,22,18,16,9,5,4,14,26,12,16,37,10,5,0,9,41,61,55,18,3,0,0,12,50,64,63,17,0,0,3,18,60,72,44,14,4,0,4,13,19,19,14,11,9,3,3,9,11,10,11,11,9,3,3,9,8,6,8,7,4,2,2,6,8,7,6,5,0,0,3,5,4,6,6,5,1,0,5,8,7,8,13,9,3,1,11,14,15,13,14,12,7,3,0,3,3,4,1,0,0,0,0,0,1,3,3,3,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1369, 1434, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (45, '062', '2023-12-13 15:04:11', '0,3,5,7,9,4,1,0,0,4,6,7,8,3,1,0,0,6,11,19,12,8,3,0,0,6,42,60,74,52,7,0,0,6,67,101,107,56,2,0,5,9,20,36,26,14,5,0,4,7,18,19,19,11,5,1,5,8,15,15,14,8,7,2,3,10,74,99,92,15,3,0,2,12,60,67,57,14,2,0,5,20,43,46,39,14,3,0,3,11,9,10,7,6,4,0,2,8,8,5,7,8,7,0,2,5,5,4,4,4,1,0,3,6,5,6,5,4,2,0,3,7,5,3,5,6,2,0,2,6,6,5,4,5,2,0,7,11,14,11,19,8,6,2,2,2,1,0,4,0,2,0,1,3,4,3,3,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1440, 1564, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (46, '411', '2023-12-13 15:07:01', '0,7,6,9,9,6,4,0,0,1,8,13,14,11,7,0,0,5,13,19,22,18,10,0,3,11,28,38,38,39,18,2,2,12,46,67,76,74,28,3,12,33,33,43,65,51,29,9,12,14,31,33,29,42,16,9,9,19,28,24,31,27,14,4,4,11,36,60,58,46,10,0,4,14,50,78,68,43,10,0,4,14,57,79,55,44,12,1,7,14,21,19,21,26,14,1,1,10,13,12,10,12,9,2,2,9,13,14,13,13,10,7,0,6,9,10,10,10,8,0,3,8,3,2,6,6,4,0,5,10,14,8,14,14,8,4,14,21,31,25,26,29,16,8,5,2,4,5,0,0,0,0,0,2,0,0,5,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1704, 1848, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (47, '091', '2023-12-13 15:08:33', '0,2,4,8,6,4,1,0,0,4,5,8,7,6,2,0,0,5,10,13,11,7,6,0,4,11,36,34,43,43,11,2,3,9,47,62,71,56,10,0,10,10,20,29,30,21,8,5,8,11,13,16,17,13,11,8,8,11,18,19,25,11,8,5,2,10,55,63,55,25,5,0,0,16,70,69,61,14,4,0,3,28,69,50,53,13,8,0,4,14,14,13,16,10,7,2,3,9,10,10,11,10,9,0,5,9,7,8,8,7,4,2,3,8,6,6,8,6,4,0,2,8,5,6,6,6,0,0,6,11,7,9,9,9,4,0,9,12,12,14,14,11,8,2,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1315, 1409, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (48, '042', '2023-12-13 15:10:14', '0,3,4,9,11,4,3,0,1,3,8,10,13,8,6,0,1,5,11,13,13,12,7,1,4,13,33,42,40,38,12,0,9,24,22,61,91,65,8,0,11,23,28,49,50,21,10,7,9,13,19,17,29,11,10,7,9,17,41,25,31,18,19,4,7,11,58,67,64,19,6,0,5,23,63,73,65,42,7,1,6,20,51,55,61,36,8,0,6,14,13,14,15,12,11,3,2,10,12,10,11,9,7,0,4,8,8,6,7,6,5,1,4,9,6,4,7,7,2,0,3,6,6,5,7,9,3,0,9,10,9,10,13,14,8,1,11,12,8,9,11,10,5,1,0,0,0,0,0,0,0,0,4,4,1,2,5,4,3,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1534, 1609, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (49, '010', '2023-12-13 15:11:55', '0,0,3,7,8,6,0,0,0,2,7,10,13,9,2,0,0,5,11,11,13,11,9,0,0,6,13,13,14,21,10,0,3,11,26,65,66,85,22,1,11,14,18,23,49,62,20,8,11,12,20,24,20,29,12,5,6,13,20,14,22,26,11,5,0,8,27,57,59,49,5,0,0,11,59,84,82,54,8,0,5,21,66,104,77,49,13,0,8,18,23,20,26,15,13,0,5,11,13,12,11,12,8,2,0,11,8,7,5,7,8,0,4,9,8,4,8,7,2,0,2,10,6,5,5,8,0,0,8,12,10,8,12,13,7,0,7,7,10,8,11,11,8,0,0,0,0,0,0,0,0,0,1,2,2,1,1,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1462, 1628, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (50, '071', '2023-12-13 15:13:35', '0,3,7,9,9,5,2,0,0,5,10,12,13,5,3,0,0,7,9,12,12,12,6,0,3,12,23,25,33,40,11,0,5,13,58,68,84,68,7,0,12,21,50,54,58,38,10,5,12,12,14,21,20,18,7,6,9,13,14,14,16,13,10,6,3,8,48,89,90,21,4,1,6,14,90,108,100,41,7,2,8,30,95,103,75,25,6,2,6,13,14,14,13,14,11,3,4,10,12,12,13,12,7,3,5,9,10,8,9,6,4,0,4,10,7,6,10,8,3,0,7,9,5,5,9,7,0,0,11,7,10,12,13,10,7,2,7,7,8,9,11,9,4,0,0,0,0,0,0,0,0,0,3,4,0,3,0,1,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1718, 1812, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (51, '78', '2023-12-13 15:18:08', '0,3,5,8,8,5,1,0,0,3,7,10,10,6,3,0,0,10,10,17,16,10,8,0,4,12,31,32,36,28,13,1,7,12,35,47,65,36,10,0,12,26,27,35,45,32,17,4,7,13,35,25,29,24,13,8,6,11,31,24,29,19,15,7,6,11,50,66,65,36,8,0,4,13,52,61,59,35,9,0,6,27,50,53,40,19,6,2,7,14,22,15,19,14,11,1,3,11,11,10,13,13,10,2,5,5,8,8,7,8,5,0,2,9,7,6,8,7,2,0,4,7,5,2,9,6,4,0,4,8,6,6,11,9,5,2,10,17,17,13,14,13,10,4,1,4,0,0,0,2,4,0,1,0,3,1,4,3,1,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1422, 1487, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (52, '104', '2023-12-13 15:19:57', '0,3,9,11,12,7,2,0,0,6,6,10,14,6,3,0,0,7,12,14,13,14,8,0,0,12,24,38,35,37,12,0,4,13,39,58,80,58,8,0,10,16,26,45,44,40,12,6,9,13,21,26,31,27,10,7,8,13,18,22,19,19,12,5,0,10,65,101,84,48,7,0,3,11,52,100,78,24,7,0,4,12,42,46,40,20,9,0,6,12,14,13,14,11,10,0,6,10,12,10,13,13,9,0,0,9,9,9,9,10,7,0,2,9,7,5,8,7,4,0,2,6,5,2,5,8,1,0,5,10,9,11,10,11,6,1,12,14,14,13,14,12,8,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1453, 1587, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (53, '067', '2023-12-13 15:25:00', '0,7,10,10,8,8,4,0,0,6,9,12,10,10,5,0,0,9,12,13,12,11,4,0,3,10,17,26,27,23,6,0,5,20,51,67,67,45,5,0,12,35,51,61,62,47,12,6,8,13,18,18,20,16,11,5,8,13,16,14,17,15,11,4,2,9,38,40,30,13,5,0,2,11,38,46,21,12,6,0,7,20,38,45,27,18,6,0,5,12,13,13,13,13,10,0,3,8,12,10,11,10,8,0,1,10,11,11,11,12,7,0,1,7,7,6,8,5,2,0,4,7,3,3,6,7,2,0,8,10,9,8,12,11,7,0,11,13,13,13,14,13,9,4,0,0,0,0,2,0,0,0,0,0,2,0,0,1,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1113, 1251, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (54, '119', '2023-12-13 15:27:03', '1,3,5,8,9,5,0,0,0,5,7,10,7,5,1,0,0,10,9,14,13,8,3,0,2,12,36,50,49,44,9,0,6,40,58,69,69,56,5,0,14,47,24,49,46,27,9,3,9,11,33,29,18,13,9,6,10,12,23,26,31,19,12,3,2,18,62,68,57,21,3,0,5,42,71,71,66,31,3,0,9,58,75,77,73,51,6,0,7,22,16,18,14,10,9,2,5,10,11,12,11,12,9,3,0,9,9,6,8,7,3,0,0,9,9,6,7,6,2,0,4,7,6,7,7,5,0,0,6,9,7,7,11,7,3,1,10,12,11,11,14,9,7,2,2,3,0,0,0,0,0,0,5,4,5,1,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1666, 1822, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (55, '014', '2023-12-13 15:30:34', '0,0,4,10,11,5,3,0,0,3,5,9,14,8,2,0,0,6,11,17,19,16,6,0,2,10,34,41,42,42,14,3,1,10,33,51,72,59,20,1,6,23,22,40,35,40,21,7,5,9,19,26,18,32,6,6,6,10,31,31,26,30,15,9,0,9,59,89,80,37,4,0,3,24,69,85,86,43,5,0,2,33,56,64,71,41,7,0,1,17,25,22,17,20,12,5,3,10,9,13,10,9,6,2,0,5,7,7,5,4,2,0,2,6,3,5,4,7,3,0,2,5,4,3,4,6,2,0,4,6,7,5,12,10,4,0,5,7,8,7,9,8,6,2,3,1,0,0,0,0,0,0,4,3,2,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1643, 1778, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (56, '224', '2023-12-13 15:32:23', '0,1,6,9,8,4,0,0,0,6,10,24,10,4,0,0,3,17,9,16,18,8,3,0,9,16,19,34,38,30,7,0,11,38,57,77,78,39,2,0,28,36,48,55,58,32,14,4,13,10,24,22,32,13,6,1,12,23,29,19,25,17,9,0,10,27,55,56,44,8,0,0,10,53,98,80,52,8,0,0,10,48,94,88,45,11,1,0,12,24,28,22,28,10,8,0,9,14,13,14,14,9,9,1,7,10,9,7,9,5,2,0,4,9,9,7,6,5,0,0,8,7,6,9,8,6,0,0,6,8,4,7,9,7,2,0,9,11,9,14,14,8,5,0,2,2,0,1,0,0,0,1,4,2,0,2,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1736, 1805, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (57, '288', '2023-12-13 15:34:15', '0,3,4,8,7,3,1,0,0,4,8,14,14,7,1,0,0,6,8,18,16,10,6,0,7,12,39,43,45,42,19,0,5,23,59,66,76,70,11,0,19,23,34,38,46,30,13,4,13,14,19,30,27,24,8,8,11,18,26,27,33,23,7,5,7,12,64,94,95,51,6,0,0,13,52,73,65,34,5,0,0,26,69,67,52,27,6,0,0,17,20,23,17,12,11,0,2,12,12,12,14,10,11,0,5,9,8,5,6,5,3,0,2,9,7,5,8,6,2,0,4,9,5,2,9,8,1,0,7,9,8,7,8,6,4,0,15,13,12,13,16,10,7,3,2,0,0,0,0,0,0,0,2,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1712, 1795, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (58, '021', '2023-12-13 15:36:26', '0,5,6,9,11,7,2,0,1,6,4,15,14,9,3,0,0,10,11,12,14,12,6,0,0,15,22,30,34,31,11,0,10,29,48,73,75,95,13,0,23,41,36,69,59,42,20,8,11,14,28,27,32,32,12,5,9,19,36,31,30,34,15,3,2,11,35,54,53,23,4,0,3,17,65,81,79,39,6,0,6,42,75,70,68,47,9,0,8,28,26,22,24,21,12,2,7,17,15,14,17,13,10,2,4,9,13,9,7,7,6,0,6,13,6,9,10,9,4,0,4,11,4,6,6,9,0,0,8,12,9,6,11,13,5,1,10,13,9,8,15,17,7,3,3,4,0,0,0,0,0,0,3,2,0,3,1,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1784, 1882, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (59, '043', '2023-12-13 15:38:59', '0,0,0,0,3,0,0,0,0,0,0,2,6,5,3,0,0,0,0,0,6,7,2,0,0,3,10,11,24,39,5,0,0,0,31,53,83,86,1,0,0,17,44,46,49,44,4,0,0,1,3,8,23,23,8,2,0,4,1,9,3,7,6,0,0,0,1,27,50,32,0,0,0,0,26,45,33,15,0,0,0,5,41,77,59,26,6,0,0,6,15,9,17,11,7,0,0,2,4,0,2,2,0,0,0,2,4,3,4,5,4,0,0,2,0,0,0,2,0,0,0,0,0,0,0,0,0,0,1,16,4,0,7,9,2,0,0,4,3,3,11,10,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1107, 1189, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (60, '154', '2023-12-13 15:41:28', '0,0,5,6,8,4,2,0,0,4,7,14,13,7,4,0,0,7,12,12,13,11,9,0,1,11,22,27,34,47,11,2,4,13,39,46,65,62,20,6,13,28,35,43,53,44,29,10,8,11,25,19,22,23,14,6,8,19,23,19,25,23,16,6,0,7,29,47,49,36,8,0,5,12,60,68,65,44,13,1,6,19,70,67,56,33,17,0,5,23,25,17,14,15,20,3,6,13,14,12,15,13,11,5,5,10,11,8,8,8,5,2,3,8,7,8,10,11,4,0,0,5,8,3,4,7,0,0,6,7,9,7,12,17,11,4,13,10,13,17,21,17,8,5,1,0,0,0,0,0,0,1,3,4,1,0,2,2,1,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1466, 1592, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (61, '168', '2023-12-14 16:47:27', '0,1,5,7,7,4,2,0,0,3,4,10,10,6,3,0,2,7,33,47,50,34,9,0,3,21,56,67,68,62,15,3,6,15,55,66,79,54,7,0,9,11,18,18,47,35,7,5,6,9,11,10,16,11,7,5,8,11,22,31,26,15,12,3,0,13,65,73,79,59,5,0,0,15,62,69,67,55,7,0,2,9,38,39,36,24,9,1,0,6,11,8,11,9,6,0,0,6,9,7,9,7,2,0,0,4,6,5,6,6,3,0,0,5,5,4,6,7,3,0,0,6,6,4,8,9,0,0,5,8,7,7,8,10,5,2,6,9,12,11,11,12,7,2,0,0,0,0,0,0,0,0,0,1,3,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1017, 1724, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (62, '136', '2023-12-14 16:49:26', '0,2,8,11,8,4,2,0,0,7,13,14,12,8,4,0,0,14,23,39,28,23,10,0,5,35,52,65,57,51,14,0,8,22,39,78,79,53,9,0,19,25,29,47,41,31,13,0,9,14,22,16,20,16,10,0,10,16,35,25,25,26,14,0,7,32,67,89,87,58,7,0,0,20,72,76,70,44,7,0,6,31,55,54,47,23,8,0,0,13,14,12,14,11,7,0,0,7,9,8,9,7,3,0,1,9,11,12,10,9,4,0,5,8,9,7,10,10,3,0,3,6,7,6,8,9,0,0,7,12,10,8,13,11,10,0,7,13,10,11,27,23,11,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1792, 1896, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (63, '043', '2023-12-14 16:51:26', '0,6,10,10,11,9,1,0,2,8,14,16,15,12,5,0,5,11,14,20,24,16,8,0,6,14,37,54,87,52,8,0,6,11,13,53,65,40,7,0,8,12,17,20,32,26,13,2,4,10,11,14,13,13,9,3,6,12,45,19,15,14,11,1,3,10,64,84,83,60,3,0,1,10,64,76,73,58,8,0,0,11,38,35,37,31,10,0,0,5,8,9,9,11,3,0,1,3,6,7,7,8,0,0,3,7,9,9,10,8,2,0,2,8,8,5,8,10,6,0,2,10,8,6,5,8,0,0,6,9,12,9,9,11,9,0,6,8,8,8,7,7,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1479, 1537, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (64, '267', '2023-12-14 16:53:38', '0,1,10,13,13,7,4,0,0,6,13,21,21,16,9,0,0,15,51,47,51,50,14,0,1,28,53,62,68,61,25,0,4,26,55,67,77,60,21,0,8,18,33,40,42,37,18,8,3,12,22,24,21,23,9,2,3,18,35,26,29,29,18,4,0,19,67,82,75,60,13,0,0,9,59,76,63,52,8,0,0,11,39,42,42,26,10,0,0,10,18,14,13,12,10,0,0,0,0,7,5,4,0,0,0,0,6,8,8,8,4,0,0,1,10,6,10,9,2,0,0,5,3,0,0,5,0,0,2,14,12,13,10,12,7,0,4,12,19,15,24,22,11,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1855, 1953, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (65, '359', '2023-12-14 16:58:01', '0,5,7,10,11,7,3,0,0,8,8,12,14,9,5,0,2,12,17,26,39,24,10,0,5,19,41,76,100,72,13,0,5,10,11,63,99,43,7,0,8,12,15,21,18,17,7,6,6,12,18,16,14,13,10,5,9,16,31,33,36,20,12,2,5,31,73,86,87,42,6,0,3,21,72,67,76,42,1,0,4,18,26,32,29,17,5,0,3,7,11,8,9,11,4,0,0,4,4,5,7,7,0,0,2,6,8,10,10,9,3,0,1,9,6,7,10,10,1,0,5,10,7,8,8,11,4,0,8,11,9,12,11,12,7,3,11,11,13,12,15,12,11,4,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1519, 1673, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (66, '076', '2023-12-14 16:59:53', '0,5,8,8,7,4,0,0,1,6,11,10,7,5,1,0,3,17,41,53,18,12,3,0,9,39,54,66,56,14,6,0,7,22,45,70,60,36,2,0,12,29,44,38,40,16,7,1,10,11,25,21,21,13,11,2,11,29,46,29,50,40,12,2,3,30,68,78,69,37,4,0,8,40,67,62,56,40,2,0,6,24,45,45,27,15,5,0,4,12,11,10,11,11,0,0,0,5,7,6,7,9,0,0,2,10,9,9,8,9,0,0,6,9,5,3,5,8,2,0,7,9,6,7,7,11,6,0,6,7,10,8,11,11,7,2,9,13,10,8,9,10,8,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1664, 1760, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (67, '191', '2023-12-14 17:06:56', '0,2,6,0,7,8,0,0,0,0,0,0,5,3,0,0,0,0,7,2,19,8,3,0,0,4,35,35,43,45,14,0,1,8,45,53,67,59,9,0,7,20,21,28,36,37,15,0,0,4,2,3,7,11,0,0,0,5,29,24,17,15,4,4,3,4,61,61,61,48,4,0,0,6,54,61,61,47,8,0,0,12,38,47,35,27,8,0,0,11,14,6,12,14,12,0,0,7,11,2,10,10,5,0,4,2,10,6,11,10,8,0,0,8,9,3,9,10,7,0,0,3,2,0,0,0,0,0,0,5,4,0,10,10,9,0,8,12,9,9,14,11,9,5,1,2,3,0,0,2,5,0,0,0,6,0,2,3,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1358, 1413, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (68, '92', '2023-12-14 17:08:46', '0,7,7,7,10,6,3,0,2,3,11,13,15,13,6,0,0,12,15,28,22,26,10,0,4,30,40,52,43,57,17,2,5,31,57,73,86,60,16,0,9,31,36,39,42,39,25,7,9,24,29,28,27,29,14,8,11,28,48,38,35,30,22,6,3,23,75,91,87,54,8,0,7,29,60,76,77,56,13,0,7,25,48,48,50,38,12,0,5,11,24,16,19,23,12,0,3,10,11,9,12,8,4,0,0,10,9,8,7,6,4,0,2,10,10,9,6,6,5,0,4,9,8,7,9,9,5,0,6,8,6,7,8,16,7,4,9,21,21,19,23,25,16,7,1,0,0,1,1,6,1,1,2,0,1,0,1,4,1,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1889, 1997, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (69, '348', '2023-12-14 17:12:08', '1,6,5,7,8,8,5,0,0,5,8,6,7,7,7,0,0,3,12,5,8,5,3,0,0,5,30,38,27,15,5,0,4,21,44,65,79,58,7,3,12,22,36,41,40,39,8,2,6,7,14,7,19,13,10,1,5,16,37,23,28,20,7,2,1,18,62,80,79,40,4,0,0,17,62,72,68,39,8,0,1,11,44,33,33,16,5,0,0,6,16,7,9,8,8,0,0,0,0,5,5,4,6,0,3,3,5,3,5,5,7,0,5,4,6,8,6,1,2,0,4,8,7,2,6,3,6,0,0,22,10,3,6,4,9,4,4,36,12,10,18,12,16,4,4,0,3,0,2,0,0,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1469, 1544, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (70, '363', '2023-12-14 17:14:58', '0,4,5,11,11,3,1,0,0,7,11,13,14,9,5,0,2,13,20,25,19,16,7,0,7,33,31,48,44,28,11,2,8,39,64,85,73,34,5,0,14,32,67,29,39,29,17,5,12,22,25,32,30,21,12,7,12,22,48,30,39,29,11,7,8,46,78,87,69,26,4,0,5,42,81,75,59,21,6,0,9,36,55,41,35,16,7,0,7,16,17,14,8,8,5,0,1,10,12,11,12,9,7,1,0,7,6,8,6,7,3,1,6,8,9,8,9,9,6,1,5,7,6,6,6,10,1,0,6,9,9,9,9,10,7,1,10,22,14,15,20,17,8,5,2,0,0,0,1,2,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1672, 1847, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (71, '239', '2023-12-14 17:21:41', '3,1,7,9,7,3,0,0,2,0,15,14,17,6,0,0,0,6,12,25,17,7,0,0,2,25,40,47,41,28,4,0,7,38,52,76,65,41,1,0,13,25,39,41,40,25,11,0,10,22,35,24,33,21,8,5,7,28,35,28,29,23,9,0,4,37,82,85,80,30,7,0,5,41,79,84,73,36,6,1,0,34,57,53,49,23,7,1,1,8,13,9,11,10,1,0,2,6,7,5,6,9,3,0,1,5,9,4,5,5,2,0,4,3,5,7,7,8,5,0,7,10,6,4,11,7,6,0,8,13,13,6,5,15,3,1,2,8,6,5,4,10,4,0,4,0,0,0,0,0,0,0,3,5,7,4,7,3,2,2,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1676, 1833, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (72, '152', '2023-12-14 17:23:21', '0,6,3,20,19,14,4,0,0,5,4,4,12,11,2,0,0,10,24,23,28,19,6,0,0,13,32,22,32,28,23,0,5,24,45,52,90,56,23,0,12,28,42,32,47,40,30,6,7,11,22,25,31,28,9,3,8,28,41,37,34,32,18,9,1,6,70,81,71,59,5,0,0,0,43,77,68,47,10,0,4,12,63,70,68,45,18,0,0,16,38,31,25,29,22,0,2,10,13,7,14,14,12,0,0,4,9,12,8,12,9,0,0,6,11,7,7,9,6,0,0,0,4,0,4,5,4,0,3,10,25,6,15,19,19,7,7,33,44,21,17,29,33,10,0,2,2,0,4,4,1,3,1,8,5,0,0,4,3,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1856, 1935, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (73, '069', '2023-12-14 17:25:03', '0,5,6,9,7,5,1,0,1,5,8,14,12,5,2,0,2,13,15,23,16,10,6,0,6,16,41,30,28,20,9,0,7,21,46,59,55,39,3,0,13,14,34,43,48,28,11,6,13,14,24,23,30,16,12,6,10,14,37,22,23,27,12,3,4,28,89,89,64,26,3,0,5,44,105,86,66,16,4,0,6,37,74,53,53,21,6,0,4,14,19,16,16,12,11,0,2,9,11,10,12,10,5,0,3,6,10,8,8,7,6,0,3,6,7,9,10,7,1,0,4,7,5,2,7,4,0,0,8,11,12,10,14,13,1,0,8,10,12,13,16,12,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1596, 1696, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (74, '230425-036', '2023-12-14 17:26:54', '0,2,7,8,9,4,3,0,0,6,5,11,6,6,3,0,0,8,18,27,15,12,6,0,4,17,41,46,49,46,13,0,5,15,26,57,59,41,7,0,8,12,37,33,29,19,7,6,9,10,14,13,20,13,10,7,8,21,52,26,33,25,11,4,3,21,68,86,78,45,6,0,3,41,72,71,75,53,6,0,3,21,45,28,38,33,7,0,0,9,11,12,9,6,5,0,0,5,9,10,10,10,6,0,1,7,8,6,5,5,6,0,0,8,9,8,8,8,3,0,2,5,10,9,6,11,0,0,4,9,8,8,11,11,8,1,4,8,11,7,9,10,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1481, 1616, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (75, '048', '2023-12-14 17:30:25', '0,3,8,9,7,5,1,0,0,6,9,12,12,7,4,0,0,7,11,14,12,10,6,0,3,17,39,47,51,38,9,0,8,26,50,68,69,57,8,0,10,17,47,53,52,48,10,5,6,9,14,15,14,13,8,0,6,12,27,15,21,17,9,0,4,12,53,67,55,34,1,0,4,14,65,75,70,42,7,0,2,28,69,72,62,41,9,0,6,13,15,14,13,12,11,0,0,7,11,8,10,10,5,0,0,7,11,8,7,9,6,0,0,3,8,9,8,8,3,0,1,7,7,3,7,7,0,0,2,7,10,8,14,27,10,0,4,11,13,13,14,14,9,1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1562, 1687, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (76, '032', '2023-12-15 09:38:15', '0,2,9,13,13,6,3,0,0,5,9,12,16,10,2,0,0,9,15,28,32,25,10,0,0,8,31,47,56,53,11,0,0,14,59,79,103,71,9,1,10,41,34,46,41,32,23,6,7,11,25,23,26,26,7,0,7,19,36,33,33,33,14,2,2,13,73,97,90,56,8,0,1,17,57,82,86,55,10,0,0,13,65,83,63,40,11,3,1,13,19,13,14,17,8,0,0,4,9,9,11,10,1,0,1,6,9,8,7,10,4,0,1,5,9,9,7,7,6,0,0,3,7,4,6,10,6,0,4,11,12,9,11,16,11,4,7,13,10,12,10,17,10,5,2,0,0,2,0,5,0,0,2,2,1,1,3,3,3,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1848, 2019, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (77, '399', '2023-12-15 09:41:46', '0,1,7,7,8,5,3,0,0,4,6,9,12,9,3,0,0,7,14,30,17,18,7,2,1,8,29,48,48,49,23,1,3,8,28,49,97,68,22,0,6,17,22,44,32,30,18,3,5,8,20,25,27,28,9,4,4,11,22,25,23,30,13,7,4,9,69,80,78,58,10,1,2,11,49,76,85,67,10,2,5,10,44,63,35,36,10,0,4,10,14,13,12,14,7,2,3,7,12,10,9,10,5,0,0,3,9,7,6,6,3,0,1,3,3,5,4,4,3,0,2,6,7,5,6,7,4,0,3,8,9,7,7,8,6,2,7,14,21,13,15,20,11,6,1,3,0,2,3,3,0,0,0,3,2,4,2,4,3,1,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1651, 1727, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (78, '489', '2023-12-15 09:44:28', '0,4,6,17,28,16,8,0,0,5,9,20,44,19,11,0,0,11,19,18,35,33,17,0,1,8,25,57,71,57,48,7,0,11,50,101,111,117,72,6,13,57,51,63,77,75,49,12,9,14,35,31,37,39,20,5,8,11,16,30,29,41,19,3,4,12,28,79,71,64,16,0,0,9,24,56,58,33,9,0,4,13,46,74,86,58,16,0,4,34,31,27,31,32,18,0,7,13,21,10,12,18,9,0,4,10,17,12,12,11,7,0,8,7,6,11,13,12,6,0,8,11,9,9,8,11,5,0,6,7,13,11,12,25,11,0,33,38,32,19,28,44,31,6,6,6,1,6,0,0,0,0,0,1,3,1,2,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1461, 2369, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (79, '025', '2023-12-15 09:46:28', '0,2,6,12,11,4,3,0,0,4,7,19,32,9,3,0,0,9,16,34,35,38,11,0,6,35,60,63,68,62,13,1,5,43,54,78,87,67,5,0,10,19,36,41,52,50,16,1,6,11,16,26,43,25,11,0,7,14,45,38,27,17,11,0,4,25,66,75,75,53,5,0,3,31,66,69,69,37,6,0,5,39,53,55,39,33,6,0,3,14,15,13,14,14,8,0,0,6,7,9,9,8,2,0,0,9,10,10,10,11,3,0,0,7,9,7,8,10,4,0,1,9,5,4,4,10,2,0,6,11,9,9,8,13,6,2,9,21,14,12,18,18,9,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1932, 2036, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (80, '088', '2023-12-15 09:49:00', '0,3,6,9,11,8,3,0,0,6,9,9,11,6,4,0,0,6,11,13,14,18,10,0,0,11,33,52,58,60,20,3,3,10,17,53,84,76,22,1,8,10,12,17,17,31,12,6,5,8,10,13,12,13,10,4,4,10,12,13,12,13,11,3,0,8,34,68,82,87,11,0,0,10,55,75,86,81,10,0,0,12,40,56,55,49,13,0,0,9,10,10,8,11,6,0,0,2,7,7,5,9,5,0,0,4,8,9,9,9,5,0,0,7,8,7,7,10,4,0,2,8,9,6,5,8,2,0,6,10,12,10,8,9,9,3,4,7,9,10,10,13,8,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1356, 1559, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (81, '172', '2023-12-15 09:50:52', '0,2,5,10,12,10,3,0,0,4,8,11,14,12,8,1,0,6,10,14,16,21,10,0,1,11,21,42,53,61,17,0,4,11,45,67,101,99,18,0,12,13,19,40,29,33,13,8,7,10,13,14,14,13,8,5,6,11,14,14,14,14,10,1,4,7,51,68,72,62,11,0,5,11,56,68,71,59,12,0,4,13,53,55,55,52,10,0,0,9,11,10,11,11,6,0,0,3,7,7,7,8,0,0,1,6,10,9,9,10,2,0,0,7,10,9,8,8,1,0,0,6,9,8,8,10,0,0,5,10,9,8,9,11,7,3,4,14,14,13,13,13,10,3,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1087, 1635, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (82, '022', '2023-12-15 09:53:03', '0,4,9,12,14,8,6,0,0,4,12,14,14,11,7,0,0,9,21,28,33,33,9,1,0,12,56,64,73,69,30,5,0,10,47,60,88,68,28,2,9,21,32,37,32,36,21,8,4,10,15,19,20,30,12,6,3,13,25,30,30,30,15,9,0,8,59,78,81,69,23,0,0,9,58,76,77,58,22,0,2,12,46,50,42,29,13,1,0,8,12,11,13,14,11,0,0,1,4,3,3,6,1,0,0,7,10,11,11,11,7,0,0,9,10,10,11,12,8,0,2,10,12,7,9,12,5,0,8,11,13,11,12,14,14,4,10,21,22,18,23,24,15,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1282, 1919, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (83, '193', '2023-12-15 09:55:13', '1,3,6,10,11,6,2,0,0,5,9,11,12,10,5,0,2,8,10,27,35,32,10,2,4,9,35,46,57,53,15,0,3,9,26,61,97,61,8,0,9,18,27,28,27,19,16,7,8,12,15,23,14,29,12,6,7,16,35,24,31,41,18,6,1,11,50,94,97,67,11,0,0,8,53,75,64,49,13,0,0,11,51,40,32,30,13,1,2,10,13,11,13,19,9,0,1,5,8,9,6,7,4,0,1,6,6,7,7,7,4,0,2,4,9,6,8,8,4,0,2,9,7,5,4,8,5,0,2,8,9,10,7,9,8,2,10,28,21,14,15,25,11,5,2,4,3,2,3,3,3,1,3,4,3,0,3,5,2,1,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1606, 1736, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (84, '379', '2023-12-15 09:58:24', '0,2,5,9,12,6,2,0,0,2,5,10,17,6,2,0,2,4,16,30,36,36,10,0,3,19,49,58,64,63,31,2,5,33,52,69,85,66,29,0,13,32,43,46,52,49,28,8,8,13,22,26,23,32,11,5,9,13,30,28,29,31,13,3,3,10,51,61,61,53,9,0,6,10,47,65,61,53,11,0,4,14,53,56,52,47,11,0,3,7,14,14,15,9,10,0,1,10,10,9,9,9,4,0,3,10,9,7,7,9,9,0,2,7,9,9,6,7,4,0,4,9,7,6,5,8,4,0,3,6,6,5,6,7,5,0,7,14,15,14,17,27,11,5,3,4,2,2,0,1,0,0,2,4,1,1,3,4,3,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1812, 1928, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (85, '390', '2023-12-15 10:02:36', '0,2,6,5,9,6,3,0,0,3,6,7,10,4,3,0,1,6,12,17,36,33,17,3,2,7,43,48,58,62,42,5,3,8,23,48,75,70,41,1,8,15,26,32,23,25,9,6,10,10,12,13,14,19,12,6,8,12,15,25,24,23,14,7,4,7,36,57,67,61,17,0,5,7,41,57,59,60,31,0,2,10,34,33,36,35,13,1,3,10,12,11,11,12,10,0,4,7,8,8,8,10,4,0,3,9,9,7,6,8,5,0,3,9,8,4,4,7,5,0,5,9,6,5,7,10,4,0,4,8,8,6,6,7,8,2,6,12,13,12,11,12,10,4,3,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1450, 1555, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (86, '386', '2023-12-15 10:06:09', '0,3,6,10,6,3,0,0,0,5,11,12,12,8,3,0,0,9,13,18,17,12,7,0,3,11,25,36,40,39,11,0,4,15,39,60,73,51,8,2,10,22,30,30,30,27,20,5,8,11,12,14,20,15,12,6,7,14,22,25,24,15,9,1,4,15,76,101,78,37,5,0,0,13,51,53,46,17,7,0,0,25,53,57,42,29,7,0,0,9,15,13,13,14,11,0,0,8,10,8,8,8,1,0,0,7,11,8,7,8,4,0,0,7,7,8,8,6,0,0,2,8,9,7,10,9,3,0,1,6,8,7,10,10,6,3,6,13,13,14,16,24,9,2,0,2,3,0,0,2,0,0,0,0,3,1,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1416, 1497, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (87, '230220-036', '2023-12-15 10:07:58', '0,6,7,9,11,11,7,0,1,5,9,12,10,10,10,0,0,7,9,12,11,12,7,0,0,11,12,14,19,22,9,0,7,14,24,33,76,44,11,1,10,13,14,21,24,13,13,7,9,11,13,17,13,13,10,6,9,14,24,29,18,26,14,6,3,12,63,71,73,59,7,0,4,31,66,66,73,58,7,0,8,38,61,58,64,57,10,0,4,11,13,12,13,14,8,0,0,6,8,9,9,10,3,0,0,6,8,9,9,11,4,0,0,9,7,7,6,9,4,0,0,8,8,7,5,6,0,0,6,10,9,9,10,14,8,5,6,9,11,8,14,11,9,4,0,0,0,0,0,0,0,0,1,0,2,0,0,3,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1341, 1455, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (88, '438', '2023-12-15 10:12:32', '0,1,5,6,8,7,1,0,0,4,10,10,18,7,3,0,0,7,15,22,33,14,10,0,5,11,37,52,53,47,23,2,6,9,46,63,83,64,28,2,10,17,24,37,46,32,16,9,10,11,19,22,29,23,11,4,7,13,17,30,23,22,13,3,6,13,61,76,76,60,8,0,4,19,66,82,77,50,11,0,8,29,66,74,70,45,11,3,2,16,17,14,14,14,10,1,1,7,9,9,10,8,3,0,0,8,11,12,11,9,2,0,0,7,5,7,11,9,0,0,4,8,4,6,7,9,1,0,7,14,12,9,16,15,7,2,10,20,18,13,14,14,11,5,0,0,0,0,0,0,0,0,1,2,0,0,2,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1749, 1848, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (89, '491', '2023-12-15 10:14:20', '0,3,5,7,7,7,1,0,0,4,9,10,12,5,2,0,1,8,9,12,14,11,8,2,3,12,25,50,53,49,12,0,3,13,36,55,73,58,6,0,11,12,26,33,41,27,12,7,7,8,13,13,21,13,9,4,8,11,14,23,15,23,11,0,3,10,52,69,66,57,8,0,3,12,56,64,68,55,9,0,3,13,51,58,55,36,9,0,5,11,12,11,11,11,9,0,0,5,7,7,5,7,2,0,0,6,8,9,9,10,3,0,1,6,8,7,7,7,4,0,4,8,7,6,5,7,3,0,5,8,8,9,8,10,8,1,8,11,12,10,12,13,9,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 1446, 1509, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (90, '434', '2023-12-15 10:16:43', '0,4,8,9,10,8,0,0,0,3,9,14,20,7,3,0,0,6,10,13,12,11,6,0,0,10,14,46,52,50,12,0,5,16,69,71,77,68,33,0,13,31,47,60,58,56,26,9,11,14,31,31,31,33,14,6,4,13,19,30,26,19,15,3,1,12,58,73,71,59,8,0,3,14,72,84,85,63,12,0,3,32,83,91,89,64,12,2,3,16,36,33,28,30,18,2,0,6,14,12,10,11,8,0,0,8,12,13,11,12,7,0,0,6,8,7,9,5,4,0,3,8,7,6,7,8,3,0,7,11,12,10,12,14,9,1,8,12,18,14,15,14,9,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '20', 2049, 2118, 1, 0, '');
INSERT INTO `renhe_collect` VALUES (95, '378', '2023-12-22 10:54:38', '0,4,4,7,8,12,7,0,0,4,9,11,14,40,14,0,0,9,14,23,47,57,32,3,1,9,13,56,88,79,60,4,0,8,13,68,97,90,42,3,6,14,24,44,43,50,16,9,5,10,11,13,13,17,11,7,2,17,47,22,44,19,30,6,0,10,101,103,79,80,19,4,0,11,70,64,56,47,12,5,0,9,14,22,13,11,8,0,0,9,11,9,6,10,9,0,0,3,6,1,0,6,0,0,2,7,6,6,5,8,7,0,0,8,7,5,5,9,4,1,0,5,3,0,4,6,0,0,1,3,8,7,9,10,6,0,10,12,14,12,14,14,15,4,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'pro', '20', 1549, 1933, 1.5, 0, '');
INSERT INTO `renhe_collect` VALUES (96, '479', '2023-12-22 10:58:28', '0,0,4,4,6,7,4,0,0,3,8,10,15,13,5,0,0,4,11,9,16,18,7,0,0,3,12,21,60,51,14,2,1,7,18,60,88,71,44,4,4,10,16,45,43,36,30,8,2,8,14,14,17,24,7,6,3,13,38,69,38,44,18,5,0,5,38,76,81,76,14,1,1,7,72,80,68,60,17,1,1,12,50,72,43,41,13,2,1,7,12,10,9,13,9,2,0,2,5,4,8,10,9,0,0,7,9,8,9,12,6,0,0,3,6,6,9,10,2,0,0,4,8,5,4,8,4,0,3,9,10,11,11,13,8,0,7,12,15,15,21,19,15,5,2,0,0,0,2,0,0,0,0,2,3,4,3,2,1,0,0,0,0,0,0,0,0,0', '2033', 'pro', '20', 1253, 1795, 1.5, 0, '');
INSERT INTO `renhe_collect` VALUES (97, '100', '2023-12-22 11:00:09', '0,0,2,4,7,7,3,0,0,2,6,8,11,14,6,0,0,2,6,10,12,18,10,0,0,4,10,19,44,59,45,5,0,4,9,51,74,84,59,3,6,10,18,51,41,47,32,8,8,9,12,14,11,18,10,6,5,11,23,16,13,41,16,7,0,7,39,89,83,89,12,2,0,6,44,74,84,82,17,4,0,4,18,44,39,23,10,3,0,2,12,8,8,12,9,1,0,2,8,7,7,9,6,0,0,3,10,7,4,8,5,0,0,5,8,7,7,7,3,0,0,1,8,6,5,6,4,0,0,3,9,8,9,11,6,3,4,11,14,13,12,13,11,4,0,0,0,0,0,0,2,0,0,2,0,0,0,2,0,0,0,0,0,0,0,0,0,0', '2033', 'pro', '20', 1508, 1645, 1.5, 0, '');
INSERT INTO `renhe_collect` VALUES (98, '295', '2023-12-22 11:02:09', '0,2,1,3,5,4,1,0,0,0,6,7,12,11,4,0,0,2,9,10,13,18,6,2,0,0,19,49,64,57,37,3,0,5,15,76,89,81,45,4,5,11,21,52,57,56,33,7,5,13,23,40,15,37,8,8,3,13,48,21,24,46,30,6,3,11,75,92,102,68,9,0,0,12,81,95,95,48,8,3,0,12,63,83,79,20,6,0,3,10,13,12,12,14,7,0,3,9,12,8,11,9,6,0,2,6,10,7,9,6,4,0,3,9,8,8,7,6,2,0,0,5,6,6,6,6,1,0,3,6,6,7,10,7,3,1,7,8,11,13,10,10,6,3,0,0,0,0,0,1,0,0,0,4,0,2,4,1,0,0,0,0,0,0,0,0,0,0', '2033', 'pro', '20', 2035, 2057, 1.5, 0, '');
INSERT INTO `renhe_collect` VALUES (99, '366', '2023-12-22 11:03:53', '0,0,0,0,4,6,5,1,0,0,1,6,14,15,12,3,0,2,4,15,35,51,17,3,0,0,8,52,60,54,48,3,1,5,16,78,103,82,59,5,4,17,38,49,56,41,36,7,7,10,15,40,21,34,13,5,0,8,40,49,50,46,29,3,0,4,54,121,113,73,35,0,2,7,43,60,78,66,10,0,0,11,47,58,49,41,7,0,0,2,8,8,4,7,5,0,0,2,3,4,1,3,2,0,0,6,9,9,12,8,7,4,0,5,6,8,9,8,5,4,2,4,5,2,2,6,4,0,0,10,9,8,9,9,6,4,5,34,16,18,39,39,36,5,0,9,6,5,6,5,0,2,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'pro', '20', 857, 2221, 1.5, 0, '');
INSERT INTO `renhe_collect` VALUES (100, '154', '2023-12-22 11:05:52', '0,0,4,6,7,6,4,0,0,0,5,10,12,8,3,0,0,4,8,11,13,18,7,1,0,2,10,45,69,61,64,6,0,0,10,59,81,89,70,5,4,12,15,54,46,48,34,12,0,2,10,12,14,17,13,7,5,7,13,21,17,37,19,5,0,1,20,67,87,81,17,5,0,4,20,66,81,67,18,4,0,7,23,57,56,53,19,8,0,10,18,10,8,13,15,2,0,7,7,4,9,12,10,3,0,4,8,7,9,9,5,2,0,7,6,6,8,6,4,0,1,3,8,3,3,8,6,1,2,6,8,7,9,11,6,4,5,10,13,14,14,16,12,5,0,0,1,0,0,0,0,2,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'pro', '20', 1574, 1752, 1.5, 0, '');
INSERT INTO `renhe_collect` VALUES (101, '119', '2023-12-22 11:07:32', '0,0,5,6,10,9,2,0,0,4,8,9,13,10,3,1,0,9,9,13,18,12,6,0,2,11,15,60,85,85,51,5,5,11,14,87,97,94,53,1,8,14,14,55,44,49,15,9,5,9,12,14,13,13,11,5,7,12,45,41,23,36,12,8,1,12,82,101,95,79,7,0,1,13,91,103,92,78,8,0,1,13,79,76,77,40,9,3,2,11,10,8,8,12,8,0,0,7,7,4,7,8,6,4,0,4,5,6,10,9,2,1,1,9,6,4,6,7,3,0,2,5,6,4,3,7,4,0,4,7,7,6,10,7,5,1,7,11,10,10,13,12,9,4,0,0,0,0,0,0,1,0,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'pro', '20', 1823, 2141, 1.5, 0, '');
INSERT INTO `renhe_collect` VALUES (102, '78', '2023-12-22 11:09:14', '0,5,6,8,8,5,1,1,0,3,9,14,12,6,3,0,3,16,12,43,37,19,6,0,4,14,54,65,62,54,11,3,2,10,51,102,79,41,13,2,8,20,47,73,63,50,32,9,5,10,35,38,43,33,16,9,1,10,47,40,45,34,12,8,4,13,87,107,104,46,8,3,1,11,58,70,67,24,7,3,2,14,56,64,68,41,10,2,1,11,14,17,16,31,8,1,0,6,11,11,11,11,8,0,0,4,14,8,8,7,3,0,0,8,13,8,12,5,4,0,0,6,9,7,8,7,3,1,2,8,7,5,11,11,6,2,6,11,20,16,14,14,15,4,3,0,1,5,0,1,2,0,0,4,3,2,0,3,3,1,0,0,0,0,0,0,0,0', '2033', 'pro', '20', 1903, 2146, 1.5, 0, '');
INSERT INTO `renhe_collect` VALUES (103, '042', '2023-12-22 11:11:13', '0,4,4,9,11,7,1,0,2,5,8,9,12,9,5,0,2,7,10,12,15,14,7,1,4,11,14,65,71,66,17,0,6,13,13,88,154,121,33,2,7,24,48,51,81,49,15,8,7,9,13,13,43,42,12,8,5,14,24,58,16,20,17,9,3,7,76,97,101,85,9,1,3,8,60,75,63,50,10,3,6,9,56,56,71,45,10,3,4,12,14,11,10,15,13,0,5,9,12,7,9,10,8,0,1,9,11,4,6,7,7,0,1,7,6,6,5,7,5,0,2,8,4,6,5,8,5,0,2,7,9,7,7,11,9,2,7,38,12,10,12,18,13,5,1,0,0,0,0,0,0,0,2,1,3,3,4,5,3,2,0,0,0,0,0,0,0,0', '2033', 'pro', '20', 1976, 2132, 1.5, 0, '');
INSERT INTO `renhe_collect` VALUES (104, '091', '2023-12-22 14:13:12', '0,2,3,4,4,3,2,1,0,2,3,5,7,5,2,0,1,3,8,9,9,7,4,1,1,4,9,22,54,63,15,2,0,3,37,78,98,97,61,1,2,5,10,45,41,31,9,5,3,7,10,13,18,17,6,6,2,7,14,15,16,12,5,5,3,5,15,76,105,76,10,3,0,5,40,104,144,122,12,2,0,8,19,70,117,78,10,1,0,8,13,13,11,8,8,3,3,7,8,9,10,7,4,0,0,5,6,5,5,5,3,0,0,3,8,6,5,5,2,0,0,3,7,5,6,6,2,0,2,6,9,8,8,7,4,2,3,10,8,10,10,11,6,1,0,0,0,2,0,0,0,0,1,5,7,3,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'pro', '20', 1749, 1862, 1.5, 0, '');
INSERT INTO `renhe_collect` VALUES (105, '411', '2023-12-22 14:16:22', '0,0,0,6,7,4,3,0,0,2,5,9,14,12,3,0,0,0,8,18,40,37,6,0,0,7,10,67,78,73,46,4,0,2,13,83,109,104,72,3,3,11,37,60,47,51,47,7,6,9,13,44,43,59,33,4,6,14,23,44,47,42,14,8,0,9,35,78,94,90,16,4,1,8,47,87,99,95,14,0,4,12,73,90,72,63,12,3,2,9,14,13,16,32,13,0,0,11,14,10,10,11,7,1,5,11,11,7,8,9,4,0,1,8,10,7,8,6,6,2,0,5,6,3,2,6,4,0,3,10,10,7,10,9,7,2,5,11,20,13,14,39,35,4,2,2,4,0,0,2,2,2,0,0,2,0,1,0,1,0,0,0,0,0,0,0,0,0', '2033', 'pro', '20', 2162, 2427, 1.5, 0, '');
INSERT INTO `renhe_collect` VALUES (106, '307', '2023-12-22 14:21:05', '0,4,6,8,8,8,4,0,0,2,7,9,9,9,3,2,0,3,8,17,38,47,12,3,0,6,11,58,72,77,49,4,0,3,12,85,115,114,52,4,3,14,19,65,59,56,36,11,3,7,14,18,14,20,13,6,3,12,45,22,43,47,15,8,0,9,56,101,98,75,10,0,0,7,76,103,119,63,11,0,0,10,65,73,53,24,7,3,0,10,14,10,11,12,11,1,0,6,9,8,10,10,5,0,0,10,12,8,9,8,5,0,0,9,10,8,9,6,3,3,0,3,4,5,4,6,5,0,2,8,9,9,11,11,8,2,5,11,12,12,13,14,9,4,2,6,3,3,2,2,0,0,0,0,3,5,1,0,0,0,0,0,0,0,0,0,0,0', '2033', 'pro', '20', 1979, 2207, 1.5, 0, '');
INSERT INTO `renhe_collect` VALUES (107, '404', '2023-12-22 14:23:04', '0,0,3,3,6,7,3,0,0,3,3,6,11,17,5,2,0,5,5,11,36,59,16,2,0,5,11,24,71,76,58,5,0,2,7,65,103,112,69,4,4,11,14,40,41,61,39,9,5,9,11,18,19,41,13,6,6,12,17,19,23,37,7,6,3,8,21,73,96,99,14,0,3,8,14,51,80,73,11,0,2,11,24,46,53,38,12,2,3,12,13,12,12,13,7,0,7,9,10,7,9,9,9,0,3,8,10,8,4,7,5,0,1,7,9,5,5,5,5,0,1,6,5,5,5,6,4,0,2,6,8,5,9,9,5,1,6,13,10,13,16,20,13,3,2,7,4,1,1,1,0,0,3,3,4,3,2,2,0,2,0,0,0,0,0,0,0,0', '2033', 'pro', '20', 1158, 1871, 1.5, 0, '');
INSERT INTO `renhe_collect` VALUES (108, '247', '2023-12-22 15:51:17', '0,3,10,10,11,11,3,0,0,9,9,11,23,12,5,0,0,12,13,19,41,51,10,1,6,12,21,71,83,83,40,3,2,9,14,78,92,79,11,1,7,13,24,50,57,48,11,9,2,8,20,14,15,23,11,8,5,16,70,43,39,55,13,9,0,9,85,98,102,81,9,0,0,5,72,78,72,56,4,0,0,6,16,13,16,12,2,0,0,11,17,10,14,14,8,0,0,2,5,2,6,9,6,0,0,9,11,6,11,8,5,0,0,7,9,6,8,9,4,0,0,6,6,1,3,4,0,0,0,7,10,8,12,11,6,0,9,13,20,15,18,20,9,5,0,1,0,1,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'pro', '20', 1865, 1989, 1.5, 0, '');
INSERT INTO `renhe_collect` VALUES (109, '355', '2023-12-22 15:54:30', '4,5,10,13,12,12,10,2,0,12,18,18,14,13,13,7,0,13,14,20,43,23,12,4,12,18,59,73,73,60,14,8,11,20,75,95,102,66,12,7,13,42,43,76,74,57,24,13,12,15,40,51,42,42,13,12,12,14,50,58,52,55,19,9,9,19,91,126,105,76,12,2,5,13,75,74,83,18,8,0,9,23,69,59,60,20,9,1,3,13,15,11,12,14,13,0,7,9,10,8,9,9,4,0,7,12,11,9,11,11,11,4,4,10,10,7,10,8,7,0,3,5,4,0,4,8,3,0,3,10,11,10,10,9,4,2,14,13,18,17,39,43,15,11,3,4,3,3,0,1,0,0,4,6,4,5,4,2,1,3,0,0,0,0,0,0,0,0', '2033', 'pro', '20', 2336, 2450, 1.5, 0, '');
INSERT INTO `renhe_collect` VALUES (110, '252', '2023-12-22 15:56:31', '0,1,5,8,7,5,3,0,0,5,8,12,22,34,5,0,1,9,18,43,52,39,15,0,3,15,48,72,63,58,15,4,6,16,39,72,91,68,9,1,5,38,39,49,63,50,17,8,5,13,36,44,20,45,11,6,5,38,69,53,54,62,39,10,5,15,82,105,113,76,9,3,2,12,60,75,63,50,11,3,1,13,47,41,40,18,10,0,0,13,12,10,11,13,8,0,0,7,10,8,7,7,6,1,0,7,8,7,5,7,5,0,2,8,8,4,7,7,5,0,1,7,8,5,4,7,5,0,2,8,12,10,7,12,10,2,7,15,37,11,15,39,16,5,1,0,4,2,0,3,1,0,0,1,3,2,0,2,1,0,0,0,0,0,0,0,0,0', '2033', 'pro', '20', 2119, 2297, 1.5, 0, '');
INSERT INTO `renhe_collect` VALUES (111, '005', '2023-12-22 16:02:11', '0,0,3,6,8,8,3,0,0,4,9,16,15,15,4,0,0,4,10,40,45,46,11,1,2,16,35,70,84,73,8,0,0,9,19,86,80,57,10,0,6,9,16,57,57,48,17,8,3,12,19,41,45,34,10,7,7,37,61,52,48,72,17,11,0,11,92,117,105,64,7,0,3,10,68,73,59,48,12,3,4,17,51,42,22,14,9,0,0,10,13,11,12,14,10,0,0,9,11,10,11,6,7,0,0,9,10,9,8,8,5,0,0,11,10,10,8,9,4,0,0,7,8,5,8,11,5,0,2,5,8,8,9,8,6,0,6,18,12,17,16,33,13,3,4,8,6,3,0,0,1,2,3,4,0,0,4,2,2,0,0,0,0,0,0,0,0,0', '2033', 'pro', '20', 1801, 2145, 1.5, 0, '');
INSERT INTO `renhe_collect` VALUES (112, '356', '2023-12-22 16:04:32', '0,0,0,0,0,0,0,0,0,2,7,9,11,10,3,0,1,6,13,19,43,37,10,2,2,10,13,56,59,62,18,2,4,11,14,70,90,64,16,3,8,22,16,43,38,38,7,9,6,10,12,14,13,15,8,6,7,12,39,18,17,34,13,7,2,10,65,118,123,73,11,0,0,6,70,87,88,55,12,0,0,8,23,44,40,16,8,0,1,11,11,9,10,12,7,0,0,6,5,5,6,6,5,0,0,8,8,9,7,6,3,0,0,8,8,6,7,6,3,0,0,6,9,7,6,8,3,0,3,7,11,7,10,11,5,1,4,10,15,12,17,18,9,3,2,4,4,4,2,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'pro', '20', 1575, 1782, 1.5, 0, '');
INSERT INTO `renhe_collect` VALUES (113, '436', '2023-12-22 16:08:36', '0,2,5,5,9,7,2,0,0,0,9,10,12,9,4,0,2,10,37,20,14,19,9,0,5,16,22,46,61,69,45,2,4,10,18,68,109,97,47,0,7,16,21,49,51,56,33,10,4,9,16,40,18,39,11,8,4,10,50,47,20,53,19,8,2,7,67,96,100,92,8,1,2,9,71,87,101,86,16,0,2,9,43,23,22,21,8,3,0,9,14,11,9,13,9,1,0,3,8,5,5,9,6,0,1,4,9,6,8,7,5,0,0,3,8,5,6,5,3,0,1,1,7,5,3,5,3,0,0,6,11,10,8,13,11,3,3,8,16,14,14,21,13,6,3,0,4,1,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'pro', '20', 1946, 2078, 1.5, 0, '');
INSERT INTO `renhe_collect` VALUES (114, '414', '2023-12-22 16:10:45', '0,1,3,8,12,8,2,0,0,3,8,8,8,9,4,0,0,6,12,18,46,49,11,1,2,9,51,59,76,70,51,4,4,9,48,89,138,86,36,3,8,15,18,49,44,67,9,11,9,9,17,19,37,41,10,10,9,43,61,53,53,52,13,11,5,9,90,107,115,89,12,4,0,12,77,77,110,66,12,0,0,8,23,40,23,42,10,0,0,11,13,7,12,36,7,3,0,7,11,5,10,11,5,0,0,7,8,7,5,8,4,0,2,5,9,7,5,10,4,0,0,4,8,5,7,7,3,0,1,7,11,7,11,11,7,2,4,15,32,13,14,18,9,4,0,3,4,0,1,2,3,0,0,0,0,1,2,0,0,0,0,0,0,0,0,0,0,0', '2033', 'pro', '20', 2142, 2373, 1.5, 0, '');
INSERT INTO `renhe_collect` VALUES (115, '298', '2023-12-22 16:12:38', '0,4,3,9,11,5,1,0,2,5,9,11,19,10,3,0,0,9,17,15,40,31,4,0,2,14,57,80,75,72,17,3,5,15,58,94,113,91,7,0,8,17,36,67,53,47,15,6,8,11,15,24,14,22,8,8,6,12,53,38,41,39,7,6,0,10,80,99,110,62,4,0,2,11,75,94,98,75,12,3,1,10,48,69,74,47,11,2,0,12,14,14,13,12,9,2,3,7,9,11,11,11,7,0,0,8,10,8,9,6,4,1,0,6,10,8,6,7,3,1,0,4,8,8,6,7,2,0,2,8,9,9,11,10,5,0,6,11,16,14,17,15,9,5,1,2,2,0,0,4,0,0,0,1,2,1,4,1,0,0,0,0,0,0,0,0,0,0', '2033', 'pro', '20', 2171, 2268, 1.5, 0, '');
INSERT INTO `renhe_collect` VALUES (116, '407', '2023-12-22 16:14:28', '0,1,3,5,8,5,2,0,0,1,2,7,8,7,3,0,0,4,7,10,12,12,7,1,2,5,9,15,41,52,40,4,3,6,12,57,86,89,51,2,8,11,13,42,17,41,10,10,9,8,19,66,45,36,11,3,6,11,19,17,10,19,13,7,4,7,17,75,96,79,13,0,6,8,58,85,83,75,11,0,4,9,20,61,60,48,9,1,0,12,12,12,12,15,10,0,0,4,10,6,7,11,5,0,2,1,7,7,9,7,5,0,0,5,5,6,7,7,4,0,0,4,4,6,2,7,4,0,4,8,8,8,8,12,8,2,6,9,12,13,13,15,7,4,0,0,0,1,1,1,0,0,0,1,0,1,1,3,1,0,0,0,0,0,0,0,0,0', '2033', 'pro', '20', 1619, 1700, 1.5, 0, '');
INSERT INTO `renhe_collect` VALUES (117, '273', '2023-12-22 16:16:19', '0,0,4,6,8,7,3,0,1,3,11,6,35,8,4,0,0,8,14,12,14,39,13,2,0,10,33,40,51,62,45,6,4,7,33,76,99,95,34,3,9,15,17,52,58,65,36,9,4,12,16,21,17,49,10,8,7,13,60,53,48,52,19,10,2,9,87,97,110,100,21,3,3,11,76,81,87,88,14,0,1,14,37,55,22,39,10,3,0,9,14,13,8,16,13,0,1,4,9,5,7,12,6,0,2,9,10,8,5,10,7,0,0,6,10,7,5,7,5,0,0,2,8,6,4,6,6,0,1,5,9,8,10,11,7,3,4,8,15,12,13,35,8,4,0,2,3,0,0,0,0,0,0,2,1,1,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'pro', '20', 1904, 2214, 1.5, 0, '');
INSERT INTO `renhe_collect` VALUES (118, '048', '2023-12-22 16:19:42', '0,4,6,7,8,5,1,0,1,4,8,10,10,5,3,0,1,7,9,11,11,11,6,0,6,12,38,64,77,69,18,1,6,11,18,82,90,73,8,0,7,11,38,52,51,54,11,8,5,9,14,14,13,19,7,6,6,10,56,41,40,44,11,6,0,7,66,91,83,73,8,0,0,6,70,86,85,82,11,1,0,10,63,54,52,52,10,0,1,11,12,10,9,10,8,0,0,5,8,5,4,8,5,0,0,7,8,8,4,6,4,0,0,4,9,7,5,6,5,0,0,4,5,1,3,4,0,0,1,2,6,7,8,10,6,0,4,10,13,12,11,13,12,3,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'pro', '20', 1754, 1962, 1.5, 0, '');
INSERT INTO `renhe_collect` VALUES (119, '239', '2023-12-22 16:32:37', '0,0,1,3,4,2,0,0,0,0,5,5,14,7,0,0,0,3,3,8,28,32,4,0,3,9,36,69,87,89,53,2,4,5,43,88,104,99,47,0,10,34,34,51,61,53,27,4,4,10,34,40,33,36,3,3,7,37,55,57,37,44,10,6,1,6,85,117,132,116,14,0,1,6,78,96,103,88,13,0,0,7,59,53,58,62,8,2,0,8,10,14,10,14,4,0,2,5,11,9,10,4,7,0,1,4,8,5,3,2,1,0,0,3,3,4,3,4,3,0,0,2,4,3,5,7,3,0,0,4,6,7,5,6,4,0,4,9,15,10,11,12,5,1,0,0,5,1,0,0,0,0,2,3,5,0,0,1,1,1,0,0,0,0,0,0,0,0', '2033', 'pro', '20', 2398, 2539, 1.5, 0, '');
INSERT INTO `renhe_collect` VALUES (120, '363', '2023-12-22 16:34:17', '0,1,4,5,5,4,0,0,0,2,9,12,12,11,3,0,0,3,8,11,11,13,7,0,0,7,17,67,50,51,12,3,1,7,69,82,85,86,35,0,0,0,0,0,0,0,0,0,9,18,35,51,53,62,32,9,6,13,44,57,58,40,17,10,4,11,76,96,97,77,12,3,2,10,78,86,96,66,12,3,4,13,83,89,78,73,14,4,3,14,16,16,14,17,17,4,2,8,11,10,11,11,8,1,1,6,10,8,5,5,4,0,0,4,7,8,6,8,4,0,0,4,6,4,3,4,1,0,0,7,9,8,11,12,5,2,4,12,16,13,15,18,7,4,0,2,1,1,1,1,1,0,0,1,0,0,0,2,0,1,0,0,0,0,0,0,0,0', '2033', 'pro', '20', 2113, 2200, 1.5, 0, '');
INSERT INTO `renhe_collect` VALUES (121, '348', '2023-12-22 16:35:57', '0,1,7,6,5,5,0,0,0,4,8,8,10,6,2,0,2,7,9,10,13,16,9,2,6,11,19,44,44,64,10,1,7,15,58,61,92,73,36,0,9,11,17,53,43,49,11,5,11,40,18,37,22,44,13,5,10,36,78,65,54,50,16,8,1,12,93,101,102,78,9,0,6,47,91,76,91,83,10,0,2,16,74,61,56,41,11,0,4,14,15,9,11,11,12,0,5,7,10,7,11,9,10,0,0,7,10,8,10,7,5,0,1,6,6,5,8,8,3,0,0,7,7,5,9,7,6,0,4,17,13,7,12,9,7,4,3,9,35,18,15,9,7,5,0,0,0,0,0,3,2,1,1,2,3,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'pro', '20', 2042, 2254, 1.5, 0, '');
INSERT INTO `renhe_collect` VALUES (122, '191', '2023-12-22 16:37:39', '0,2,6,6,6,3,1,0,0,4,8,9,8,5,3,0,0,8,11,12,12,8,6,1,0,11,24,50,63,50,7,1,4,11,80,97,91,63,5,2,11,17,41,52,54,42,11,10,6,12,13,17,20,14,9,6,6,10,42,22,20,17,9,6,1,8,75,85,79,41,6,0,0,10,23,78,59,23,7,4,0,10,42,66,50,17,7,0,0,11,14,13,12,13,11,0,0,9,11,10,10,11,6,0,0,6,10,7,6,5,3,0,0,5,9,6,7,8,0,0,0,3,3,5,6,6,0,0,0,7,10,10,10,10,5,0,3,12,13,13,13,11,8,4,0,1,0,0,0,0,2,1,2,2,4,0,2,0,0,0,0,0,0,0,0,0,0,0', '2033', 'pro', '20', 1523, 1677, 1.5, 0, '');
INSERT INTO `renhe_collect` VALUES (124, '267', '2023-12-22 16:56:39', '0,2,5,6,9,9,4,0,0,0,8,10,15,12,7,0,0,7,11,18,22,35,13,2,0,10,47,71,84,85,53,9,1,10,43,86,101,92,45,4,5,15,18,50,53,63,33,7,4,16,22,24,20,39,11,5,3,18,63,52,24,49,12,7,5,13,95,108,108,79,9,0,0,10,84,94,100,61,0,0,0,11,63,63,76,37,7,0,0,13,17,15,13,15,10,0,0,4,4,3,2,6,1,0,0,5,8,9,8,8,5,0,0,9,10,7,10,8,3,0,0,0,0,0,0,0,0,0,0,8,6,9,6,8,0,0,11,24,15,12,21,16,7,4,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'pro', '20', 2141, 2387, 1.5, 0, '');
INSERT INTO `renhe_collect` VALUES (125, '491', '2023-12-22 16:58:28', '0,2,3,5,7,6,0,0,2,2,6,8,9,7,3,0,1,6,8,10,13,12,8,1,3,9,14,42,78,64,13,0,3,10,11,50,97,79,11,1,8,11,15,39,22,43,9,8,4,7,11,13,13,13,7,5,6,10,22,22,16,38,12,5,2,9,75,93,107,93,11,0,0,5,53,79,95,93,12,0,0,8,22,39,44,23,9,0,1,8,9,9,9,10,8,0,0,3,8,6,7,8,4,0,0,5,8,8,8,6,5,0,1,3,9,7,6,7,3,0,0,4,7,5,3,4,1,0,3,6,9,8,8,12,8,1,4,5,9,9,10,9,6,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'pro', '20', 1470, 1665, 1.5, 0, '');
INSERT INTO `renhe_collect` VALUES (126, '390', '2023-12-22 17:00:10', '0,1,8,7,6,4,0,0,0,4,10,8,11,5,2,0,1,9,11,13,10,8,1,0,3,13,68,75,66,53,6,1,5,10,74,91,95,68,3,0,7,13,36,68,48,11,5,5,6,7,13,14,12,12,5,4,5,10,13,14,19,11,7,7,0,9,75,76,71,14,2,0,0,12,72,64,65,21,3,0,0,8,57,52,67,13,6,0,0,11,11,12,10,11,6,0,2,7,10,8,9,10,5,0,1,7,10,9,6,7,2,0,0,8,8,8,7,6,3,0,0,4,8,5,4,5,1,0,2,8,9,6,8,8,3,0,3,10,12,12,12,11,7,3,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'pro', '20', 1463, 1662, 1.5, 0, '');
INSERT INTO `renhe_collect` VALUES (152, '452', '2023-12-27 15:52:49', '0,1,4,5,5,3,1,0,1,4,7,8,6,4,3,0,1,6,11,14,22,21,5,0,5,11,43,53,52,46,9,0,4,10,51,58,70,51,4,0,9,9,13,18,22,23,5,2,5,7,8,9,7,12,5,4,5,17,42,15,24,29,8,3,3,18,66,81,65,48,5,0,4,14,56,61,61,27,6,0,2,6,32,33,34,17,3,0,3,8,10,7,7,7,4,0,2,6,8,7,7,6,3,0,0,6,6,4,5,4,2,0,2,5,6,5,5,4,2,0,0,5,4,3,8,6,2,0,2,4,3,3,6,4,1,0,5,7,7,7,7,5,4,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1389, 1403, 1, 1, '');
INSERT INTO `renhe_collect` VALUES (153, '455', '2023-12-27 15:55:08', '0,3,4,7,7,4,0,0,0,1,6,8,9,6,1,0,0,6,12,11,11,9,5,0,1,10,20,29,24,24,6,0,5,12,45,68,73,40,4,0,11,18,34,46,40,37,13,6,8,9,14,21,18,20,9,4,7,11,17,14,22,19,11,1,0,6,46,58,52,38,5,0,5,8,52,60,59,33,8,0,4,12,53,62,53,44,9,0,4,5,14,14,14,11,10,0,1,5,8,8,9,8,6,0,0,3,9,7,9,8,5,0,3,1,8,8,7,8,6,0,2,1,9,7,5,6,5,0,2,7,8,8,10,7,5,2,5,11,14,8,10,7,7,2,0,0,3,0,0,0,0,0,0,0,2,2,4,3,3,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1258, 1402, 1, 2, '偏小，烧录1.5倍后再检验');
INSERT INTO `renhe_collect` VALUES (154, '509', '2023-12-27 15:57:02', '0,5,3,7,8,4,1,0,0,5,12,13,14,7,4,0,2,11,20,26,31,29,8,0,7,21,53,59,57,54,13,0,8,20,54,68,67,48,5,0,13,26,44,46,40,32,13,4,10,13,21,20,23,15,11,4,10,13,36,18,31,21,11,3,0,15,61,90,81,60,8,0,2,13,57,61,57,50,9,2,0,12,45,37,31,29,10,0,0,6,18,13,12,14,10,0,0,0,11,10,8,8,7,0,0,1,11,11,5,7,7,0,3,8,9,7,6,6,7,0,1,7,9,6,6,8,4,0,7,14,7,6,4,6,6,1,7,21,32,15,13,19,11,3,1,0,2,0,1,1,0,0,0,0,0,0,5,4,1,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1676, 1759, 1, 2, '');
INSERT INTO `renhe_collect` VALUES (155, '446', '2023-12-27 15:58:42', '0,0,0,7,8,6,3,0,0,0,6,9,10,8,9,0,0,0,7,25,17,28,12,0,0,2,32,42,49,41,8,0,0,11,32,43,56,44,11,0,2,12,24,26,24,26,18,8,0,3,10,9,14,11,6,6,1,10,43,31,23,30,15,6,0,5,65,74,79,49,7,0,0,5,67,61,66,40,6,0,0,2,42,33,34,31,5,0,0,2,7,4,8,11,9,0,0,0,2,0,0,3,0,0,0,2,5,3,1,6,5,0,0,3,4,1,1,4,2,0,0,2,0,0,0,0,2,0,0,0,8,6,12,19,12,4,3,4,3,4,3,7,9,2,0,0,0,0,0,0,0,0,0,2,0,0,0,0,1,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1336, 1455, 1, 2, '偏小，烧录1.5倍后再检验');
INSERT INTO `renhe_collect` VALUES (156, '075', '2023-12-27 16:00:31', '0,2,3,6,6,5,2,0,0,5,7,11,14,10,8,0,0,5,10,14,19,12,7,0,1,11,37,37,40,38,14,1,3,14,40,51,59,51,21,0,10,14,32,41,44,43,15,10,7,10,14,14,19,21,10,5,2,11,24,13,18,19,10,0,0,6,31,39,41,25,6,0,0,11,50,58,51,35,7,0,0,13,54,58,53,33,5,0,0,10,13,11,13,12,8,0,0,3,7,6,6,8,1,0,0,5,8,8,7,7,0,0,0,7,10,5,6,6,5,0,1,10,9,7,9,10,4,0,3,8,8,6,9,9,6,1,6,9,8,10,11,12,7,1,0,0,1,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1267, 1371, 1, 2, '偏小，烧录1.5倍后再检验');
INSERT INTO `renhe_collect` VALUES (157, '014', '2023-12-27 16:02:02', '0,3,6,7,7,7,7,0,0,5,7,12,14,25,12,0,0,6,10,30,33,48,21,5,1,10,14,54,63,62,38,6,0,4,10,55,76,57,13,5,7,12,26,32,35,36,16,12,6,11,15,20,28,22,13,9,8,13,49,32,37,36,23,8,6,19,65,76,73,59,11,2,0,20,61,59,60,53,4,1,0,16,37,34,37,21,7,0,3,11,13,11,12,15,7,0,1,3,12,8,9,9,5,0,4,9,13,12,12,11,4,0,1,12,12,10,12,11,7,0,2,9,8,9,12,8,0,0,7,11,8,10,19,13,9,3,10,21,13,13,14,10,7,4,0,0,0,0,0,0,0,0,0,0,3,0,2,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1707, 1728, 1, 2, '偏小，烧录1.5倍后再检验');
INSERT INTO `renhe_collect` VALUES (158, '482', '2023-12-27 16:03:44', '0,0,0,0,6,1,1,0,0,0,0,4,1,2,0,0,0,0,4,9,21,16,1,0,0,0,13,34,66,69,19,0,0,0,22,78,96,68,2,0,3,7,16,22,20,35,18,0,2,0,7,7,13,8,0,0,0,6,14,22,25,22,6,0,0,5,47,62,59,45,6,0,0,0,40,61,57,49,4,0,0,1,23,33,35,18,8,0,0,2,4,6,5,5,5,0,0,0,1,3,1,6,1,0,0,1,9,7,5,7,3,0,0,0,0,0,7,9,5,0,0,2,0,0,0,6,2,0,0,2,0,0,3,11,8,0,5,12,13,8,16,21,14,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1191, 1376, 1, 2, '');
INSERT INTO `renhe_collect` VALUES (159, '271', '2023-12-27 16:05:45', '0,2,4,12,15,4,2,0,0,2,7,11,13,10,4,0,0,5,16,25,35,28,8,3,7,13,45,55,61,54,16,4,3,15,34,59,81,46,13,1,9,14,20,35,44,27,18,8,6,10,12,18,16,20,11,9,8,13,23,29,26,28,18,6,3,4,34,63,73,69,18,1,0,5,49,64,69,62,23,1,0,5,36,37,36,34,10,0,0,8,13,12,12,10,9,0,0,3,7,7,8,8,6,0,0,5,9,10,7,9,5,0,0,6,7,7,6,8,7,0,0,6,9,8,7,13,7,0,1,5,8,8,9,9,8,3,7,9,12,12,11,14,10,4,4,5,6,4,2,1,0,0,3,3,4,4,1,3,1,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1531, 1615, 1, 1, '');
INSERT INTO `renhe_collect` VALUES (160, '63', '2023-12-27 16:07:36', '0,2,2,3,3,1,0,0,0,0,4,9,11,7,3,0,3,3,8,10,15,8,4,0,4,9,25,45,44,37,10,0,2,10,15,48,70,31,4,0,10,10,20,28,22,15,8,2,6,10,13,19,19,14,8,6,6,13,15,14,17,11,9,3,0,6,56,73,64,31,4,0,0,12,60,64,53,26,6,0,5,9,33,19,20,14,2,0,0,9,13,10,10,8,5,0,0,6,7,6,7,7,2,0,1,7,10,8,7,9,1,0,0,6,6,5,6,8,4,0,2,8,7,4,6,8,1,0,6,3,4,6,6,9,8,2,8,6,5,11,10,13,9,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1045, 1183, 1, 2, '偏小，烧录1.5倍后再检验');
INSERT INTO `renhe_collect` VALUES (161, '233', '2023-12-27 16:09:15', '0,1,4,8,9,4,0,0,0,9,5,10,11,6,4,0,0,10,13,25,47,41,9,0,9,24,48,56,65,63,23,0,8,14,51,64,79,59,9,0,13,17,24,33,40,27,16,7,10,11,15,18,19,19,10,6,9,13,19,20,30,24,13,4,3,11,43,75,87,58,15,0,2,9,56,88,80,67,12,0,0,11,35,35,38,35,11,0,0,9,15,12,11,12,12,0,0,3,8,6,6,9,5,0,1,4,11,9,8,9,6,0,0,7,9,7,8,10,9,0,3,8,8,4,6,10,9,0,6,8,7,5,7,11,10,3,9,11,17,21,16,22,13,4,0,1,0,0,0,0,0,0,0,2,3,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1651, 1769, 1, 1, '');
INSERT INTO `renhe_collect` VALUES (162, '046', '2023-12-27 16:10:46', '0,2,0,3,5,8,3,0,0,6,0,2,5,5,0,0,0,0,0,1,2,3,0,0,0,8,14,26,44,31,0,0,0,5,14,49,70,27,0,0,5,13,7,4,18,4,0,0,0,3,0,2,9,4,0,0,3,10,0,7,8,13,3,0,0,2,23,40,49,45,7,0,0,0,23,38,49,36,7,0,0,8,21,10,11,12,4,0,0,9,1,4,9,8,3,0,0,2,2,8,2,8,0,0,0,4,3,7,8,8,0,0,0,5,10,0,8,6,0,0,0,1,1,0,0,1,0,0,0,9,7,0,10,13,3,0,4,8,5,2,9,11,7,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 654, 870, 1, 2, '');
INSERT INTO `renhe_collect` VALUES (163, '501', '2023-12-27 16:13:17', '0,2,5,5,8,4,0,0,1,4,6,12,11,9,3,0,1,8,14,18,30,27,7,0,6,20,36,45,52,52,34,2,9,16,37,57,85,66,26,0,10,24,33,31,37,33,14,7,8,13,23,27,21,21,12,7,10,15,47,24,21,20,14,7,4,20,81,86,68,36,7,0,0,21,69,72,65,33,7,0,2,20,30,28,33,27,5,0,3,11,17,14,12,19,7,0,2,3,8,5,7,9,6,0,4,6,10,7,6,7,5,0,4,7,8,4,7,10,4,0,4,6,7,6,7,9,6,0,4,8,7,6,7,9,4,1,10,22,12,11,12,13,10,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1611, 1694, 1, 1, '');
INSERT INTO `renhe_collect` VALUES (164, '212', '2023-12-27 16:14:58', '0,3,4,9,10,8,1,0,0,6,4,10,14,11,6,0,2,9,18,27,37,45,17,4,4,13,35,56,64,70,51,5,5,11,30,56,78,71,32,1,9,16,27,33,39,33,19,7,9,11,14,22,21,21,13,6,8,13,26,38,24,33,14,7,6,10,45,68,82,70,34,4,3,8,36,70,80,65,24,0,0,8,23,36,29,29,12,0,0,11,12,12,14,15,8,0,1,4,7,8,8,10,3,0,0,3,6,7,9,9,1,0,0,5,9,5,5,7,6,0,0,5,7,7,7,10,6,0,0,4,8,6,7,11,7,5,3,16,19,20,21,23,11,6,0,4,3,0,1,4,1,3,1,0,5,3,4,5,0,1,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1727, 1797, 1, 1, '');
INSERT INTO `renhe_collect` VALUES (165, '73', '2023-12-27 16:16:39', '0,1,2,8,9,11,4,0,0,8,8,12,9,15,11,0,4,10,9,14,14,15,11,0,0,8,10,41,51,25,17,0,5,9,23,78,102,51,10,0,9,9,23,34,31,27,16,5,5,5,19,19,15,15,12,4,6,12,32,20,20,21,12,1,5,25,81,93,100,36,8,0,0,11,69,72,82,23,11,0,0,4,32,18,24,10,5,0,0,9,11,12,14,15,6,0,0,5,6,5,6,4,0,0,0,2,5,3,8,9,2,0,0,4,8,7,5,6,6,0,0,1,3,4,4,6,0,0,0,5,6,6,6,5,3,0,5,9,21,20,15,12,6,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1387, 1514, 1, 1, '');
INSERT INTO `renhe_collect` VALUES (166, '420', '2023-12-27 16:18:31', '0,3,3,12,14,6,2,0,0,2,5,9,8,7,5,0,0,5,8,17,24,26,12,1,0,16,23,42,46,48,32,5,2,9,28,51,96,72,22,1,13,20,25,30,36,34,18,6,8,13,21,33,31,24,17,7,9,13,33,36,28,25,22,5,7,11,53,70,73,58,11,0,3,8,52,70,69,53,12,0,4,12,39,38,46,36,12,0,2,11,16,12,11,14,10,0,0,4,7,10,12,11,5,0,1,6,12,8,5,9,6,0,1,8,8,10,8,10,4,0,0,5,7,4,8,8,4,0,3,7,8,7,9,8,7,1,5,15,21,20,18,18,6,2,2,0,4,0,0,0,0,0,0,0,8,2,1,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1626, 1694, 1, 2, '');
INSERT INTO `renhe_collect` VALUES (167, '123', '2023-12-27 16:21:32', '0,1,2,7,6,4,0,0,0,5,5,10,14,8,5,0,0,9,11,15,27,16,8,0,1,11,44,55,58,54,23,1,4,12,41,58,81,60,20,0,10,14,26,31,33,27,19,6,7,11,14,17,23,21,10,7,9,13,31,33,34,22,11,6,0,11,95,102,107,85,9,0,0,12,86,101,104,48,8,0,0,12,40,42,41,24,11,0,0,9,13,10,10,9,10,0,0,0,6,8,8,7,3,0,0,8,12,8,10,10,5,0,0,6,10,8,10,9,6,0,0,8,11,9,7,12,5,0,4,9,11,10,11,10,6,2,5,9,17,9,9,12,9,3,0,0,0,0,0,0,0,1,0,1,4,2,1,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1753, 1853, 1, 1, '');
INSERT INTO `renhe_collect` VALUES (168, '199', '2023-12-27 16:23:14', '0,0,6,6,4,4,3,0,0,4,4,12,10,8,3,0,0,4,10,22,26,25,14,0,0,9,30,48,59,50,11,0,0,7,14,52,94,64,14,0,3,11,9,49,44,37,13,2,0,3,8,12,9,9,5,3,2,9,26,15,11,20,6,1,0,2,49,71,93,57,9,0,0,3,26,55,51,44,9,0,0,4,11,8,6,12,5,0,0,0,2,2,6,5,1,0,0,0,2,0,2,4,0,0,0,0,2,1,3,5,1,0,0,3,8,6,5,5,6,0,0,5,6,2,1,3,2,0,2,3,11,10,11,12,6,1,4,7,13,12,10,10,13,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 699, 1354, 1, 1, '');
INSERT INTO `renhe_collect` VALUES (169, '223', '2023-12-27 16:25:26', '0,2,3,9,10,4,1,0,0,2,8,16,17,6,3,0,0,3,11,23,21,20,7,0,0,8,31,44,45,44,26,4,4,18,53,68,90,62,20,0,14,20,35,36,43,30,18,4,11,12,17,22,27,22,12,4,12,14,31,30,28,24,14,3,5,9,73,87,85,52,10,0,4,11,67,69,70,47,11,0,7,13,55,62,47,39,10,0,5,10,17,12,17,17,9,0,6,12,12,13,13,11,6,0,6,10,12,6,7,8,7,1,1,8,8,5,6,5,4,0,0,2,8,6,12,10,2,0,2,5,5,4,4,5,4,0,7,9,15,16,22,17,4,2,0,0,5,7,6,5,0,0,0,3,5,4,6,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1684, 1791, 1, 1, '');
INSERT INTO `renhe_collect` VALUES (170, '001', '2023-12-27 16:27:55', '0,3,3,7,11,8,2,0,0,5,6,7,13,7,5,0,0,4,11,12,14,13,10,0,0,6,14,35,32,47,13,1,1,7,21,40,59,56,19,0,6,10,13,22,28,25,11,7,7,11,13,14,12,13,10,4,7,10,12,12,13,18,11,3,2,4,28,49,52,37,10,0,5,7,48,60,57,42,12,0,0,9,42,41,42,32,12,0,2,10,11,9,10,11,9,0,2,7,8,8,10,9,5,0,0,4,7,7,5,6,6,0,1,5,8,8,7,8,5,0,0,5,7,5,6,8,5,0,2,6,8,7,7,10,6,2,5,7,12,12,12,11,5,2,0,0,2,0,0,0,0,0,0,1,4,3,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1127, 1195, 1, 2, '偏小，烧录1.5倍后再检验');
INSERT INTO `renhe_collect` VALUES (171, '120', '2023-12-27 16:29:45', '0,0,0,0,2,6,4,0,0,0,0,3,6,8,7,0,0,0,0,6,6,10,7,0,0,0,3,14,28,25,18,0,0,0,2,28,101,83,25,4,5,2,12,18,23,19,12,4,1,3,11,13,14,13,11,8,0,1,10,19,17,17,10,4,0,0,32,69,67,50,6,0,0,5,67,98,82,44,17,0,0,6,71,80,59,45,18,0,0,6,13,11,14,18,15,0,0,4,9,10,10,10,8,0,0,2,10,9,6,7,7,0,0,1,3,4,8,11,9,0,0,4,1,0,6,7,7,0,1,3,2,1,9,18,20,5,0,6,2,1,12,8,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1331, 1462, 1, 1, '');
INSERT INTO `renhe_collect` VALUES (188, '346', '2023-12-28 14:40:43', '0,4,5,5,11,3,2,0,0,3,4,13,12,8,4,0,0,7,21,25,23,33,12,0,3,14,28,62,62,46,23,0,3,9,30,52,69,45,16,0,9,12,23,29,29,27,16,9,7,13,18,23,20,27,11,8,7,12,11,18,22,24,18,8,0,12,51,89,90,52,10,0,5,8,48,80,77,49,16,2,1,7,44,52,47,37,14,0,0,9,12,10,11,12,8,3,0,0,8,7,9,11,6,0,0,6,6,5,5,5,5,0,0,3,7,5,5,5,1,0,0,1,6,3,5,5,6,0,2,3,4,6,7,10,6,0,2,7,11,13,13,9,9,3,2,1,3,3,2,5,2,0,1,4,6,3,6,6,0,1,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1440, 1628, 1, 1, '');
INSERT INTO `renhe_collect` VALUES (189, '500', '2023-12-28 14:44:07', '0,0,3,5,4,4,0,0,0,6,8,14,15,5,4,0,2,8,10,16,24,21,9,0,3,12,43,52,58,56,21,0,4,16,48,67,79,55,15,0,13,21,22,39,43,32,15,5,8,11,15,18,20,20,10,6,7,18,18,15,22,22,14,4,3,8,50,103,99,58,7,0,7,15,77,87,85,29,8,0,5,20,58,61,47,34,8,0,4,13,24,12,13,14,11,1,2,8,8,8,9,10,6,0,5,7,9,9,8,8,7,0,2,8,6,6,6,7,4,0,2,11,10,6,5,11,5,0,3,9,10,6,10,12,6,2,9,50,19,20,17,22,7,4,2,4,2,3,4,3,0,1,1,6,5,3,8,6,1,1,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1650, 1826, 1, 1, '');
INSERT INTO `renhe_collect` VALUES (190, '53', '2023-12-28 14:46:20', '0,1,3,6,7,2,0,0,0,5,6,7,8,4,2,0,0,7,12,15,19,16,4,0,4,12,33,40,51,31,9,0,5,9,24,54,68,33,0,0,13,9,18,27,24,12,9,3,10,12,14,13,15,13,7,4,7,19,35,19,20,11,12,4,4,13,64,69,59,23,3,0,1,13,55,54,45,13,1,0,3,15,24,21,18,13,2,0,0,7,10,9,11,11,3,0,2,6,7,6,8,4,0,0,2,8,6,5,5,4,0,0,3,9,9,5,5,5,0,0,3,9,6,6,7,4,0,0,2,8,5,5,9,5,3,0,6,12,13,10,8,7,3,0,2,1,0,0,0,0,0,0,2,3,2,0,1,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1072, 1198, 1, 2, '偏小，烧录1.5倍后再检验');
INSERT INTO `renhe_collect` VALUES (191, '370', '2023-12-28 14:48:41', '0,2,3,8,9,8,4,0,1,2,6,8,11,8,7,2,0,5,10,12,19,22,17,5,0,5,26,49,52,57,33,8,0,5,21,59,72,56,29,1,10,15,25,33,41,34,16,9,10,11,17,17,16,21,13,7,7,13,15,17,23,23,15,7,4,12,43,70,71,52,8,0,7,12,58,70,73,31,7,0,5,13,27,35,30,23,9,0,3,12,13,11,12,13,9,0,1,4,7,7,8,8,3,0,3,9,11,10,9,10,5,0,2,9,8,8,8,5,1,0,2,7,5,4,5,4,0,0,4,9,5,8,10,11,4,2,5,16,16,14,32,15,7,5,0,2,0,0,0,0,0,0,3,3,4,6,4,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1348, 1516, 1, 2, '偏小，烧录1.5倍后再检验');
INSERT INTO `renhe_collect` VALUES (192, '074', '2023-12-28 14:50:49', '0,2,4,6,8,4,0,0,0,8,9,12,14,9,4,0,4,7,15,12,13,20,17,0,2,12,14,21,21,26,21,2,4,10,15,31,47,37,14,0,12,13,17,22,25,16,12,6,10,12,15,21,25,23,9,10,10,14,26,27,23,33,18,10,6,10,51,72,71,59,15,1,3,11,57,62,60,53,14,2,7,9,31,37,39,34,14,0,6,8,14,14,13,14,12,1,5,7,12,10,11,11,5,0,5,8,12,13,8,9,8,0,3,10,13,10,8,8,7,3,2,5,12,7,10,12,10,2,3,7,6,6,7,9,8,2,4,9,14,15,10,11,9,3,1,0,4,0,0,0,1,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 599, 1316, 1, 2, '');
INSERT INTO `renhe_collect` VALUES (194, '230425-042', '2023-12-28 15:01:07', '0,1,3,7,6,3,0,0,0,1,3,7,8,4,0,0,1,4,8,10,8,7,5,0,2,7,38,44,35,37,8,0,2,9,41,45,57,37,3,0,7,14,41,27,23,12,5,2,7,7,7,9,16,23,4,3,4,12,16,14,22,11,6,4,2,11,66,92,63,24,0,0,1,17,61,78,54,21,2,0,4,20,54,46,44,23,5,0,3,8,19,14,13,8,8,0,3,7,7,9,7,4,6,0,1,6,4,5,3,2,1,0,3,4,4,5,4,3,1,0,2,5,3,3,6,4,0,0,4,7,4,6,6,4,2,0,7,15,10,12,13,7,3,0,0,2,1,0,0,0,0,0,1,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1172, 1363, 1, 2, '');
INSERT INTO `renhe_collect` VALUES (195, '470', '2023-12-28 15:04:55', '0,1,3,5,7,5,0,0,0,1,6,6,6,5,4,0,0,4,11,16,20,18,7,0,3,9,34,47,51,52,20,0,4,8,40,56,68,62,16,0,9,14,21,28,24,25,10,7,7,9,11,13,13,16,10,6,8,12,24,22,19,25,13,7,1,8,53,66,71,60,11,0,3,11,56,61,61,52,9,0,3,8,33,28,33,25,9,2,1,9,11,11,10,10,9,0,0,0,6,7,8,7,3,0,0,5,11,5,4,6,5,0,3,5,7,6,6,6,4,0,2,3,8,4,5,6,2,0,0,5,7,6,6,6,5,1,4,12,14,12,12,11,6,3,0,3,3,1,0,0,0,0,0,0,4,5,3,0,2,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 810, 1440, 1, 2, '偏小，烧录1.5倍后再检验');
INSERT INTO `renhe_collect` VALUES (196, '029', '2023-12-28 15:08:46', '0,2,4,4,6,3,0,0,0,2,7,9,7,3,0,0,1,6,10,11,12,7,4,0,5,11,50,52,54,50,9,0,5,9,50,60,64,56,8,0,8,12,26,28,29,22,7,3,6,7,12,14,13,13,9,6,6,10,45,18,32,18,9,2,3,11,58,66,63,35,4,0,3,14,56,60,55,26,3,0,3,28,58,57,50,15,3,0,1,10,10,6,7,7,0,0,0,0,4,3,4,5,0,0,2,4,7,6,7,5,3,0,2,2,5,6,5,6,0,0,1,5,6,1,4,3,0,0,3,6,6,7,7,5,1,0,6,14,10,12,13,9,4,1,3,1,0,0,0,0,1,0,0,4,3,5,2,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1414, 1473, 1, 2, '偏小，烧录1.5倍后再检验');
INSERT INTO `renhe_collect` VALUES (197, '024', '2023-12-28 15:11:12', '1,0,3,4,3,3,0,0,1,6,4,7,6,4,0,0,1,5,10,9,12,7,3,0,4,11,15,24,27,15,8,0,5,9,30,50,56,46,5,0,11,13,24,24,31,22,13,5,11,11,13,14,13,11,9,1,8,10,10,10,12,9,11,3,2,11,49,70,69,48,2,0,5,14,59,64,63,42,5,0,7,19,57,42,42,25,7,1,7,11,13,12,12,13,5,0,7,6,7,8,10,10,3,0,4,5,8,7,7,7,1,0,4,7,8,6,4,6,0,0,2,4,4,6,5,1,0,0,4,5,8,7,7,6,3,0,6,10,9,9,9,6,3,0,2,3,4,2,4,1,0,0,4,5,6,5,6,1,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1113, 1255, 1, 2, '偏小，烧录1.5倍后再检验');
INSERT INTO `renhe_collect` VALUES (198, '208', '2023-12-28 15:14:21', '0,1,2,6,5,4,0,0,0,1,4,7,7,5,3,0,0,3,7,13,12,12,6,0,0,8,14,30,48,48,11,0,0,8,43,64,90,65,7,0,5,12,21,21,26,18,9,6,5,8,14,17,16,12,9,0,5,10,27,13,21,18,8,3,0,8,39,64,58,48,7,0,6,9,32,55,66,48,7,0,4,10,36,39,44,18,7,0,2,10,10,12,12,12,7,0,1,6,8,7,6,7,4,0,0,5,5,5,4,3,5,0,0,4,2,3,4,3,1,0,0,6,5,4,7,5,2,0,1,6,6,7,6,5,4,0,3,6,10,9,11,10,5,2,1,1,0,2,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1204, 1320, 1, 2, '');
INSERT INTO `renhe_collect` VALUES (199, '056', '2023-12-28 15:25:37', '0,1,4,4,6,5,4,0,0,1,3,8,9,6,5,1,0,2,8,13,16,14,9,3,0,3,12,51,56,54,45,7,0,1,10,51,71,63,40,3,6,9,11,16,21,18,10,9,7,9,12,12,14,12,10,7,6,12,24,13,20,21,10,7,0,11,61,77,73,56,6,0,3,14,67,70,73,53,8,0,0,14,56,52,53,25,10,0,0,8,11,9,11,11,9,0,0,5,8,7,9,9,8,0,0,3,7,8,6,7,7,0,3,6,9,8,7,7,2,0,1,7,7,3,6,9,2,0,2,7,9,10,11,12,7,3,4,7,11,10,12,10,8,3,2,2,0,0,0,0,0,0,1,3,1,3,3,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1457, 1504, 1, 2, '偏小，烧录1.5倍后再检验');
INSERT INTO `renhe_collect` VALUES (200, '089', '2023-12-28 15:27:39', '0,5,7,12,11,8,1,0,0,6,8,13,10,5,5,0,2,8,11,15,25,21,7,0,0,12,36,50,60,52,13,0,5,13,30,60,89,65,11,0,11,14,20,26,31,24,10,4,5,10,14,20,24,16,9,1,8,14,31,27,30,27,13,2,4,12,72,79,98,67,8,0,1,17,60,55,74,61,8,0,4,11,41,40,41,18,8,0,0,8,11,8,11,12,6,0,0,3,8,9,8,8,5,0,1,9,10,9,8,11,4,0,4,10,8,8,9,10,2,0,3,8,9,6,12,9,3,0,4,7,6,5,9,11,7,2,5,7,9,11,11,10,8,2,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1474, 1632, 1, 1, '');
INSERT INTO `renhe_collect` VALUES (201, '383', '2023-12-28 15:29:49', '0,3,4,9,9,7,1,0,0,7,8,9,12,10,5,0,0,10,14,26,22,20,11,0,4,12,20,37,35,26,10,1,0,12,20,37,56,27,7,0,8,11,13,15,16,19,9,1,6,10,12,11,15,12,10,5,9,12,30,22,29,21,10,5,1,14,78,70,77,37,9,0,3,14,58,44,54,14,5,0,2,10,24,18,23,20,7,0,0,9,9,7,9,9,6,0,0,1,6,3,6,6,1,0,0,4,8,7,6,6,4,0,1,5,7,5,8,6,5,0,2,6,6,3,7,7,1,0,3,7,6,6,10,9,3,0,7,11,12,11,11,11,7,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1026, 1182, 1, 2, '偏小，烧录1.5倍后再检验');
INSERT INTO `renhe_collect` VALUES (202, '322', '2023-12-28 15:32:00', '0,6,7,10,6,6,1,0,0,7,9,11,9,10,3,0,0,7,10,12,13,11,7,0,1,12,38,43,43,37,7,0,7,13,49,69,66,29,8,1,11,14,16,36,26,16,12,8,6,10,13,15,14,13,9,5,8,14,36,19,19,14,10,5,2,13,63,94,81,53,9,0,2,16,63,68,57,37,8,0,2,13,36,37,34,19,7,0,0,8,11,9,10,10,5,1,0,5,9,8,6,7,3,0,0,7,9,9,7,7,3,0,0,6,8,3,8,7,3,0,0,6,6,4,6,9,3,0,1,9,9,6,12,10,9,0,7,13,12,12,13,13,10,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1358, 1424, 1, 1, '');
INSERT INTO `renhe_collect` VALUES (203, '395', '2023-12-28 15:35:03', '0,3,6,9,8,4,2,0,0,3,6,9,11,7,2,0,0,6,7,10,10,9,4,0,4,12,13,22,15,20,6,0,5,13,30,83,37,14,4,0,10,18,23,31,27,18,11,2,11,11,13,14,14,13,8,1,10,11,21,12,32,28,9,0,3,18,69,70,56,13,2,0,8,37,105,101,71,16,2,0,6,45,95,73,61,21,2,0,5,13,13,11,12,11,8,0,4,9,11,10,11,10,3,0,4,9,7,7,6,8,4,0,2,8,7,6,7,5,0,0,5,10,7,4,6,7,2,0,5,5,7,4,9,7,4,0,6,9,10,13,10,8,5,1,0,1,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1371, 1458, 1, 2, '');
INSERT INTO `renhe_collect` VALUES (204, '169', '2023-12-28 15:37:25', '0,2,5,8,7,4,1,0,0,4,6,7,13,7,4,0,0,8,13,29,22,20,9,0,5,15,42,39,56,47,13,0,5,14,21,66,66,24,7,0,11,21,27,30,26,18,9,1,12,13,16,22,20,14,11,3,11,14,31,22,21,16,12,5,4,27,53,67,57,34,6,0,6,21,62,50,33,20,5,0,5,8,17,22,18,20,2,0,1,10,11,11,13,13,4,0,0,4,8,8,7,8,3,0,0,8,9,5,4,7,1,0,0,8,10,5,6,6,1,0,0,7,7,7,7,9,0,0,1,8,10,9,6,9,3,0,5,22,34,9,14,11,7,1,0,1,4,5,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1146, 1343, 1, 2, '偏小，烧录1.5倍后再检验');
INSERT INTO `renhe_collect` VALUES (205, '118', '2023-12-28 15:39:35', '0,3,5,10,10,7,5,0,0,6,8,11,11,10,3,0,0,8,12,20,14,14,11,1,4,14,24,39,45,51,18,5,2,11,24,61,71,57,15,1,10,14,18,35,25,18,14,8,10,10,13,18,14,19,12,8,9,12,19,19,14,19,12,9,4,9,24,52,60,46,9,1,6,10,40,60,62,53,12,0,4,9,35,40,45,28,12,1,2,11,13,13,10,12,10,0,3,8,10,11,10,9,5,1,2,6,9,6,7,8,4,2,0,5,9,7,8,8,4,0,1,4,8,7,3,8,5,0,2,5,8,7,7,13,9,3,4,7,14,9,12,11,8,5,2,0,2,0,2,1,0,0,2,1,4,0,2,2,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1095, 1336, 1, 2, '偏小，烧录1.5倍后再检验');
INSERT INTO `renhe_collect` VALUES (206, '449', '2023-12-28 15:49:20', '0,0,3,7,8,3,3,0,0,4,4,10,11,7,5,0,0,7,10,12,16,17,10,0,3,11,43,49,53,52,14,0,3,7,33,52,64,58,18,2,7,11,19,16,19,20,11,6,7,11,13,14,14,30,10,5,6,12,27,21,21,35,14,3,4,6,49,63,64,43,8,0,2,10,55,64,63,56,10,2,1,10,40,46,48,35,10,0,0,7,11,10,10,11,7,0,0,3,4,6,7,8,4,0,0,4,9,5,8,7,5,0,0,5,7,6,5,9,6,0,0,3,6,5,6,7,5,0,1,5,6,5,7,9,5,3,4,8,13,10,9,11,9,5,1,1,0,0,0,0,0,0,0,2,2,0,1,0,1,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1371, 1450, 1, 2, '偏小，烧录1.5倍后再检验');
INSERT INTO `renhe_collect` VALUES (207, '99', '2023-12-28 15:51:41', '0,1,3,7,6,9,6,0,0,3,5,7,10,10,8,2,0,4,8,12,12,12,11,1,0,4,12,26,30,30,16,5,0,1,10,37,58,36,12,2,3,10,13,17,20,20,12,8,6,8,13,14,14,13,11,7,5,11,33,16,29,24,13,7,1,12,53,60,60,43,8,0,0,10,43,50,55,24,4,0,0,11,25,20,26,15,5,0,0,7,10,8,8,10,5,0,0,0,3,1,2,3,0,0,0,4,7,7,8,8,6,0,0,4,8,5,8,8,2,0,0,7,8,4,6,7,2,0,0,6,9,6,9,10,7,0,4,10,12,11,13,13,10,3,2,1,1,0,0,0,0,0,0,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1022, 1101, 1, 2, '偏小，烧录1.5倍后再检验');
INSERT INTO `renhe_collect` VALUES (208, '477', '2023-12-28 15:53:49', '0,2,3,5,5,10,3,0,0,1,5,6,8,16,7,0,0,1,8,12,14,21,8,0,0,3,13,49,54,58,55,9,0,3,7,56,78,73,49,7,7,13,22,32,41,41,25,10,9,12,13,21,16,27,12,8,6,14,25,24,24,23,14,8,2,7,51,65,63,55,8,0,5,12,63,76,73,58,13,0,6,14,51,63,62,46,14,0,9,11,14,15,13,14,14,0,4,6,11,13,8,9,5,0,2,13,13,8,8,9,8,0,2,9,10,11,9,8,8,0,0,7,7,8,6,10,5,0,3,5,7,6,9,10,5,0,5,18,17,16,22,26,13,2,4,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1660, 1740, 1, 2, '偏小，烧录1.5倍后再检验');
INSERT INTO `renhe_collect` VALUES (213, '230', '2024-01-03 15:40:59', '0,0,2,4,5,4,0,0,0,2,5,8,18,6,1,0,0,4,6,10,16,11,5,0,1,6,23,46,55,49,15,3,1,5,48,60,74,71,25,1,10,16,21,38,41,41,12,5,9,11,11,16,17,23,9,5,8,8,14,14,15,10,8,4,1,6,41,65,74,53,7,0,2,7,68,95,90,49,7,0,2,10,61,66,68,42,7,0,5,11,19,16,12,17,10,0,0,7,9,7,9,11,7,0,0,7,7,5,5,8,6,0,0,3,6,4,5,4,1,0,0,4,4,5,3,3,0,0,1,5,6,8,7,6,3,0,4,13,20,14,19,11,7,2,1,3,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1581, 1681, 1, 0, NULL);
INSERT INTO `renhe_collect` VALUES (214, '253', '2024-01-03 15:52:23', '0,1,5,7,7,4,1,0,0,3,9,12,13,9,2,0,0,9,12,15,20,17,7,0,4,12,38,51,52,51,21,0,5,15,51,67,77,68,17,0,13,22,36,38,48,43,18,3,9,12,15,14,19,17,11,4,6,12,15,17,14,20,10,1,1,11,57,67,63,49,8,0,4,11,48,64,63,49,5,0,6,16,52,58,54,43,8,0,2,16,17,13,19,20,10,0,1,9,12,10,10,10,5,0,1,10,12,10,6,10,6,0,0,8,10,8,9,6,0,0,2,4,8,6,6,7,0,0,5,11,10,8,10,9,4,0,6,14,17,17,17,12,8,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1394, 1659, 1, 0, NULL);
INSERT INTO `renhe_collect` VALUES (215, '189', '2024-01-03 15:54:20', '0,0,1,4,5,9,3,0,0,0,2,9,10,14,5,0,0,1,8,12,14,22,14,0,0,1,13,46,53,55,43,6,0,0,8,51,69,68,34,3,7,11,13,18,17,23,10,6,6,9,12,13,14,13,9,7,5,10,13,13,13,15,12,7,1,5,31,59,63,52,13,0,2,7,51,66,70,61,21,1,5,7,45,58,54,49,15,4,3,8,13,13,10,13,9,0,0,3,7,8,9,9,6,0,0,7,10,7,6,8,7,0,0,7,11,8,7,10,7,0,0,4,8,6,6,11,6,0,2,6,8,7,7,9,7,1,3,8,9,9,10,13,10,4,0,0,0,2,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1380, 1445, 1, 0, NULL);
INSERT INTO `renhe_collect` VALUES (216, '296', '2024-01-03 16:00:07', '0,2,5,8,9,5,1,0,0,6,7,14,12,7,3,0,4,10,33,50,57,51,10,0,9,29,60,61,86,68,11,0,8,12,48,68,78,49,5,0,12,11,22,28,29,22,10,5,9,12,23,21,15,17,10,6,9,20,47,31,28,33,12,6,3,26,79,78,86,50,6,0,2,32,62,67,69,45,10,0,2,14,39,38,43,26,6,1,2,10,15,9,9,10,5,0,0,1,8,7,7,8,5,0,0,9,10,10,10,8,5,0,1,9,9,8,9,10,4,0,0,8,6,4,8,9,4,0,5,8,8,7,10,10,4,1,8,12,16,23,26,22,9,2,0,0,1,1,0,0,0,0,2,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1791, 1916, 1, 0, NULL);
INSERT INTO `renhe_collect` VALUES (217, '502', '2024-01-03 16:02:19', '0,0,0,0,0,0,0,0,0,0,1,2,5,2,0,0,0,0,6,6,5,10,0,0,0,4,15,24,39,46,7,0,0,1,20,52,83,51,0,0,1,14,14,6,21,17,6,0,2,4,5,6,6,8,0,0,1,6,9,7,4,9,2,0,3,8,39,50,50,33,3,0,1,5,26,32,35,23,2,0,1,10,39,31,20,17,4,0,0,7,4,2,3,6,1,0,2,5,1,0,0,2,1,0,1,0,5,3,2,3,2,0,0,0,0,0,2,5,1,0,0,0,0,0,0,0,0,0,0,4,0,0,0,2,3,0,2,1,3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 771, 934, 1, 0, NULL);
INSERT INTO `renhe_collect` VALUES (218, '323', '2024-01-03 16:04:10', '0,4,7,8,10,6,2,0,0,7,8,18,20,10,6,0,4,9,20,38,48,47,17,0,4,14,58,65,82,63,17,0,6,14,36,66,93,58,12,0,7,12,25,32,34,33,17,8,4,10,14,21,23,23,12,5,7,18,37,27,42,41,15,6,3,12,82,109,111,82,14,0,1,14,100,107,100,65,12,0,3,13,59,71,50,36,11,0,2,12,15,11,9,12,6,0,0,4,7,6,8,7,3,0,0,8,12,11,10,8,3,0,0,7,12,8,8,8,4,0,0,6,10,5,5,9,3,0,0,10,12,10,12,9,9,2,4,12,15,14,13,13,8,2,0,0,0,0,0,0,0,0,0,4,6,3,4,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 2090, 2150, 1, 0, NULL);
INSERT INTO `renhe_collect` VALUES (219, '145', '2024-01-03 16:05:58', '0,0,5,6,15,14,3,0,0,5,7,13,10,7,7,1,0,8,21,22,28,26,10,2,0,12,20,46,54,49,23,8,0,7,27,53,80,29,9,1,10,18,38,31,29,23,18,6,7,14,16,21,24,20,14,9,9,20,29,27,29,22,15,6,5,19,68,77,85,45,10,0,3,31,60,65,63,33,6,0,0,18,37,38,34,22,7,0,2,14,14,12,14,15,9,0,4,9,10,11,10,6,1,0,0,8,11,9,12,12,5,0,0,9,10,11,9,7,2,0,2,8,10,7,10,10,0,0,2,7,12,8,11,10,6,3,8,20,20,18,30,22,9,3,0,3,1,1,0,0,0,1,0,4,4,3,2,4,3,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1491, 1596, 1, 0, NULL);
INSERT INTO `renhe_collect` VALUES (220, '114', '2024-01-03 16:08:18', '0,1,7,5,14,5,2,0,0,4,8,17,15,9,3,0,0,8,10,15,22,15,12,0,0,9,51,54,78,73,35,3,0,6,40,92,111,79,12,0,10,20,24,31,36,30,12,7,11,12,14,23,23,15,13,2,9,12,14,15,14,24,14,0,2,11,48,100,100,63,9,0,4,19,91,105,105,80,6,0,3,24,62,77,87,55,6,0,0,14,16,12,13,13,8,0,0,7,10,9,9,10,2,0,0,11,14,12,9,10,4,0,0,10,10,5,9,8,0,0,0,8,7,1,3,4,0,0,3,8,11,11,11,14,9,4,6,14,13,13,14,17,9,3,0,0,0,0,0,0,0,0,0,0,2,2,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1947, 2057, 1, 0, NULL);
INSERT INTO `renhe_collect` VALUES (221, '064', '2024-01-03 16:10:13', '0,4,4,5,7,5,2,0,0,7,7,10,15,8,7,1,1,11,14,33,38,35,11,5,4,12,40,58,93,76,29,3,3,11,27,67,108,90,23,2,9,13,13,30,23,24,9,7,6,10,13,14,14,14,11,6,7,13,22,28,20,22,14,7,0,8,56,76,72,60,15,1,0,7,42,76,80,47,9,0,4,10,21,41,22,18,7,0,0,10,13,12,11,14,8,0,0,3,7,5,7,7,1,0,0,5,10,9,8,9,5,0,0,5,8,7,9,7,3,0,0,5,9,3,4,8,0,0,3,8,8,6,7,9,5,0,7,12,16,14,19,15,6,3,0,0,0,0,0,0,0,0,0,4,1,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1575, 1688, 1, 0, NULL);
INSERT INTO `renhe_collect` VALUES (222, '334', '2024-01-03 16:13:34', '0,4,6,13,12,6,4,0,0,7,11,27,29,14,6,0,1,13,25,44,48,51,14,3,1,25,63,66,74,67,26,5,5,27,54,72,85,59,13,3,11,21,19,27,33,28,20,9,10,12,18,18,17,17,11,8,9,17,14,21,23,26,14,6,0,10,61,100,96,86,12,5,0,11,58,79,99,76,10,0,0,13,45,56,57,55,8,0,0,13,17,13,15,18,7,0,0,4,6,8,5,4,0,0,0,6,8,7,8,9,6,0,1,5,9,8,10,11,3,0,1,8,7,10,8,8,1,0,3,8,10,8,9,15,9,1,8,16,28,13,17,18,10,4,0,0,0,0,0,0,0,0,0,4,0,1,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1993, 2062, 1, 0, NULL);
INSERT INTO `renhe_collect` VALUES (223, '242', '2024-01-03 16:16:26', '0,3,5,7,11,7,5,0,0,6,6,9,12,8,6,0,2,7,13,42,47,48,16,1,4,13,48,62,68,69,36,3,4,12,46,64,87,73,27,3,7,11,8,26,25,32,18,9,4,9,12,14,13,21,13,8,7,11,19,23,14,37,14,7,0,6,54,72,73,67,14,0,0,4,50,68,70,60,14,0,0,7,14,30,37,30,11,0,0,7,10,9,11,12,10,0,0,0,7,5,6,7,4,0,0,3,6,9,7,9,8,0,0,2,8,8,7,9,7,0,0,0,7,5,5,9,4,0,3,6,8,6,6,7,9,1,5,11,14,12,12,12,10,3,0,3,0,0,0,0,0,0,1,0,4,3,1,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1547, 1707, 1, 0, NULL);
INSERT INTO `renhe_collect` VALUES (224, '132', '2024-01-03 16:18:34', '0,2,7,10,12,4,2,0,1,5,8,10,12,8,5,1,0,10,11,14,17,17,12,0,3,11,27,35,45,46,14,0,5,15,32,45,76,46,11,0,11,17,25,26,22,22,10,7,9,10,19,18,19,17,12,7,9,13,18,23,24,21,13,7,5,14,61,76,66,39,8,0,5,21,66,64,69,34,8,0,1,18,51,43,45,30,10,2,2,11,13,9,11,12,10,0,1,8,7,6,6,8,6,0,0,4,9,7,5,6,4,0,2,7,10,6,8,7,5,0,0,7,8,5,6,9,2,0,3,6,9,8,9,7,4,2,7,14,17,9,11,13,7,1,0,0,0,0,0,0,0,0,0,2,4,2,2,1,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1348, 1454, 1, 0, NULL);
INSERT INTO `renhe_collect` VALUES (225, '412', '2024-01-03 16:28:59', '0,1,3,5,7,4,1,0,2,0,6,10,16,11,8,0,3,7,13,32,35,31,21,1,1,11,42,49,53,71,43,4,0,13,39,61,92,81,24,0,6,19,25,33,35,34,23,7,4,10,14,14,20,22,12,8,6,13,22,30,30,31,16,8,4,13,67,82,73,60,12,1,2,16,103,109,102,85,18,2,2,14,43,42,38,35,11,0,2,13,19,13,12,16,11,0,0,5,6,7,9,10,7,0,0,9,11,10,10,12,7,0,0,8,11,11,10,12,7,3,0,7,7,6,8,11,6,0,2,8,5,7,12,16,7,2,5,19,22,16,21,29,13,5,0,0,1,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1863, 1981, 1, 0, NULL);
INSERT INTO `renhe_collect` VALUES (226, '140', '2024-01-03 16:31:51', '0,2,4,7,13,9,6,0,0,0,9,11,14,12,7,0,0,7,20,37,33,38,23,3,0,7,32,48,55,62,29,3,1,8,20,55,87,46,24,2,8,18,26,35,29,29,23,11,10,13,23,28,27,17,13,5,10,23,37,29,28,30,19,8,1,29,77,89,94,53,11,0,0,17,66,73,62,27,9,0,0,12,31,30,36,26,7,0,0,11,25,14,15,19,14,0,1,0,5,8,12,10,8,0,0,4,10,10,8,7,5,0,5,9,12,13,11,9,7,0,0,18,16,9,9,12,5,0,4,8,31,18,17,18,11,2,7,14,25,62,24,16,13,4,0,4,0,0,2,0,0,0,0,2,0,1,0,1,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1697, 1816, 1, 0, NULL);
INSERT INTO `renhe_collect` VALUES (227, '478', '2024-01-03 16:33:41', '0,1,5,5,5,3,0,0,0,1,4,4,7,7,3,0,0,1,16,25,16,19,1,0,0,10,28,27,32,28,0,0,3,18,47,74,59,25,1,0,0,8,18,22,32,21,10,0,0,9,12,11,16,22,6,1,3,18,34,16,26,21,7,0,2,28,58,79,67,29,1,0,0,31,65,57,64,40,2,0,0,41,60,45,41,31,5,0,0,12,13,11,11,9,5,0,0,7,7,6,6,6,2,0,0,10,8,8,4,7,5,0,0,7,6,4,10,5,1,0,0,0,0,0,0,0,0,0,0,7,9,0,2,9,5,0,9,28,23,26,24,19,10,5,1,3,3,0,0,0,0,0,0,3,2,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 803, 1529, 1, 0, NULL);
INSERT INTO `renhe_collect` VALUES (228, '031', '2024-01-03 16:35:52', '0,6,8,11,10,7,0,0,0,8,11,12,21,10,7,0,1,14,25,41,31,38,10,0,8,32,52,64,62,51,8,0,8,18,40,73,79,41,4,0,10,23,29,33,32,27,11,3,9,13,21,19,23,18,12,3,11,18,49,31,31,30,14,4,3,23,87,89,83,61,8,0,0,22,70,66,56,42,9,0,0,17,39,29,31,22,9,0,0,10,13,9,10,12,8,0,0,2,3,1,5,6,0,0,0,4,8,8,7,9,3,0,0,8,11,9,10,12,6,0,0,9,7,2,6,9,1,0,5,11,9,8,10,11,8,0,7,12,10,12,14,11,6,2,0,0,0,0,0,0,0,0,0,2,2,0,0,2,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1661, 1803, 1, 0, NULL);
INSERT INTO `renhe_collect` VALUES (229, '013', '2024-01-03 16:47:57', '4,5,9,21,15,6,3,0,3,7,14,21,26,23,6,0,5,17,29,47,56,65,20,1,5,19,43,61,84,85,15,0,8,20,54,67,87,65,11,0,13,21,28,33,36,25,14,6,12,15,20,27,26,26,10,5,11,20,38,40,29,34,13,5,5,12,74,95,98,96,33,0,0,6,38,55,59,45,11,0,0,8,21,25,21,21,6,0,2,10,11,8,9,10,0,0,0,0,6,3,2,0,0,0,0,7,13,9,8,8,0,0,0,10,13,8,13,12,5,0,3,12,9,9,12,11,0,0,4,10,11,11,15,17,5,1,13,14,21,17,23,14,9,0,3,2,0,0,0,0,0,0,3,3,5,2,1,2,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1874, 1962, 1, 0, NULL);
INSERT INTO `renhe_collect` VALUES (230, '011', '2024-01-03 16:49:37', '0,3,4,7,5,3,2,0,0,3,3,12,9,2,0,0,2,9,8,14,21,18,5,0,5,14,49,53,61,62,10,0,6,14,43,66,83,62,10,1,12,21,29,25,29,35,3,4,7,10,11,15,19,15,8,0,9,12,23,16,20,18,13,0,6,11,60,72,85,48,3,0,5,12,73,78,78,40,11,0,4,13,59,62,53,30,9,0,0,9,13,9,9,11,5,0,0,6,7,6,7,7,1,0,0,6,10,8,8,8,2,0,0,9,11,9,7,7,3,0,0,9,6,10,11,11,4,0,6,10,9,11,12,8,4,4,8,9,17,13,12,13,7,1,2,0,0,0,0,0,0,0,0,1,2,3,2,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1258, 1669, 1, 0, NULL);
INSERT INTO `renhe_collect` VALUES (231, '306', '2024-01-03 16:51:30', '0,2,3,6,7,4,2,0,0,6,8,12,17,9,4,0,0,9,8,20,33,30,11,0,1,8,53,62,66,64,38,3,0,10,46,74,95,82,28,0,12,19,24,22,32,27,16,7,10,13,13,14,14,24,12,6,7,12,14,24,23,19,12,5,1,9,66,100,92,66,11,0,0,11,72,87,92,62,11,0,0,13,59,62,57,51,9,2,0,11,14,11,10,13,9,0,0,7,9,8,10,10,3,0,0,9,9,9,8,8,4,0,0,7,9,8,9,6,1,0,0,4,6,6,7,8,0,0,7,8,11,8,12,12,7,0,8,18,13,13,17,15,6,0,0,0,3,0,0,0,0,0,1,5,4,3,3,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1836, 1936, 1, 0, NULL);
INSERT INTO `renhe_collect` VALUES (232, '093', '2024-01-03 16:54:45', '0,2,5,9,10,7,0,0,0,6,7,10,9,6,3,0,0,6,10,13,13,13,11,2,0,12,14,45,67,58,21,3,1,8,16,52,89,76,19,2,7,11,13,24,22,24,12,7,6,10,12,14,13,17,10,6,5,12,25,18,22,22,12,6,0,11,56,80,76,67,12,0,0,13,63,77,70,65,16,0,2,10,55,50,52,45,11,0,0,10,11,11,9,11,8,0,0,3,5,4,7,7,0,0,0,7,8,8,7,9,5,0,1,10,9,8,8,8,2,0,2,6,6,4,6,8,0,0,6,12,11,5,14,12,8,3,9,9,14,13,11,13,7,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1514, 1585, 1, 0, NULL);
INSERT INTO `renhe_collect` VALUES (233, '095', '2024-01-03 16:59:15', '2,4,6,6,6,5,0,0,0,2,5,4,4,7,2,0,1,5,16,17,31,36,8,2,6,6,33,42,55,54,7,0,2,6,30,48,65,48,9,0,7,4,17,22,22,21,6,2,5,5,8,12,11,10,6,2,6,6,17,9,15,13,7,0,3,5,54,72,74,54,4,0,1,8,55,57,65,54,7,0,0,6,37,27,16,21,6,0,0,2,7,2,6,7,2,0,1,2,6,7,0,3,4,0,0,1,6,5,6,7,2,0,0,5,6,6,5,8,6,0,3,3,11,8,7,10,7,0,9,8,9,5,11,12,9,5,6,8,13,11,9,12,6,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1183, 1337, 1, 0, NULL);
INSERT INTO `renhe_collect` VALUES (234, '277', '2024-01-03 17:01:03', '0,4,4,9,14,11,6,0,0,4,8,10,14,12,9,0,1,8,13,27,39,40,13,0,4,14,45,55,62,81,40,3,7,14,42,59,86,73,31,1,10,18,21,41,51,47,18,6,8,11,13,19,17,22,12,6,9,14,24,25,19,25,15,5,5,10,57,86,100,80,36,2,1,9,44,76,82,75,39,0,1,12,38,41,33,33,14,0,0,11,13,11,12,13,12,3,0,0,6,6,3,3,7,0,0,3,10,6,2,5,5,0,0,7,9,8,8,9,7,0,5,6,12,6,7,10,8,0,3,10,13,12,10,12,13,4,8,14,20,14,14,19,14,9,0,1,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1731, 1929, 1, 0, NULL);
INSERT INTO `renhe_collect` VALUES (235, '292', '2024-01-03 17:02:58', '0,1,3,9,9,11,5,0,0,6,7,11,13,11,8,0,0,3,11,13,23,28,12,3,0,4,22,44,58,56,32,4,0,8,26,68,81,61,24,0,1,12,19,29,33,26,11,6,1,11,12,14,22,16,9,2,7,13,25,21,27,16,12,4,0,10,100,103,82,65,8,0,0,13,103,102,88,53,10,0,3,16,50,47,44,38,10,0,0,11,12,9,12,13,10,0,0,7,8,6,6,8,1,0,0,6,9,8,7,8,7,0,0,5,9,5,8,7,2,0,0,6,7,5,9,7,3,0,0,8,8,9,9,12,7,0,7,16,14,13,14,14,11,2,0,0,0,0,0,0,0,0,0,0,3,2,1,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1728, 1785, 1, 0, NULL);
INSERT INTO `renhe_collect` VALUES (236, '143', '2024-01-03 17:04:48', '0,2,3,8,8,5,2,0,0,3,5,9,12,10,2,0,1,7,11,10,14,14,10,0,1,13,14,25,26,31,10,0,6,19,43,70,90,44,7,0,9,17,29,31,26,23,9,2,8,12,21,20,21,21,11,4,9,18,34,25,26,31,15,5,2,16,100,97,104,63,6,0,3,22,84,58,66,41,5,0,2,19,47,40,49,34,8,0,1,12,14,12,12,13,9,0,0,7,9,7,7,11,4,0,0,6,10,6,6,9,6,0,0,8,8,7,9,8,5,0,0,8,11,4,8,8,5,0,4,5,6,7,9,9,8,0,5,11,17,12,14,17,10,3,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1540, 1650, 1, 0, NULL);
INSERT INTO `renhe_collect` VALUES (238, '006', '2024-01-03 17:24:45', '0,2,4,4,4,2,0,0,1,3,6,7,4,3,1,0,2,4,5,8,8,4,2,0,5,9,36,45,49,22,4,0,6,14,52,63,68,37,1,0,8,6,9,9,12,5,3,4,7,6,6,7,7,5,3,5,7,7,10,8,9,7,7,5,5,8,50,65,58,12,3,0,3,21,66,68,71,21,1,0,1,20,45,48,50,18,2,0,1,6,7,5,6,3,4,0,2,6,8,4,6,6,3,0,1,3,3,5,2,2,2,0,1,2,2,3,2,2,1,0,1,3,3,2,4,3,0,0,3,6,4,5,7,6,4,1,5,8,8,8,7,8,2,0,0,0,0,0,0,0,0,0,0,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1040, 1179, 1, 0, NULL);
INSERT INTO `renhe_collect` VALUES (239, '64', '2024-01-03 17:27:13', '0,3,8,8,7,3,2,0,0,5,5,6,6,3,1,0,0,6,13,19,19,16,6,0,6,17,48,61,69,51,8,0,8,18,51,100,104,43,2,0,11,7,20,27,39,16,9,1,9,13,18,15,18,13,8,0,10,12,31,27,26,12,12,3,6,20,102,104,100,35,6,0,5,27,109,77,88,36,6,0,5,17,56,39,38,19,5,0,3,10,12,9,11,10,3,0,0,6,6,8,9,8,1,0,0,7,8,5,5,4,2,0,0,5,6,7,10,6,0,0,0,7,7,7,7,5,0,0,0,8,9,8,9,4,3,0,9,22,25,21,14,8,6,2,1,0,0,0,0,0,0,0,0,3,4,1,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1806, 1841, 1, 0, NULL);
INSERT INTO `renhe_collect` VALUES (240, '284', '2024-01-03 17:29:27', '0,0,3,11,10,4,2,0,0,5,7,8,8,5,4,0,2,11,10,14,29,20,8,0,3,11,43,46,50,52,18,0,7,19,48,65,79,54,12,0,19,20,24,30,38,32,16,7,16,12,16,21,25,20,11,5,12,13,17,19,20,21,12,0,5,10,59,83,100,76,12,0,6,12,60,76,72,67,14,0,7,11,58,68,57,43,13,0,8,13,17,13,14,14,10,0,2,6,10,6,7,10,8,0,2,10,10,8,9,6,5,0,1,9,9,7,7,7,4,0,0,5,8,6,6,9,2,0,3,8,8,7,7,6,4,3,5,14,22,21,21,17,8,3,0,0,0,0,1,3,0,0,0,0,3,3,4,5,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1720, 1794, 1, 0, NULL);
INSERT INTO `renhe_collect` VALUES (241, '124', '2024-01-03 17:31:48', '0,1,4,6,7,8,5,0,0,3,6,10,12,9,5,2,0,2,11,13,15,21,11,3,0,0,18,47,56,49,35,6,0,1,14,52,75,62,27,4,6,8,12,28,26,35,9,5,5,9,13,14,14,20,7,7,6,10,22,25,25,20,13,6,1,7,54,67,72,68,16,0,0,7,54,58,63,63,30,0,0,8,34,39,29,14,12,0,3,10,12,11,10,11,7,0,0,3,6,9,9,8,7,0,0,3,9,5,4,4,4,1,0,3,7,7,4,5,4,0,0,3,7,5,5,7,5,0,0,6,9,7,7,8,6,3,3,10,13,14,14,14,11,4,0,0,0,0,0,0,0,0,0,0,0,1,0,1,1,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1450, 1479, 1, 0, NULL);
INSERT INTO `renhe_collect` VALUES (242, '451', '2024-01-03 17:33:49', '0,2,2,6,7,14,6,0,0,4,6,6,8,13,7,1,0,5,10,17,22,36,28,6,1,8,18,41,57,59,41,10,3,5,11,49,76,65,41,2,8,13,16,30,37,36,19,9,9,13,15,22,21,35,16,8,8,13,24,30,23,38,22,9,4,9,48,66,71,64,24,0,0,10,55,66,71,66,31,0,0,7,49,49,51,39,15,1,0,11,14,14,12,11,8,0,1,7,10,11,10,11,10,0,0,7,7,5,6,8,5,0,0,8,8,8,7,10,7,0,2,5,8,7,5,10,9,0,3,5,8,7,7,10,11,3,5,30,23,17,22,20,12,4,3,6,0,4,3,0,0,0,0,4,3,1,4,4,2,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1701, 1765, 1, 0, NULL);
INSERT INTO `renhe_collect` VALUES (243, '85', '2024-01-03 17:35:27', '0,3,5,7,9,5,7,0,0,5,9,8,12,8,4,0,1,12,21,29,44,45,7,0,0,20,43,48,58,55,10,0,8,10,41,54,70,48,6,0,1,4,11,21,20,16,11,0,1,11,15,16,13,15,6,1,4,19,42,27,31,26,12,0,0,32,66,79,67,46,0,0,0,47,69,62,65,37,0,0,0,38,52,48,49,23,0,0,0,6,6,3,5,8,2,0,0,0,0,0,3,2,0,0,0,0,1,1,3,5,0,0,0,7,5,7,6,8,4,0,0,8,4,8,6,6,0,0,6,4,7,9,12,10,3,0,3,26,18,10,6,5,8,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1542, 1697, 1, 0, NULL);
INSERT INTO `renhe_collect` VALUES (244, '285', '2024-01-03 17:37:22', '0,3,2,5,9,6,1,0,0,3,7,14,17,12,11,0,1,7,12,18,28,31,14,4,1,12,17,33,49,51,31,7,4,16,37,47,77,69,32,3,12,20,21,28,32,34,24,6,9,12,13,15,19,24,14,7,8,12,18,24,22,20,12,3,4,14,46,76,87,66,16,0,3,12,57,66,63,43,12,0,3,11,55,53,49,36,12,0,3,13,9,11,13,14,12,0,0,7,7,8,6,8,5,0,6,11,12,13,10,11,7,0,3,8,7,7,9,6,3,0,1,6,6,4,6,9,6,0,5,6,7,5,6,9,5,1,7,26,19,21,22,17,11,3,2,4,0,0,0,0,0,0,0,3,0,0,2,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1452, 1657, 1, 0, NULL);
INSERT INTO `renhe_collect` VALUES (245, '371', '2024-01-03 17:39:03', '0,3,9,10,10,9,3,0,0,5,5,10,20,10,4,0,1,8,15,32,23,19,10,0,5,11,37,47,45,54,26,0,9,15,38,59,92,68,26,0,14,27,42,52,50,41,26,9,8,11,16,32,25,30,12,1,9,15,24,40,37,31,13,0,0,11,54,75,70,59,11,0,4,15,62,75,78,65,18,0,5,21,53,56,60,47,13,0,4,13,20,17,15,20,12,0,2,6,10,7,9,11,5,0,2,10,11,11,11,10,5,0,0,10,14,7,10,9,4,0,0,7,10,6,9,15,6,0,3,11,12,11,12,12,8,0,4,14,14,14,13,12,7,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2033', 'plus', '21', 1699, 1909, 1, 0, NULL);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '描述',
  `flag` int(50) NULL DEFAULT NULL COMMENT '唯一标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '管理员', '拥有系统最高操作权限', 1);
INSERT INTO `role` VALUES (3, '普通成员', '一般成员，可操作事务管理内容', 2);
INSERT INTO `role` VALUES (4, '游客', '游客', 3);
INSERT INTO `role` VALUES (5, '测试', '测试员', 4);
INSERT INTO `role` VALUES (13, '众信安员工', '众信安员工专用角色', 4);

-- ----------------------------
-- Table structure for role_menu
-- ----------------------------
DROP TABLE IF EXISTS `role_menu`;
CREATE TABLE `role_menu`  (
  `role_id` bigint(11) NOT NULL COMMENT '角色id',
  `menu_id` bigint(11) NOT NULL COMMENT '菜单id',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE,
  UNIQUE INDEX `uniq_roleId_menuId`(`role_id`, `menu_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色对应菜单权限' ROW_FORMAT = Fixed;

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
INSERT INTO `role_menu` VALUES (1, 14);
INSERT INTO `role_menu` VALUES (1, 22);
INSERT INTO `role_menu` VALUES (1, 23);
INSERT INTO `role_menu` VALUES (1, 30);
INSERT INTO `role_menu` VALUES (1, 32);
INSERT INTO `role_menu` VALUES (1, 33);
INSERT INTO `role_menu` VALUES (1, 34);
INSERT INTO `role_menu` VALUES (1, 35);
INSERT INTO `role_menu` VALUES (1, 36);
INSERT INTO `role_menu` VALUES (1, 37);
INSERT INTO `role_menu` VALUES (1, 39);
INSERT INTO `role_menu` VALUES (1, 42);
INSERT INTO `role_menu` VALUES (3, 2);
INSERT INTO `role_menu` VALUES (3, 5);
INSERT INTO `role_menu` VALUES (3, 7);
INSERT INTO `role_menu` VALUES (3, 8);
INSERT INTO `role_menu` VALUES (3, 9);
INSERT INTO `role_menu` VALUES (3, 10);
INSERT INTO `role_menu` VALUES (3, 14);
INSERT INTO `role_menu` VALUES (3, 22);
INSERT INTO `role_menu` VALUES (3, 23);
INSERT INTO `role_menu` VALUES (3, 30);
INSERT INTO `role_menu` VALUES (3, 32);
INSERT INTO `role_menu` VALUES (3, 33);
INSERT INTO `role_menu` VALUES (3, 35);
INSERT INTO `role_menu` VALUES (3, 36);
INSERT INTO `role_menu` VALUES (4, 2);
INSERT INTO `role_menu` VALUES (4, 7);
INSERT INTO `role_menu` VALUES (4, 22);
INSERT INTO `role_menu` VALUES (4, 23);
INSERT INTO `role_menu` VALUES (4, 30);
INSERT INTO `role_menu` VALUES (5, 2);
INSERT INTO `role_menu` VALUES (5, 5);
INSERT INTO `role_menu` VALUES (5, 6);
INSERT INTO `role_menu` VALUES (5, 7);
INSERT INTO `role_menu` VALUES (5, 8);
INSERT INTO `role_menu` VALUES (5, 9);
INSERT INTO `role_menu` VALUES (5, 10);
INSERT INTO `role_menu` VALUES (5, 11);
INSERT INTO `role_menu` VALUES (5, 12);
INSERT INTO `role_menu` VALUES (5, 14);
INSERT INTO `role_menu` VALUES (5, 22);
INSERT INTO `role_menu` VALUES (5, 23);
INSERT INTO `role_menu` VALUES (5, 30);
INSERT INTO `role_menu` VALUES (5, 32);
INSERT INTO `role_menu` VALUES (5, 33);
INSERT INTO `role_menu` VALUES (13, 2);
INSERT INTO `role_menu` VALUES (13, 36);
INSERT INTO `role_menu` VALUES (13, 37);
INSERT INTO `role_menu` VALUES (13, 39);
INSERT INTO `role_menu` VALUES (13, 42);

-- ----------------------------
-- Table structure for sleep_position_collect
-- ----------------------------
DROP TABLE IF EXISTS `sleep_position_collect`;
CREATE TABLE `sleep_position_collect`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_info_id` bigint(11) NULL DEFAULT NULL COMMENT 'userInfo的id',
  `bed_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '床垫id',
  `mat` tinyint(1) NULL DEFAULT NULL COMMENT '舒适层:1stand 2plus 3pro',
  `is_automode` tinyint(1) NULL DEFAULT NULL COMMENT '是否启用自动模式0关1开',
  `is_fine_adjustment` tinyint(1) NULL DEFAULT NULL COMMENT '是否启用微调0关1开',
  `project` tinyint(1) NULL DEFAULT NULL COMMENT '测试项目：1、正中识别2、1/3身体在传感器外',
  `period` int(5) NULL DEFAULT NULL COMMENT '检测周期，单位秒',
  `recognition` tinyint(1) NULL DEFAULT NULL COMMENT '识别姿势：5无人1仰卧2、3侧卧4坐姿',
  `actual_sleep_position` tinyint(1) NULL DEFAULT NULL COMMENT '实际睡姿',
  `is_reg` tinyint(1) NULL DEFAULT NULL COMMENT '识别是否成功：0失败1成功',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `start_time` datetime(0) NULL DEFAULT NULL COMMENT '开始时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sleepUserId_userInfoId`(`user_info_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sleep_position_collect
-- ----------------------------
INSERT INTO `sleep_position_collect` VALUES (1, 3, '2033', 1, 0, 1, 2, 30, 1, 1, 1, '2023-12-30 22:45:10', '2024-01-02 22:07:31');
INSERT INTO `sleep_position_collect` VALUES (6, 3, '1457', 2, 1, 1, 1, 5, NULL, 1, NULL, '2024-01-03 00:48:42', '2024-01-03 00:48:42');
INSERT INTO `sleep_position_collect` VALUES (20, 3, '1457', 2, 1, 1, 2, 1, NULL, 1, NULL, '2024-01-03 22:06:51', '2024-01-03 22:06:51');

-- ----------------------------
-- Table structure for target
-- ----------------------------
DROP TABLE IF EXISTS `target`;
CREATE TABLE `target`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uid` bigint(11) NOT NULL COMMENT '用户id',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '目标代号',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '目标描述',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `start_time` date NOT NULL COMMENT '开始日期',
  `end_time` date NOT NULL COMMENT '结束日期',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '完成状态；0：未开始，1：进行中，2：已完成，3：已过期，4：已终止',
  `schedule` int(3) NOT NULL DEFAULT 0 COMMENT '完成进度',
  `level` tinyint(11) NOT NULL DEFAULT 1 COMMENT '级别；0：困难，1：正常，2：轻松',
  `is_delete` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除；0：未删除，1：已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 36 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of target
-- ----------------------------
INSERT INTO `target` VALUES (1, 62, '天鹰计划', '训练跑步', '2023-02-23 23:05:27', '2023-02-23', '2023-02-23', 3, 58, 0, 0);
INSERT INTO `target` VALUES (2, 62, '天马计划', '训练跑步', '2023-02-22 23:05:27', '2023-02-22', '2023-02-23', 3, 80, 1, 0);
INSERT INTO `target` VALUES (3, 62, '天狼计划', '训练跑步', '2023-02-21 23:05:27', '2023-02-21', '2023-02-23', 2, 100, 2, 0);
INSERT INTO `target` VALUES (4, 62, '天熊计划', '训练跑步', '2023-02-20 23:05:27', '2023-02-20', '2023-02-23', 3, 25, 0, 0);
INSERT INTO `target` VALUES (5, 62, '天龙计划', '训练跑步', '2023-02-19 23:05:27', '2023-02-19', '2023-02-23', 4, 75, 1, 0);
INSERT INTO `target` VALUES (6, 62, '天鹿计划', '训练跑步', '2023-02-18 23:05:27', '2023-02-18', '2023-02-23', 3, 0, 2, 0);
INSERT INTO `target` VALUES (7, 62, '天人计划', '训练跑步', '2023-02-17 23:05:27', '2023-02-17', '2023-02-23', 3, 11, 1, 0);
INSERT INTO `target` VALUES (14, 62, '测试代号', '测试描述', '2023-03-05 10:45:43', '2023-03-06', '2023-03-09', 4, 0, 1, 0);
INSERT INTO `target` VALUES (35, 22, '梅花Q', NULL, '2023-03-18 23:29:52', '2023-03-18', '2023-03-24', 3, 19, 0, 0);

-- ----------------------------
-- Table structure for target_detail
-- ----------------------------
DROP TABLE IF EXISTS `target_detail`;
CREATE TABLE `target_detail`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `t_id` bigint(11) NULL DEFAULT NULL COMMENT '所属任务id',
  `a_id` bigint(11) NULL DEFAULT NULL COMMENT '活动id',
  `duration` int(11) NULL DEFAULT NULL COMMENT '计划活动时长',
  `be_prepared` int(11) NULL DEFAULT NULL COMMENT '已完成时长',
  `status` tinyint(4) NULL DEFAULT 0 COMMENT '状态：0：未完成，1：已完成',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of target_detail
-- ----------------------------
INSERT INTO `target_detail` VALUES (26, 35, 1, 7, 3, 0);
INSERT INTO `target_detail` VALUES (27, 35, 2, 2, 0, 0);
INSERT INTO `target_detail` VALUES (28, 35, 4, 5, 0, 0);
INSERT INTO `target_detail` VALUES (29, 35, 9, 7, 1, 0);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '性别',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `role` bigint(50) NOT NULL DEFAULT 4 COMMENT '角色：1管理员，2普通成员，3游客，4定制',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `open_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '微信openid',
  `recent_login` datetime(0) NULL DEFAULT NULL COMMENT '最近登录时间',
  `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '删除状态：1，删除；0，未删除',
  `status` tinyint(1) NULL DEFAULT 0 COMMENT '在线状态：1，在线；0，离线',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_userId`(`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 72 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'sqn', '$2a$10$B2mSSpvnzb3aF9WAeWXcaO1D78yc3kgO6DWceOalVFi6rIQBKQ15.', '沈奇男', '1997-10-01', '男', 'http://localhost:9090/files/test/0cda61eac7b849e59af673c5ca470e92.jpg', NULL, 1, '15215913937', NULL, '2024-01-03 21:45:10', 0, 1);
INSERT INTO `user` VALUES (22, 'dmj', '$2a$10$CQ1i9M.57VCCHZsM0DggWervD/fgQWO18BalmJOXFsyMA5NWpY946', '杜梅军', '1971-07-14', '女', 'http://localhost:9090/files/test/dd626ce6f5f441d8b34e4c9106d369eb.jpg', NULL, 3, '13819545627', NULL, '2023-12-30 14:28:41', 0, 0);
INSERT INTO `user` VALUES (23, 'sjx', '$2a$10$CQ1i9M.57VCCHZsM0DggWervD/fgQWO18BalmJOXFsyMA5NWpY946', '沈建祥', '1974-03-22', '男', NULL, NULL, 3, '18888790728', NULL, '2023-12-30 14:26:49', 0, 0);
INSERT INTO `user` VALUES (24, 'sjy', '$2a$10$CQ1i9M.57VCCHZsM0DggWervD/fgQWO18BalmJOXFsyMA5NWpY946', '沈建英', NULL, '女', NULL, NULL, 3, '13454588810', NULL, NULL, 0, 0);
INSERT INTO `user` VALUES (42, 'sqy', '$2a$10$DK3So8no8V4mNTdqmZqLm.dzvqPOMUCGk9EXmJ8YXxu8njGwEFVNO', '沈奇亚', '1997-03-07', '女', 'http://localhost:9090/files/test/ebd6733138664ee79f15e6cd499fcdd0.jpg', '2022-07-24 23:34:26', 1, '15868180225', NULL, '2023-12-16 10:57:13', 0, 1);
INSERT INTO `user` VALUES (26, 'bzy', '$2a$10$CQ1i9M.57VCCHZsM0DggWervD/fgQWO18BalmJOXFsyMA5NWpY946', '边震宇', '2008-08-30', '男', NULL, NULL, 3, '18258021073', NULL, '2023-12-30 15:08:19', 0, 1);
INSERT INTO `user` VALUES (31, 'yk1', '$2a$10$s9EXA7z4XgkdUGKg7hZAL.tk5o4BSJHC8V6jUKdAyzGN4ugt9FkuW', '游客1', '2022-07-14', '女', '', '2022-07-19 01:35:13', 4, '15215913933', NULL, NULL, 0, 0);
INSERT INTO `user` VALUES (45, 'ts1', '$2a$10$.dIyUhwvquxSvSD/dPoeNOJ96Bhcho/g2ePSvfipdqxYUtS20e0fW', '沈小测1', NULL, NULL, 'http://localhost:9090/files/test/cdd762c6722a4daf81ea03e9a88c143a.jpg', '2022-07-26 14:41:19', 5, '15215913934', NULL, '2023-04-20 23:38:28', 0, 1);
INSERT INTO `user` VALUES (62, 'admin', '$2a$10$s9OiSHAn331k5LuiUbbIWeyXZPVVjjQEJqv6tRXRrbHDhzev9rkAm', '系统管理员', NULL, '男', 'http://localhost:9090/files/test/6b269c174b3f46f0ae817f3cd2da9250.jpg', '2022-08-22 22:42:11', 1, '', NULL, '2023-03-21 22:20:29', 0, 1);
INSERT INTO `user` VALUES (55, 'sre', '$2a$10$mVzSSS5OZOXUsbM1iJBlV.HmklaulG6yqEECCuZVC.u1ZRQ3PP/Mi', '沈蓉儿', '2000-11-19', '女', NULL, '2022-07-29 21:45:27', 3, '15158280805', NULL, NULL, 0, 0);
INSERT INTO `user` VALUES (71, 'ts2', '$2a$10$hVBesnZYIvV0U/2KvTFGle6CO4Te3oBtLtAx0OTpV6vffwWJcg2o2', '测试2', '2023-12-29', '男', NULL, '2023-12-29 23:50:18', 5, '15868180222', NULL, NULL, 0, 0);
INSERT INTO `user` VALUES (69, 'yk3', '$2a$10$B2mSSpvnzb3aF9WAeWXcaO1D78yc3kgO6DWceOalVFi6rIQBKQ15.', '游客_x2mmfgqk', NULL, NULL, NULL, '2023-06-28 15:52:14', 4, '15268180225', NULL, '2023-06-28 16:17:37', 1, 1);
INSERT INTO `user` VALUES (70, 'zxa', '$2a$10$CVSd4FtsaV0M1yaZQNV1je3BuHeHx49t0sjn/tnVwQk7vz4WbpGF2', '小安', NULL, NULL, 'http://localhost:9090/files/test/cdd762c6722a4daf81ea03e9a88c143a.jpg', '2023-12-29 13:49:43', 13, '15215913938', NULL, '2023-12-30 23:22:58', 0, 0);

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '测试人员姓名',
  `weight` decimal(5, 1) NULL DEFAULT NULL COMMENT '体重',
  `height` decimal(5, 1) NULL DEFAULT NULL COMMENT '身高',
  `sex` tinyint(1) NULL DEFAULT NULL COMMENT '性别：1男2女',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES (10, '小安', 110.0, 180.0, 2);
INSERT INTO `user_info` VALUES (3, '沈奇男', 135.0, 173.0, 1);
INSERT INTO `user_info` VALUES (11, '小众', 100.0, 155.0, 1);

SET FOREIGN_KEY_CHECKS = 1;
