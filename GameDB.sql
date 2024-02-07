/* Diablobase Wizards - CSC 430/530 Database Theory project - Su23
   Alex Frederick - Sunzid Hassan - Yead Rahman - Trey Thomas 		*/

# SQL DDL COMMANDS
# Run these to create the database schema and populate with some data
# check out line 193 for queries and things

CREATE DATABASE  IF NOT EXISTS `GameDB`;
USE `GameDB`;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

DROP TABLE IF EXISTS `ability`;
CREATE TABLE `ability` (
  `abilityName` varchar(15) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `manaCost` int DEFAULT NULL,
  `characterID` varchar(45) NOT NULL,
  PRIMARY KEY (`abilityName`),
  KEY `ability_foreign_fk_idx` (`characterID`),
  CONSTRAINT `ability_foreign_fk` FOREIGN KEY (`characterID`) REFERENCES `charactr` (`characterID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS `adventure_party`;
CREATE TABLE `adventure_party` (
  `partyLeader` varchar(15) NOT NULL,
  `partyName` varchar(45) NOT NULL,
  `questName` varchar(45) NOT NULL,
  `area` varchar(10) NOT NULL,
  `characterID` varchar(45) NOT NULL,
  PRIMARY KEY (`characterID`,`questName`),
  KEY `adven_quest_idx` (`questName`),
  KEY `adven_area_fk_idx` (`area`),
  KEY `adven_leader_fk_idx` (`characterID`),
  CONSTRAINT `adven_leader_fk` FOREIGN KEY (`characterID`) REFERENCES `charactr` (`characterID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS `charactr`;
CREATE TABLE `charactr` (
  `characterID` varchar(15) NOT NULL,
  `playerID` varchar(15) NOT NULL,
  `class` varchar(15) DEFAULT NULL,
  `level` int DEFAULT NULL,
  `experience` int DEFAULT NULL,
  `strength` int DEFAULT NULL,
  `agility` int DEFAULT NULL,
  `intelligence` int DEFAULT NULL,
  `armorClass` int DEFAULT NULL,
  `hitPoints` int DEFAULT NULL,
  `mana` int DEFAULT NULL,
  `area` varchar(45) DEFAULT NULL,
  `totalGold` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`characterID`),
  KEY `char_playerID_fk_idx` (`playerID`),
  KEY `char_coord_fk_idx` (`area`),
  CONSTRAINT `char_playerID_fk` FOREIGN KEY (`playerID`) REFERENCES `player` (`playerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS `creature`;
CREATE TABLE `creature` (
  `creatureName` varchar(15) NOT NULL,
  `strength` varchar(45) DEFAULT NULL,
  `weakness` varchar(45) DEFAULT NULL,
  `xpWorth` int DEFAULT NULL,
  `area` varchar(100) DEFAULT NULL,
  `new_area` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`creatureName`),
  KEY `creat_coor_fk_idx` (`area`),
  KEY `creat_coor_fk` (`new_area`),
  CONSTRAINT `creat_coor_fk` FOREIGN KEY (`new_area`) REFERENCES `location` (`area`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS `inventory`;
CREATE TABLE `inventory` (
  `itemName` varchar(15) NOT NULL,
  `characterID` varchar(15) NOT NULL,
  `quantity` int DEFAULT NULL,
  `damage` int DEFAULT NULL,
  `acBonus` int DEFAULT NULL,
  `effects` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`itemName`,`characterID`),
  KEY `inven_charc_fk_idx` (`characterID`),
  CONSTRAINT `inven_charc_fk` FOREIGN KEY (`characterID`) REFERENCES `charactr` (`characterID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS `location`;
CREATE TABLE `location` (
  `area` varchar(100) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `temp_area` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`area`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS `mage`;
CREATE TABLE `mage` (
  `characterID` varchar(15) NOT NULL,
  `MagicPwr` int DEFAULT NULL,
  `magicResist` int DEFAULT NULL,
  `spellName` varchar(50) DEFAULT NULL,
  KEY `mage_char_fk_idx` (`characterID`),
  CONSTRAINT `mage_char_fk` FOREIGN KEY (`characterID`) REFERENCES `charactr` (`characterID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS `player`;
CREATE TABLE `player` (
  `playerID` varchar(15) NOT NULL,
  `userName` varchar(15) NOT NULL,
  `password` varchar(10) NOT NULL,
  PRIMARY KEY (`playerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS `quest`;
CREATE TABLE `quest` (
  `description` varchar(200) DEFAULT NULL,
  `experienceBonus` int DEFAULT NULL,
  `rewards` int DEFAULT NULL,
  `questName` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='	';

DROP TABLE IF EXISTS `rogue`;
CREATE TABLE `rogue` (
  `characterID` varchar(15) NOT NULL,
  `agilityBonus` int DEFAULT NULL,
  `stealthBonus` int DEFAULT NULL,
  KEY `rog_char_fk` (`characterID`),
  CONSTRAINT `rog_char_fk` FOREIGN KEY (`characterID`) REFERENCES `charactr` (`characterID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS `warrior`;
CREATE TABLE `warrior` (
  `characterID` varchar(15) NOT NULL,
  `attackBonus` int DEFAULT NULL,
  `armorBonus` int DEFAULT NULL,
  KEY `war_char_fk` (`characterID`),
  CONSTRAINT `war_char_fk` FOREIGN KEY (`characterID`) REFERENCES `charactr` (`characterID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


# SQL DML COMMANDS
# ! DATA LOADING DONE HERE. NOT FROM DATA FILES. !

LOCK TABLES `ability` WRITE;
INSERT INTO `ability` VALUES ('Fireball','Casts a powerful fireball at the target',20,'Gandalf'),('Fog of War','Conjures a magical fog that obscures vision',15,'Merlin'),('Heal','Restores HP to a target or self',25,'Merlin'),('Power Strike','Unleashes a powerful melee attack',15,'Aragorn'),('Shadow Step','Allows the character to move quickly and avoid attacks. Provides a short burst of speed and agility, making it harder for enemies to hit the character.',10,'Legolas');
UNLOCK TABLES;

LOCK TABLES `adventure_party` WRITE;
INSERT INTO `adventure_party` VALUES ('Gandalf','The Fellowship of the Ring','Quest for the Fellowship','Rivendell','Aragorn'),('Arthur','Knights of the Round Table','Quest for the Holy Grail','Camelot','Arthur'),('Gandalf','The Fellowship of the Ring','Quest for the Fellowship','Rivendell','Gandalf'),('Arthur','Knights of the Round Table','Quest for the Holy Grail','Camelot','Lancelot'),('Gandalf','The Fellowship of the Ring','Quest for the Fellowship','Rivendell','Legolas'),('Arthur','Knights of the Round Table','Quest for the Holy Grail','Camelot','Merlin');
UNLOCK TABLES;

LOCK TABLES `charactr` WRITE;
INSERT INTO `charactr` VALUES ('Aragorn','player789','Warrior',7,15000,18,14,12,14,70,50,'Gondor',75),('Arthur','player123','Warrior',5,8000,18,12,10,14,80,0,'Camelot',0),('Gandalf','player123','Mage',5,10000,10,12,18,10,50,100,'Rivendell',100),('Lancelot','player456','Warrior',7,12000,20,14,10,16,100,0,'Camelot',0),('Legolas','player789','Rogue',6,13000,12,20,16,12,60,80,'Mirkwood',65),('Merlin','player456','Mage',6,12000,12,10,20,8,45,120,'Camelot',90);
UNLOCK TABLES;

LOCK TABLES `creature` WRITE;
INSERT INTO `creature` VALUES ('Goblin','Low','Light',100,NULL,'Misty Mountains'),('Orc','High','Sunlight',500,'Mirkwood',NULL),('Troll','Regeneration','Fire',800,'Misty Mountains',NULL);
UNLOCK TABLES;

LOCK TABLES `inventory` WRITE;
INSERT INTO `inventory` VALUES ('Bow','Legolas',1,6,0,'None'),('Chain Mail','Aragorn',1,NULL,6,'Light armor for warrior class'),('Excalibur','Arthur',1,15,5,'Legendary sword in the stone'),('Glamdring','Gandalf',1,20,5,'Increased damage against undead'),('Healing Potion','Merlin',3,0,0,'Heals 50 HP'),('Leather Armor','Legolas',1,NULL,4,'Allows stealth movement'),('Mage Robes','Gandalf',1,NULL,2,'Increase mana regeneration'),('Plate Mail','Arthur',1,0,8,'Heavy and sturdy plate mail armor'),('Plate Mail','Lancelot',1,0,8,'Heavy and sturdy plate mail armor'),('Staff','Gandalf',1,4,0,'None'),('Staff','Merlin',1,5,0,'A simple wooden staff'),('Sword','Aragorn',1,8,0,'None'),('Sword','Lancelot',1,10,0,'A powerful and sharp sword');
UNLOCK TABLES;

LOCK TABLES `location` WRITE;
INSERT INTO `location` VALUES ('Camelot','Legendary castle and court of King Arthur',NULL),('Gondor','Kingdom in Middle-earth',NULL),('Mirkwood','Dark and dense forest in Middle-earth',NULL),('Misty Mountains','Mountain range in Middle-earth',NULL),('Rivendell','Elf kingdom in Middle-earth',NULL);
UNLOCK TABLES;

LOCK TABLES `mage` WRITE;
INSERT INTO `mage` VALUES ('Gandalf',15,20,'Fireball'),('Merlin',12,25,'FogOfWar');
UNLOCK TABLES;

LOCK TABLES `player` WRITE;
INSERT INTO `player` VALUES ('player123','JimiHendrix','pass123'),('player456','DavidGilmour','pass456'),('player789','JimMorrison','pass789');
UNLOCK TABLES;

LOCK TABLES `quest` WRITE;
INSERT INTO `quest` VALUES ('An epic quest to find the legendary Holy Grail',500,1000,'Quest for the Holy Grail'),('An epic quest to find the legendary Holy Grail',500,1000,'Quest for the Holy Grail');
UNLOCK TABLES;

LOCK TABLES `rogue` WRITE;
INSERT INTO `rogue` VALUES ('Legolas',10,8);
UNLOCK TABLES;

LOCK TABLES `warrior` WRITE;
INSERT INTO `warrior` VALUES ('Aragorn',8,6),('Arthur',15,10),('Lancelot',20,12);
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;

# 	- UPDATE LIKE QUERIES -

# 	1. INSERT EXAMPLE
# insert some more fun characters to play with
INSERT INTO `GameDB`.`player` (`playerID`, `userName`, `password`) VALUES ('player321', 'XxXnoscopeXxX', 'plaintext1');
INSERT INTO `GameDB`.`player` (`playerID`, `userName`, `password`) VALUES ('player555', 'gachaAddict', 'jpg123');
INSERT INTO `GameDB`.`player` (`playerID`, `userName`, `password`) VALUES ('player413', 'SlimShadyREAL', '0a682^SGYd');
INSERT INTO `GameDB`.`player` (`playerID`, `userName`, `password`) VALUES ('player333', 'WolfSwordKing', 'WolfSwordK');
INSERT INTO `GameDB`.`player` (`playerID`, `userName`, `password`) VALUES ('player258', 'DunceMaster', 'dX7#');
INSERT INTO `GameDB`.`player` (`playerID`, `userName`, `password`) VALUES ('player134', 'RupeeHoarder', 'hH06h!6!12');

INSERT INTO `GameDB`.`location` (`area`, `description`) VALUES ('Alagaesia', 'Lands surrounding a large desert, where Dragon Riders once roamed.');
INSERT INTO `GameDB`.`location` (`area`, `description`) VALUES ('Hyrule', 'Legendary kingdom where the Master Sword sleeps.');
INSERT INTO `GameDB`.`location` (`area`, `description`) VALUES ('tutorial_area5', '(management wants this finished so we can bring in new players!!)');
INSERT INTO `GameDB`.`location` (`area`, `description`) VALUES ('Evil Forest', 'Low level area for adventures to improve their combat skills.');
INSERT INTO `GameDB`.`location` (`area`, `description`) VALUES ('Unearthed Dungeon', 'Rumor has it a Lich has moved into this newly discovered dungeon.');

INSERT INTO `GameDB`.`charactr` (`characterID`, `playerID`, `class`, `level`, `experience`, `strength`, `agility`, `intelligence`, `armorClass`, `hitPoints`, `mana`, `area`, `totalGold`) VALUES ('Eragon', 'player413', 'Warrior', '7', '12500', '15', '15', '15', '15', '90', '90', 'Alagaesia', '3');
INSERT INTO `GameDB`.`charactr` (`characterID`, `playerID`, `class`, `level`, `experience`, `strength`, `agility`, `intelligence`, `armorClass`, `hitPoints`, `mana`, `area`, `totalGold`) VALUES ('Kragooba', 'player413', 'Mage', '4', '5400', '6', '7', '5', '5', '55', '650', 'Evil Forest', '20');
INSERT INTO `GameDB`.`charactr` (`characterID`, `playerID`, `class`, `level`, `experience`, `strength`, `agility`, `intelligence`, `armorClass`, `hitPoints`, `mana`, `area`, `totalGold`) VALUES ('p\'Neep', 'player555', 'Warrior', '5', '6500', '7', '15', '6', '9', '50', '40', 'Evil Forest', '5');
INSERT INTO `GameDB`.`charactr` (`characterID`, `playerID`, `class`, `level`, `experience`, `strength`, `agility`, `intelligence`, `armorClass`, `hitPoints`, `mana`, `area`, `totalGold`) VALUES ('Gideon', 'player555', 'Warrior', '7', '12500', '15', '13', '14', '14', '80', '75', 'Unearthed Dungeon', '80');
INSERT INTO `GameDB`.`charactr` (`characterID`, `playerID`, `class`, `level`, `experience`, `strength`, `agility`, `intelligence`, `armorClass`, `hitPoints`, `mana`, `area`, `totalGold`) VALUES ('Hood', 'player321', 'Rogue', '6', '12500', '11', '15', '10', '10', '65', '20', 'Unearthed Dungeon', '120');

INSERT INTO `GameDB`.`creature` (`creatureName`, `strength`, `weakness`, `xpWorth`, `area`) VALUES ('Dungeon Slime', 'Acid', 'Cold', '150', 'Unearthed Dungeon');
INSERT INTO `GameDB`.`creature` (`creatureName`, `strength`, `weakness`, `xpWorth`, `area`) VALUES ('Elder Dragon', 'Dragon Fire', 'Elder Magiks', '1200', 'Alagaesia');
INSERT INTO `GameDB`.`creature` (`creatureName`, `strength`, `weakness`, `xpWorth`, `area`) VALUES ('Lich', 'Necrotic', 'Aether', '1000', 'Unearthed Dungeon');
INSERT INTO `GameDB`.`creature` (`creatureName`, `strength`, `weakness`, `xpWorth`, `area`) VALUES ('Skeleton', 'Medium', 'Blunt Force', '250', 'Unearthed Dungeon');

INSERT INTO `GameDB`.`inventory` (`itemName`, `characterID`, `quantity`, `damage`, `acBonus`, `effects`) VALUES ('Brisingr', 'Eragon', '1', '18', '4', 'Bursts into magic flame when its name is said');
INSERT INTO `GameDB`.`inventory` (`itemName`, `characterID`, `quantity`, `damage`, `acBonus`, `effects`) VALUES ('Master Sword', 'Aragorn', '3', '35', '0', 'Link didn\'t stand a chance');

#	2. DELETE EXAMPLE
DELETE FROM charactr WHERE characterID = 'Gideon';

#	3. UPDATE EXAMPLE
UPDATE charactr
SET area = 'Evil Forest'
WHERE characterID = 'Hood';

# 	- RETRIVAL QUERIES -

# 	1. 
# This query returns a table of characters under level 7 who have 
# a item in their inventory with damage greater than 9.
SELECT DISTINCT c.characterID AS 'Character', c.level AS 'Level', i.itemName AS 'Weapon'
FROM (inventory i JOIN charactr c ON i.characterID  = c.characterID)
WHERE i.damage >= 10 AND c.level < 7;

#	2. 
# Simple query to retrieve the characterID and experience points of the top 4 characters, sorted in descending order by experience
USE GameDB;
SELECT characterID, experience
FROM charactr
ORDER BY experience DESC
LIMIT 4;

#	3. 
# Simple query that calculates the average level of all characters and renames it as average_level
SELECT AVG(level) AS 'Average character level' 
FROM charactr;

#	4. 
# class summary queary 1
# query shows average attributes for the 3 classes.
# this can be used in town to display current class statistics.
(SELECT class, COUNT(characterID) as characterNo, CAST(AVG(level) AS DECIMAL(10,2)) as avg_level, CAST(AVG(strength) AS DECIMAL(10,2)) as avg_strength, CAST(AVG(agility) AS DECIMAL(10,2)) as avg_aligity, CAST(AVG(intelligence) AS DECIMAL(10,2)) as avg_intelligence, CAST(AVG(armorCLass) AS DECIMAL(10,2)) as avg_armorClass, CAST(AVG(hitPoints) AS DECIMAL(10,2)) as avg_hitPoints, CAST(AVG(mana) AS DECIMAL(10,2)) as avg_mana, CAST(AVG(totalGold) AS DECIMAL(10,2)) as avg_totalGold
FROM charactr c
CROSS JOIN warrior w USING (characterID)
GROUP BY class)
UNION ALL
(SELECT class, COUNT(characterID) as characterNo, CAST(AVG(level) AS DECIMAL(10,2)) as avg_level, CAST(AVG(strength) AS DECIMAL(10,2)) as avg_strength, CAST(AVG(agility) AS DECIMAL(10,2)) as avg_aligity, CAST(AVG(intelligence) AS DECIMAL(10,2)) as avg_intelligence, CAST(AVG(armorCLass) AS DECIMAL(10,2)) as avg_armorClass, CAST(AVG(hitPoints) AS DECIMAL(10,2)) as avg_hitPoints, CAST(AVG(mana) AS DECIMAL(10,2)) as avg_mana, CAST(AVG(totalGold) AS DECIMAL(10,2)) as avg_totalGold
FROM charactr c
CROSS JOIN mage m USING (characterID)
GROUP BY class)
UNION ALL
(SELECT class, COUNT(characterID) as characterNo, CAST(AVG(level) AS DECIMAL(10,2)) as avg_level, CAST(AVG(strength) AS DECIMAL(10,2)) as avg_strength, CAST(AVG(agility) AS DECIMAL(10,2)) as avg_aligity, CAST(AVG(intelligence) AS DECIMAL(10,2)) as avg_intelligence, CAST(AVG(armorCLass) AS DECIMAL(10,2)) as avg_armorClass, CAST(AVG(hitPoints) AS DECIMAL(10,2)) as avg_hitPoints, CAST(AVG(mana) AS DECIMAL(10,2)) as avg_mana, CAST(AVG(totalGold) AS DECIMAL(10,2)) as avg_totalGold
FROM charactr c
CROSS JOIN rogue r USING (characterID)
GROUP BY class);

#	5. 
# class summary queary 2
# This query shows count of the 3 classes against level
SELECT COALESCE(level, 'all') as level, SUM(warrior) as warrior, SUM(mage) as mage, SUM(rogue) as rogue
FROM
	((SELECT level, COUNT(class) as warrior, 0 as mage, 0 as rogue
	FROM charactr c
	CROSS JOIN warrior w USING (characterID)
	GROUP BY level)
	UNION ALL
	(SELECT level, 0 as warrior, COUNT(class) as mage, 0 as rogue
	FROM charactr c
	CROSS JOIN mage m USING (characterID)
	GROUP BY level)
	UNION ALL
	(SELECT level, 0 as warrior, 0 as mage, COUNT(class) as rogue
	FROM charactr c
	CROSS JOIN rogue r USING (characterID)
	GROUP BY level)) t
GROUP BY level
ORDER BY level desc;


# TRIGGERS

# TRIGGER EX 1
# On insert to charactr table, inserts to warrior table if tuple class attribute is "Warrior"
DELIMITER //
CREATE TRIGGER after_charactr_insert_handles_warrior_class
AFTER INSERT ON charactr
FOR EACH ROW
BEGIN
  IF NEW.class = 'Warrior' THEN
    INSERT INTO warrior (characterID) VALUES (NEW.characterID);
  END IF;
END;
//
DELIMITER ;

# Example of query that will trigger this

INSERT INTO `GameDB`.`charactr` 
(`characterID`, `playerID`, `class`, `level`, `experience`, `strength`, `agility`, `intelligence`, `armorClass`, `hitPoints`, `mana`, `area`, `totalGold`)
VALUES 
('AlexTheGrate', 'player321', 'Warrior', '6', '12500', '11', '15', '10', '10', '65', '20', 'Unearthed Dungeon', '120');


# TRIGGER EX 2
# a trigger to check if party leader is in existing characters
DELIMITER $$
CREATE TRIGGER adven_party_leader
BEFORE INSERT ON adventure_party
FOR EACH ROW
BEGIN
	DECLARE MSG VARCHAR(255);
    IF NEW.partyLeader not in (
		SELECT characterID
        FROM charactr
        WHERE NEW.partyLeader = characterID)
    THEN /* Cause Error Message */
    SET MSG = 'Party leader needs to be an existing character';
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = MSG;
	END IF;
END$$
DELIMITER ;

# Example of query that will trigger this

INSERT INTO `GameDB`.`adventure_party` 
(`partyLeader`, `partyName`, `questName`, `area`, `characterID`) 
VALUES 
('BEEFCAKE', 'Beef Eaters', 'Quest for the Holy Grail', 'Camelot', 'BEEFCAKE');


# TRIGGER EX 3
# Trigger to update the manaCost of an ability with an average manaCost 
# of all the existing abilities BEFORE inserting the record in the ABILITY table if the manaCost is empty or NULL.

DELIMITER $$
CREATE TRIGGER ability_manacost
BEFORE INSERT ON ability
FOR EACH ROW
BEGIN 
     IF (NEW.manaCost='' OR NEW.manaCost IS NULL)
     THEN
     SET NEW.manaCost=(SELECT AVG(manaCost)
                      FROM ability);
	 END IF;
END $$
DELIMITER ;

# Example of query that will trigger this
INSERT INTO `GameDB`.`ability` 
(`abilityName`, `description`, `characterID`) 
VALUES 
('Blink strike', 'In the blink of an eye, teleport to your target and hit it. Hit it real good.', 'Eragon');


# VIEWS

# View 1
# Create a view that displays highest achieved level, total experience, total collected gold, and area exploration % of each player
CREATE OR REPLACE VIEW player_progress
AS SELECT p.userName, MAX(c.level) Highest_character_level, SUM(c.experience) as Total_experience, SUM(c.totalGold) AS Total_gold, CONCAT(CAST(COUNT(c.area)/(SELECT COUNT(area)FROM location)*100 as DECIMAL(10)),'%') AS Area_explored
	FROM charactr c, player p
    WHERE c.playerID = p.playerID
	GROUP BY c.playerID;

# View 2
#5. Create a view that displays player username, playerID, and corresponding characterIDs 
CREATE OR REPLACE VIEW player_character_info AS
             SELECT p.username,c.characterID,p.playerID
             FROM player p, charactr c
             WHERE p.playerID=c.playerID;

# View 3
# Create a view that displays partyName, partyLeader, number of character, sum of experience and hitpoints
CREATE OR REPLACE VIEW char_adv_info
	AS SELECT a.partyName, a.partyLeader, COUNT(c.characterID), SUM(c.experience), SUM(c.hitPoints)
	FROM charactr c, adventure_party a
	WHERE c.characterID=a.characterID
    GROUP BY a.partyName, a.partyLeader;


# SCHEMA MODIFICATIONS

# EXAMPLE OF ALTER COMMAND
#This query changes the maximum size of the userName column in the player table to 100 characters.
USE GameDB;
ALTER TABLE player
MODIFY COLUMN userName VARCHAR(100);

#This query adds a check constraint to the level column in the charactr table, ensuring that the level value falls between 1 and 10.
USE GameDB;
ALTER TABLE charactr
ADD CONSTRAINT chk_characters_level CHECK (level >= 1 AND level <= 10);


# 😭~END~😭