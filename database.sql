-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: forum
-- ------------------------------------------------------
-- Server version	5.7.20-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log` (
  `lid` int(11) NOT NULL AUTO_INCREMENT,
  `time` datetime NOT NULL,
  `table_name` varchar(45) NOT NULL,
  `operation` varchar(45) NOT NULL,
  `key_value` int(11) NOT NULL,
  PRIMARY KEY (`lid`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES (1,'2017-12-30 17:53:45','user','insert',1),(2,'2017-12-30 17:54:16','session','insert',1),(3,'2017-12-30 17:54:31','session','insert',2),(4,'2017-12-30 17:54:37','session','insert',3),(5,'2017-12-30 17:55:27','topic','insert',1),(6,'2017-12-30 17:55:41','reply','insert',1),(7,'2017-12-30 17:56:12','user','update',1),(8,'2017-12-30 18:17:10','topic','insert',2),(9,'2017-12-30 18:17:12','user','insert',2),(10,'2017-12-30 18:17:38','topic','insert',3),(11,'2017-12-30 18:21:53','reply','insert',2),(12,'2017-12-30 18:22:03','topic','insert',4),(13,'2017-12-30 18:24:20','user','insert',3),(14,'2017-12-30 19:00:15','user','update',2),(15,'2017-12-30 19:00:27','user','update',1),(16,'2017-12-30 19:00:27','user','update',3),(17,'2017-12-30 19:03:10','reply','insert',3),(18,'2017-12-31 15:11:16','user','update',1),(19,'2017-12-31 15:11:24','reply','insert',4),(20,'2017-12-31 16:13:09','topic','insert',5),(21,'2017-12-31 19:16:48','reply','insert',5),(22,'2018-01-02 14:22:54','reply','insert',6),(23,'2018-01-02 14:23:08','user','update',1),(24,'2018-01-02 14:23:09','user','update',1),(25,'2018-01-02 14:24:15','reply','insert',7),(26,'2018-01-02 14:24:29','topic','insert',6),(27,'2018-01-02 14:26:10','user','update',2);
/*!40000 ALTER TABLE `log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reply`
--

DROP TABLE IF EXISTS `reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reply` (
  `rid` int(11) NOT NULL AUTO_INCREMENT,
  `tid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `content` varchar(300) NOT NULL,
  `createtime` datetime NOT NULL,
  PRIMARY KEY (`rid`),
  UNIQUE KEY `rid_UNIQUE` (`rid`),
  KEY `r_1_idx` (`tid`),
  KEY `r_3_idx` (`uid`),
  CONSTRAINT `r_1` FOREIGN KEY (`tid`) REFERENCES `topic` (`tid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `r_3` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reply`
--

LOCK TABLES `reply` WRITE;
/*!40000 ALTER TABLE `reply` DISABLE KEYS */;
INSERT INTO `reply` VALUES (1,1,1,'good movie','2017-12-30 17:55:41'),(2,3,1,'我也觉得','2017-12-30 18:21:53'),(3,4,1,'??','2017-12-30 19:03:10'),(4,3,1,'zzz','2017-12-31 15:11:24'),(5,5,1,'s','2017-12-31 19:16:48'),(6,1,1,'good','2018-01-02 14:22:54'),(7,1,2,'1','2018-01-02 14:24:15');
/*!40000 ALTER TABLE `reply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `sname` varchar(45) NOT NULL,
  `topics` int(11) NOT NULL,
  `replies` int(11) NOT NULL,
  `updatetime` datetime NOT NULL,
  PRIMARY KEY (`sid`),
  UNIQUE KEY `sid_UNIQUE` (`sid`),
  UNIQUE KEY `sname_UNIQUE` (`sname`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session`
--

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
INSERT INTO `session` VALUES (1,'电影',3,4,'2018-01-02 14:24:29'),(2,'音乐',1,1,'2017-12-30 19:03:10'),(3,'学习',2,2,'2017-12-31 15:11:24');
/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topic`
--

DROP TABLE IF EXISTS `topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topic` (
  `tid` int(11) NOT NULL AUTO_INCREMENT,
  `sid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `title` varchar(45) NOT NULL,
  `content` varchar(300) NOT NULL,
  `createtime` datetime NOT NULL,
  `updatetime` datetime NOT NULL,
  `replycount` int(11) NOT NULL,
  PRIMARY KEY (`tid`),
  UNIQUE KEY `tid_UNIQUE` (`tid`),
  KEY `topic_1_idx` (`sid`),
  KEY `topic_2_idx` (`uid`),
  CONSTRAINT `topic_1` FOREIGN KEY (`sid`) REFERENCES `session` (`sid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `topic_2` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topic`
--

LOCK TABLES `topic` WRITE;
/*!40000 ALTER TABLE `topic` DISABLE KEYS */;
INSERT INTO `topic` VALUES (1,1,1,'Moon','clone man ','2017-12-30 17:55:27','2018-01-02 14:24:15',3),(2,3,1,'数据结构','1','2017-12-30 18:17:10','2017-12-30 18:17:10',0),(3,3,2,'计算机图形学','难！','2017-12-30 18:17:38','2017-12-31 15:11:24',2),(4,2,2,'CHVRCHERS','blue\n','2017-12-30 18:22:03','2017-12-30 19:03:10',1),(5,1,1,'Confession','','2017-12-31 16:13:09','2017-12-31 19:16:48',1),(6,1,2,'zz','z','2018-01-02 14:24:29','2018-01-02 14:24:29',0);
/*!40000 ALTER TABLE `topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `nickname` varchar(45) NOT NULL,
  `avatar` varchar(45) NOT NULL,
  `regdate` datetime NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `sex` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `nickname_UNIQUE` (`nickname`),
  UNIQUE KEY `UID_UNIQUE` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'hong','hong','hongz','http://172.29.35.3:3000/avatar.jpg','2017-12-30 17:53:45','123@qq.com',1),(2,'gomez','gomez','gomez','http://172.29.35.3:3000/avatar.jpg','2017-12-30 18:17:12','gvgfgf',NULL),(3,'toby','toby','toby','http://172.29.35.3:3000/avatar.jpg','2017-12-30 18:24:20',NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-01-04 17:27:22
