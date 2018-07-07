CREATE TABLE `Role` (
	`roleID` int NOT NULL,
	`roleName` varchar(50) NOT NULL,
	PRIMARY KEY (`roleID`)
);

CREATE TABLE `Platforms` (
	`platformID` int NOT NULL,
	`platformName` varchar(50) NOT NULL,
	PRIMARY KEY (`platformID`)
);

CREATE TABLE `GameGenre` (
	`genreID` int NOT NULL,
	`genreName` varchar(50) NOT NULL,
	PRIMARY KEY (`genreID`)
);

CREATE TABLE `Developer` (
	`developerID` int NOT NULL,
	`companyName` varchar(50) NOT NULL,
	`website` varchar(50) NOT NULL,
	`contactEmail` varchar(50) NOT NULL,
	PRIMARY KEY (`developerID`)
);

CREATE TABLE `User` (
	`userID` int NOT NULL,
	`roleID` int NOT NULL,
	`firstName` varchar(50) NOT NULL,
	`lastName` varchar(50) NOT NULL,
	`email` varchar(50) NOT NULL,
	`username` varchar(50) NOT NULL,
	`password` varchar(50) NOT NULL,
	PRIMARY KEY (`userID`)
);

CREATE TABLE `Review` (
	`reviewID` int NOT NULL,
	`userID` int NOT NULL,
	`stars` int NOT NULL,
	`descrption` varchar(50) NOT NULL,
	PRIMARY KEY (`reviewID`)
);

CREATE TABLE `Game` (
	`gameID` int NOT NULL,
	`genreID` int NOT NULL,
	`platformID` int NOT NULL,
	`developerID` int NOT NULL,
	`typeID` int NOT NULL,
	`reviewID` int NOT NULL,
	`gameName` varchar(50) NOT NULL,
	`description` varchar(200) NOT NULL,
	`price` double NOT NULL,
	`releaseDate` DATE NOT NULL,
	PRIMARY KEY (`gameID`)
);

CREATE TABLE `Favourite` (
	`favouriteID` int NOT NULL,
	`userID` int NOT NULL,
	`gameID` int NOT NULL,
	PRIMARY KEY (`favouriteID`)
);

CREATE TABLE `GameType` (
	`typeID` int NOT NULL,
	`typeName` varchar(50) NOT NULL,
	PRIMARY KEY (`typeID`)
);

ALTER TABLE `User` ADD CONSTRAINT `User_fk0` FOREIGN KEY (`roleID`) REFERENCES `Role`(`roleID`);

ALTER TABLE `Review` ADD CONSTRAINT `Review_fk0` FOREIGN KEY (`userID`) REFERENCES `User`(`userID`);

ALTER TABLE `Game` ADD CONSTRAINT `Game_fk0` FOREIGN KEY (`genreID`) REFERENCES `GameGenre`(`genreID`);

ALTER TABLE `Game` ADD CONSTRAINT `Game_fk1` FOREIGN KEY (`platformID`) REFERENCES `Platforms`(`platformID`);

ALTER TABLE `Game` ADD CONSTRAINT `Game_fk2` FOREIGN KEY (`developerID`) REFERENCES `Developer`(`developerID`);

ALTER TABLE `Game` ADD CONSTRAINT `Game_fk3` FOREIGN KEY (`typeID`) REFERENCES `GameType`(`typeID`);

ALTER TABLE `Favourite` ADD CONSTRAINT `Favourite_fk0` FOREIGN KEY (`userID`) REFERENCES `User`(`userID`);

ALTER TABLE `Favourite` ADD CONSTRAINT `Favourite_fk1` FOREIGN KEY (`gameID`) REFERENCES `Game`(`gameID`);
