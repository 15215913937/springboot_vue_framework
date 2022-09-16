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

 Date: 16/09/2022 12:04:37
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '正文',
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发布人',
  `time` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES (1, '我是标题', '我是郑文', '作者', '我是时间');
INSERT INTO `article` VALUES (4, '13241234', NULL, '沈奇男', NULL);

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '图书ID',
  `bookname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '书名',
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '作者',
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '类别',
  `version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '版本',
  `publishing_house` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '出版社',
  `uid` int(11) NULL DEFAULT NULL COMMENT '购买人',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '价格',
  `buy_date` date NULL DEFAULT NULL COMMENT '购书日期',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '封面地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 65 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '图书信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (1, '从0到1搭建自动化测试框架', '蔡超', '自动化技术、计算机技术', NULL, '机械工业出版社', 18, 63.96, '2022-02-07', '从架构设计、工作原理、设计原则、代码实现、工程实践等维度，深入分析如何从0到1搭建自动化测试框架。\n', 'http://localhost:9090/files/5193c07851f74969a23b414bd642601d');
INSERT INTO `book` VALUES (31, '不战之困', '戴旭', '军事', NULL, '武汉出版社', 23, 45.00, '2012-04-23', '一部影响中国军队30年变革的思想库，\n50部改变中外军事格局的军事文件首度曝光。', 'http://localhost:9090/files/4e8cc550907640fd9aecd5111ca0a30f');
INSERT INTO `book` VALUES (32, '全栈自动化测试实战', '卢家涛', '自动化技术、计算机技术', '2020年3月第1版', '电子工业出版社', 18, 79.00, '2021-10-31', '基于TestNG、HttpClient、Selenium和Appium', 'http://localhost:9090/files/851c041f164b4a269afb2ae535384344');
INSERT INTO `book` VALUES (33, '金融的价值', '黄益平', '经济', '2021年12月第1版', '中信出版集团', 23, 69.00, '2022-07-22', '与宏观分析趋势，于底层掌握逻辑', 'http://localhost:9090/files/36bac59e0cad4ba486b607f2c2e10606');
INSERT INTO `book` VALUES (34, '李东生 向生而生', '李海东', '综合性图书', NULL, '中国友谊出版公司', 23, 48.00, '2022-07-22', '经历痛苦的蜕变，才能如“鹰”般重生。', 'http://localhost:9090/files/1527646ef01140cdb33879e10321c591');
INSERT INTO `book` VALUES (59, '假如时间不存在？', '[意]卡尔罗·罗威利（Carlo Rovelli）', '科普/物理', '2013年5月北京第1版第1次印刷', '化学工业出版社', 23, 24.00, '2013-10-04', '--购书于秦皇岛。\n讲点颠覆常理的科学', 'http://localhost:9090/files/784e481472164d6183e47f3b30dc6703');
INSERT INTO `book` VALUES (60, '未来简史', '[以色列]尤瓦尔·赫拉利（Yuval Noah Harari））', '社会科学总论', '2017年2月第1版', '中信出版社', 23, 68.00, '2017-11-14', '--购书于阿拉善左旗。\nHome Deus A Brief History of Tomorrow\n从智人到智神', 'http://localhost:9090/files/0774edccebfd498e86debc789a06e3b0');
INSERT INTO `book` VALUES (61, '一本书读懂不良资产', '石佳华', '经济', NULL, '中国法制出版社', 23, 68.00, '2022-09-02', ' 多年从事银行信贷、不良资产收购与处置的页内专业人士带你揭开中国不良资产管理行业的神秘面纱', 'http://localhost:9090/files/a0da2e590694473ebd0182f3285e7287');

-- ----------------------------
-- Table structure for category_list
-- ----------------------------
DROP TABLE IF EXISTS `category_list`;
CREATE TABLE `category_list`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '书籍类别',
  `flag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '唯一标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 58 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

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
-- Table structure for consumer_details
-- ----------------------------
DROP TABLE IF EXISTS `consumer_details`;
CREATE TABLE `consumer_details`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `uid` int(11) NULL DEFAULT NULL COMMENT '用户ID',
  `cost` decimal(20, 2) NULL DEFAULT NULL COMMENT '金额',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '消费类型',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '消费类别',
  `createtime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 49 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

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
INSERT INTO `consumer_details` VALUES (45, 1, 400000.00, '支出', '早餐，老台门，2个肉包子', '餐饮', '2022-09-15 23:55:23');
INSERT INTO `consumer_details` VALUES (46, 1, 100000.33, '收入', '理财', '理财', '2022-09-15 23:57:39');
INSERT INTO `consumer_details` VALUES (47, 62, 100.00, '支出', '21', '餐饮', '2022-09-16 11:05:37');
INSERT INTO `consumer_details` VALUES (48, 62, 500.00, '收入', '13', '生活缴费', '2022-09-16 11:05:46');
INSERT INTO `consumer_details` VALUES (49, 1, 40000.00, '支出', '早餐，老台门，2个肉包子', '餐饮', '2022-08-15 23:55:23');
INSERT INTO `consumer_details` VALUES (50, 1, 800000.33, '收入', '理财', '理财', '2022-08-15 23:57:39');

-- ----------------------------
-- Table structure for consumption_category
-- ----------------------------
DROP TABLE IF EXISTS `consumption_category`;
CREATE TABLE `consumption_category`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '类别名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

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

-- ----------------------------
-- Table structure for consumption_type
-- ----------------------------
DROP TABLE IF EXISTS `consumption_type`;
CREATE TABLE `consumption_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '类型名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

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
INSERT INTO `dict` VALUES ('map', 'MapLocation', 'icon');
INSERT INTO `dict` VALUES ('localAim', 'Aim', 'icon');
INSERT INTO `dict` VALUES ('coffee', 'Coffee', 'icon');
INSERT INTO `dict` VALUES ('discount', 'Discount', 'icon');
INSERT INTO `dict` VALUES ('wallet', 'Wallet', 'icon');

-- ----------------------------
-- Table structure for events
-- ----------------------------
DROP TABLE IF EXISTS `events`;
CREATE TABLE `events`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '正文',
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '编者',
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `view_count` bigint(255) NULL DEFAULT 0 COMMENT '查看次数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 40 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of events
-- ----------------------------
INSERT INTO `events` VALUES (28, '我是大漂酿', '<p>我是大漂酿<span style=\"color: var(--w-e-textarea-color); font-size: var(--el-dialog-content-font-size);\">👻</span></p>', '沈奇亚', '2022-07-29 00:19:26', 5);
INSERT INTO `events` VALUES (24, '老沈爱我的表现1', '<p>老沈昨天掐了我三下，说是爱我的表现<span style=\"color: var(--w-e-textarea-color); font-size: var(--el-dialog-content-font-size);\">😤</span></p>', '沈奇男', '2022-07-16 01:40:10', 2);
INSERT INTO `events` VALUES (25, '老沈新语1', '<p>老沈说：“有女人的地方就有江湖”<span style=\"color: var(--w-e-textarea-color); font-size: var(--el-dialog-content-font-size);\">👏</span></p>', '沈奇男', '2022-07-20 23:46:03', 1);
INSERT INTO `events` VALUES (35, '小程序端正在开发', '<p>uniapp练习</p>', '沈奇男', '2022-08-11 00:05:50', 1);
INSERT INTO `events` VALUES (37, 'uniapp组件学习', '<p>uni-ui是DCloud提供的一个跨端ui库，它是基于vue组件的、flex布局的、无dom的跨全端ui框架。<br/><br/>uni-ui不包括基础组件，它是基础组件的补充。<br/><br/>#uni-ui产品特点<br/>1、高性能<br/><br/>目前为止，在小程序和混合app领域，uni-ui是性能的标杆。<br/><br/>自动差量更新数据<br/>虽然uni-app支持小程序自定义组件，所有小程序的ui库都可以用。但小程序自定义组件的ui库都需要使用setData手动更新数据，在大数据量时、或高频更新数据时，很容易产生性能问题。<br/><br/>而uni-ui属于vue组件，uni-app引擎底层自动diff更新数据。当然其实插件市场里众多vue组件都具备这个特点。<br/><br/>优化逻辑层和视图层通讯折损<br/>非H5，不管是小程序还是App，不管是app的webview渲染还是原生渲染，全都是逻辑层和视图层分离的。这里就有一个逻辑层和视图层通讯的折损问题。 比如在视图层拖动一个可跟手的组件，由于通讯的损耗，用js监听很难做到实时跟手。<br/><br/>这时就需要使用css动画以及平台底层提供的wxs、bindingx等技术。不过这些技术都比较复杂，所以uni-ui里做了封装，在需要跟手式操作的ui组件，比如swiperaction列表项左滑菜单，就在底层使用了这些技术，实现了高性能的交互体验<br/><br/>背景停止<br/>很多ui组件是会一直动的，比如轮播图、跑马灯。即便这个窗体被新窗体挡住，它在背景层仍然在消耗着硬件资源。在Android的webview版本为chrome66以上，背景操作ui会引发很严重的性能问题，造成前台界面明显卡顿。<br/><br/>而uni-ui的组件，会自动判断自己的显示状态，在组件不再可见时，不会再消耗硬件资源。<br/><br/>2、全端<br/><br/>uni-ui的组件都是多端自适应的，底层会抹平很多小程序平台的差异或bug。<br/><br/>比如导航栏navbar组件，会自动处理不同端的状态栏； 比如swiperaction组件，在app和微信小程序上会使用交互体验更好的wxs技术，但在不支持wxs的其他小程序端会使用js模拟类似效果。<br/><br/>uni-ui还支持nvue原生渲染。<br/><br/>uni-ui还支持pc等宽屏设备，可以通过PC浏览器访问<a href=\"https://hellouniapp.dcloud.net.cn/pages/extUI/badge/badge\" target=\"_blank\">https://hellouniapp.dcloud.net.cn/pages/extUI/badge/badge</a> (opens new window)体验<br/><br/>3、风格扩展<br/><br/>uni-ui的默认风格是中型的，与uni-app基础组件风格一致。但它支持uni.scss (opens new window)，可以方便的扩展和切换应用的风格。<br/><br/>ui是一种需求非常发散的产品，DCloud官方也无意用uni-ui压制第三方ui插件的空间，但官方有义务在性能和跨端方面提供一个开源的标杆给大家。<br/><br/>我们欢迎更多优秀的ui组件出现，也欢迎更多人贡献uni-ui的主题风格，满足更多用户的需求。<br/><br/>4、与uniCloud协作<br/><br/>uni-ui里很多组件与uniCloud打通，可大幅提升开发效率<br/><br/>5、与uni统计自动集成实现免打点<br/><br/>uni统计是优秀的多端统计平台，见tongji.dcloud.net.cn (opens new window)。<br/><br/>除了一张报表看全端，它的另一个重要特点是免打点。 比如使用uni-ui的navbar标题栏、收藏、购物车等组件，均可实现自动打点，统计页面标题等各种行为数据。 当然你也可以关闭uni统计，这不是强制的。<br/><br/>6、uni-ui符合全套DCloud组件规范<br/><br/>包括easycom、uni_module、datacom，全部遵循。<br/></p>', '沈奇男', '2022-08-17 00:09:23', 5);

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
) ENGINE = MyISAM AUTO_INCREMENT = 45 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of files
-- ----------------------------
INSERT INTO `files` VALUES (32, '老沈.jpg', 'jpg', 34, 'http://localhost:9090/files/test/ebd6733138664ee79f15e6cd499fcdd0.jpg', 'e3f851531cb8c035015dd190b2895f71', 0, 1);
INSERT INTO `files` VALUES (33, '小沈.jpg', 'jpg', 434, 'http://localhost:9090/files/test/0cda61eac7b849e59af673c5ca470e92.jpg', '6011acb83994d9c62f4a4a2ef29180be', 0, 1);
INSERT INTO `files` VALUES (34, 'tx1.jpeg', 'jpeg', 83, 'http://localhost:9090/files/test/d7943336f1ef40dea6c29a06f2dad5e0.jpeg', '3e647ca495ddad8d3c52f63eef8bec50', 1, 1);
INSERT INTO `files` VALUES (35, 'tx1.jpeg', 'jpeg', 83, 'http://localhost:9090/files/test/d7943336f1ef40dea6c29a06f2dad5e0.jpeg', '3e647ca495ddad8d3c52f63eef8bec50', 1, 1);
INSERT INTO `files` VALUES (36, '小沈.jpg', 'jpg', 434, 'http://localhost:9090/files/test/0cda61eac7b849e59af673c5ca470e92.jpg', '6011acb83994d9c62f4a4a2ef29180be', 0, 1);
INSERT INTO `files` VALUES (37, '老沈.jpg', 'jpg', 34, 'http://localhost:9090/files/test/ebd6733138664ee79f15e6cd499fcdd0.jpg', 'e3f851531cb8c035015dd190b2895f71', 0, 1);
INSERT INTO `files` VALUES (38, '1.mp4', 'mp4', 664, 'http://localhost:9090/files/test/9beea1f1b42841a7b515fc0411040722.mp4', '4fc33dbb0d7d924f2d056033cbb51bbb', 1, 1);
INSERT INTO `files` VALUES (39, '开工头像照片1.jpg', 'jpg', 38, 'http://localhost:9090/files/test/558e5156abca439390031516f382946f.jpg', 'ef9af9eb00145fd42bdaf24524660f77', 0, 1);
INSERT INTO `files` VALUES (40, '开工头像照片1.jpg', 'jpg', 38, 'http://localhost:9090/files/test/558e5156abca439390031516f382946f.jpg', 'ef9af9eb00145fd42bdaf24524660f77', 1, 1);
INSERT INTO `files` VALUES (41, '身份证.jpg', 'jpg', 189, 'http://localhost:9090/files/test/36a8695fe03a4f51a6f13b02cac82b32.jpg', 'c774aa7d6856f5d460f528f17d743392', 0, 1);
INSERT INTO `files` VALUES (42, 'default.jpg', 'jpg', 13, 'http://localhost:9090/files/test/e216d505a5694a00973eb1391b776ddc.jpg', '834c7fa1fa9c8b62610250717e7b25c8', 0, 1);
INSERT INTO `files` VALUES (43, '默认头像.png', 'png', 9, 'http://localhost:9090/files/test/f776fde4b0e34c0e8cb43c6fa8b765dd.png', 'ac6bf2e6db9b9969eb8bde298c8bf9ec', 0, 1);
INSERT INTO `files` VALUES (44, '哈头像.jpg', 'jpg', 7, 'http://localhost:9090/files/test/6b269c174b3f46f0ae817f3cd2da9250.jpg', 'd0034dd1f891ee8446debade2142390c', 0, 1);

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
) ENGINE = MyISAM AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

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
INSERT INTO `menu` VALUES (28, '新冠疫情', '/newpneumonia', 'PieChart', NULL, NULL, 'Newpneumonia');
INSERT INTO `menu` VALUES (30, '我的账单', '/bill', 'Wallet', NULL, 5, 'Bill');

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
) ENGINE = MyISAM AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

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
INSERT INTO `role_menu` VALUES (1, 22);
INSERT INTO `role_menu` VALUES (1, 23);
INSERT INTO `role_menu` VALUES (1, 28);
INSERT INTO `role_menu` VALUES (1, 30);
INSERT INTO `role_menu` VALUES (3, 2);
INSERT INTO `role_menu` VALUES (3, 7);
INSERT INTO `role_menu` VALUES (3, 8);
INSERT INTO `role_menu` VALUES (3, 10);
INSERT INTO `role_menu` VALUES (3, 22);
INSERT INTO `role_menu` VALUES (3, 23);
INSERT INTO `role_menu` VALUES (3, 28);
INSERT INTO `role_menu` VALUES (3, 30);
INSERT INTO `role_menu` VALUES (4, 2);
INSERT INTO `role_menu` VALUES (4, 7);
INSERT INTO `role_menu` VALUES (4, 8);
INSERT INTO `role_menu` VALUES (4, 22);
INSERT INTO `role_menu` VALUES (4, 23);
INSERT INTO `role_menu` VALUES (4, 28);
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
INSERT INTO `role_menu` VALUES (5, 27);
INSERT INTO `role_menu` VALUES (5, 28);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '性别',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色：1管理员，2普通成员',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `open_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '微信openid',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 63 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'sqn', '$2a$10$9rmVXRmsRuO1FbbjqMPGl.tdIkZDvQ8FoNf5/Fat1W2NMRivX1Cn6', '沈奇男', '1997-10-01', '男', 'http://localhost:9090/files/test/0cda61eac7b849e59af673c5ca470e92.jpg', NULL, 'ROLE_ADMIN', '15215913937', NULL);
INSERT INTO `user` VALUES (22, 'dmj', '$2a$10$CQ1i9M.57VCCHZsM0DggWervD/fgQWO18BalmJOXFsyMA5NWpY946', '杜梅军', '1971-07-14', '女', 'http://localhost:9090/files/test/558e5156abca439390031516f382946f.jpg', NULL, 'ROLE_USER', '13819545627', NULL);
INSERT INTO `user` VALUES (23, 'sjx', '$2a$10$CQ1i9M.57VCCHZsM0DggWervD/fgQWO18BalmJOXFsyMA5NWpY946', '沈建祥', '1974-03-22', '男', NULL, NULL, 'ROLE_USER', '18888790728', NULL);
INSERT INTO `user` VALUES (24, 'sjy', '$2a$10$CQ1i9M.57VCCHZsM0DggWervD/fgQWO18BalmJOXFsyMA5NWpY946', '沈建英', NULL, '女', NULL, NULL, 'ROLE_USER', '13454588810', NULL);
INSERT INTO `user` VALUES (42, 'sqy', '$2a$10$DK3So8no8V4mNTdqmZqLm.dzvqPOMUCGk9EXmJ8YXxu8njGwEFVNO', '沈奇亚', '1997-03-07', '女', 'http://localhost:9090/files/test/ebd6733138664ee79f15e6cd499fcdd0.jpg', '2022-07-24 23:34:26', 'ROLE_ADMIN', '15868180225', NULL);
INSERT INTO `user` VALUES (26, 'bzy', '$2a$10$CQ1i9M.57VCCHZsM0DggWervD/fgQWO18BalmJOXFsyMA5NWpY946', '边震宇', '2008-08-30', '男', NULL, NULL, 'ROLE_USER', NULL, NULL);
INSERT INTO `user` VALUES (31, 'yk1', '$2a$10$s9EXA7z4XgkdUGKg7hZAL.tk5o4BSJHC8V6jUKdAyzGN4ugt9FkuW', '游客1', '2022-07-14', '女', '', '2022-07-19 01:35:13', 'ROLE_VISITOR', '15215913933', NULL);
INSERT INTO `user` VALUES (45, 'ts1', '$2a$10$CU2YPItFd5ZH4WAq2PMHPuC9O/DCSOTOH2OrL5gRhFiHdTbuRip66', '沈小测1', NULL, NULL, NULL, '2022-07-26 14:41:19', 'ROLE_TESTER', '15215913937', NULL);
INSERT INTO `user` VALUES (62, 'admin', '$2a$10$s9OiSHAn331k5LuiUbbIWeyXZPVVjjQEJqv6tRXRrbHDhzev9rkAm', '系统管理员', NULL, NULL, 'http://localhost:9090/files/test/6b269c174b3f46f0ae817f3cd2da9250.jpg', '2022-08-22 22:42:11', 'ROLE_ADMIN', '15215913937', NULL);
INSERT INTO `user` VALUES (55, 'sre', '$2a$10$mVzSSS5OZOXUsbM1iJBlV.HmklaulG6yqEECCuZVC.u1ZRQ3PP/Mi', '沈蓉儿', '2000-11-19', '女', NULL, '2022-07-29 21:45:27', 'ROLE_USER', NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
