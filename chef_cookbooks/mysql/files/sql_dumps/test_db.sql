CREATE DATABASE  IF NOT EXISTS `my_test` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `my_test`;
-- MySQL dump 10.13  Distrib 5.7.9, for linux-glibc2.5 (x86_64)
--
-- Host: localhost    Database: my_test
-- ------------------------------------------------------
-- Server version	5.5.59-0ubuntu0.14.04.1-log

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
-- Table structure for table `todo_task`
--

DROP TABLE IF EXISTS `todo_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `todo_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `todo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_todo_task_1_idx` (`todo`),
  CONSTRAINT `fk_todo_task_1` FOREIGN KEY (`todo`) REFERENCES `todos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `todo_task`
--

LOCK TABLES `todo_task` WRITE;
/*!40000 ALTER TABLE `todo_task` DISABLE KEYS */;
INSERT INTO `todo_task` VALUES (4,'sad',10),(5,'sdsd',10),(6,'sadsad',10),(7,'sdsad',11);
/*!40000 ALTER TABLE `todo_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `todos`
--

DROP TABLE IF EXISTS `todos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `todos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `todo_name` varchar(255) NOT NULL,
  `todo_description` varchar(255) DEFAULT NULL,
  `todo_done` tinyint(4) DEFAULT NULL,
  `todo_created` datetime NOT NULL,
  `todo_updated` datetime DEFAULT NULL,
  `todo_deleted` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `todos`
--

LOCK TABLES `todos` WRITE;
/*!40000 ALTER TABLE `todos` DISABLE KEYS */;
INSERT INTO `todos` VALUES (10,'sd','sadsad',0,'0000-00-00 00:00:00',NULL,NULL),(11,'sasdsad','sadsdsd',0,'0000-00-00 00:00:00',NULL,NULL),(12,'sadsad','sdsad',NULL,'0000-00-00 00:00:00',NULL,NULL),(13,'sdsad','asdsd',NULL,'0000-00-00 00:00:00',NULL,NULL);
/*!40000 ALTER TABLE `todos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'my_test'
--

--
-- Dumping routines for database 'my_test'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-02-14  8:45:01
