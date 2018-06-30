/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50721
 Source Host           : localhost:3306
 Source Schema         : igrice

 Target Server Type    : MySQL
 Target Server Version : 50721
 File Encoding         : 65001

 Date: 01/07/2018 01:49:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for developer
-- ----------------------------
DROP TABLE IF EXISTS `developer`;
CREATE TABLE `developer`  (
  `developerID` int(11) NOT NULL AUTO_INCREMENT,
  `companyName` varchar(50) CHARACTER SET utf8 COLLATE utf8_slovenian_ci NOT NULL,
  `website` varchar(50) CHARACTER SET utf8 COLLATE utf8_slovenian_ci NOT NULL,
  `contactEmail` varchar(50) CHARACTER SET utf8 COLLATE utf8_slovenian_ci NOT NULL,
  PRIMARY KEY (`developerID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_slovenian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for favourites
-- ----------------------------
DROP TABLE IF EXISTS `favourites`;
CREATE TABLE `favourites`  (
  `favouriteID` int(11) NOT NULL AUTO_INCREMENT,
  `gameID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  PRIMARY KEY (`favouriteID`) USING BTREE,
  INDEX `game`(`gameID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_slovenian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for game
-- ----------------------------
DROP TABLE IF EXISTS `game`;
CREATE TABLE `game`  (
  `gameID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_slovenian_ci NOT NULL,
  `genreID` int(11) NOT NULL,
  `platformID` int(11) NOT NULL,
  `developerID` int(11) NOT NULL,
  `reviewID` int(11) NOT NULL,
  `releaseDate` datetime(0) NOT NULL,
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_slovenian_ci NOT NULL,
  `price` double(10, 2) NOT NULL,
  PRIMARY KEY (`gameID`) USING BTREE,
  INDEX `gamegenre`(`genreID`) USING BTREE,
  INDEX `platforms`(`platformID`) USING BTREE,
  INDEX `developer`(`developerID`) USING BTREE,
  INDEX `review`(`reviewID`) USING BTREE,
  INDEX `gameID`(`gameID`, `name`) USING BTREE,
  CONSTRAINT `developer` FOREIGN KEY (`developerID`) REFERENCES `developer` (`developerID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `gamegenre` FOREIGN KEY (`genreID`) REFERENCES `gamegenre` (`genreID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `platforms` FOREIGN KEY (`platformID`) REFERENCES `platforms` (`platformID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `review` FOREIGN KEY (`reviewID`) REFERENCES `review` (`reviewID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_slovenian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for gamegenre
-- ----------------------------
DROP TABLE IF EXISTS `gamegenre`;
CREATE TABLE `gamegenre`  (
  `genreID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_slovenian_ci NOT NULL,
  `typeID` int(11) NOT NULL,
  PRIMARY KEY (`genreID`) USING BTREE,
  INDEX `gametype`(`typeID`) USING BTREE,
  CONSTRAINT `gametype` FOREIGN KEY (`typeID`) REFERENCES `gametype` (`typeID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_slovenian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for gametype
-- ----------------------------
DROP TABLE IF EXISTS `gametype`;
CREATE TABLE `gametype`  (
  `typeID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_slovenian_ci NOT NULL,
  PRIMARY KEY (`typeID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_slovenian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for platforms
-- ----------------------------
DROP TABLE IF EXISTS `platforms`;
CREATE TABLE `platforms`  (
  `platformID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_slovenian_ci NOT NULL,
  PRIMARY KEY (`platformID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_slovenian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for review
-- ----------------------------
DROP TABLE IF EXISTS `review`;
CREATE TABLE `review`  (
  `userID` int(11) NOT NULL AUTO_INCREMENT,
  `reviewID` int(11) NOT NULL,
  `stars` int(2) NOT NULL,
  `description` varchar(150) CHARACTER SET utf8 COLLATE utf8_slovenian_ci NOT NULL,
  PRIMARY KEY (`userID`) USING BTREE,
  INDEX `reviewID`(`reviewID`) USING BTREE,
  CONSTRAINT `user` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_slovenian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `roleID` int(11) NOT NULL AUTO_INCREMENT,
  `roleName` varchar(50) CHARACTER SET utf8 COLLATE utf8_slovenian_ci NOT NULL,
  PRIMARY KEY (`roleID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_slovenian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `userID` int(11) NOT NULL AUTO_INCREMENT,
  `roleID` int(11) NOT NULL,
  `firstName` varchar(50) CHARACTER SET utf8 COLLATE utf8_slovenian_ci NOT NULL,
  `lastName` varchar(50) CHARACTER SET utf8 COLLATE utf8_slovenian_ci NOT NULL,
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_slovenian_ci NOT NULL,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_slovenian_ci NOT NULL,
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_slovenian_ci NOT NULL,
  PRIMARY KEY (`userID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_slovenian_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
