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

 Date: 27/07/2023 15:01:09
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
) ENGINE = MyISAM AUTO_INCREMENT = 354 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

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
) ENGINE = MyISAM AUTO_INCREMENT = 60 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '事件管理表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of events
-- ----------------------------
INSERT INTO `events` VALUES (28, '我是大漂酿', '<p>我是大漂酿<span style=\"color: var(--w-e-textarea-color); font-size: var(--el-dialog-content-font-size);\">👻</span></p>', 42, '2022-07-29 00:19:26', 251);
INSERT INTO `events` VALUES (24, '老沈爱我的表现1', '<p>老沈昨天掐了我三下，说是爱我的表现<span style=\"color: var(--w-e-textarea-color); font-size: var(--el-dialog-content-font-size);\">😤</span></p>', 1, '2022-07-16 01:40:10', 160);
INSERT INTO `events` VALUES (44, '老沈练书法的第一天', '<p>我家老沈第一天练字，加油！very good!<img src=\"http://localhost:9090/files/250d46c597f94157abf1c22074346fc3\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', 1, '2023-02-24 21:28:32', 9);
INSERT INTO `events` VALUES (47, '哼哼哼', '<p>今天沈奇男不让我学习，哼哼哼</p>', 42, '2023-03-08 22:10:37', 4);
INSERT INTO `events` VALUES (48, '沈奇男必须提醒我', '<p>明天要在我的宝座上做作业，<span style=\"color: var(--w-e-textarea-color);\">沈奇男必须提醒我，这个是沈奇男的监督任务，必须完成!!!</span></p>', 42, '2023-03-08 22:11:55', 7);
INSERT INTO `events` VALUES (57, '老沈今天吃不完银耳', '哈哈哈', 42, '2023-04-23 23:35:51', 19);

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
) ENGINE = MyISAM AUTO_INCREMENT = 54 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '文件管理表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of files
-- ----------------------------
INSERT INTO `files` VALUES (47, '哈头像.jpg', 'jpg', 7, 'http://localhost:9090/files/test/b25f4a7e765d4375aa9bde534e01e4c3.jpg', 'd0034dd1f891ee8446debade2142390c', 0, 1);
INSERT INTO `files` VALUES (48, '小沈.jpg', 'jpg', 434, 'http://localhost:9090/files/test/d3ddc566bbd3429293f35e77b382dae1.jpg', '6011acb83994d9c62f4a4a2ef29180be', 0, 1);
INSERT INTO `files` VALUES (49, '老沈.jpg', 'jpg', 34, 'http://localhost:9090/files/test/a73326ce64064c7f858881855638ee25.jpg', 'e3f851531cb8c035015dd190b2895f71', 0, 1);
INSERT INTO `files` VALUES (50, 'default.jpg', 'jpg', 13, 'http://localhost:9090/files/test/53f46cdcd3ce4132b46ba2bb4d3563c7.jpg', '834c7fa1fa9c8b62610250717e7b25c8', 1, 1);
INSERT INTO `files` VALUES (51, '背景1.jfif', 'jfif', 2778, 'http://localhost:9090/files/test/5222f97fc3f44ce093920a5a0bb3c753.jfif', 'df5f1222c820547de66bb8038efb3873', 0, 1);
INSERT INTO `files` VALUES (52, '哈头像.jpg', 'jpg', 32, 'http://localhost:9090/files/test/cdd762c6722a4daf81ea03e9a88c143a.jpg', 'aec84b4f31e1f72fde9d35695e02d5b4', 0, 1);
INSERT INTO `files` VALUES (53, '富士山.jpg', 'jpg', 91, 'http://localhost:9090/files/test/dd626ce6f5f441d8b34e4c9106d369eb.jpg', 'e1eabf7f2679f768743eba6669bb9d07', 0, 1);

-- ----------------------------
-- Table structure for genealogy
-- ----------------------------
DROP TABLE IF EXISTS `genealogy`;
CREATE TABLE `genealogy`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '姓名',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '绑定账户',
  `father_id` bigint(255) NULL DEFAULT NULL COMMENT '父亲',
  `mother_id` bigint(255) NULL DEFAULT NULL COMMENT '母亲',
  `son_id` bigint(255) NULL DEFAULT NULL COMMENT '儿子',
  `daughter_id` bigint(255) NULL DEFAULT NULL COMMENT '女儿',
  `husband_id` bigint(255) NULL DEFAULT NULL COMMENT '丈夫',
  `wife_id` bigint(255) NULL DEFAULT NULL COMMENT '妻子',
  `bro_sis_id` bigint(255) NULL DEFAULT NULL COMMENT '兄妹',
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `status` tinyint(255) NULL DEFAULT NULL COMMENT '状态：0：去世；1：健在',
  `is_immediate_family` tinyint(255) NULL DEFAULT NULL COMMENT '是否是直系亲属：0：否；1：是',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '家谱' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of genealogy
-- ----------------------------
INSERT INTO `genealogy` VALUES (1, '小沈', NULL, NULL, NULL, 2, 3, NULL, NULL, NULL, '2023-07-19 20:13:52', 1, NULL);
INSERT INTO `genealogy` VALUES (2, '小奇', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2023-07-26 16:23:39', 1, NULL);
INSERT INTO `genealogy` VALUES (3, '小亚', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2023-07-27 14:34:52', 1, NULL);

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
) ENGINE = MyISAM AUTO_INCREMENT = 35 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '菜单表' ROW_FORMAT = Dynamic;

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
INSERT INTO `menu` VALUES (34, '家谱', '/genealogy', 'Notebook', '记录沈家人员关系', 6, 'Genealogy');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '描述',
  `flag` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '唯一标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '管理员', '拥有系统最高操作权限', 'ROLE_ADMIN');
INSERT INTO `role` VALUES (3, '普通成员', '一般成员，可操作事务管理内容', 'ROLE_USER');
INSERT INTO `role` VALUES (4, '游客', '游客', 'ROLE_VISITOR');
INSERT INTO `role` VALUES (5, '测试', '测试员', 'ROLE_TESTER');

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
INSERT INTO `role_menu` VALUES (3, 2);
INSERT INTO `role_menu` VALUES (3, 7);
INSERT INTO `role_menu` VALUES (3, 8);
INSERT INTO `role_menu` VALUES (3, 22);
INSERT INTO `role_menu` VALUES (3, 23);
INSERT INTO `role_menu` VALUES (3, 30);
INSERT INTO `role_menu` VALUES (3, 32);
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
INSERT INTO `target` VALUES (35, 22, '梅花Q', NULL, '2023-03-18 23:29:52', '2023-03-18', '2023-03-24', 1, 19, 0, 0);

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
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色：1管理员，2普通成员，3游客，4测试',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `open_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '微信openid',
  `recent_login` datetime(0) NULL DEFAULT NULL COMMENT '最近登录时间',
  `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '删除状态：1，删除；0，未删除',
  `status` tinyint(1) NULL DEFAULT 0 COMMENT '在线状态：1，在线；0，离线',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_userId`(`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 70 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'sqn', '$2a$10$B2mSSpvnzb3aF9WAeWXcaO1D78yc3kgO6DWceOalVFi6rIQBKQ15.', '沈奇男', '1997-10-01', '男', 'http://localhost:9090/files/test/0cda61eac7b849e59af673c5ca470e92.jpg', NULL, 'ROLE_ADMIN', '15215913937', NULL, '2023-07-27 14:23:46', 0, 1);
INSERT INTO `user` VALUES (22, 'dmj', '$2a$10$CQ1i9M.57VCCHZsM0DggWervD/fgQWO18BalmJOXFsyMA5NWpY946', '杜梅军', '1971-07-14', '女', 'http://localhost:9090/files/test/dd626ce6f5f441d8b34e4c9106d369eb.jpg', NULL, 'ROLE_USER', '13819545627', NULL, '2023-04-21 23:12:33', 0, 1);
INSERT INTO `user` VALUES (23, 'sjx', '$2a$10$CQ1i9M.57VCCHZsM0DggWervD/fgQWO18BalmJOXFsyMA5NWpY946', '沈建祥', '1974-03-22', '男', NULL, NULL, 'ROLE_USER', '18888790728', NULL, '2023-03-02 22:51:28', 0, 1);
INSERT INTO `user` VALUES (24, 'sjy', '$2a$10$CQ1i9M.57VCCHZsM0DggWervD/fgQWO18BalmJOXFsyMA5NWpY946', '沈建英', NULL, '女', NULL, NULL, 'ROLE_USER', '13454588810', NULL, NULL, 0, 0);
INSERT INTO `user` VALUES (42, 'sqy', '$2a$10$DK3So8no8V4mNTdqmZqLm.dzvqPOMUCGk9EXmJ8YXxu8njGwEFVNO', '沈奇亚', '1997-03-07', '女', 'http://localhost:9090/files/test/ebd6733138664ee79f15e6cd499fcdd0.jpg', '2022-07-24 23:34:26', 'ROLE_ADMIN', '15868180225', NULL, '2023-06-29 13:31:48', 0, 1);
INSERT INTO `user` VALUES (26, 'bzy', '$2a$10$CQ1i9M.57VCCHZsM0DggWervD/fgQWO18BalmJOXFsyMA5NWpY946', '边震宇', '2008-08-30', '男', NULL, NULL, 'ROLE_USER', NULL, NULL, NULL, 0, 0);
INSERT INTO `user` VALUES (31, 'yk1', '$2a$10$s9EXA7z4XgkdUGKg7hZAL.tk5o4BSJHC8V6jUKdAyzGN4ugt9FkuW', '游客1', '2022-07-14', '女', '', '2022-07-19 01:35:13', 'ROLE_VISITOR', '15215913933', NULL, NULL, 0, 0);
INSERT INTO `user` VALUES (45, 'ts1', '$2a$10$.dIyUhwvquxSvSD/dPoeNOJ96Bhcho/g2ePSvfipdqxYUtS20e0fW', '沈小测1', NULL, NULL, 'http://localhost:9090/files/test/cdd762c6722a4daf81ea03e9a88c143a.jpg', '2022-07-26 14:41:19', 'ROLE_TESTER', '15215913934', NULL, '2023-04-20 23:38:28', 0, 1);
INSERT INTO `user` VALUES (62, 'admin', '$2a$10$s9OiSHAn331k5LuiUbbIWeyXZPVVjjQEJqv6tRXRrbHDhzev9rkAm', '系统管理员', NULL, '男', 'http://localhost:9090/files/test/6b269c174b3f46f0ae817f3cd2da9250.jpg', '2022-08-22 22:42:11', 'ROLE_ADMIN', '15215913935', NULL, '2023-03-21 22:20:29', 0, 1);
INSERT INTO `user` VALUES (55, 'sre', '$2a$10$mVzSSS5OZOXUsbM1iJBlV.HmklaulG6yqEECCuZVC.u1ZRQ3PP/Mi', '沈蓉儿', '2000-11-19', '女', NULL, '2022-07-29 21:45:27', 'ROLE_USER', NULL, NULL, NULL, 0, 0);
INSERT INTO `user` VALUES (67, 'yk2', '$2a$10$Jsbvf.jyg.KB/D/aLQdFgeilDQnZ/wFBIP86wBMNaL7OVwU9NVkiu', '游客2', NULL, NULL, NULL, '2022-09-20 23:45:08', 'ROLE_VISITOR', '13454566610', NULL, NULL, 0, 0);
INSERT INTO `user` VALUES (69, 'yk3', '$2a$10$B2mSSpvnzb3aF9WAeWXcaO1D78yc3kgO6DWceOalVFi6rIQBKQ15.', '游客_x2mmfgqk', NULL, NULL, NULL, '2023-06-28 15:52:14', 'ROLE_VISITOR', '15268180225', NULL, '2023-06-28 16:17:37', 1, 1);

SET FOREIGN_KEY_CHECKS = 1;
