-- phpMyAdmin SQL Dump
-- version 4.8.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 09, 2018 at 08:10 PM
-- Server version: 10.1.33-MariaDB
-- PHP Version: 7.2.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `games`
--

-- --------------------------------------------------------

--
-- Table structure for table `developer`
--

CREATE TABLE `developer` (
  `developerID` int(11) NOT NULL,
  `companyName` varchar(50) COLLATE utf8_slovenian_ci NOT NULL,
  `website` varchar(50) COLLATE utf8_slovenian_ci NOT NULL,
  `contactEmail` varchar(50) COLLATE utf8_slovenian_ci NOT NULL,
  `stateID` int(11) NOT NULL,
  `numOfEmployees` int(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovenian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `favourite`
--

CREATE TABLE `favourite` (
  `favouriteID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `gameID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovenian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `game`
--

CREATE TABLE `game` (
  `gameID` int(11) NOT NULL,
  `image` varchar(500) NOT NULL,
  `video` varchar(500),
  `genreID` int(11) NOT NULL,
  `platformID` int(11) NOT NULL,
  `developerID` int(11) NOT NULL,
  `typeID` int(11) NOT NULL,
  `gameName` varchar(50) COLLATE utf8_slovenian_ci NOT NULL,
  `description` varchar(200) COLLATE utf8_slovenian_ci NOT NULL,
  `price` double NOT NULL,
  `releaseDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovenian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gamegenre`
--

CREATE TABLE `gamegenre` (
  `genreID` int(11) NOT NULL,
  `genreName` varchar(50) COLLATE utf8_slovenian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovenian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gametype`
--

CREATE TABLE `gametype` (
  `typeID` int(11) NOT NULL,
  `typeName` varchar(50) COLLATE utf8_slovenian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovenian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gender`
--

CREATE TABLE `gender` (
  `genderID` int(11) NOT NULL,
  `genderName` varchar(1) COLLATE utf8_slovenian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovenian_ci;

--
-- Dumping data for table `gender`
--

INSERT INTO `gender` (`genderID`, `genderName`) VALUES
(1, 'M'),
(2, 'F');

-- --------------------------------------------------------

--
-- Table structure for table `platforms`
--

CREATE TABLE `platforms` (
  `platformID` int(11) NOT NULL,
  `platformName` varchar(50) COLLATE utf8_slovenian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovenian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `reviewID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `stars` int(5) NOT NULL,
  `descrption` varchar(50) COLLATE utf8_slovenian_ci NOT NULL,
  `gameID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovenian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `roleID` int(11) NOT NULL,
  `roleName` varchar(50) COLLATE utf8_slovenian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovenian_ci;

-- --------------------------------------------------------

--
-- Dumping data for table `role`
--
INSERT INTO `role` (`roleID`, `roleName`) VALUES
(1, 'admin'),
(2, 'defaultUser');

--
-- Table structure for table `state`
--

CREATE TABLE `state` (
  `stateID` int(11) NOT NULL,
  `stateName` varchar(50) COLLATE utf8_slovenian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovenian_ci;

--
-- Dumping data for table `state`
--

INSERT INTO `state` (`stateID`, `stateName`) VALUES
(1, 'Other'),
(2, 'Afghanistan'),
(3, 'Albania'),
(4, 'Andorra'),
(5, 'Angola'),
(6, 'Anguilla'),
(7, 'Antigua and Barbuda'),
(8, 'Argentina'),
(9, 'Armenia'),
(10, 'Australia'),
(11, 'Austria'),
(12, 'Azerbaijan'),
(13, 'Bahamas'),
(14, 'Bahrain'),
(15, 'Bangladesh'),
(16, 'Barbados'),
(17, 'Belarus'),
(18, 'Belgium'),
(19, 'Belize'),
(20, 'Benin'),
(21, 'Bermuda'),
(22, 'Bhutan'),
(23, 'Bolivia'),
(24, 'Bosnia and Herzegovina'),
(25, 'Botswana'),
(26, 'Brazil'),
(27, 'Brunei Darussalam'),
(28, 'Bulgaria'),
(29, 'Burkina Faso'),
(30, 'Myanmar'),
(31, 'Burundi'),
(32, 'Cambodia'),
(33, 'Cameroon'),
(34, 'Canada'),
(35, 'Cape Verde'),
(36, 'Cayman Islands'),
(37, 'Central African Republic'),
(38, 'Chad'),
(39, 'Chile'),
(40, 'China'),
(41, 'Colombia'),
(42, 'Comoros'),
(43, 'Congo'),
(44, 'Costa Rica'),
(45, 'Croatia'),
(46, 'Cuba'),
(47, 'Cyprus'),
(48, 'Czech Republic'),
(49, 'DR of Congo'),
(50, 'Denmark'),
(51, 'Djibouti'),
(52, 'Dominica'),
(53, 'Dominican Republic'),
(54, 'Ecuador'),
(55, 'Egypt'),
(56, 'El Salvador'),
(57, 'Equatorial Guinea'),
(58, 'Eritrea'),
(59, 'Estonia'),
(60, 'Ethiopia'),
(61, 'Fiji'),
(62, 'Finland'),
(63, 'France'),
(64, 'French Guiana'),
(65, 'Gabon'),
(66, 'Gambia'),
(67, 'Georgia'),
(68, 'Germany'),
(69, 'Ghana'),
(70, 'Great Britain'),
(71, 'Greece'),
(72, 'Grenada'),
(73, 'Guadeloupe'),
(74, 'Guatemala'),
(75, 'Guinea'),
(76, 'Guinea-Bissau'),
(77, 'Guyana'),
(78, 'Haiti'),
(79, 'Honduras'),
(80, 'Hungary'),
(81, 'Iceland'),
(82, 'India'),
(83, 'Indonesia'),
(84, 'Iran'),
(85, 'Iraq'),
(86, 'Israel'),
(87, 'Italy'),
(88, 'Ivory Coast'),
(89, 'Jamaica'),
(90, 'Japan'),
(91, 'Jordan'),
(92, 'Kazakhstan'),
(93, 'Kenya'),
(94, 'Kuwait'),
(95, 'Kyrgyzstan'),
(96, 'Laos'),
(97, 'Latvia'),
(98, 'Lebanon'),
(99, 'Lesotho'),
(100, 'Liberia'),
(101, 'Libya'),
(102, 'Liechtenstein'),
(103, 'Lithuania'),
(104, 'Luxembourg'),
(105, 'Republic of Macedonia'),
(106, 'Madagascar'),
(107, 'Malawi'),
(108, 'Malaysia'),
(109, 'Maldives'),
(110, 'Mali'),
(111, 'Malta'),
(112, 'Martinique'),
(113, 'Mauritania'),
(114, 'Mauritius'),
(115, 'Mayotte'),
(116, 'Mexico'),
(117, 'Moldova'),
(118, 'Monaco'),
(119, 'Mongolia'),
(120, 'Montenegro'),
(121, 'Montserrat'),
(122, 'Morocco'),
(123, 'Mozambique'),
(124, 'Namibia'),
(125, 'Nepal'),
(126, 'Netherlands'),
(127, 'New Zealand'),
(128, 'Nicaragua'),
(129, 'Niger'),
(130, 'Nigeria'),
(131, 'North Korea'),
(132, 'Norway'),
(133, 'Oman'),
(134, 'Pacific Islands'),
(135, 'Pakistan'),
(136, 'Panama'),
(137, 'Papua New Guinea'),
(138, 'Paraguay'),
(139, 'Peru'),
(140, 'Philippines'),
(141, 'Poland'),
(142, 'Portugal'),
(143, 'Puerto Rico'),
(144, 'Qatar'),
(145, 'Reunion'),
(146, 'Romania'),
(147, 'Russian Federation'),
(148, 'Rwanda'),
(149, 'Saint Kitts and Nevis'),
(150, 'Saint Lucia'),
(151, 'Saint Vincent'),
(152, 'Samoa'),
(153, 'Sao Tome and Principe'),
(154, 'Saudi Arabia'),
(155, 'Senegal'),
(156, 'Serbia'),
(157, 'Seychelles'),
(158, 'Sierra Leone'),
(159, 'Singapore'),
(160, 'Slovakia'),
(161, 'Slovenia'),
(162, 'Solomon Islands'),
(163, 'Somalia'),
(164, 'South Africa'),
(165, 'South Korea'),
(166, 'South Sudan'),
(167, 'Spain'),
(168, 'Sri Lanka'),
(169, 'Sudan'),
(170, 'Suriname'),
(171, 'Swaziland'),
(172, 'Sweden'),
(173, 'Switzerland'),
(174, 'Syria'),
(175, 'Tajikistan'),
(176, 'Tanzania'),
(177, 'Thailand'),
(178, 'Timor Leste'),
(179, 'Togo'),
(180, 'Trinidad and Tobago'),
(181, 'Tunisia'),
(182, 'Turkey'),
(183, 'Turkmenistan'),
(184, 'Turks and Caicos Islands'),
(185, 'Uganda'),
(186, 'Ukraine'),
(187, 'United Arab Emirates'),
(188, 'United States of America'),
(189, 'Uruguay'),
(190, 'Uzbekistan'),
(191, 'Venezuela'),
(192, 'Vietnam'),
(193, 'Virgin Islands (UK)'),
(194, 'Virgin Islands (US)'),
(195, 'Yemen'),
(196, 'Zambia'),
(197, 'Zimbabwe');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `userID` int(11) NOT NULL,
  `roleID` int(11) NOT NULL,
  `firstName` varchar(50) COLLATE utf8_slovenian_ci NOT NULL,
  `lastName` varchar(50) COLLATE utf8_slovenian_ci NOT NULL,
  `image` varchar(500) COLLATE utf8_slovenian_ci NOT NULL,
  `birthDate` date NOT NULL,
  `genderID` int(11) NOT NULL,
  `email` varchar(50) COLLATE utf8_slovenian_ci NOT NULL,
  `username` varchar(50) COLLATE utf8_slovenian_ci NOT NULL,
  `password` varchar(50) COLLATE utf8_slovenian_ci NOT NULL,
  `stateID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovenian_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `developer`
--
ALTER TABLE `developer`
  ADD PRIMARY KEY (`developerID`),
  ADD KEY `Developer_fk0` (`stateID`);

--
-- Indexes for table `favourite`
--
ALTER TABLE `favourite`
  ADD PRIMARY KEY (`favouriteID`),
  ADD KEY `Favourite_fk0` (`userID`),
  ADD KEY `Favourite_fk1` (`gameID`);

--
-- Indexes for table `game`
--
ALTER TABLE `game`
  ADD PRIMARY KEY (`gameID`),
  ADD KEY `Game_fk0` (`genreID`),
  ADD KEY `Game_fk1` (`platformID`),
  ADD KEY `Game_fk2` (`developerID`),
  ADD KEY `Game_fk3` (`typeID`);

--
-- Indexes for table `gamegenre`
--
ALTER TABLE `gamegenre`
  ADD PRIMARY KEY (`genreID`);

--
-- Indexes for table `gametype`
--
ALTER TABLE `gametype`
  ADD PRIMARY KEY (`typeID`);

--
-- Indexes for table `gender`
--
ALTER TABLE `gender`
  ADD PRIMARY KEY (`genderID`);

--
-- Indexes for table `platforms`
--
ALTER TABLE `platforms`
  ADD PRIMARY KEY (`platformID`);

--
-- Indexes for table `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`reviewID`),
  ADD KEY `Review_fk0` (`userID`),
  ADD KEY `Review_fk1` (`gameID`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`roleID`);

--
-- Indexes for table `state`
--
ALTER TABLE `state`
  ADD PRIMARY KEY (`stateID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`userID`),
  ADD KEY `User_fk0` (`roleID`),
  ADD KEY `User_fk1` (`genderID`),
  ADD KEY `User_fk2` (`stateID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `developer`
--
ALTER TABLE `developer`
  MODIFY `developerID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `favourite`
--
ALTER TABLE `favourite`
  MODIFY `favouriteID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `game`
--
ALTER TABLE `game`
  MODIFY `gameID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gamegenre`
--
ALTER TABLE `gamegenre`
  MODIFY `genreID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gametype`
--
ALTER TABLE `gametype`
  MODIFY `typeID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gender`
--
ALTER TABLE `gender`
  MODIFY `genderID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `platforms`
--
ALTER TABLE `platforms`
  MODIFY `platformID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `review`
--
ALTER TABLE `review`
  MODIFY `reviewID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `roleID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `state`
--
ALTER TABLE `state`
  MODIFY `stateID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=198;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `userID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `developer`
--
ALTER TABLE `developer`
  ADD CONSTRAINT `Developer_fk0` FOREIGN KEY (`stateID`) REFERENCES `state` (`stateID`);


--
-- Constraints for table `favourite`
--
ALTER TABLE `favourite`
  ADD CONSTRAINT `Favourite_fk0` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`),
  ADD CONSTRAINT `Favourite_fk1` FOREIGN KEY (`gameID`) REFERENCES `game` (`gameID`);

--
-- Constraints for table `game`
--
ALTER TABLE `game`
  ADD CONSTRAINT `Game_fk0` FOREIGN KEY (`genreID`) REFERENCES `gamegenre` (`genreID`),
  ADD CONSTRAINT `Game_fk1` FOREIGN KEY (`platformID`) REFERENCES `platforms` (`platformID`),
  ADD CONSTRAINT `Game_fk2` FOREIGN KEY (`developerID`) REFERENCES `developer` (`developerID`),
  ADD CONSTRAINT `Game_fk3` FOREIGN KEY (`typeID`) REFERENCES `gametype` (`typeID`);

--
-- Constraints for table `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `Review_fk0` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`),
  ADD CONSTRAINT `Review_fk1` FOREIGN KEY (`gameID`) REFERENCES `game` (`gameID`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `User_fk0` FOREIGN KEY (`roleID`) REFERENCES `role` (`roleID`),
  ADD CONSTRAINT `User_fk1` FOREIGN KEY (`genderID`) REFERENCES `gender` (`genderID`),
  ADD CONSTRAINT `User_fk2` FOREIGN KEY (`stateID`) REFERENCES `state` (`stateID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
