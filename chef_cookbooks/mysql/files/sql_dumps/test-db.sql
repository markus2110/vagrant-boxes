CREATE DATABASE  IF NOT EXISTS `test-db` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `test-db`;

--
-- Table structure for table `table1`
--
DROP TABLE IF EXISTS `table1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `table1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `field1` varchar(255) DEFAULT NULL,
  `field2` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `table1`
--
LOCK TABLES `table1` WRITE;
INSERT INTO `table1` VALUES (1, 'This is the first value',1),(1, 'This is the another value',22);
UNLOCK TABLES;
