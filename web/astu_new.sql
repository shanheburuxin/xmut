/*
 Navicat Premium Dump SQL

 Source Server         : 本机
 Source Server Type    : MySQL
 Source Server Version : 80406 (8.4.6)
 Source Host           : localhost:3306
 Source Schema         : astu_new

 Target Server Type    : MySQL
 Target Server Version : 80406 (8.4.6)
 File Encoding         : 65001

 Date: 29/12/2025 22:24:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for person
-- ----------------------------
DROP TABLE IF EXISTS `person`;
CREATE TABLE `person` (
  `userAccount` varchar(32) NOT NULL COMMENT '账号/学号/工号',
  `userName` varchar(64) NOT NULL COMMENT '姓名',
  `userSex` char(2) DEFAULT '男' COMMENT '性别',
  `userBirthday` date DEFAULT NULL COMMENT '出生日期',
  `userIdCard` varchar(18) DEFAULT NULL COMMENT '身份证号',
  `userPassword` varchar(64) NOT NULL COMMENT '密码 (建议后续加密存储)',
  `userIdentify` tinyint NOT NULL DEFAULT '0' COMMENT '身份: 0-学生, 1-老师, 2-管理员',
  `userOtherName` varchar(64) DEFAULT NULL COMMENT '职称/备注',
  PRIMARY KEY (`userAccount`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户信息表';

-- ----------------------------
-- Records of person
-- ----------------------------
BEGIN;
INSERT INTO `person` (`userAccount`, `userName`, `userSex`, `userBirthday`, `userIdCard`, `userPassword`, `userIdentify`, `userOtherName`) VALUES ('1', '荞麦', '男', '1999-02-02', '19181712313', '1', 1, '计组老师');
INSERT INTO `person` (`userAccount`, `userName`, `userSex`, `userBirthday`, `userIdCard`, `userPassword`, `userIdentify`, `userOtherName`) VALUES ('2', '张三', '男', '2002-02-02', '13131311313', '2', 0, '普通学生');
INSERT INTO `person` (`userAccount`, `userName`, `userSex`, `userBirthday`, `userIdCard`, `userPassword`, `userIdentify`, `userOtherName`) VALUES ('3', '彦祖', '男', '2022-03-03', '11234994901', '3', 0, '普通学生');
INSERT INTO `person` (`userAccount`, `userName`, `userSex`, `userBirthday`, `userIdCard`, `userPassword`, `userIdentify`, `userOtherName`) VALUES ('5', '皮卡丘', '女', '1998-09-09', '12321245134', '5', 1, '数学老师');
INSERT INTO `person` (`userAccount`, `userName`, `userSex`, `userBirthday`, `userIdCard`, `userPassword`, `userIdentify`, `userOtherName`) VALUES ('6', '杰尼龟', '男', '1971-01-12', '12414314414', '6', 1, '物理老师');
INSERT INTO `person` (`userAccount`, `userName`, `userSex`, `userBirthday`, `userIdCard`, `userPassword`, `userIdentify`, `userOtherName`) VALUES ('8', '某老师', '男', '2025-12-28', '123124124124214', '0', 1, '政治老师');
INSERT INTO `person` (`userAccount`, `userName`, `userSex`, `userBirthday`, `userIdCard`, `userPassword`, `userIdentify`, `userOtherName`) VALUES ('87126222', '1', '男', '2025-12-10', '123124124124214', '1', 1, '学生');
INSERT INTO `person` (`userAccount`, `userName`, `userSex`, `userBirthday`, `userIdCard`, `userPassword`, `userIdentify`, `userOtherName`) VALUES ('admin', '管理员', '男', '2003-03-03', '12321412414', 'admin', 2, '管理员');
COMMIT;

-- ----------------------------
-- Table structure for studenttask
-- ----------------------------
DROP TABLE IF EXISTS `studenttask`;
CREATE TABLE `studenttask` (
  `taskAccount` varchar(32) NOT NULL COMMENT '关联任务ID',
  `studentAccount` varchar(32) NOT NULL COMMENT '关联学生ID',
  `studentAnswer` text COMMENT '学生答案 (支持长文本)',
  `isFinish` tinyint(1) DEFAULT '0' COMMENT '状态: 0-未完成, 1-已提交, 2-已批改',
  `score` int DEFAULT '0' COMMENT '分数',
  `uploadFileName` varchar(255) DEFAULT NULL COMMENT '附件文件名',
  `isScore` int DEFAULT '0',
  PRIMARY KEY (`taskAccount`,`studentAccount`),
  KEY `fk_st_student` (`studentAccount`),
  CONSTRAINT `fk_st_student` FOREIGN KEY (`studentAccount`) REFERENCES `person` (`userAccount`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_st_task` FOREIGN KEY (`taskAccount`) REFERENCES `task` (`taskAccount`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='学生提交作业表';

-- ----------------------------
-- Records of studenttask
-- ----------------------------
BEGIN;
INSERT INTO `studenttask` (`taskAccount`, `studentAccount`, `studentAnswer`, `isFinish`, `score`, `uploadFileName`, `isScore`) VALUES ('01', '2', NULL, 0, 0, NULL, 0);
INSERT INTO `studenttask` (`taskAccount`, `studentAccount`, `studentAnswer`, `isFinish`, `score`, `uploadFileName`, `isScore`) VALUES ('01', '3', '333333', 1, 0, NULL, 0);
INSERT INTO `studenttask` (`taskAccount`, `studentAccount`, `studentAnswer`, `isFinish`, `score`, `uploadFileName`, `isScore`) VALUES ('13929546', '3', '', 2, 0, '4a374fe1-5d59-45a3-8b15-691452727fc1.jpg', 0);
INSERT INTO `studenttask` (`taskAccount`, `studentAccount`, `studentAnswer`, `isFinish`, `score`, `uploadFileName`, `isScore`) VALUES ('14382347', '3', NULL, 0, 0, NULL, 0);
INSERT INTO `studenttask` (`taskAccount`, `studentAccount`, `studentAnswer`, `isFinish`, `score`, `uploadFileName`, `isScore`) VALUES ('16211631', '3', '死吧 s', 2, 0, NULL, 77);
INSERT INTO `studenttask` (`taskAccount`, `studentAccount`, `studentAnswer`, `isFinish`, `score`, `uploadFileName`, `isScore`) VALUES ('25523694', '3', 'kkk', 2, 0, NULL, 99);
INSERT INTO `studenttask` (`taskAccount`, `studentAccount`, `studentAnswer`, `isFinish`, `score`, `uploadFileName`, `isScore`) VALUES ('27469976', '3', '1111111', 2, 20, NULL, 0);
INSERT INTO `studenttask` (`taskAccount`, `studentAccount`, `studentAnswer`, `isFinish`, `score`, `uploadFileName`, `isScore`) VALUES ('38521345', '3', NULL, 0, 0, NULL, 0);
INSERT INTO `studenttask` (`taskAccount`, `studentAccount`, `studentAnswer`, `isFinish`, `score`, `uploadFileName`, `isScore`) VALUES ('49886289', '3', NULL, 0, 0, NULL, 0);
INSERT INTO `studenttask` (`taskAccount`, `studentAccount`, `studentAnswer`, `isFinish`, `score`, `uploadFileName`, `isScore`) VALUES ('91813818', '3', '我都不会', 1, 0, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for task
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task` (
  `taskAccount` varchar(32) NOT NULL COMMENT '任务ID',
  `teacherAccount` varchar(32) NOT NULL COMMENT '发布教师ID',
  `taskDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
  `taskName` varchar(255) NOT NULL COMMENT '任务内容/标题',
  PRIMARY KEY (`taskAccount`),
  KEY `fk_task_teacher` (`teacherAccount`),
  CONSTRAINT `fk_task_teacher` FOREIGN KEY (`teacherAccount`) REFERENCES `person` (`userAccount`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='作业任务表';

-- ----------------------------
-- Records of task
-- ----------------------------
BEGIN;
INSERT INTO `task` (`taskAccount`, `teacherAccount`, `taskDate`, `taskName`) VALUES ('01', '6', '2025-12-10 00:00:00', '请写出图的种类');
INSERT INTO `task` (`taskAccount`, `teacherAccount`, `taskDate`, `taskName`) VALUES ('13929546', '8', '2025-12-29 20:47:58', 'sb');
INSERT INTO `task` (`taskAccount`, `teacherAccount`, `taskDate`, `taskName`) VALUES ('14382347', '1', '2025-12-24 15:17:37', '测试001');
INSERT INTO `task` (`taskAccount`, `teacherAccount`, `taskDate`, `taskName`) VALUES ('16211631', '8', '2025-12-29 21:57:43', 'sss');
INSERT INTO `task` (`taskAccount`, `teacherAccount`, `taskDate`, `taskName`) VALUES ('25523694', '8', '2025-12-29 22:04:52', 'oooo');
INSERT INTO `task` (`taskAccount`, `teacherAccount`, `taskDate`, `taskName`) VALUES ('27469976', '1', '2025-12-24 09:45:36', '111111');
INSERT INTO `task` (`taskAccount`, `teacherAccount`, `taskDate`, `taskName`) VALUES ('38521345', '1', '2025-12-24 09:53:56', '请写出web');
INSERT INTO `task` (`taskAccount`, `teacherAccount`, `taskDate`, `taskName`) VALUES ('49886289', '1', '2025-12-27 20:21:44', '34444');
INSERT INTO `task` (`taskAccount`, `teacherAccount`, `taskDate`, `taskName`) VALUES ('91813818', '6', '2025-12-21 14:32:34', '请写出你对数据库的理解');
COMMIT;

-- ----------------------------
-- Table structure for userteacher
-- ----------------------------
DROP TABLE IF EXISTS `userteacher`;
CREATE TABLE `userteacher` (
  `userAccount` varchar(32) NOT NULL COMMENT '学生ID',
  `teacherAccount` varchar(32) NOT NULL COMMENT '老师ID',
  PRIMARY KEY (`userAccount`,`teacherAccount`),
  KEY `fk_ut_teacher` (`teacherAccount`),
  CONSTRAINT `fk_ut_student` FOREIGN KEY (`userAccount`) REFERENCES `person` (`userAccount`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ut_teacher` FOREIGN KEY (`teacherAccount`) REFERENCES `person` (`userAccount`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='学生选课/师生关联表';

-- ----------------------------
-- Records of userteacher
-- ----------------------------
BEGIN;
INSERT INTO `userteacher` (`userAccount`, `teacherAccount`) VALUES ('3', '1');
INSERT INTO `userteacher` (`userAccount`, `teacherAccount`) VALUES ('3', '5');
INSERT INTO `userteacher` (`userAccount`, `teacherAccount`) VALUES ('2', '6');
INSERT INTO `userteacher` (`userAccount`, `teacherAccount`) VALUES ('3', '6');
INSERT INTO `userteacher` (`userAccount`, `teacherAccount`) VALUES ('3', '8');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
