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
-- Table structure for table `boardtbl`
--

DROP TABLE IF EXISTS `boardtbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `boardtbl` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(10) NOT NULL,
  `name` varchar(10) NOT NULL,
  `subject` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `fileName` varchar(30) DEFAULT NULL,
  `regist_day` varchar(30) DEFAULT NULL,
  `hit` int(11) DEFAULT NULL,
  PRIMARY KEY (`num`),
  KEY `id` (`id`),
  CONSTRAINT `boardtbl_ibfk_1` FOREIGN KEY (`id`) REFERENCES `usertbl` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boardtbl`
--

LOCK TABLES `boardtbl` WRITE;
/*!40000 ALTER TABLE `boardtbl` DISABLE KEYS */;
INSERT INTO `boardtbl` VALUES (1,'admin1','회원1','인클라인 덤벨프레스 자극궁금합니다','인클라인 덤벨프레스 할때 자극이 잘안오는 경우가 궁금합니다','인클레인 덤벨 프레스.jpg','2022/57/08(14:57:12)',6),(2,'admin2','회원2','바벨 백스쿼드 할때 무릎이 아픔니다 ','바벨 백스쿼드 할때 무릎이 아픈 경우 잘못된 점을 알려주세요\r\n운동자세 사진이 없어서 사진없이 글을 썻습니다',NULL,'2022/00/08(15:00:13)',0);
/*!40000 ALTER TABLE `boardtbl` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-08 16:33:08
