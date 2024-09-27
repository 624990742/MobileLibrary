/*
 Navicat Premium Data Transfer

 Source Server         : MobileLibrary
 Source Server Type    : MySql
 Source Server Version : 8.3.0
 Source Schema         : main

 Target Server Type    : MySql
 Target Server Version : 8.3.0
 File Encoding         : 65001

 Date: 02/04/2024 16:23:29
*/

-- 如果存在的话再放开这行代码删除
DROP DATABASE MobileLibrary;
CREATE DATABASE MobileLibrary;
USE MobileLibrary;
SET NAMES utf8;
START TRANSACTION;



-- ----------------------------
-- Table structure for bookInfo
-- ----------------------------

CREATE TABLE `bookInfo` (  
    `bookId` BIGINT NOT NULL AUTO_INCREMENT,  
    `bookTitle` VARCHAR(255), -- 假设标题长度最大为255
    `bookAuthor` VARCHAR(255), -- 假设作者名字长度最大为255
    `bookPress` VARCHAR(255), -- 假设出版社名字长度最大为255
    `bookCategory` VARCHAR(255), -- 假设书籍类别长度最大为255
    `bookType` INT ,  
    `bookISBN` VARCHAR(17), -- ISBN标准长度为10或13位，加上可能的连字符，这里设为17
    `bookInsideCode` VARCHAR(255), -- 图书内部条形码
    `bookLibTotal` INT,
    `bookPrice` DECIMAL(10, 2) ,
    `bookUploadTime` TEXT, -- 如果不需要日期时间格式，可以保持为TEXT  
    `bookCover` VARCHAR(255) , -- 假设封面图片路径或名称长度最大为255
    `bookBrief` TEXT , -- 简介可能较长，保持为TEXT
    `bookState` INT ,  
    `bookTotalPage` INT , -- 假设总页数长度最大为10位数字
    `bookBackTotal` INT ,
    PRIMARY KEY (`bookId`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;  
ALTER TABLE `bookInfo` AUTO_INCREMENT = 1;
ALTER TABLE bookInfo ADD FULLTEXT INDEX idx_book_title_author (bookTitle, bookAuthor);
# CREATE FULLTEXT INDEX idx_bookTitle ON bookInfo(bookTitle);
# CREATE FULLTEXT INDEX idx_bookAuthor ON bookInfo(bookAuthor);



# 前缀：“BL-”代表北京理工大学（Beijing Normal University）。
# 楼层标识：使用字母“F”后接楼层数字，如“F1”代表一层，“F2”代表二层。
# 类别代码：使用两个字母缩写，如“MZ”代表杂志，“WX”代表文学，“XS”代表小说，“ZM”代表中外名著。
# 序列号：四位数字，从“0001”开始递增。

INSERT INTO `bookInfo`
VALUES
(1, '活着', '余华', '人民文学出版社', '文学', 2, '9787108059343','BL-F1-WX-0001', 1000, 29.8, '2023-03-15', 'book1', '这是一部充满力量的长篇小说，讲述人在极端艰难的生存困境中的挣扎与坚持，读来令人深感沉重，又充满感奋。', 0, '230', 0),
(2, '时间简史', '史蒂芬·霍金', '湖南科学技术出版社', '自然科学', 1, '9787535752079','BL-F1-XS-0002', 800, 69.0, '2022-01-01', 'book2', '《时间简史》讲述是探索时间和空间核心秘密的故事，是关于宇宙本性的最前沿知识，包括我们的宇宙图像、空间和时间、膨胀的宇宙、不确定性原理、黑洞、宇宙的起源和命运等内容，深入浅出地介绍了遥远星系、黑洞、粒子、反物质等知识，并对宇宙的起源、空间和时间以及相对论等古老问题做了阐述，使读者在轻松的阅读中获取有关宇宙的知识。', 0, '215', 0),
(3, '人类简史：从动物到上帝', '尤瓦尔·赫拉利', '中信出版集团', '社会科学', 2, '9787567558887','BL-F1-SX-0003', 1200, 68.0, '2021-06-01', 'book3', '《人类简史：从动物到上帝》以全新的角度讲述了人类的历史，将人类历史分为四个阶段：认知革命、农业革命、人类的融合统一与科学革命，理清影响人类发展的重大脉络，挖掘人类文化、宗教、法律、国家、战争、文明、科技等诸多方面的进化原因。', 0, '432', 0),
(4, '明朝那些事儿', '当年明月', '四川人民出版社', '历史', 2, '9787220078035','BL-F1-FK-0004', 900, 29.8, '2020-09-01', 'book4', '《明朝那些事儿》主要讲述的是从1344年到1644年这三百年间关于明朝的一些故事。以年代和具体人物为主线，并加入了小说的笔法，对明朝十七帝和其他王公权贵和小人物的命运进行全景展示，尤其对官场政治、战争、帝王心术着墨最多，并加入对当时政治经济制度、人伦道德的演义。', 0, '966', 0),
(5, '经济学原理', 'N.格里高利·曼昆', '中国人民大学出版社', '经济管理', 1, '9787300242214','BL-F1-XU-0002', 700, 59.0, '2020-01-01', 'book5', '《经济学原理》是美国经济学家N·格里高利·曼昆创作的经济学著作，首次出版于1998年。《经济学原理》主要从供给与需求、企业行为与产业组织、长期经济增长与短期经济波动以及宏观经济政策等角度，讲述了经济学的基本知识与基本原理。', 0, '384', 0),
(6, '三体', '刘慈欣', '二十一世纪出版社', '科幻', 2, '9787539192291','BL-F1-XR-0012', 1500, 35.0, '2023-04-01', 'book6', '《三体》是刘慈欣创作的科幻小说系列，作品讲述了地球人类文明和三体文明的信息交流、生死搏杀及两个文明在宇宙中的兴衰历程。其第一部经过刘宇昆翻译后获得了第73届雨果奖最佳长篇小说奖。', 0, '307', 0),
(7, '解忧杂货店', '东野圭吾', '北京联合出版公司', '小说', 2, '9787550263512','BL-F4-XL-0012', 1300, 39.8, '2023-04-10', 'book7', '现代人内心流失的东西，这家杂货店能帮你找回——僻静的街道旁有一家杂货店，只要写下烦恼投进卷帘门的投信口，第二天就会在店后的牛奶箱里得到回答：因男友身患绝症，年轻女孩静子在爱情与梦想间徘徊；克郎为了音乐梦想离家漂泊，却在现实中寸步难行；少年浩介面临家庭巨变，挣扎在亲情与未来的迷茫中……', 0, '272', 0),
(8, '追风筝的人', '卡勒德·胡赛尼', '上海人民出版社', '小说', 2, '9787532753600','BL-F3-XO-0014', 1100, 29.0, '2023-04-15', 'book15', '12岁的阿富汗富家少爷阿米尔与仆人哈桑情同手足。然而，在一场风筝比赛后，发生了一件悲惨不堪的事，阿米尔为自己的懦弱感到自责和痛苦，逼走了哈桑，不久，自己也跟随父亲逃往美国。成年后的阿米尔始终无法原谅自己当年对哈桑的背叛。为了赎罪，阿米尔再度踏上暌违二十多年的故乡，希望能为不幸的好友尽最后一点心力，却发现一个惊天谎言，儿时的噩梦再度重演，阿米尔该如何抉择？', 0, '362', 0),
(9, '百年孤独', '加西亚·马尔克斯', '上海译文出版社', '文学', 3, '9787532733331','BL-F5-RX-0078', 800, 68.0, '2023-04-20', 'book8', '《百年孤独》，是哥伦比亚作家加西亚·马尔克斯创作的长篇小说，是其代表作，也是拉丁美洲魔幻现实主义文学的代表作，被誉为“再现拉丁美洲历史社会图景的鸿篇巨著”。作品描写了布恩迪亚家族七代人的传奇故事，以及加勒比海沿岸小镇马孔多的百年兴衰，反映了拉丁美洲一个世纪以来风云变幻的历史。', 0, '366', 0),
(10, '小王子', '安托万·德·圣-埃克苏佩里', '译林出版社', '儿童文学', 2, '9787544738743','BL-F3-XX-0032', 1000, 22.0, '2023-04-25', 'book9', '小王子是一个超凡脱俗的仙童，他住在一颗只比他大一丁点儿的小行星上。陪伴他的是一朵他非常喜爱的小玫瑰花。但玫瑰花的虚荣心伤害了小王子对她的感情。小王子告别小行星，开始了遨游太空的旅行。他先后访问了六个行星，各种见闻使他陷入忧伤，他感到大人们荒唐可笑、太不正常。只有在其中一个点灯人的星球上，小王子才找到一个可以作为朋友的人。但点灯人的天地又十分狭小，除了点灯人和他自己，不能容下第二个人。在地理学家的指点下，孤单的小王子来到人类居住的地球。', 0, '151', 0),
(11, '乌合之众：大众心理研究', '古斯塔夫·勒庞', '译林出版社', '社会心理学', 3, '9787544728801','BL-F4-XML-0013', 900, 28.0, '2023-05-10', 'book10', '古斯塔夫·勒庞在本书中极为精致地描述了集体心态，对人们理解集体行为的作用以及对社会心理学的思考发挥了巨大影响。作者层层分析，逐步推进，明确指出个人一旦进入群体中，他的个性便湮没了，群体的思想占据统治地位，而群体的行为表现为无异议、情绪化和低智商。', 0, '251', 0),
(12, '货币战争', '宋鸿兵', '中信出版社', '金融', 2, '9787802341381', 'BL-F2-XP-0222',1200, 39.8, '2023-05-15', 'book11', '《货币战争》是从一个全新的角度审视世界历史的。该书讲述了自英格兰银行成立以来，世界各大文明国家因争夺货币发行权，而爆发的一系列战争的故事。这些战争，早已超越了普通军事战争的范畴，也超越了传统经济斗争的范畴，因为，控制世界货币发行权，从根本上来说，就是控制世界的命运。', 0, '446', 0),
(13, '活着为了讲述', '加西亚·马尔克斯', '吉林出版集团', '自传', 3, '9787547254111','BL-F5-XTR-0011', 850, 48.0, '2023-05-20', 'book12', '《活着为了讲述》是加西亚·马尔克斯唯一自传。这一次，他亲自讲述自己的故事。生活不是我们活过的日子，而是我们记住的日子，我们为了讲述而在记忆中重现的日子。', 0, '288', 0),
(14, '思考，快与慢', '丹尼尔·卡尼曼', '中信出版社', '心理学', 3, '9787508634553','BL-F3-XGF-0014', 1000, 49.0, '2023-05-25', 'book13', '在书中，卡尼曼会带领我们体验一次思维的终极之旅。他认为，我们的大脑有快与慢两种作决定的方式。常用的无意识的“系统1”依赖情感、记忆和经验迅速作出判断，它见闻广博，使我们能够迅速对眼前的情况作出反应。但系统1也很容易上当，它固守“眼见即为事实”的原则，任由损失厌恶和乐观主义等偏见作祟。有意识的“系统2”通过调动注意力来分析和解决问题，并作出决定，它比较慢，不容易出错，但它很懒惰，经常走捷径，直接采纳系统1的直觉型判断结果。', 0, '424', 0),
(15, '人类群星闪耀时', '斯蒂芬·茨威格', '译林出版社', '历史', 3, '9787544717050','BL-F6-XXJ-0017', 750, 28.0, '2023-05-30', 'book14', '《人类群星闪耀时》是“历史上最好的传记作家”——斯蒂芬·茨威格的传记名作之一。该书共收入他的历史特写14篇，分别向我们展现了14个决定世界历史的瞬间：千年帝国拜占庭的陷落、滑铁卢的一分钟，英雄的瞬间，南极探险的斗争，西塞罗，威尔逊的梦想与失败以及马赛曲神佑般的创作……', 0, '284', 0);


-- ----------------------------
-- Table structure for bookRecordInfo
-- ----------------------------
CREATE TABLE `bookRecordInfo` (  
  `recordId` BIGINT NOT NULL AUTO_INCREMENT,  
  `recordBookTitle` VARCHAR(255),
  `recordBookAuthor` VARCHAR(255),
  `recordBookPress` VARCHAR(255),
  `recordBookISBN` VARCHAR(17),  
  `recordBorrower` VARCHAR(255),  
  `recordBorrowerTime` VARCHAR(255), -- 假设存储为字符串格式的日期时间  
  `recordBackTime` VARCHAR(255), -- 假设存储为字符串格式的日期时间  
  `bookType` INT,
  `recordBookState` INT, -- 0 未申请，1 申请中， 2已借阅（借阅中）
  `userId` INT,
  `userIphone` VARCHAR(15),  
  `createTime` VARCHAR(255), 
  `updateTime` VARCHAR(255),
   `bookInsideCode` VARCHAR(255), -- 图书内部条形码
  PRIMARY KEY (`recordId`)   #   `userName` VARCHAR(255),
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
ALTER TABLE `bookRecordInfo` AUTO_INCREMENT = 1;



INSERT INTO `bookRecordInfo`
VALUES
(1, '有效沟通', '贾宝玉' ,'北京出版社','9787564234567', '贾小晨', '2024-4-22', '2024-05-29', 1,1,9, '18800129703', '2024-4-22', '2024-4-22','BL-F1-WX-0011'),
(2, '数据库原理', '贾纳西' ,'机械出版社','9787121345678', '贾小晨', '2024-4-19', '2024-05-22', 2,1,9, '18800129703', '2024-4-19', '22024-4-19','BL-F1-TY-0011'),
(3, '算法导论', '贾乐乐' ,'工业出版社' ,'9787302567890', '薛宝钗', '2024-4-20', '2024-05-30', 3,1,8, '13700137003', '2024-4-20', '2024-05-30','BL-F1-UI-0011'),
(4, '中国历史', '贾嘻嘻' ,'北京大学出版社' ,'9787500645671', '薛宝钗', '2024-4-22', '2024-05-29', 1,2,8, '13700137003', '2024-4-22', '2024-05-29','BL-F1-TT-0011'),
(5, 'Python编程', '贾哈哈' ,'北京理工大学出版社' ,'9787115432109', '贾小晨', '2024-4-22', '2024-06-21',2,2,9, '18800129703', '2024-4-22', '2024-06-21','BL-F1-RR-0011'),
(6, '经济学原理', '贾动动' ,'高等教育出版社' ,'9787811223345', '林黛玉', '2024-4-22', '2024-06-31', 3,1,7, '13900139002', '2024-4-22', '2024-05-31','BL-F1-ER-0011'),
(7, '心理学与生活', '贾默默' ,'高等教育出版社' ,'9787301234567', '贾宝玉', '2024-4-21', '2024-05-31', 1,1,6, '13800138001', '2024-4-21', '2024-05-31','BL-F1-OP-0011');


-- -- ----------------------------
-- -- Table structure for collectionBookInfo
-- -- ----------------------------

CREATE TABLE `collectionBookInfo` (  
    `collectionId` BIGINT NOT NULL AUTO_INCREMENT,  
    `bookId` BIGINT NOT NULL,  
    `bookTitle` VARCHAR(255) ,
    `bookISBN` VARCHAR(255) ,
    `bookPress` VARCHAR(255),
    `bookAuthor` VARCHAR(255),
    `collectionTime` TEXT,
    PRIMARY KEY (`collectionId`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4; 
ALTER TABLE `collectionBookInfo` AUTO_INCREMENT = 1;

INSERT INTO `collectionBookInfo`
VALUES 
(1, 1, '书名1', 'ISBN1234567890', '出版社1', '王五', '2023-10-23 10:00:00'), 
(2, 2, '书名2', 'ISBN0987654321', '出版社2', '赵三', '2023-10-24 11:15:00'), 
(3, 3, '书名3', 'ISBN2345678901', '出版社3', '李四', '2023-10-25 12:30:00'), 
(4, 4, '书名4', 'ISBN3456789012', '出版社4', '陈姐', '2023-10-26 13:45:00'), 
(5, 5, '书名5', 'ISBN4567890123', '出版社5', '阿哥', '2023-10-27 14:00:00');

-- -- ----------------------------
-- -- Table structure for forumInfo
-- -- ----------------------------
CREATE TABLE `forumInfo` (  
    `forumId` BIGINT NOT NULL AUTO_INCREMENT,  
    `bookTitl` VARCHAR(255),  
    `content` VARCHAR(255),  
    `url` TEXT,  
    `bookCover` VARCHAR(255),  
    `createTime` VARCHAR(255),
    `updateTime` VARCHAR(255),
    `userId` VARCHAR(255),  
    `hits` INTEGER,  
    `praiseLen` INTEGER,  
    `nickName` VARCHAR(255),  
    `avatar` VARCHAR(255),  
    PRIMARY KEY (`forumId`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
ALTER TABLE `forumInfo` AUTO_INCREMENT = 1;

-- -- ----------------------------
-- -- Records of forumInfo
-- -- ----------------------------

INSERT INTO `forumInfo` VALUES 
(1, '红楼梦解析', '详述《红楼梦》中贾宝玉与林黛玉、薛宝钗之间的情感纠葛及其象征意义。', 'https://example.com/forum/post1', 'book_cover_hongloumeng.jpg', '2023-06-09 10:30:00', '2023-06-15 14:45:00', 'user123', 120, 50, 'user123_nick', 'user123_avatar.jpg'),
(2, '西游记新解', '探讨《西游记》中孙悟空形象的塑造及其对现代社会的启示。', 'https://example.com/forum/post2', 'book_cover_xiyouji.jpg', '2023-06-12 18:45:00', '2023-06-18 09:20:00', 'user456', 87, 10, 'user456_nick', 'user456_avatar.jpg'),
(3, '水浒传人物研究', '深度剖析《水浒传》主要人物的性格特点与命运走向。', 'https://example.com/forum/post3', 'book_cover_shuihuzhuan.jpg', '2023-06-15 09:15:00', '2023-06-20 16:10:00', 'user789', 11, 25, 'user789_nick', 'user789_avatar.jpg'),
(4, '三国演义战略解析', '通过经典战役解析《三国演义》中的战略智慧与权谋艺术。', 'https://example.com/forum/post4', 'book_cover_sanguoyanyi.jpg', '2023-06-17 15:20:00', '2023-06-22 11:30:00', 'userABC', 150, 75, 'userABC_nick', 'userABC_avatar.jpg'),
(5, '儒林外史讽刺艺术探究', '分析《儒林外史》中吴敬梓如何运用讽刺手法揭示科举制度下的社会现象。', 'https://example.com/forum/post5', 'book_cover_rulinwaishi.jpg', '2023-06-19 13:40:00', '2023-06-24 14:50:00', 'userDEF', 105, 20, 'userDEF_nick', 'userDEF_avatar.jpg');


-- -- ----------------------------
-- -- Table structure for loopCoverInfo
-- -- ----------------------------
CREATE TABLE `loopCoverInfo` (  
  `loopId` BIGINT NOT NULL AUTO_INCREMENT,  
  `title` TEXT,  
  `content` TEXT,  
  `url` TEXT,  
  `imageUrl` TEXT,  
  `createTime` VARCHAR(255), 
  `updateTime` VARCHAR(255), 
  `type` INTEGER,  
  PRIMARY KEY (`loopId`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4; 
ALTER TABLE `loopCoverInfo` AUTO_INCREMENT = 1;



-- -- ----------------------------
-- -- Records of loopCoverInfo
-- -- ----------------------------

INSERT INTO `loopCoverInfo` VALUES 
(1, '轮播图一', '欢迎访问我们的新品特惠活动页面', 'https://example.com/new-offers', 'https://example.com/images/cover1.jpg', '2023-05-6 10:30:00', '2023-05-9 14:45:23', 1),
(2, '促销轮播', '限时抢购！热门商品低至五折', 'https://example.com/sale-items', 'https://example.com/images/cover2.jpg', '2023-05-1 13:15:12', '2023-05-20 09:08:57', 2),
(3, '品牌故事', '探索我们的品牌历史与价值理念', 'https://example.com/about-us/story', 'https://example.com/images/cover3.jpg', '2023-05-12 08:42:00', '2023-05-18 17:23:35', 1),
(4, '夏季新品发布', '清凉一夏，探索最新夏季系列', 'https://example.com/new-summer-collection', 'https://example.com/images/cover4.jpg', '2023-05-25 11:55:.png', '2023-05-28 15:07:16', 2),
(5, '用户评价精选', '看看其他客户怎么说', 'https://example.com/reviews', 'https://example.com/images/cover5.jpg', '2023-05-29 09:10:10', '2023-05-31 16:35:42', 1),
(6, '订阅优惠通知', '立即订阅获取独家折扣码', 'https://example.com/newsletter-subscribe', 'https://example.com/images/cover6.jpg', '2023-06-2 12:45:30', '2023-06-5 10:20:18', 2),
(7, '环保倡议', '加入我们，为地球做出贡献', 'https://example.com/sustainability', 'https://example.com/images/cover7.jpg', '2023-06-8 17:05:55', '2023-06-11 13:17:20', 1),
(8, '会员福利', '注册成为会员，享受更多特权', 'https://example.com/membership', 'https://example.com/images/cover8.jpg', '2023-06-12 09:30:11', '2023-06-15 11:46:44', 2),
(9, '联系我们', '有任何问题？随时与我们取得联系', 'https://example.com/contact', 'https://example.com/images/cover9.jpg', '2023-06-16 14:22:30', '2023-06-19 16:50:05', 1),
(10, '社区分享', '加入讨论，分享您的体验', 'https://example.com/community', 'https://example.com/images/cover10.jpg', '2023-06-20 08:55:50', '2023-06-23 12:10:11', 2);


-- -- ----------------------------
-- -- Table structure for noticeInfo
-- -- ----------------------------

CREATE TABLE `noticeInfo` (
    `noticeId` BIGINT NOT NULL AUTO_INCREMENT,
    `title` TEXT ,
    `content` TEXT ,
    `updateTime` VARCHAR(255),
    `createTime` VARCHAR(255),
    PRIMARY KEY (`noticeId`) 
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
ALTER TABLE `noticeInfo` AUTO_INCREMENT = 1;



-- -- ----------------------------
-- -- Records of noticeInfo
-- -- ----------------------------

INSERT INTO `noticeInfo` VALUES 
(1, '重要系统更新', '今晚午夜将进行关键软件更新。请在此之前保存工作并退出系统，以免造成任何数据丢失。', '2023-06-09 23:55:00', '2023-06-0.jpg'),
(2, '即将关闭办公区', '办公区将于6月2日因年度维护而关闭。在此期间，所有员工应远程工作。', '2023-06-07 10:30:00', '2023-06-06 09:00:00'),
(3, '新员工入职培训', '所有新员工请于6月6日周一上午9点参加在会议室A举行的入职培训。请携带工牌及笔记本电脑。', '2023-06-04 15:45:00', '2023-06-03 14:15:00'),
(4, '第二季度销售报告', '第二季度销售报告已发布在公司内网。请在6月6日周三下班前查阅并提供反馈。', '2023-06-02 10:15:00', '2023-06-01 08:45:00'),
(5, '健康与安全提示', '请确保在6月30日前完成强制性消防安全培训。可通过HR门户访问在线课程。', '2023-06-08 14:30:00', '2023-06-07 13:00:00'),
(6, '团队建设活动', '请在日历上标注6月15日在当地公园举行的团队建设活动。后续将提供详细信息及报名指示。', '2023-06-10 09:45:00', '2023-06-09 08:15:00'),
(7, '客户满意度调查', '诚邀所有客户参与我们的满意度调查，您的意见有助于我们提升服务质量。链接：https://survey.example.com', '2023-06-12 11:00:00', '2023-06-11 09:30:00'),
(8, '产品线发布预告', '振奋人心的消息！我们的新产品线将于6月20日发布。敬请期待促销活动和独家预览。', '2023-06-14 16:15:00', '2023-06-13 14:45:00'),
(9, '费用报销政策更新', '自7月1日起，我们将执行修订后的费用报销政策。请在公司手册中查看更新后的指导原则。', '2023-06-16 13:30:00', '2023-06-15 12:00:00'),
(10, '办公室装修计划', '从6月25日起，办公室部分区域将进行装修。稍后将公布临时工作区安排及详细时间表。', '2023-06-18 10:45:00', '2023-06-17 09:15:00');

-- -- ----------------------------
-- -- Table structure for userInfo
-- -- ----------------------------

CREATE TABLE `userInfo`(
  `userId` BIGINT NOT NULL AUTO_INCREMENT,
  `userName` VARCHAR(255),
  `userSex` INT,
  `userAge` VARCHAR(255),
  `userIphone` VARCHAR(255),
  `userEmail` VARCHAR(255),
  `userPassword` VARCHAR(255),
  `userRole` VARCHAR(255),
  `userState` INT,
  `cardId` VARCHAR(255),
  `readCardId` VARCHAR(255),
  `userUnit` VARCHAR(255),
  `breakNumber` INT,
  `adminLevel` INT,
  `borrowMaxNumber` INT,
  `borrowStartDate` VARCHAR(255),
  `borrowDay` INT,
  `fineMoney` INT,
  `employeeId` VARCHAR(255), 
  `userIcon` VARCHAR(255),
  PRIMARY KEY (`userId`)
  )ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
ALTER TABLE `userInfo` AUTO_INCREMENT = 1;

-- -- ----------------------------
-- -- Records of userInfo
-- -- ----------------------------

INSERT INTO `userInfo` VALUES 
(1, '鲁智深', 1, '35', '18710172063', 'luzhishen@example.com', '123456', 'superAdmin', 1, '142623199019861215243214', 'BL001', '北京理工大学历史系', 0, 1, 6, '2023-01-01', 0, 0, '001', 'userIcon1'),
(2, '林冲', 1, '42', '18563247905', 'linchong@example.com', 's3cr3tP@ss', 'admin', 1, '23456789012345678901', 'BL002', '北京大学', 0, 2, 6, '2022-01-20', 15, 0, '002', 'userIcon2'),
(3, '武松', 1, '38', '19638527401', 'wusong@example.com', 'strongPass123!', 'admin', 1, '34567890123456789012', 'BL003', '北京清华大学', 0, 3, 6, '2023-02-01', 0, 0, '003', 'userIcon3'),
(4, '鲁智深', 1, '35', '15278963401', 'yangzhi@example.com', 'password12', 'admin', 1, '45678901234567890123', 'BL004', '北京理工大学计算机系', 0, 1, 6, '2023-01-01', 0, 0, '004', 'userIcon4'),
(5, '花荣', 1, '33', '13679045281', 'huarong@example.com', 'security_123', 'admin', 1, '56789012345678901234', 'BL005', '北京理工大学机械电子工程系', 0, 1, 6, '2023-01-15', 0, 0, '005', 'userIcon5'),
(6, '贾宝玉', 1, '20', '13800138001', 'jiabaoyu@example.com', 'Password123', 'reader', 1, '110101199001011234', 'BL007', '荣国府', 0, 1, 6, '2023-01-01', 0, 0, '007', 'userIcon1'),
(7, '林黛玉', 2, '19', '13900139002', 'lindaiyu@example.com', 'LdyPassword', 'reader', 1, '110101199102025678', 'BL008', '大观园', 0, 2, 6, '2023-02-01', 0, 0, '008', 'userIcon3'),
(8, '薛宝钗', 2, '21', '13700137003', 'xuebaochai@example.com', 'XbcPassword6', 'reader', 1, '110101199203039012', 'BL009', '薛家', 0, 3, 6, '2023-03-01', 0, 0, '009', 'userIcon1'),
(9, '贾小晨', 1, '20', '18800129703', 'jiaxiaochen@example.com', '123456', 'reader', 1, '110101199001011342', 'BL006', '北京海淀北京理工大学', 0, 1, 6, '2023-04-03', 0, 0, '006', 'userIcon2');

