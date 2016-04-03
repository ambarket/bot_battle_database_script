-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 03, 2016 at 01:05 AM
-- Server version: 5.5.47-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `bbweb`
--

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`bbweb`@`localhost` FUNCTION `login`(`acct` VARCHAR(30), `pwd` VARCHAR(32)) RETURNS int(11)
    READS SQL DATA
if exists(select * from users where account=acct and password=pwd)
	then 
		return (select uid from users where account=acct);
	else 
		return 0;
end if$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `category_id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `challenges`
--

CREATE TABLE IF NOT EXISTS `challenges` (
  `challenge_id` int(11) NOT NULL AUTO_INCREMENT,
  `creator_uid` int(11) NOT NULL,
  `name` varchar(80) NOT NULL,
  `description` mediumtext NOT NULL,
  `difficulty` int(11) NOT NULL,
  `creation_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `category` int(11) NOT NULL,
  PRIMARY KEY (`challenge_id`),
  KEY `creator_uid` (`creator_uid`,`category`),
  KEY `category` (`category`),
  KEY `difficulty` (`difficulty`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=25 ;

-- --------------------------------------------------------

--
-- Table structure for table `challenge_map`
--

CREATE TABLE IF NOT EXISTS `challenge_map` (
  `challenge_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `match_id` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `contests`
--

CREATE TABLE IF NOT EXISTS `contests` (
  `contest_id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_uid` int(11) NOT NULL,
  `challenge_id` int(11) NOT NULL,
  `name` varchar(80) NOT NULL,
  `description` mediumtext NOT NULL,
  `matches` int(11) NOT NULL,
  `creation_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `run_date` datetime NOT NULL,
  `finished` tinyint(1) NOT NULL DEFAULT '0',
  `category` int(11) NOT NULL,
  PRIMARY KEY (`contest_id`),
  KEY `admin_uid` (`admin_uid`,`challenge_id`,`category`),
  KEY `challenge_id` (`challenge_id`),
  KEY `category` (`category`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=90 ;

-- --------------------------------------------------------

--
-- Table structure for table `contests_registration`
--

CREATE TABLE IF NOT EXISTS `contests_registration` (
  `contest_id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `bot_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`contest_id`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `contest_map`
--

CREATE TABLE IF NOT EXISTS `contest_map` (
  `contest_id` int(11) DEFAULT NULL,
  `round_id` int(11) DEFAULT NULL,
  `match_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `difficulty`
--

CREATE TABLE IF NOT EXISTS `difficulty` (
  `difficulty_id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`difficulty_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `enqueued_challenges`
--

CREATE TABLE IF NOT EXISTS `enqueued_challenges` (
  `match_id` int(11) DEFAULT NULL,
  `bot_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `enqueued_contests`
--

CREATE TABLE IF NOT EXISTS `enqueued_contests` (
  `contest_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `enqueued_testarena`
--

CREATE TABLE IF NOT EXISTS `enqueued_testarena` (
  `challenge_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `command` text,
  PRIMARY KEY (`challenge_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lessons`
--

CREATE TABLE IF NOT EXISTS `lessons` (
  `lid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  `uid` int(11) DEFAULT NULL,
  `category` int(11) NOT NULL,
  `difficulty` int(11) NOT NULL,
  `video` varchar(1024) NOT NULL,
  `description` mediumtext NOT NULL,
  PRIMARY KEY (`lid`),
  KEY `uid` (`uid`),
  KEY `category` (`category`),
  KEY `difficulty` (`difficulty`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=357 ;

-- --------------------------------------------------------

--
-- Table structure for table `maps`
--

CREATE TABLE IF NOT EXISTS `maps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `map` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `match_turns`
--

CREATE TABLE IF NOT EXISTS `match_turns` (
  `id` int(11) NOT NULL,
  `command` text,
  `winner_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `testarena_turns`
--

CREATE TABLE IF NOT EXISTS `testarena_turns` (
  `challenge_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `command` text,
  PRIMARY KEY (`challenge_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(30) NOT NULL,
  `display` varchar(80) NOT NULL,
  `email` varchar(80) NOT NULL,
  `password` varchar(1024) NOT NULL COMMENT 'Going to use SHA256, which is SHA2("pwd"+"salt", 256)',
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `SALT` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `account` (`account`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Preliminary User DB' AUTO_INCREMENT=80 ;

-- --------------------------------------------------------

--
-- Table structure for table `user_bots`
--

CREATE TABLE IF NOT EXISTS `user_bots` (
  `bot_id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `challenge_id` int(11) NOT NULL,
  `default_version` int(11) NOT NULL,
  `name` varchar(80) NOT NULL,
  `creation_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `description` varchar(255) NOT NULL,
  `public` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`bot_id`),
  KEY `challenge_id` (`challenge_id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=54 ;

-- --------------------------------------------------------

--
-- Table structure for table `user_bots_versions`
--

CREATE TABLE IF NOT EXISTS `user_bots_versions` (
  `bot_id` int(11) NOT NULL,
  `version` int(11) NOT NULL,
  `creation_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `source_code` mediumtext NOT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `type` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`bot_id`,`version`),
  KEY `bot_id` (`bot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `challenges`
--
ALTER TABLE `challenges`
  ADD CONSTRAINT `challenges_ibfk_1` FOREIGN KEY (`creator_uid`) REFERENCES `users` (`uid`),
  ADD CONSTRAINT `challenges_ibfk_2` FOREIGN KEY (`difficulty`) REFERENCES `difficulty` (`difficulty_id`),
  ADD CONSTRAINT `challenges_ibfk_3` FOREIGN KEY (`category`) REFERENCES `category` (`category_id`);

--
-- Constraints for table `contests`
--
ALTER TABLE `contests`
  ADD CONSTRAINT `contests_ibfk_1` FOREIGN KEY (`admin_uid`) REFERENCES `users` (`uid`),
  ADD CONSTRAINT `contests_ibfk_2` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`challenge_id`),
  ADD CONSTRAINT `contests_ibfk_3` FOREIGN KEY (`category`) REFERENCES `category` (`category_id`);

--
-- Constraints for table `lessons`
--
ALTER TABLE `lessons`
  ADD CONSTRAINT `lessons_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`),
  ADD CONSTRAINT `lessons_ibfk_2` FOREIGN KEY (`category`) REFERENCES `category` (`category_id`),
  ADD CONSTRAINT `lessons_ibfk_3` FOREIGN KEY (`difficulty`) REFERENCES `difficulty` (`difficulty_id`);

--
-- Constraints for table `user_bots`
--
ALTER TABLE `user_bots`
  ADD CONSTRAINT `user_bots_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`),
  ADD CONSTRAINT `user_bots_ibfk_2` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`challenge_id`);

--
-- Constraints for table `user_bots_versions`
--
ALTER TABLE `user_bots_versions`
  ADD CONSTRAINT `user_bots_versions_ibfk_1` FOREIGN KEY (`bot_id`) REFERENCES `user_bots` (`bot_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
