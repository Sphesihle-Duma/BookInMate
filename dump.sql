-- MySQL dump 10.13  Distrib 8.0.35, for Linux (x86_64)
--
-- Host: localhost    Database: booking_db
-- ------------------------------------------------------
-- Server version	8.0.35-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `booking_id` varchar(50) NOT NULL,
  `inmate_id` varchar(50) DEFAULT NULL,
  `visitor_id` varchar(50) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `timeslot` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`booking_id`),
  KEY `inmate_id` (`inmate_id`),
  KEY `visitor_id` (`visitor_id`),
  CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`inmate_id`) REFERENCES `inmate` (`inmate_id`),
  CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`visitor_id`) REFERENCES `visitor` (`visitor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES ('10f5f279-99a5-4f10-98c1-ca0b422d705d','410789','125478','2023-11-09','Declined','11:00','duma_sphesihle@yahoo.com'),('12334556','410784','1478566','2023-11-09','Approved','09:00','example123@gmail.com'),('25654084-13a0-4305-8cff-419096025c0c','410791','589645','2023-11-15','Approved','12:00','duma_sphesihle@yahoo.com'),('a9116fba-ecae-42c1-98e4-82b34005960c','410788','456789','2023-11-23','Approved','14:00','duma_sphesihle@yahoo.com'),('b63d8dff-ee08-428a-8950-e0db220314c1','410786','156987','2023-11-09','Approved','12:00','example34@gmail.com'),('c1f03ee1-1fc0-4cda-8174-51710c0516fe','410792','4567892','2023-11-08','Approved','10:00','duma_sphesihle@yahoo.com'),('cc93ef98-65ec-4202-89c7-ea898d4b18cd','410787','689587','2023-11-16','Approved','11:00','duma_sphesihle@yahoo.com'),('dce59de9-9b08-4f26-adf6-c8555af4f5b0','410790','457893','2023-11-20','Approved','13:00','duma_sphesihle@yahoo.com'),('e60b6afb-347c-4460-be7a-6e883abbc173','410785','147859097','2004-04-22','Approved','09:00','example67@gmail.com');
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facility`
--

DROP TABLE IF EXISTS `facility`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facility` (
  `facility_id` varchar(50) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `province` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`facility_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facility`
--

LOCK TABLES `facility` WRITE;
/*!40000 ALTER TABLE `facility` DISABLE KEYS */;
INSERT INTO `facility` VALUES ('EC001','Qumbu','Port Elizaberth','Eastern Cape'),('EST001','Escort','Escort','KwaZulu-Natal'),('FS001','Mangaung','Bloemfontein','Free state'),('HD001','Helderstorm','CapeTown','Western Cape'),('KG001','Kgose','Pretoria','Gauteng'),('LADY001','Ladysmith','Ladysmith','KwaZulu-Natal'),('PL001','Pollsmor','Cape Town','Western Cape'),('PTA001','Pretoria central','Pretoria','Gauteng'),('WES001','Westville','Durban','KwaZulu-Natal');
/*!40000 ALTER TABLE `facility` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inmate`
--

DROP TABLE IF EXISTS `inmate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inmate` (
  `inmate_id` varchar(50) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `facility_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`inmate_id`),
  KEY `facility_id` (`facility_id`),
  CONSTRAINT `inmate_ibfk_1` FOREIGN KEY (`facility_id`) REFERENCES `facility` (`facility_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inmate`
--

LOCK TABLES `inmate` WRITE;
/*!40000 ALTER TABLE `inmate` DISABLE KEYS */;
INSERT INTO `inmate` VALUES ('410784','Menzi','PTA001'),('410785','John','PL001'),('410786','Joe','FS001'),('410787','Mondli','HD001'),('410788','Albert','WES001'),('410789','Bheki','EST001'),('410790','Gininda','LADY001'),('410791','Kabza','KG001'),('410792','Steve','EC001');
/*!40000 ALTER TABLE `inmate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visitor`
--

DROP TABLE IF EXISTS `visitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visitor` (
  `visitor_id` varchar(50) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `facility_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`visitor_id`),
  KEY `facility_id` (`facility_id`),
  CONSTRAINT `visitor_ibfk_1` FOREIGN KEY (`facility_id`) REFERENCES `facility` (`facility_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visitor`
--

LOCK TABLES `visitor` WRITE;
/*!40000 ALTER TABLE `visitor` DISABLE KEYS */;
INSERT INTO `visitor` VALUES ('12456','test','testa@gmail.com','PL001'),('125478','Asithandile','duma_sphesihle@yahoo.com','EST001'),('1478566','Sphes','example123@gmail.com','PTA001'),('147859097','JOHN','example67@gmail.com','PL001'),('14785997','JOHN','example67@gmail.com','PL001'),('156987','Joe','example34@gmail.com','FS001'),('25698','test','testa@gmail.com','PL001'),('456789','Duma','duma_sphesihle@yahoo.com','WES001'),('4567892','steve','duma_sphesihle@yahoo.com','EC001'),('457893','test12','duma_sphesihle@yahoo.com','LADY001'),('589645','admih','duma_sphesihle@yahoo.com','KG001'),('689587','Sphe','duma_sphesihle@yahoo.com','HD001');
/*!40000 ALTER TABLE `visitor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-07  1:42:58
