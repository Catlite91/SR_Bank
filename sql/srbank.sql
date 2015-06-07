/*
SQLyog Trial v10.51 
MySQL - 5.6.21 : Database - srbank
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`srbank` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `srbank`;

/*Table structure for table `bk_account` */

DROP TABLE IF EXISTS `bk_account`;

CREATE TABLE `bk_account` (
  `acc_id` int(18) NOT NULL AUTO_INCREMENT COMMENT '账户ID,自增主键',
  `acc_num` varchar(19) NOT NULL COMMENT '账户卡号',
  `acc_pwd` int(6) NOT NULL COMMENT '账户密码',
  `acc_type` char(1) NOT NULL COMMENT '账户类型，C代表Credit，D代表Debit',
  `acc_balance` decimal(18,2) NOT NULL COMMENT '账户余额',
  `acc_state` int(1) NOT NULL DEFAULT '1' COMMENT '账户状态，1表示有效，0表示无效',
  PRIMARY KEY (`acc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

/*Data for the table `bk_account` */

insert  into `bk_account`(`acc_id`,`acc_num`,`acc_pwd`,`acc_type`,`acc_balance`,`acc_state`) values (1,'6220389493893024',123456,'D',27656.00,1),(2,'6220389493878943',123456,'D',17500.00,1),(3,'6220389493878900',123456,'D',33000.00,1),(4,'6220389493878912',123456,'C',400.00,1),(5,'6220389493878934',123456,'D',8300.00,1),(6,'6220389493878123',123456,'D',8000.00,1),(7,'6220389493878100',123456,'D',5900.00,1),(8,'6220389493878165',123456,'D',102100.00,1),(9,'6220309309597200',123456,'C',77400.00,1),(10,'6220309864259721',123456,'D',15000.00,1),(11,'6220309111111720',123456,'D',3000.00,1),(12,'1231243245354200',123456,'C',4000.00,1),(13,'1231243250123212',123456,'D',600.00,1),(14,'1231123123214099',123456,'C',8000.00,1),(15,'1231000002321412',123456,'D',5000.00,1),(16,'1232323023214067',123456,'C',16000.00,1),(17,'1232323023214000',123456,'D',12000.00,1),(18,'1234321434132405',123456,'D',13000.00,1),(19,'1234321434100324',123456,'C',3003344.00,1),(20,'1234321400341003',123456,'D',5000.00,1),(21,'1234320014003410',123456,'C',3000.00,1),(22,'1231231231231989',123456,'D',2000.00,1),(23,'1231231231231007',123456,'D',40000.00,1),(24,'1235624332496643',123456,'C',50000.00,1),(25,'6220309309592322',123456,'C',1000400.00,1),(26,'6220309309598493',123456,'C',20000.00,1),(27,'6222300093440843',123456,'C',12000.00,1),(29,'123432143402320',123,'C',21000.00,1),(30,'6222300093440329',123456,'C',666.00,1),(31,'7232312328344728',123456,'C',57000000.00,1),(32,'6333300093440845',0,'C',0.00,1);

/*Table structure for table `bk_transaction_0` */

DROP TABLE IF EXISTS `bk_transaction_0`;

CREATE TABLE `bk_transaction_0` (
  `trans_id` int(18) NOT NULL AUTO_INCREMENT COMMENT '交易编号,自增主键',
  `user_id` int(18) NOT NULL COMMENT '客户编号,NOT NULL; 外键，级联于xt_cus的cus_id',
  `trans_user_id` int(18) NOT NULL,
  `acc_id` int(18) NOT NULL COMMENT '账户编号,NOT NULL; 外键，级联于xt_account的acc_id',
  `trans_acc_id` int(18) NOT NULL COMMENT '交易账户编号,NOT NULL; 外键，级联于xt_account的acc_id',
  `trans_currency` varchar(20) NOT NULL DEFAULT 'RMB' COMMENT '币种',
  `trans_balance` decimal(18,2) NOT NULL COMMENT '本次交易后的余额',
  `trans_amount` decimal(18,2) NOT NULL COMMENT '交易数额',
  `trans_time` datetime NOT NULL COMMENT '交易时间',
  `trans_message` text COMMENT '交易留言',
  `trans_type` int(2) NOT NULL COMMENT '交易类型',
  `trans_state` int(1) NOT NULL COMMENT '交易状态,1代表已完成，0代表进行中，-1代表失败',
  PRIMARY KEY (`trans_id`),
  KEY `bk_transaction_0_ibfk_1` (`trans_user_id`),
  KEY `bk_transaction_0_ibfk_2` (`acc_id`),
  KEY `bk_transaction_0_ibfk_3` (`trans_acc_id`),
  KEY `bk_transaction_0_ibfk_4` (`user_id`),
  CONSTRAINT `bk_transaction_0_ibfk_1` FOREIGN KEY (`trans_user_id`) REFERENCES `bk_user` (`user_id`),
  CONSTRAINT `bk_transaction_0_ibfk_2` FOREIGN KEY (`acc_id`) REFERENCES `bk_account` (`acc_id`),
  CONSTRAINT `bk_transaction_0_ibfk_3` FOREIGN KEY (`trans_acc_id`) REFERENCES `bk_account` (`acc_id`),
  CONSTRAINT `bk_transaction_0_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `bk_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bk_transaction_0` */

/*Table structure for table `bk_transaction_1` */

DROP TABLE IF EXISTS `bk_transaction_1`;

CREATE TABLE `bk_transaction_1` (
  `trans_id` int(18) NOT NULL AUTO_INCREMENT COMMENT '交易编号,自增主键',
  `user_id` int(18) NOT NULL COMMENT '客户编号,NOT NULL; 外键，级联于xt_cus的cus_id',
  `trans_user_id` int(18) NOT NULL,
  `acc_id` int(18) NOT NULL COMMENT '账户编号,NOT NULL; 外键，级联于xt_account的acc_id',
  `trans_acc_id` int(18) NOT NULL COMMENT '交易账户编号,NOT NULL; 外键，级联于xt_account的acc_id',
  `trans_currency` varchar(20) NOT NULL DEFAULT 'RMB' COMMENT '币种',
  `trans_balance` decimal(18,2) NOT NULL COMMENT '本次交易后的余额',
  `trans_amount` decimal(18,2) NOT NULL COMMENT '交易数额',
  `trans_time` datetime NOT NULL COMMENT '交易时间',
  `trans_message` text COMMENT '交易留言',
  `trans_type` int(2) NOT NULL COMMENT '交易类型',
  `trans_state` int(1) NOT NULL COMMENT '交易状态,1代表已完成，0代表进行中，-1代表失败',
  PRIMARY KEY (`trans_id`),
  KEY `bk_transaction_0_ibfk_1` (`trans_user_id`),
  KEY `bk_transaction_0_ibfk_2` (`acc_id`),
  KEY `bk_transaction_0_ibfk_3` (`trans_acc_id`),
  KEY `bk_transaction_0_ibfk_4` (`user_id`),
  CONSTRAINT `bk_transaction_1_ibfk_1` FOREIGN KEY (`trans_user_id`) REFERENCES `bk_user` (`user_id`),
  CONSTRAINT `bk_transaction_1_ibfk_2` FOREIGN KEY (`acc_id`) REFERENCES `bk_account` (`acc_id`),
  CONSTRAINT `bk_transaction_1_ibfk_3` FOREIGN KEY (`trans_acc_id`) REFERENCES `bk_account` (`acc_id`),
  CONSTRAINT `bk_transaction_1_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `bk_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;

/*Data for the table `bk_transaction_1` */

insert  into `bk_transaction_1`(`trans_id`,`user_id`,`trans_user_id`,`acc_id`,`trans_acc_id`,`trans_currency`,`trans_balance`,`trans_amount`,`trans_time`,`trans_message`,`trans_type`,`trans_state`) values (1,1,1,19,1,'RMB',7000.00,-1000.00,'2015-06-05 12:10:31','Fee for meal',1,1),(2,1,1,1,19,'RMB',11000.00,1000.00,'2015-06-05 12:10:31','Fee for meal',2,1),(47,1,1,1,19,'RMB',28656.00,-2344.00,'2015-06-06 14:36:45','Hello',1,1),(48,1,1,19,1,'RMB',3002344.00,2344.00,'2015-06-06 14:36:45','Hello',2,1),(49,1,1,1,19,'RMB',27656.00,-1000.00,'2015-06-07 06:51:58','fee',1,1),(50,1,1,19,1,'RMB',3003344.00,1000.00,'2015-06-07 06:51:58','fee',2,1),(51,1,1,27,27,'RMB',1000.00,1000.00,'2015-06-07 07:00:58','Bank Deposit',5,1),(52,1,2,27,2,'RMB',2000.00,1000.00,'2015-06-07 07:26:09','Tuhao zuopengyou!',4,1),(53,1,3,27,8,'RMB',12000.00,10000.00,'2015-06-07 08:43:21','Tu hao',4,1);

/*Table structure for table `bk_transaction_2` */

DROP TABLE IF EXISTS `bk_transaction_2`;

CREATE TABLE `bk_transaction_2` (
  `trans_id` int(18) NOT NULL AUTO_INCREMENT COMMENT '交易编号,自增主键',
  `user_id` int(18) NOT NULL COMMENT '客户编号,NOT NULL; 外键，级联于xt_cus的cus_id',
  `trans_user_id` int(18) NOT NULL,
  `acc_id` int(18) NOT NULL COMMENT '账户编号,NOT NULL; 外键，级联于xt_account的acc_id',
  `trans_acc_id` int(18) NOT NULL COMMENT '交易账户编号,NOT NULL; 外键，级联于xt_account的acc_id',
  `trans_currency` varchar(20) NOT NULL DEFAULT 'RMB' COMMENT '币种',
  `trans_balance` decimal(18,2) NOT NULL COMMENT '本次交易后的余额',
  `trans_amount` decimal(18,2) NOT NULL COMMENT '交易数额',
  `trans_time` datetime NOT NULL COMMENT '交易时间',
  `trans_message` text COMMENT '交易留言',
  `trans_type` int(2) NOT NULL COMMENT '交易类型',
  `trans_state` int(1) NOT NULL COMMENT '交易状态,1代表已完成，0代表进行中，-1代表失败',
  PRIMARY KEY (`trans_id`),
  KEY `bk_transaction_0_ibfk_1` (`trans_user_id`),
  KEY `bk_transaction_0_ibfk_2` (`acc_id`),
  KEY `bk_transaction_0_ibfk_3` (`trans_acc_id`),
  KEY `bk_transaction_0_ibfk_4` (`user_id`),
  CONSTRAINT `bk_transaction_2_ibfk_1` FOREIGN KEY (`trans_user_id`) REFERENCES `bk_user` (`user_id`),
  CONSTRAINT `bk_transaction_2_ibfk_2` FOREIGN KEY (`acc_id`) REFERENCES `bk_account` (`acc_id`),
  CONSTRAINT `bk_transaction_2_ibfk_3` FOREIGN KEY (`trans_acc_id`) REFERENCES `bk_account` (`acc_id`),
  CONSTRAINT `bk_transaction_2_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `bk_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

/*Data for the table `bk_transaction_2` */

insert  into `bk_transaction_2`(`trans_id`,`user_id`,`trans_user_id`,`acc_id`,`trans_acc_id`,`trans_currency`,`trans_balance`,`trans_amount`,`trans_time`,`trans_message`,`trans_type`,`trans_state`) values (1,2,3,5,9,'RMB',7300.00,300.00,'2015-06-06 12:30:50','money for dinner',4,1),(8,2,2,3,3,'RMB',32000.00,30000.00,'2015-06-06 16:39:21','Bank Deposit',5,1),(9,2,2,3,3,'RMB',31900.00,-100.00,'2015-06-06 16:39:46','Bank Deposit',6,1),(10,2,1,2,27,'RMB',19000.00,-1000.00,'2015-06-07 07:26:09','Tuhao zuopengyou!',3,1),(11,2,2,2,3,'RMB',18000.00,-1000.00,'2015-06-07 07:26:55','',1,1),(12,2,2,3,2,'RMB',32900.00,1000.00,'2015-06-07 07:26:55','',2,1),(13,2,2,2,5,'RMB',17000.00,-1000.00,'2015-06-07 07:28:55','',1,1),(14,2,2,5,2,'RMB',8300.00,1000.00,'2015-06-07 07:28:55','',2,1),(15,2,2,4,2,'RMB',500.00,-500.00,'2015-06-07 07:32:32','',1,1),(16,2,2,2,4,'RMB',17500.00,500.00,'2015-06-07 07:32:32','',2,1),(17,2,2,4,3,'RMB',400.00,-100.00,'2015-06-07 07:33:10','1234',1,1),(18,2,2,3,4,'RMB',33000.00,100.00,'2015-06-07 07:33:10','1234',2,1);

/*Table structure for table `bk_transaction_3` */

DROP TABLE IF EXISTS `bk_transaction_3`;

CREATE TABLE `bk_transaction_3` (
  `trans_id` int(18) NOT NULL AUTO_INCREMENT COMMENT '交易编号,自增主键',
  `user_id` int(18) NOT NULL COMMENT '客户编号,NOT NULL; 外键，级联于xt_cus的cus_id',
  `trans_user_id` int(18) NOT NULL,
  `acc_id` int(18) NOT NULL COMMENT '账户编号,NOT NULL; 外键，级联于xt_account的acc_id',
  `trans_acc_id` int(18) NOT NULL COMMENT '交易账户编号,NOT NULL; 外键，级联于xt_account的acc_id',
  `trans_currency` varchar(20) NOT NULL DEFAULT 'RMB' COMMENT '币种',
  `trans_balance` decimal(18,2) NOT NULL COMMENT '本次交易后的余额',
  `trans_amount` decimal(18,2) NOT NULL COMMENT '交易数额',
  `trans_time` datetime NOT NULL COMMENT '交易时间',
  `trans_message` text COMMENT '交易留言',
  `trans_type` int(2) NOT NULL COMMENT '交易类型',
  `trans_state` int(1) NOT NULL COMMENT '交易状态,1代表已完成，0代表进行中，-1代表失败',
  PRIMARY KEY (`trans_id`),
  KEY `bk_transaction_0_ibfk_1` (`trans_user_id`),
  KEY `bk_transaction_0_ibfk_2` (`acc_id`),
  KEY `bk_transaction_0_ibfk_3` (`trans_acc_id`),
  KEY `bk_transaction_0_ibfk_4` (`user_id`),
  CONSTRAINT `bk_transaction_3_ibfk_1` FOREIGN KEY (`trans_user_id`) REFERENCES `bk_user` (`user_id`),
  CONSTRAINT `bk_transaction_3_ibfk_2` FOREIGN KEY (`acc_id`) REFERENCES `bk_account` (`acc_id`),
  CONSTRAINT `bk_transaction_3_ibfk_3` FOREIGN KEY (`trans_acc_id`) REFERENCES `bk_account` (`acc_id`),
  CONSTRAINT `bk_transaction_3_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `bk_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `bk_transaction_3` */

insert  into `bk_transaction_3`(`trans_id`,`user_id`,`trans_user_id`,`acc_id`,`trans_acc_id`,`trans_currency`,`trans_balance`,`trans_amount`,`trans_time`,`trans_message`,`trans_type`,`trans_state`) values (1,3,3,7,8,'RMB',8900.00,-100.00,'2015-06-05 15:07:58','a test',1,1),(2,3,3,8,7,'RMB',112100.00,100.00,'2015-06-05 15:07:58','a test',2,1),(3,3,2,9,5,'RMB',77400.00,-300.00,'2015-06-06 12:30:50','money for dinner',3,1),(4,3,3,25,25,'RMB',1000400.00,1000400.00,'2015-06-06 17:51:28','Bank Deposit',5,1),(5,3,3,26,26,'RMB',20000.00,20000.00,'2015-06-06 17:51:46','Bank Deposit',5,1),(6,3,3,31,31,'RMB',-3000000.00,-3000000.00,'2015-06-07 08:39:22','Bank Deposit',6,1),(7,3,3,31,31,'RMB',57000000.00,60000000.00,'2015-06-07 08:39:45','Bank Deposit',5,1),(8,3,3,7,10,'RMB',5900.00,-3000.00,'2015-06-07 08:40:58','money for dinner',1,1),(9,3,3,10,7,'RMB',15000.00,3000.00,'2015-06-07 08:40:58','money for dinner',2,1),(10,3,1,8,27,'RMB',102100.00,-10000.00,'2015-06-07 08:43:21','Tu hao',3,1);

/*Table structure for table `bk_transaction_4` */

DROP TABLE IF EXISTS `bk_transaction_4`;

CREATE TABLE `bk_transaction_4` (
  `trans_id` int(18) NOT NULL AUTO_INCREMENT COMMENT '交易编号,自增主键',
  `user_id` int(18) NOT NULL COMMENT '客户编号,NOT NULL; 外键，级联于xt_cus的cus_id',
  `trans_user_id` int(18) NOT NULL,
  `acc_id` int(18) NOT NULL COMMENT '账户编号,NOT NULL; 外键，级联于xt_account的acc_id',
  `trans_acc_id` int(18) NOT NULL COMMENT '交易账户编号,NOT NULL; 外键，级联于xt_account的acc_id',
  `trans_currency` varchar(20) NOT NULL DEFAULT 'RMB' COMMENT '币种',
  `trans_balance` decimal(18,2) NOT NULL COMMENT '本次交易后的余额',
  `trans_amount` decimal(18,2) NOT NULL COMMENT '交易数额',
  `trans_time` datetime NOT NULL COMMENT '交易时间',
  `trans_message` text COMMENT '交易留言',
  `trans_type` int(2) NOT NULL COMMENT '交易类型',
  `trans_state` int(1) NOT NULL COMMENT '交易状态,1代表已完成，0代表进行中，-1代表失败',
  PRIMARY KEY (`trans_id`),
  KEY `bk_transaction_0_ibfk_1` (`trans_user_id`),
  KEY `bk_transaction_0_ibfk_2` (`acc_id`),
  KEY `bk_transaction_0_ibfk_3` (`trans_acc_id`),
  KEY `bk_transaction_0_ibfk_4` (`user_id`),
  CONSTRAINT `bk_transaction_4_ibfk_1` FOREIGN KEY (`trans_user_id`) REFERENCES `bk_user` (`user_id`),
  CONSTRAINT `bk_transaction_4_ibfk_2` FOREIGN KEY (`acc_id`) REFERENCES `bk_account` (`acc_id`),
  CONSTRAINT `bk_transaction_4_ibfk_3` FOREIGN KEY (`trans_acc_id`) REFERENCES `bk_account` (`acc_id`),
  CONSTRAINT `bk_transaction_4_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `bk_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bk_transaction_4` */

/*Table structure for table `bk_transaction_5` */

DROP TABLE IF EXISTS `bk_transaction_5`;

CREATE TABLE `bk_transaction_5` (
  `trans_id` int(18) NOT NULL AUTO_INCREMENT COMMENT '交易编号,自增主键',
  `user_id` int(18) NOT NULL COMMENT '客户编号,NOT NULL; 外键，级联于xt_cus的cus_id',
  `trans_user_id` int(18) NOT NULL,
  `acc_id` int(18) NOT NULL COMMENT '账户编号,NOT NULL; 外键，级联于xt_account的acc_id',
  `trans_acc_id` int(18) NOT NULL COMMENT '交易账户编号,NOT NULL; 外键，级联于xt_account的acc_id',
  `trans_currency` varchar(20) NOT NULL DEFAULT 'RMB' COMMENT '币种',
  `trans_balance` decimal(18,2) NOT NULL COMMENT '本次交易后的余额',
  `trans_amount` decimal(18,2) NOT NULL COMMENT '交易数额',
  `trans_time` datetime NOT NULL COMMENT '交易时间',
  `trans_message` text COMMENT '交易留言',
  `trans_type` int(2) NOT NULL COMMENT '交易类型',
  `trans_state` int(1) NOT NULL COMMENT '交易状态,1代表已完成，0代表进行中，-1代表失败',
  PRIMARY KEY (`trans_id`),
  KEY `bk_transaction_0_ibfk_1` (`trans_user_id`),
  KEY `bk_transaction_0_ibfk_2` (`acc_id`),
  KEY `bk_transaction_0_ibfk_3` (`trans_acc_id`),
  KEY `bk_transaction_0_ibfk_4` (`user_id`),
  CONSTRAINT `bk_transaction_5_ibfk_1` FOREIGN KEY (`trans_user_id`) REFERENCES `bk_user` (`user_id`),
  CONSTRAINT `bk_transaction_5_ibfk_2` FOREIGN KEY (`acc_id`) REFERENCES `bk_account` (`acc_id`),
  CONSTRAINT `bk_transaction_5_ibfk_3` FOREIGN KEY (`trans_acc_id`) REFERENCES `bk_account` (`acc_id`),
  CONSTRAINT `bk_transaction_5_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `bk_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bk_transaction_5` */

/*Table structure for table `bk_transaction_6` */

DROP TABLE IF EXISTS `bk_transaction_6`;

CREATE TABLE `bk_transaction_6` (
  `trans_id` int(18) NOT NULL AUTO_INCREMENT COMMENT '交易编号,自增主键',
  `user_id` int(18) NOT NULL COMMENT '客户编号,NOT NULL; 外键，级联于xt_cus的cus_id',
  `trans_user_id` int(18) NOT NULL,
  `acc_id` int(18) NOT NULL COMMENT '账户编号,NOT NULL; 外键，级联于xt_account的acc_id',
  `trans_acc_id` int(18) NOT NULL COMMENT '交易账户编号,NOT NULL; 外键，级联于xt_account的acc_id',
  `trans_currency` varchar(20) NOT NULL DEFAULT 'RMB' COMMENT '币种',
  `trans_balance` decimal(18,2) NOT NULL COMMENT '本次交易后的余额',
  `trans_amount` decimal(18,2) NOT NULL COMMENT '交易数额',
  `trans_time` datetime NOT NULL COMMENT '交易时间',
  `trans_message` text COMMENT '交易留言',
  `trans_type` int(2) NOT NULL COMMENT '交易类型',
  `trans_state` int(1) NOT NULL COMMENT '交易状态,1代表已完成，0代表进行中，-1代表失败',
  PRIMARY KEY (`trans_id`),
  KEY `bk_transaction_0_ibfk_1` (`trans_user_id`),
  KEY `bk_transaction_0_ibfk_2` (`acc_id`),
  KEY `bk_transaction_0_ibfk_3` (`trans_acc_id`),
  KEY `bk_transaction_0_ibfk_4` (`user_id`),
  CONSTRAINT `bk_transaction_6_ibfk_1` FOREIGN KEY (`trans_user_id`) REFERENCES `bk_user` (`user_id`),
  CONSTRAINT `bk_transaction_6_ibfk_2` FOREIGN KEY (`acc_id`) REFERENCES `bk_account` (`acc_id`),
  CONSTRAINT `bk_transaction_6_ibfk_3` FOREIGN KEY (`trans_acc_id`) REFERENCES `bk_account` (`acc_id`),
  CONSTRAINT `bk_transaction_6_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `bk_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bk_transaction_6` */

/*Table structure for table `bk_transaction_7` */

DROP TABLE IF EXISTS `bk_transaction_7`;

CREATE TABLE `bk_transaction_7` (
  `trans_id` int(18) NOT NULL AUTO_INCREMENT COMMENT '交易编号,自增主键',
  `user_id` int(18) NOT NULL COMMENT '客户编号,NOT NULL; 外键，级联于xt_cus的cus_id',
  `trans_user_id` int(18) NOT NULL,
  `acc_id` int(18) NOT NULL COMMENT '账户编号,NOT NULL; 外键，级联于xt_account的acc_id',
  `trans_acc_id` int(18) NOT NULL COMMENT '交易账户编号,NOT NULL; 外键，级联于xt_account的acc_id',
  `trans_currency` varchar(20) NOT NULL DEFAULT 'RMB' COMMENT '币种',
  `trans_balance` decimal(18,2) NOT NULL COMMENT '本次交易后的余额',
  `trans_amount` decimal(18,2) NOT NULL COMMENT '交易数额',
  `trans_time` datetime NOT NULL COMMENT '交易时间',
  `trans_message` text COMMENT '交易留言',
  `trans_type` int(2) NOT NULL COMMENT '交易类型',
  `trans_state` int(1) NOT NULL COMMENT '交易状态,1代表已完成，0代表进行中，-1代表失败',
  PRIMARY KEY (`trans_id`),
  KEY `bk_transaction_0_ibfk_1` (`trans_user_id`),
  KEY `bk_transaction_0_ibfk_2` (`acc_id`),
  KEY `bk_transaction_0_ibfk_3` (`trans_acc_id`),
  KEY `bk_transaction_0_ibfk_4` (`user_id`),
  CONSTRAINT `bk_transaction_7_ibfk_1` FOREIGN KEY (`trans_user_id`) REFERENCES `bk_user` (`user_id`),
  CONSTRAINT `bk_transaction_7_ibfk_2` FOREIGN KEY (`acc_id`) REFERENCES `bk_account` (`acc_id`),
  CONSTRAINT `bk_transaction_7_ibfk_3` FOREIGN KEY (`trans_acc_id`) REFERENCES `bk_account` (`acc_id`),
  CONSTRAINT `bk_transaction_7_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `bk_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bk_transaction_7` */

/*Table structure for table `bk_transaction_8` */

DROP TABLE IF EXISTS `bk_transaction_8`;

CREATE TABLE `bk_transaction_8` (
  `trans_id` int(18) NOT NULL AUTO_INCREMENT COMMENT '交易编号,自增主键',
  `user_id` int(18) NOT NULL COMMENT '客户编号,NOT NULL; 外键，级联于xt_cus的cus_id',
  `trans_user_id` int(18) NOT NULL,
  `acc_id` int(18) NOT NULL COMMENT '账户编号,NOT NULL; 外键，级联于xt_account的acc_id',
  `trans_acc_id` int(18) NOT NULL COMMENT '交易账户编号,NOT NULL; 外键，级联于xt_account的acc_id',
  `trans_currency` varchar(20) NOT NULL DEFAULT 'RMB' COMMENT '币种',
  `trans_balance` decimal(18,2) NOT NULL COMMENT '本次交易后的余额',
  `trans_amount` decimal(18,2) NOT NULL COMMENT '交易数额',
  `trans_time` datetime NOT NULL COMMENT '交易时间',
  `trans_message` text COMMENT '交易留言',
  `trans_type` int(2) NOT NULL COMMENT '交易类型',
  `trans_state` int(1) NOT NULL COMMENT '交易状态,1代表已完成，0代表进行中，-1代表失败',
  PRIMARY KEY (`trans_id`),
  KEY `bk_transaction_0_ibfk_1` (`trans_user_id`),
  KEY `bk_transaction_0_ibfk_2` (`acc_id`),
  KEY `bk_transaction_0_ibfk_3` (`trans_acc_id`),
  KEY `bk_transaction_0_ibfk_4` (`user_id`),
  CONSTRAINT `bk_transaction_8_ibfk_1` FOREIGN KEY (`trans_user_id`) REFERENCES `bk_user` (`user_id`),
  CONSTRAINT `bk_transaction_8_ibfk_2` FOREIGN KEY (`acc_id`) REFERENCES `bk_account` (`acc_id`),
  CONSTRAINT `bk_transaction_8_ibfk_3` FOREIGN KEY (`trans_acc_id`) REFERENCES `bk_account` (`acc_id`),
  CONSTRAINT `bk_transaction_8_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `bk_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bk_transaction_8` */

/*Table structure for table `bk_transaction_9` */

DROP TABLE IF EXISTS `bk_transaction_9`;

CREATE TABLE `bk_transaction_9` (
  `trans_id` int(18) NOT NULL AUTO_INCREMENT COMMENT '交易编号,自增主键',
  `user_id` int(18) NOT NULL COMMENT '客户编号,NOT NULL; 外键，级联于xt_cus的cus_id',
  `trans_user_id` int(18) NOT NULL,
  `acc_id` int(18) NOT NULL COMMENT '账户编号,NOT NULL; 外键，级联于xt_account的acc_id',
  `trans_acc_id` int(18) NOT NULL COMMENT '交易账户编号,NOT NULL; 外键，级联于xt_account的acc_id',
  `trans_currency` varchar(20) NOT NULL DEFAULT 'RMB' COMMENT '币种',
  `trans_balance` decimal(18,2) NOT NULL COMMENT '本次交易后的余额',
  `trans_amount` decimal(18,2) NOT NULL COMMENT '交易数额',
  `trans_time` datetime NOT NULL COMMENT '交易时间',
  `trans_message` text COMMENT '交易留言',
  `trans_type` int(2) NOT NULL COMMENT '交易类型',
  `trans_state` int(1) NOT NULL COMMENT '交易状态,1代表已完成，0代表进行中，-1代表失败',
  PRIMARY KEY (`trans_id`),
  KEY `bk_transaction_0_ibfk_1` (`trans_user_id`),
  KEY `bk_transaction_0_ibfk_2` (`acc_id`),
  KEY `bk_transaction_0_ibfk_3` (`trans_acc_id`),
  KEY `bk_transaction_0_ibfk_4` (`user_id`),
  CONSTRAINT `bk_transaction_9_ibfk_1` FOREIGN KEY (`trans_user_id`) REFERENCES `bk_user` (`user_id`),
  CONSTRAINT `bk_transaction_9_ibfk_2` FOREIGN KEY (`acc_id`) REFERENCES `bk_account` (`acc_id`),
  CONSTRAINT `bk_transaction_9_ibfk_3` FOREIGN KEY (`trans_acc_id`) REFERENCES `bk_account` (`acc_id`),
  CONSTRAINT `bk_transaction_9_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `bk_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bk_transaction_9` */

/*Table structure for table `bk_user` */

DROP TABLE IF EXISTS `bk_user`;

CREATE TABLE `bk_user` (
  `user_id` int(18) NOT NULL AUTO_INCREMENT COMMENT '客户ID,自增主键',
  `user_no` varchar(20) NOT NULL COMMENT '客户编号,默认登录名；NOT NULL',
  `user_name` varchar(20) NOT NULL COMMENT '客户姓名',
  `user_pwd` varchar(128) NOT NULL COMMENT '客户密码',
  `user_identity` varchar(18) NOT NULL COMMENT '客户身份证号',
  `user_gender` char(1) NOT NULL COMMENT '客户性别,“F”为女，”M”为男',
  `user_tel` varchar(15) DEFAULT NULL COMMENT '手机,可选登录名，NULL',
  `user_email` varchar(50) DEFAULT NULL,
  `role_id` int(2) NOT NULL COMMENT '角色编号,1代表管理员，2代表普通用户，3代表VIP',
  `user_state` int(1) NOT NULL DEFAULT '1' COMMENT '0表示无效，1表示有效 NOT NULL',
  PRIMARY KEY (`user_id`),
  KEY `customer_ibfk_1` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `bk_user` */

insert  into `bk_user`(`user_id`,`user_no`,`user_name`,`user_pwd`,`user_identity`,`user_gender`,`user_tel`,`user_email`,`role_id`,`user_state`) values (1,'Grace','土豪超','1234567','142303199202184127','F','19500022391','test635482@qq.com',2,1),(2,'Anto','环宇壕','12345678','182738199206298832','M','18700110011','testlihuanyu@163.com',2,1),(3,'Simon','帅平','12345678','173827199210248394','M','19000232011','liuping456@qq.com',2,1),(4,'Candy','胖青青','12345678','187183199306088748','F','19300000023','testcandy1993@qq.com',1,1),(5,'Twinkle','小黑黑','12345678','19837827434','M','19302030123','test18739281@qq.com',2,1);

/*Table structure for table `bk_user_acc` */

DROP TABLE IF EXISTS `bk_user_acc`;

CREATE TABLE `bk_user_acc` (
  `user_acc_id` int(18) NOT NULL AUTO_INCREMENT,
  `user_id` int(18) NOT NULL COMMENT '客户编号,外键；级联xt_cus表的cus_id',
  `acc_id` int(18) NOT NULL COMMENT '账户编号,外键；级联xt_account表的acc_id',
  PRIMARY KEY (`user_acc_id`),
  KEY `bk_user_acc_ibfk_1` (`acc_id`),
  KEY `bk_user_acc_ibfk_2` (`user_id`),
  CONSTRAINT `bk_user_acc_ibfk_1` FOREIGN KEY (`acc_id`) REFERENCES `bk_account` (`acc_id`),
  CONSTRAINT `bk_user_acc_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `bk_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

/*Data for the table `bk_user_acc` */

insert  into `bk_user_acc`(`user_acc_id`,`user_id`,`acc_id`) values (4,1,1),(20,1,19),(21,1,20),(23,1,22),(24,1,23),(25,1,24),(26,2,2),(27,2,3),(28,2,4),(29,2,5),(30,2,6),(31,3,7),(32,3,8),(33,3,9),(34,3,10),(35,4,11),(36,4,12),(37,4,13),(38,4,14),(39,4,15),(40,4,16),(41,3,17),(42,3,18),(43,2,21),(44,3,25),(45,3,26),(46,1,27),(48,3,29),(49,4,30),(50,3,31),(51,3,32);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
