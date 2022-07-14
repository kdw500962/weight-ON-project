-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: localhost    Database: weight_ondb
-- ------------------------------------------------------
-- Server version	8.0.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `plantbl`
--

DROP TABLE IF EXISTS `plantbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plantbl` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(10) NOT NULL,
  `workoutNum` varchar(10) NOT NULL,
  `name` varchar(30) NOT NULL,
  `category` varchar(10) NOT NULL,
  `setCount` int(11) DEFAULT NULL,
  `setWeight` int(11) DEFAULT NULL,
  `memo` text,
  `complete` varchar(10) DEFAULT NULL,
  `save_day` varchar(50) DEFAULT NULL,
  `done_day` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`num`),
  KEY `id` (`id`),
  CONSTRAINT `plantbl_ibfk_1` FOREIGN KEY (`id`) REFERENCES `usertbl` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plantbl`
--

LOCK TABLES `plantbl` WRITE;
/*!40000 ALTER TABLE `plantbl` DISABLE KEYS */;
INSERT INTO `plantbl` VALUES (1,'admin1','C001','덤벨 플렛 벤치프레스','가슴',1,30,'','Done','2022-07-03','2022-07-03'),(2,'admin1','C001','덤벨 플렛 벤치프레스','가슴',2,30,'','Done','2022-07-03','2022-07-03'),(3,'admin1','C001','덤벨 플렛 벤치프레스','가슴',3,30,'','Done','2022-07-03','2022-07-03'),(4,'admin1','C001','덤벨 플렛 벤치프레스','가슴',4,30,'','Done','2022-07-03','2022-07-03'),(5,'admin1','C001','덤벨 플렛 벤치프레스','가슴',5,30,'','Done','2022-07-03','2022-07-03'),(6,'admin1','C001','덤벨 플렛 벤치프레스','가슴',1,30,'','Done','2022-07-04','2022-07-04'),(7,'admin1','C001','덤벨 플렛 벤치프레스','가슴',2,30,'','Done','2022-07-04','2022-07-04'),(8,'admin1','C001','덤벨 플렛 벤치프레스','가슴',3,30,'','Done','2022-07-04','2022-07-04'),(9,'admin1','C001','덤벨 플렛 벤치프레스','가슴',4,30,'','Done','2022-07-04','2022-07-04'),(10,'admin1','C001','덤벨 플렛 벤치프레스','가슴',5,30,'','Done','2022-07-04','2022-07-04');
/*!40000 ALTER TABLE `plantbl` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-08 16:33:09
