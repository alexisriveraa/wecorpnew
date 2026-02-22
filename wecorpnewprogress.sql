-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: wecorp
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `business`
--

DROP TABLE IF EXISTS `business`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `business` (
  `business_id` int NOT NULL AUTO_INCREMENT,
  `business_name` varchar(100) NOT NULL,
  `type` enum('House','Bakery','School','Cafe','Pharmacy','Bank','Grocery','Hardware') NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`business_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business`
--

LOCK TABLES `business` WRITE;
/*!40000 ALTER TABLE `business` DISABLE KEYS */;
INSERT INTO `business` VALUES (1,'ABC Bakery','Bakery','Cauayan City'),(2,'Hardware','House',NULL);
/*!40000 ALTER TABLE `business` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `electric_bills`
--

DROP TABLE IF EXISTS `electric_bills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `electric_bills` (
  `bill_id` int NOT NULL AUTO_INCREMENT,
  `reading_id` int DEFAULT NULL,
  `used_kwh` decimal(10,2) DEFAULT NULL,
  `rate_per_kwh` decimal(10,2) DEFAULT NULL,
  `service_fee` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `status` enum('Pending','Partially Paid','Paid','Overdue') DEFAULT 'Pending',
  `generated_by` varchar(20) DEFAULT NULL,
  `electric_tax_id` int DEFAULT NULL,
  `business_id` int DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  PRIMARY KEY (`bill_id`),
  KEY `reading_id` (`reading_id`),
  KEY `generated_by` (`generated_by`),
  KEY `fk_electric_tax` (`electric_tax_id`),
  KEY `business_id` (`business_id`),
  CONSTRAINT `electric_bills_ibfk_1` FOREIGN KEY (`reading_id`) REFERENCES `electric_readings` (`reading_id`),
  CONSTRAINT `electric_bills_ibfk_2` FOREIGN KEY (`generated_by`) REFERENCES `employees` (`employees_id`),
  CONSTRAINT `electric_bills_ibfk_3` FOREIGN KEY (`business_id`) REFERENCES `business` (`business_id`),
  CONSTRAINT `fk_electric_tax` FOREIGN KEY (`electric_tax_id`) REFERENCES `electric_tax` (`electric_tax_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `electric_bills`
--

LOCK TABLES `electric_bills` WRITE;
/*!40000 ALTER TABLE `electric_bills` DISABLE KEYS */;
/*!40000 ALTER TABLE `electric_bills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `electric_meters`
--

DROP TABLE IF EXISTS `electric_meters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `electric_meters` (
  `electric_meter_id` int NOT NULL AUTO_INCREMENT,
  `business_id` int NOT NULL,
  `meter_no` varchar(50) DEFAULT NULL,
  `unit` varchar(10) DEFAULT 'kWh',
  PRIMARY KEY (`electric_meter_id`),
  KEY `electric_meters_ibfk_1` (`business_id`),
  CONSTRAINT `electric_meters_ibfk_1` FOREIGN KEY (`business_id`) REFERENCES `business` (`business_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `electric_meters`
--

LOCK TABLES `electric_meters` WRITE;
/*!40000 ALTER TABLE `electric_meters` DISABLE KEYS */;
/*!40000 ALTER TABLE `electric_meters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `electric_payments`
--

DROP TABLE IF EXISTS `electric_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `electric_payments` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL,
  `payment_date` date NOT NULL,
  `amount_paid` decimal(10,2) NOT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `received_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `bill_id` (`bill_id`),
  KEY `received_by` (`received_by`),
  CONSTRAINT `electric_payments_ibfk_1` FOREIGN KEY (`bill_id`) REFERENCES `electric_bills` (`bill_id`),
  CONSTRAINT `electric_payments_ibfk_2` FOREIGN KEY (`received_by`) REFERENCES `employees` (`employees_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `electric_payments`
--

LOCK TABLES `electric_payments` WRITE;
/*!40000 ALTER TABLE `electric_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `electric_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `electric_penalties`
--

DROP TABLE IF EXISTS `electric_penalties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `electric_penalties` (
  `penalty_id` int NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL,
  `penalty_rate` decimal(5,2) NOT NULL,
  `penalty_amount` decimal(10,2) NOT NULL,
  `penalty_date` date NOT NULL,
  `reason` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`penalty_id`),
  KEY `bill_id` (`bill_id`),
  CONSTRAINT `electric_penalties_ibfk_1` FOREIGN KEY (`bill_id`) REFERENCES `electric_bills` (`bill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `electric_penalties`
--

LOCK TABLES `electric_penalties` WRITE;
/*!40000 ALTER TABLE `electric_penalties` DISABLE KEYS */;
/*!40000 ALTER TABLE `electric_penalties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `electric_rates`
--

DROP TABLE IF EXISTS `electric_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `electric_rates` (
  `rate_id` int NOT NULL AUTO_INCREMENT,
  `peso_per_kwh` decimal(10,2) DEFAULT NULL,
  `service_fee` decimal(10,2) DEFAULT NULL,
  `effective_year` int DEFAULT NULL,
  PRIMARY KEY (`rate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `electric_rates`
--

LOCK TABLES `electric_rates` WRITE;
/*!40000 ALTER TABLE `electric_rates` DISABLE KEYS */;
/*!40000 ALTER TABLE `electric_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `electric_readings`
--

DROP TABLE IF EXISTS `electric_readings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `electric_readings` (
  `reading_id` int NOT NULL AUTO_INCREMENT,
  `electric_meter_id` int NOT NULL,
  `month` int DEFAULT NULL,
  `year` int DEFAULT NULL,
  `prev_kwh` decimal(10,2) DEFAULT NULL,
  `curr_kwh` decimal(10,2) DEFAULT NULL,
  `encoded_by` varchar(20) NOT NULL,
  PRIMARY KEY (`reading_id`),
  UNIQUE KEY `electric_meter_id` (`electric_meter_id`,`month`,`year`),
  KEY `electric_readings_ibfk_2` (`encoded_by`),
  CONSTRAINT `electric_readings_ibfk_1` FOREIGN KEY (`electric_meter_id`) REFERENCES `electric_meters` (`electric_meter_id`),
  CONSTRAINT `electric_readings_ibfk_2` FOREIGN KEY (`encoded_by`) REFERENCES `employees` (`employees_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `electric_readings`
--

LOCK TABLES `electric_readings` WRITE;
/*!40000 ALTER TABLE `electric_readings` DISABLE KEYS */;
/*!40000 ALTER TABLE `electric_readings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `electric_tax`
--

DROP TABLE IF EXISTS `electric_tax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `electric_tax` (
  `electric_tax_id` int NOT NULL AUTO_INCREMENT,
  `tax_id` int DEFAULT NULL,
  `tax_rate` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`electric_tax_id`),
  KEY `tax_id` (`tax_id`),
  CONSTRAINT `electric_tax_ibfk_1` FOREIGN KEY (`tax_id`) REFERENCES `tax` (`tax_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `electric_tax`
--

LOCK TABLES `electric_tax` WRITE;
/*!40000 ALTER TABLE `electric_tax` DISABLE KEYS */;
INSERT INTO `electric_tax` VALUES (1,1,12.00),(2,2,5.00);
/*!40000 ALTER TABLE `electric_tax` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `employees_id` varchar(20) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `position` varchar(50) DEFAULT NULL,
  `gmail` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`employees_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES ('24','Alexis Valdez',NULL,NULL),('2416249','Alexis Rivera',NULL,NULL),('243','Immanuel Genisis',NULL,NULL);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax`
--

DROP TABLE IF EXISTS `tax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tax` (
  `tax_id` int NOT NULL AUTO_INCREMENT,
  `tax_name` varchar(50) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`tax_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax`
--

LOCK TABLES `tax` WRITE;
/*!40000 ALTER TABLE `tax` DISABLE KEYS */;
INSERT INTO `tax` VALUES (1,'VAT','SAMPLE ONLY','Inactive'),(2,'Environmental Fee','SAMPLE ONLY','Inactive');
/*!40000 ALTER TABLE `tax` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `water_bills`
--

DROP TABLE IF EXISTS `water_bills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `water_bills` (
  `bill_id` int NOT NULL AUTO_INCREMENT,
  `reading_id` int DEFAULT NULL,
  `used_cubic` decimal(10,2) DEFAULT NULL,
  `rate_per_cubic` decimal(10,2) DEFAULT NULL,
  `service_fee` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `status` enum('Pending','Partially Paid','Paid','Overdue') DEFAULT 'Pending',
  `generated_by` varchar(20) DEFAULT NULL,
  `water_tax_id` int DEFAULT NULL,
  `business_id` int DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  PRIMARY KEY (`bill_id`),
  KEY `reading_id` (`reading_id`),
  KEY `fk_water_bills_generated_by` (`generated_by`),
  KEY `fk_water_tax` (`water_tax_id`),
  KEY `business_id` (`business_id`),
  CONSTRAINT `fk_water_bills_generated_by` FOREIGN KEY (`generated_by`) REFERENCES `employees` (`employees_id`),
  CONSTRAINT `fk_water_tax` FOREIGN KEY (`water_tax_id`) REFERENCES `water_tax` (`water_tax_id`),
  CONSTRAINT `water_bills_ibfk_1` FOREIGN KEY (`reading_id`) REFERENCES `water_readings` (`reading_id`),
  CONSTRAINT `water_bills_ibfk_2` FOREIGN KEY (`business_id`) REFERENCES `business` (`business_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `water_bills`
--

LOCK TABLES `water_bills` WRITE;
/*!40000 ALTER TABLE `water_bills` DISABLE KEYS */;
INSERT INTO `water_bills` VALUES (1,1,30.00,33.25,50.00,1047.50,'Partially Paid',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `water_bills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `water_meters`
--

DROP TABLE IF EXISTS `water_meters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `water_meters` (
  `water_meter_id` int NOT NULL AUTO_INCREMENT,
  `business_id` int NOT NULL,
  `meter_no` varchar(50) DEFAULT NULL,
  `unit` varchar(10) DEFAULT 'm3',
  PRIMARY KEY (`water_meter_id`),
  KEY `water_meters_ibfk_1` (`business_id`),
  CONSTRAINT `water_meters_ibfk_1` FOREIGN KEY (`business_id`) REFERENCES `business` (`business_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `water_meters`
--

LOCK TABLES `water_meters` WRITE;
/*!40000 ALTER TABLE `water_meters` DISABLE KEYS */;
INSERT INTO `water_meters` VALUES (1,1,'WM-1001','m3');
/*!40000 ALTER TABLE `water_meters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `water_payments`
--

DROP TABLE IF EXISTS `water_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `water_payments` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL,
  `payment_date` date NOT NULL,
  `amount_paid` decimal(10,2) NOT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `received_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `bill_id` (`bill_id`),
  KEY `received_by` (`received_by`),
  CONSTRAINT `water_payments_ibfk_1` FOREIGN KEY (`bill_id`) REFERENCES `water_bills` (`bill_id`),
  CONSTRAINT `water_payments_ibfk_2` FOREIGN KEY (`received_by`) REFERENCES `employees` (`employees_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `water_payments`
--

LOCK TABLES `water_payments` WRITE;
/*!40000 ALTER TABLE `water_payments` DISABLE KEYS */;
INSERT INTO `water_payments` VALUES (2,1,'2026-02-17',300.00,'Cash','2416249');
/*!40000 ALTER TABLE `water_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `water_penalties`
--

DROP TABLE IF EXISTS `water_penalties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `water_penalties` (
  `penalty_id` int NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL,
  `penalty_rate` decimal(5,2) NOT NULL,
  `penalty_amount` decimal(10,2) NOT NULL,
  `penalty_date` date NOT NULL,
  `reason` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`penalty_id`),
  KEY `bill_id` (`bill_id`),
  CONSTRAINT `water_penalties_ibfk_1` FOREIGN KEY (`bill_id`) REFERENCES `water_bills` (`bill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `water_penalties`
--

LOCK TABLES `water_penalties` WRITE;
/*!40000 ALTER TABLE `water_penalties` DISABLE KEYS */;
/*!40000 ALTER TABLE `water_penalties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `water_rates`
--

DROP TABLE IF EXISTS `water_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `water_rates` (
  `rate_id` int NOT NULL AUTO_INCREMENT,
  `peso_per_cubic` decimal(10,2) DEFAULT NULL,
  `service_fee` decimal(10,2) DEFAULT NULL,
  `effective_year` int DEFAULT NULL,
  PRIMARY KEY (`rate_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `water_rates`
--

LOCK TABLES `water_rates` WRITE;
/*!40000 ALTER TABLE `water_rates` DISABLE KEYS */;
INSERT INTO `water_rates` VALUES (1,33.25,50.00,2026);
/*!40000 ALTER TABLE `water_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `water_readings`
--

DROP TABLE IF EXISTS `water_readings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `water_readings` (
  `reading_id` int NOT NULL AUTO_INCREMENT,
  `water_meter_id` int DEFAULT NULL,
  `month` int DEFAULT NULL,
  `year` int DEFAULT NULL,
  `previous_m3` decimal(10,2) DEFAULT NULL,
  `current_m3` decimal(10,2) DEFAULT NULL,
  `encoded_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`reading_id`),
  UNIQUE KEY `water_meter_id` (`water_meter_id`,`month`,`year`),
  KEY `fk_water_readings_encoded_by` (`encoded_by`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `water_readings`
--

LOCK TABLES `water_readings` WRITE;
/*!40000 ALTER TABLE `water_readings` DISABLE KEYS */;
INSERT INTO `water_readings` VALUES (1,1,1,2026,120.00,150.00,NULL);
/*!40000 ALTER TABLE `water_readings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `water_tax`
--

DROP TABLE IF EXISTS `water_tax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `water_tax` (
  `water_tax_id` int NOT NULL AUTO_INCREMENT,
  `tax_id` int DEFAULT NULL,
  `tax_rate` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`water_tax_id`),
  KEY `tax_id` (`tax_id`),
  CONSTRAINT `water_tax_ibfk_1` FOREIGN KEY (`tax_id`) REFERENCES `tax` (`tax_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `water_tax`
--

LOCK TABLES `water_tax` WRITE;
/*!40000 ALTER TABLE `water_tax` DISABLE KEYS */;
INSERT INTO `water_tax` VALUES (1,1,12.00),(2,2,3.00);
/*!40000 ALTER TABLE `water_tax` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-22 19:20:19
