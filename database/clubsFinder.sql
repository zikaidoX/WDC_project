-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: localhost    Database: clubsFinder
-- ------------------------------------------------------
-- Server version	8.0.32-0ubuntu0.22.04.2

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
-- Current Database: `clubsFinder`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `clubsFinder` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `clubsFinder`;

--
-- Table structure for table `Attendance`
--

DROP TABLE IF EXISTS `Attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Attendance` (
  `event_id` int NOT NULL,
  `user_id` int NOT NULL,
  `rsvp_status` int DEFAULT NULL,
  PRIMARY KEY (`user_id`,`event_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `Attendance_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`),
  CONSTRAINT `Attendance_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `Events` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Attendance`
--

LOCK TABLES `Attendance` WRITE;
/*!40000 ALTER TABLE `Attendance` DISABLE KEYS */;
/*!40000 ALTER TABLE `Attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Club_Posts`
--

DROP TABLE IF EXISTS `Club_Posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Club_Posts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `content` text,
  `club_id` int DEFAULT NULL,
  `is_public` bit(1) DEFAULT b'1',
  PRIMARY KEY (`id`),
  KEY `club_id` (`club_id`),
  CONSTRAINT `Club_Posts_ibfk_1` FOREIGN KEY (`club_id`) REFERENCES `Clubs` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Club_Posts`
--

LOCK TABLES `Club_Posts` WRITE;
/*!40000 ALTER TABLE `Club_Posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `Club_Posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Clubs`
--

DROP TABLE IF EXISTS `Clubs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Clubs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `club_name` varchar(30) DEFAULT NULL,
  `club_bio` varchar(255) DEFAULT NULL,
  `logo_image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Clubs`
--

LOCK TABLES `Clubs` WRITE;
/*!40000 ALTER TABLE `Clubs` DISABLE KEYS */;
/*!40000 ALTER TABLE `Clubs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Events`
--

DROP TABLE IF EXISTS `Events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Events` (
  `id` int NOT NULL AUTO_INCREMENT,
  `club_id` int DEFAULT NULL,
  `event_name` varchar(30) DEFAULT NULL,
  `event_description` varchar(200) DEFAULT NULL,
  `event_start_time` datetime DEFAULT NULL,
  `event_end_time` datetime DEFAULT NULL,
  `event_location` varchar(50) DEFAULT NULL,
  `public_or_private` bit(1) DEFAULT b'1',
  PRIMARY KEY (`id`),
  KEY `club_id` (`club_id`),
  CONSTRAINT `Events_ibfk_1` FOREIGN KEY (`club_id`) REFERENCES `Clubs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Events`
--

LOCK TABLES `Events` WRITE;
/*!40000 ALTER TABLE `Events` DISABLE KEYS */;
/*!40000 ALTER TABLE `Events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Memberships`
--

DROP TABLE IF EXISTS `Memberships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Memberships` (
  `user_id` int NOT NULL,
  `club_id` int NOT NULL,
  `is_manager` bit(1) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`club_id`),
  KEY `club_id` (`club_id`),
  CONSTRAINT `Memberships_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`),
  CONSTRAINT `Memberships_ibfk_2` FOREIGN KEY (`club_id`) REFERENCES `Clubs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Memberships`
--

LOCK TABLES `Memberships` WRITE;
/*!40000 ALTER TABLE `Memberships` DISABLE KEYS */;
/*!40000 ALTER TABLE `Memberships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Post_Comments`
--

DROP TABLE IF EXISTS `Post_Comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Post_Comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `content` text,
  `user_id` int DEFAULT NULL,
  `post_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `Post_Comments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `Post_Comments_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `Club_Posts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Post_Comments`
--

LOCK TABLES `Post_Comments` WRITE;
/*!40000 ALTER TABLE `Post_Comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `Post_Comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Post_Likes`
--

DROP TABLE IF EXISTS `Post_Likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Post_Likes` (
  `user_id` int NOT NULL,
  `post_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`post_id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `Post_Likes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`),
  CONSTRAINT `Post_Likes_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `Club_Posts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Post_Likes`
--

LOCK TABLES `Post_Likes` WRITE;
/*!40000 ALTER TABLE `Post_Likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `Post_Likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(20) DEFAULT NULL,
  `last_name` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `pass` varchar(255) DEFAULT NULL,
  `about_bio` varchar(255) DEFAULT NULL,
  `is_admin` bit(1) DEFAULT b'0',
  `is_manager` bit(1) DEFAULT b'0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


/*Fill database with data for login test - all passwords are '12345'*/
INSERT INTO `Users` VALUES (1,'Dylan','Nguyen','dnguyen@email.com','$argon2id$v=19$m=65536,t=3,p=4$blKmLTBk4xqMmhoILDXJXA$40ITo1pvbGQDwbonqOUIo2aiJAEk11LPoab1p3jciVE',NULL, 1 , 1),(2,'Nhut','Kien','nkien@email.com','$argon2id$v=19$m=65536,t=3,p=4$vQNKWs6MiDTAd5TO4VWBrQ$r8d32cTUHpI6gc66bpvtfd8RSUp8JNvH1F+xGJwjmqM',NULL, 1, 1),(3,'Mia','Lee','mlee@email.com','$argon2id$v=19$m=65536,t=3,p=4$DULCLSLLQFMkIMGtsKKfZA$eWGInY8cB57h04VAD8EsYmZSwA71xe8oJ/UEMOLqgJ0',NULL, 0, 1),(4,'Minh','Dang','tmdang@email.com','$argon2id$v=19$m=65536,t=3,p=4$oKXEUoPlCHGO/YRDJFv5uw$MG6OkbR/PGCehxuGE6gE5EbfcofxcaDVl6srQdT9pho',NULL, 0, 0),(5,'Phil','Nguyen','pnguyen@email.com','$argon2id$v=19$m=65536,t=3,p=4$0HuVLpxq+GRQWHyk5ekg8g$jfvBBMBN2tJzirZfQ68BXaNKqtMyzShcorHiQxle9F8',NULL,_binary '\0',_binary '\0'),(6,'Kim','Wright','kwright@email.com','$argon2id$v=19$m=65536,t=3,p=4$OTj1dhRKmsGoJ2UiQldTsg$yiwo9mqpUi2kOyfRKwVefk8yZ51MDsENp0uaroqKOf4',NULL,_binary '\0',_binary '\0'),(7,'Stacy','Smith','ssmith@email.com','$argon2id$v=19$m=65536,t=3,p=4$fpJsfcS0/dYo1SSxrF8bjA$UikLsQwxG7Wo01Gkqtiq3LCNybEMPk7R7SOiq3OO4wI',NULL,_binary '\0',_binary '\0'),(8,'Michael','Smith','msmith@email.com','$argon2id$v=19$m=65536,t=3,p=4$qDOI1gfiiPjV8jKwqcYl1w$k/m7NvI0IH00x1bnuu9/AMrJcO0xugd40qGS1T4HAuQ',NULL,_binary '\0',_binary '\0'),(10,'Michael','Johnson','mjohnson@email.com','$argon2id$v=19$m=65536,t=3,p=4$gyaBHROpnxPFxda3Z73rkw$YA6iMP5VUtY2Gr+nMlqsR+mdOb+BuhiaTJTKMwgrjYs',NULL,_binary '\0',_binary '\0'),(11,'Bao','Nguyen','bnguyen@email.com','$argon2id$v=19$m=65536,t=3,p=4$xzRBboFL/recR2/RQv0GHg$qLvsDEX03Kogae8qMqJXQ/yC3VWP9gUK1L541ehtu+Q',NULL,_binary '\0',_binary '\0'),(12,'Miku','Hatsune','miku@email.com','$argon2id$v=19$m=65536,t=3,p=4$lJgitj5xgnvRSfAP+SolMg$9KqbAZOZ77pLCRjF4U0bHFRWy+3pTDXImcQpla0SBIk',NULL,_binary '\0',_binary '\0'),(13,'Amelia','Watson','watoto@email.com','$argon2id$v=19$m=65536,t=3,p=4$QX2plL4j+cHnTQCUG/jPlQ$CrhAHDRvz/NMI9/maBUrTdO0O/fPsbE7HO/MbtSZulA',NULL,_binary '\0',_binary '\0');

INSERT INTO Clubs VALUES (1, "Computer Science Club", NULL, NULL ),
(2, "Engineering Club", NULL, NULL ),
(3, "Business Club", NULL, NULL ),
(4, "Anime Club", NULL, NULL ),
(5, "Mathematics Club", NULL, NULL ),
(6, "Mechanical Keyboard Club", NULL, NULL ),
(7, "Drawing Club", NULL, NULL),
(8, "WISTEMS", NULL, NULL),
(9, "Fashion Club", NULL, NULL),
(10, "Competitive Coding Club", NULL, NULL);

INSERT INTO Memberships VALUES (2, 1, 0),
(2, 4, 0),
(3, 2, 0),
(3, 4, 1),
(5, 1, 1),
(1, 2, 0);

INSERT INTO Club_Posts VALUES (1, '2023-02-15 12:30:00', 'We have the first post. We are the Computer Science club, a student run club for people interested in computer science and computing in general.', 1, 1),
(2, '2023-02-15 15:34:00', 'We are the Business Club, a respresentative body for all business students providing a wide range of services to its members. Come join us now!', 3, 1),
(3, '2023-02-17 10:00:00', 'To all current members, the Duck Lounge right now is open. Come in anytime to ask for help or just hangout.', 1, 0),
(4, '2023-02-17 11:30:00', 'Engineering is fun', 2, 1),
(5, '2023-02-20 16:56:00', 'ATTENTION WEEBS ! Here is out anime lineup for Semester 1 2023!\n 1. Akiba Maid Wars\n 2. Fruits Basket\n 3. Lycoris Recoil\n Can''t wait to see you all :)', 4, 1),
(6, '2023-02-20 18:00:00', 'Welcome to out ClubsFinder page. We are the Fashion Club and we specialise in all things fashion.', 9, 1),
(7, '2023-02-15 04:34:33', 'Out semester meetup is coming in two days. Please make sure you purchase your tickets', 6, 0);

