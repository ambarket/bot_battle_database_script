-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 03, 2016 at 01:31 AM
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
DROP DATABASE IF EXISTS `bbweb`;
CREATE DATABASE IF NOT EXISTS `bbweb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `bbweb`;

DELIMITER $$
--
-- Functions
--
DROP FUNCTION IF EXISTS `login`$$
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
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
CREATE TABLE IF NOT EXISTS `languages` (
  `language_id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `languages` (`language_id`, `name`) VALUES
(1, 'Java');

--
-- Table structure for table `challenge_lessons_map`
--

DROP TABLE IF EXISTS `challenge_lessons_map`;
CREATE TABLE IF NOT EXISTS `challenge_lessons_map` (
  `lesson_id` int(11) NOT NULL,
  `challenge_id` int(11) NOT NULL,
  PRIMARY KEY (`lesson_id`, `challenge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `challenges_code`
--

DROP TABLE IF EXISTS `challenges_code`;
CREATE TABLE IF NOT EXISTS `challenges_code` (
  `challenge_id` int(11) NOT NULL,
  `new_version` bit(1) NOT NULL DEFAULT 1,
  `main_class_name` varchar(2) NOT NULL,
  `compiled_code_archive` longblob NOT NULL,
  PRIMARY KEY (`challenge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `test_arena_template_bots`
--

DROP TABLE IF EXISTS `test_arena_template_bots`;
CREATE TABLE IF NOT EXISTS `test_arena_template_bots` (
  `challenge_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL DEFAULT 1,
  `source_code` mediumtext NOT NULL,
  PRIMARY KEY (`challenge_id`, `language_id`),
  KEY (`challenge_id`),
  KEY (`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `test_arena_template_bots`
--

DROP TABLE IF EXISTS `test_arena_bots`;
CREATE TABLE IF NOT EXISTS `test_arena_bots` (
  `uid` int(11) NOT NULL,
  `challenge_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL DEFAULT 1,
  `needs_compiled` bit(1) NOT NULL DEFAULT 1,
  `errors`   int(11), 
  `warnings` int(11),
  `error_messages` text,
  `warning_messages` text,
  `source_code` mediumtext NOT NULL,
  PRIMARY KEY (`uid`, `challenge_id`, `language_id`),
  KEY (`uid`),
  KEY (`challenge_id`),
  KEY (`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `pending_test_arena_turns`
--

DROP TABLE IF EXISTS `pending_test_arena_turns`;
CREATE TABLE IF NOT EXISTS `pending_test_arena_turns` (
  `pending_turn_id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `challenge_id` int(11) NOT NULL,
  `bot_type` varchar(10) NOT NULL DEFAULT 'TEST_ARENA',
  `language_id` int(11) NOT NULL DEFAULT 1,
  `bot_id`   int(11), 
  `bot_version` int(11),
  `player` smallint,
  `last_turn_index` int(11),
  PRIMARY KEY (`pending_turn_id`),
  UNIQUE KEY (`uid`, `challenge_id`),
  KEY (`uid`),
  KEY (`challenge_id`),
  KEY (`language_id`),
  KEY (`bot_id`, `bot_version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`category_id`, `name`) VALUES
(1, 'Java'),
(2, 'C++'),
(3, 'javaScript'),
(4, 'SQL');

-- --------------------------------------------------------

--
-- Table structure for table `challenges`
--

DROP TABLE IF EXISTS `challenges`;
CREATE TABLE IF NOT EXISTS `challenges` (
  `challenge_id` int(11) NOT NULL AUTO_INCREMENT,
  `creator_uid` int(11) NOT NULL,
  `name` varchar(80) NOT NULL,
  `description` mediumtext NOT NULL,
  `difficulty` int(11) NOT NULL,
  `creation_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `category` int(11) NOT NULL,
  `player_count` smallint NOT NULL,
  PRIMARY KEY (`challenge_id`),
  KEY `creator_uid` (`creator_uid`,`category`),
  KEY `category` (`category`),
  KEY `difficulty` (`difficulty`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=25 ;

--
-- Dumping data for table `challenges`
--

INSERT INTO `challenges` (`challenge_id`, `creator_uid`, `name`, `description`, `difficulty`, `creation_date`, `active`, `category`, `player_count`) VALUES
(1, 1, 'Challenge_1', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum ultricies diam vel feugiat accumsan. Praesent lectus velit, auctor at sollicitudin quis, iaculis non diam. Aliquam est enim, tristique at est non, placerat mattis emis mauris. Maecenas id dictum justo. Nullam condimentum nisi quis diam tincidunt, nec placerat quam pulvinar. Proin tincidunt nec eros eleifend fisk consectetur. Donec in tortor sed nibh cursus yeset  tincidunt. Ut vitae nisi erat. Proin a arcu mi. Sed vitae pretium tortor.', 1, '2016-02-29 13:18:01', 0, 1, 2),
(2, 1, 'Challenge_1', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum ultricies diam vel feugiat accumsan. Praesent lectus velit, auctor at sollicitudin quis, iaculis non diam. Aliquam est enim, tristique at est non, placerat mattis mauris. Maecenas id dictum justo. Nullam condimentum nisi quis diam tincidunt, nec placerat quam pulvinar. Proin tincidunt nec eros eleifend consectetur. Donec in tortor sed nibh cursus tincidunt. Ut vitae nisi erat. Proin a arcu mi. Sed vitae pretium tortor.', 2, '2016-02-29 13:19:47', 0, 2, 2),
(7, 1, 'Challenge_3', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum ultricies diam vel feugiat accumsan. Praesent lectus velit, auctor at sollicitudin quis, iaculis non diam. Aliquam est enim, tristique at est non, placerat mattis mauris. Maecenas id dictum justo. Nullam condimentum nisi quis diam tincidunt, nec placerat quam pulvinar. Proin tincidunt nec eros eleifend consectetur. Donec in tortor sed nibh cursus tincidunt. Ut vitae nisi erat. Proin a arcu mi. Sed vitae pretium tortor.', 4, '2016-02-29 13:19:47', 0, 3, 2),
(11, 1, 'Variables', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum ultricies diam vel feugiat accumsan. Praesent lectus velit, auctor at sollicitudin quis, iaculis non diam. Aliquam est enim, tristique at est non, placerat mattis mauris. Maecenas id dictum justo. Nullam condimentum nisi quis diam tincidunt, nec placerat quam pulvinar. Proin tincidunt nec eros eleifend consectetur. Donec in tortor sed nibh cursus tincidunt. Ut vitae nisi erat. Proin a arcu mi. Sed vitae pretium tortor.', 2, '2016-03-17 17:08:51', 1, 4, 2);

-- --------------------------------------------------------

--
-- Table structure for table `challenge_map`
--

DROP TABLE IF EXISTS `challenge_map`;
CREATE TABLE IF NOT EXISTS `challenge_map` (
  `challenge_id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `match_id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`challenge_id`, `uid`, `match_id`),
  KEY (`challenge_id`),
  KEY (`uid`),
  KEY (`match_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `contests`
--

DROP TABLE IF EXISTS `contests`;
CREATE TABLE IF NOT EXISTS `contests` (
  `contest_id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_uid` int(11) NOT NULL,
  `challenge_id` int(11) NOT NULL,
  `name` varchar(80) NOT NULL,
  `description` mediumtext NOT NULL,
  `matches_per_user_in_initial_round` int(11) NOT NULL,
  `users_in_bracket` int(11) NOT NULL,
  `creation_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `run_date` timestamp NOT NULL,
  `finished` tinyint(1) NOT NULL DEFAULT '0',
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`contest_id`),
  KEY (`admin_uid`),
  KEY (`challenge_id`),
  KEY (`category_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=90 ;

--
-- Dumping data for table `contests`
--

INSERT INTO `contests` (`contest_id`, `admin_uid`, `challenge_id`, `name`, `description`, `matches_per_user_in_initial_round`, `users_in_bracket`, `creation_date`, `run_date`, `finished`, `category_id`) VALUES
(7, 1, 1, 'Tournament_1', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce eget laoreet orci. Duis mauris nulla, elementum sit amet justo rutrum, venenatis suscipit purus. Sed dui libero, pellentesque ut magna mattis, mollis interdum urna. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin semper faucibus tristique. Nunc interdum turpis vitae mattis viverra. Donec nec condimentum justo. Vivamus ac pellentesque arcu. Sed at porttitor tortor. Nullam a augue velit.', 1, 8, '2016-03-01 18:58:12', '2016-04-01 12:30:00', 0, 3),
(8, 1, 1, 'Tournament_2', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce eget laoreet orci. Duis mauris nulla, elementum sit amet justo rutrum, venenatis suscipit purus. Sed dui libero, pellentesque ut magna mattis, mollis interdum urna. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin semper faucibus tristique. Nunc interdum turpis vitae mattis viverra. Donec nec condimentum justo. Vivamus ac pellentesque arcu. Sed at porttitor tortor. Nullam a augue velit.', 1, 8, '2016-03-01 18:58:12', '2016-04-01 12:30:00', 0, 4),
(10, 1, 2, 'Tournament_6', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce eget laoreet orci. Duis mauris nulla, elementum sit amet justo rutrum, venenatis suscipit purus. Sed dui libero, pellentesque ut magna mattis, mollis interdum urna. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin semper faucibus tristique. Nunc interdum turpis vitae mattis viverra. Donec nec condimentum justo. Vivamus ac pellentesque arcu. Sed at porttitor tortor. Nullam a augue velit.1', 0, 8, '2016-03-02 17:37:16', '2015-02-18 00:00:00', 1, 1),
(6, 1, 1, 'Tournament_7', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce eget laoreet orci. Duis mauris nulla, elementum sit amet justo rutrum, venenatis suscipit purus. Sed dui libero, pellentesque ut magna mattis, mollis interdum urna. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin semper faucibus tristique. Nunc interdum turpis vitae mattis viverra. Donec nec condimentum justo. Vivamus ac pellentesque arcu. Sed at porttitor tortor. Nullam a augue velit. ', 0, 8, '2016-03-02 17:37:16', '2014-11-13 00:00:00', 1, 2),
(12, 1, 2, 'Tournament_8', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce eget laoreet orci. Duis mauris nulla, elementum sit amet justo rutrum, venenatis suscipit purus. Sed dui libero, pellentesque ut magna mattis, mollis interdum urna. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin semper faucibus tristique. Nunc interdum turpis vitae mattis viverra. Donec nec condimentum justo. Vivamus ac pellentesque arcu. Sed at porttitor tortor. Nullam a augue velit.', 0, 8, '2016-03-02 17:37:16', '2015-07-01 00:00:00', 1, 3),
(13, 1, 11, 'Tournament_9', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce eget laoreet orci. Duis mauris nulla, elementum sit amet justo rutrum, venenatis suscipit purus. Sed dui libero, pellentesque ut magna mattis, mollis interdum urna. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin semper faucibus tristique. Nunc interdum turpis vitae mattis viverra. Donec nec condimentum justo. Vivamus ac pellentesque arcu. Sed at porttitor tortor. Nullam a augue velit.', 0, 8, '2016-03-02 17:37:16', '2015-01-22 00:00:00', 1, 4),
(78, 1, 7, 'Tournament_4', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce eget laoreet orci. Duis mauris nulla, elementum sit amet justo rutrum, venenatis suscipit purus. Sed dui libero, pellentesque ut magna mattis, mollis interdum urna. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin semper faucibus tristique. Nunc interdum turpis vitae mattis viverra. Donec nec condimentum justo. Vivamus ac pellentesque arcu. Sed at porttitor tortor. Nullam a augue velit.', 0, 8, '2016-03-31 00:29:51', '2016-03-16 04:00:00', 0, 4),
(85, 1, 11, 'Tournament_3', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce eget laoreet orci. Duis mauris nulla, elementum sit amet justo rutrum, venenatis suscipit purus. Sed dui libero, pellentesque ut magna mattis, mollis interdum urna. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin semper faucibus tristique. Nunc interdum turpis vitae mattis viverra. Donec nec condimentum justo. Vivamus ac pellentesque arcu. Sed at porttitor tortor. Nullam a augue velit.', 0, 8, '2016-03-31 00:29:51', '2016-03-16 04:00:00', 0, 4);

-- --------------------------------------------------------

--
-- Table structure for table `contests_registration`
--

DROP TABLE IF EXISTS `contests_registration`;
CREATE TABLE IF NOT EXISTS `contests_registration` (
  `contest_id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `bot_id` int(11) NOT NULL,
  `bot_version` int(11) NOT NULL,
  PRIMARY KEY (`contest_id`,`uid`),
  KEY (`contest_id`),
  KEY (`uid`),
  KEY (`bot_id`, `bot_version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contests_registration`
--

INSERT INTO `contests_registration` (`contest_id`, `uid`, `bot_id`, `bot_version`) VALUES
(6, 1, 1, 1),
(6, 74, 1, 1),
(7, 1, 1, 1),
(7, 67, 1, 1),
(7, 74, 1, 1),
(8, 1, 1, 1),
(8, 59, 1, 1),
(78, 1, 1, 1),
(78, 74, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `contest_map`
--

DROP TABLE IF EXISTS `contest_map`;
CREATE TABLE IF NOT EXISTS `contest_map` (
  `contest_id` int(11) NOT NULL,
  `round_id` int(11) NOT NULL,
  `match_id` int(11) NOT NULL,
  PRIMARY KEY (`contest_id`, `round_id`, `match_id`),
  KEY (`contest_id`),
  KEY (`match_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contest_map`
--

INSERT INTO `contest_map` (`contest_id`, `round_id`, `match_id`) VALUES
(6, 1, 1),
(6, 1, 2),
(6, 1, 3),
(6, 1, 4),
(6, 2, 5),
(6, 2, 6),
(6, 3, 7);

-- --------------------------------------------------------

--
-- Table structure for table `difficulty`
--

DROP TABLE IF EXISTS `difficulty`;
CREATE TABLE IF NOT EXISTS `difficulty` (
  `difficulty_id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`difficulty_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `difficulty`
--

INSERT INTO `difficulty` (`difficulty_id`, `name`) VALUES
(1, '*'),
(2, '**'),
(3, '***'),
(4, '****'),
(5, '*****');

-- --------------------------------------------------------

--
-- Table structure for table `pending_challenge_matches`
--

DROP TABLE IF EXISTS `pending_challenge_matches`;
CREATE TABLE IF NOT EXISTS `pending_challenge_matches` (
  `challenge_match_id` int(11) NOT NULL AUTO_INCREMENT,
  `challenge_id` int(11) NOT NULL,
  `match_id` int(11) NOT NULL,
  `bots` json,
  PRIMARY KEY (`challenge_match_id`),
  KEY (`challenge_id`),
  KEY (`match_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pending_contests`
--

DROP TABLE IF EXISTS `pending_contests`;
CREATE TABLE IF NOT EXISTS `pending_contests` (
  `pending_contest_id` int(11) NOT NULL,
  `contest_id` int(11) NOT NULL,
  PRIMARY KEY (`pending_contest_id`),
  KEY (`contest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `lessons`
--

DROP TABLE IF EXISTS `lessons`;
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

--
-- Dumping data for table `lessons`
--

INSERT INTO `lessons` (`lid`, `name`, `uid`, `category`, `difficulty`, `video`, `description`) VALUES
(334, 'Inheritence', 1, 1, 2, '', 'Proin sapien nulla, iaculis non lorem id, scelerisque egestas urna. Donec sit amet semper neque. Sed ligula ipsum, lacinia vel auctor quis, gravida id lacus. Duis orci elit, porttitor id turpis a, sollicitudin rhoncus nibh. Vestibulum cursus odio eu tincidunt feugiat. Pellentesque cursus nisi quam, non tempus enim placerat ac. Maecenas ultrices, quam nec pharetra gravida, sem tellus pulvinar ex, sit amet gravida augue eros vel mauris. Cras commodo lectus at vehicula pulvinar. Fusce feugiat ligula quis pellentesque lobortis. Quisque sit amet rhoncus lectus, eu semper mi. Nullam facilisis metus leo, vel laoreet odio scelerisque vel.\r\n'),
(335, 'Pointers', 1, 2, 1, '<iframe width="560" height="315" src="https://www.youtube.com/embed/Cfd9DOnuF9w" frameborder="0" allowfullscreen></iframe>', 'Proin sapien nulla, iaculis non lorem id, scelerisque egestas urna. Donec sit amet semper neque. Sed ligula ipsum, lacinia vel auctor quis, gravida id lacus. Duis orci elit, porttitor id turpis a, sollicitudin rhoncus nibh. Vestibulum cursus odio eu tincidunt feugiat. Pellentesque cursus nisi quam, non tempus enim placerat ac. Maecenas ultrices, quam nec pharetra gravida, sem tellus pulvinar ex, sit amet gravida augue eros vel mauris. Cras commodo lectus at vehicula pulvinar. Fusce feugiat ligula quis pellentesque lobortis. Quisque sit amet rhoncus lectus, eu semper mi. Nullam facilisis metus leo, vel laoreet odio scelerisque vel.\r\n'),
(336, 'Closure', 1, 3, 2, '<iframe width="560" height="315" src="https://www.youtube.com/embed/jkTzHEtHd54?list=PL41lfR-6DnOrwYi5d824q9-Y6z3JdSgQa" frameborder="0" allowfullscreen></iframe>', 'Proin sapien nulla, iaculis non lorem id, scelerisque egestas urna. Donec sit amet semper neque. Sed ligula ipsum, lacinia vel auctor quis, gravida id lacus. Duis orci elit, porttitor id turpis a, sollicitudin rhoncus nibh. Vestibulum cursus odio eu tincidunt feugiat. Pellentesque cursus nisi quam, non tempus enim placerat ac. Maecenas ultrices, quam nec pharetra gravida, sem tellus pulvinar ex, sit amet gravida augue eros vel mauris. Cras commodo lectus at vehicula pulvinar. Fusce feugiat ligula quis pellentesque lobortis. Quisque sit amet rhoncus lectus, eu semper mi. Nullam facilisis metus leo, vel laoreet odio scelerisque vel.\r\n'),
(337, 'SQL introduction', 1, 4, 3, '<iframe width="560" height="315" src="https://www.youtube.com/embed/7Vtl2WggqOg" frameborder="0" allowfullscreen></iframe>', 'Proin sapien nulla, iaculis non lorem id, scelerisque egestas urna. Donec sit amet semper neque. Sed ligula ipsum, lacinia vel auctor quis, gravida id lacus. Duis orci elit, porttitor id turpis a, sollicitudin rhoncus nibh. Vestibulum cursus odio eu tincidunt feugiat. Pellentesque cursus nisi quam, non tempus enim placerat ac. Maecenas ultrices, quam nec pharetra gravida, sem tellus pulvinar ex, sit amet gravida augue eros vel mauris. Cras commodo lectus at vehicula pulvinar. Fusce feugiat ligula quis pellentesque lobortis. Quisque sit amet rhoncus lectus, eu semper mi. Nullam facilisis metus leo, vel laoreet odio scelerisque vel dovos.\r\n'),
(338, 'JSON', 1, 3, 2, '<iframe width="560" height="315" src="https://www.youtube.com/embed/Hu3w3yac47s" frameborder="0" allowfullscreen></iframe>', 'Proin sapien nulla, iaculis non lorem id, scelerisque egestas urna. Donec sit amet semper neque. Sed ligula ipsum, lacinia vel auctor quis, gravida id lacus. Duis orci elit, porttitor id turpis a, sollicitudin rhoncus nibh. Vestibulum cursus odio eu tincidunt feugiat. Pellentesque cursus nisi quam, non tempus enim placerat ac. Maecenas ultrices, quam nec pharetra gravida, sem tellus pulvinar ex, sit amet gravida augue eros vel mauris. Cras commodo lectus at vehicula pulvinar. Fusce feugiat ligula quis pellentesque lobortis. Quisque sit amet rhoncus lectus, eu semper mi. Nullam facilisis metus leo, vel laoreet odio scelerisque vel');

-- --------------------------------------------------------

--
-- Table structure for table `matches`
--

DROP TABLE IF EXISTS `matches`;
CREATE TABLE IF NOT EXISTS `matches` (
  `match_id` int(11) NOT NULL,
  `ready_for_playback` bit(1),
  `winner` varchar(80),
  `game_initialization_message` json,
  `turns` json,
  PRIMARY KEY (`match_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `matches` (`match_id`, `ready_for_playback`, `winner`, `game_initialization_message`, `turns`) VALUES (1, 0, 'player 1', NULL, NULL), 
(2, 0, 'player 1', NULL, NULL), 
(3, 0, 'player 1', NULL, NULL), 
(4, 0, 'player 1', NULL, NULL),
(5, 0, 'player 1', NULL, NULL),
(6, 0, 'player 1', NULL, NULL),
(7, 0, 'player 1', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `testarena_turns`
--

DROP TABLE IF EXISTS `test_arena_matches`;
CREATE TABLE IF NOT EXISTS `test_arena_matches` (
  `uid` int(11) NOT NULL,
  `challenge_id` int(11) NOT NULL,
  `last_turn_status` varchar(20) DEFAULT 'DISPLAYED',
  `game_initialization_message` json,
  `turns` json,
  PRIMARY KEY (`uid`, `challenge_id`),
  KEY (`uid`),
  KEY (`challenge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
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

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`uid`, `account`, `display`, `email`, `password`, `admin`, `reg_date`, `SALT`) VALUES
(1, 'Admin', 'Admnistrator', 'admin@botbattle.com', 'BIBPVoZivrDUS2OIMrXe+0YVn6M5W3vwMQJ7OWMTcEYUYzClx1C2LU83dMcufPvJeWgzrA8HIvbk7wE8hXrEyQ==', 1, '2016-02-19 02:50:06', '5e786bf603fa01e9741069952c6b075907502ab781efea8e36d025ef11c81f061ab2fda32d24cf98907b48e79fb02ca1a0901ac4a845a72538479854c421372e'),
(59, 'mjgood', 'Michael', 'mjgood91@yahoo.com', 'mw0p2UUuuqTLN5dh2k+65U7A1RVoRY90Z4tJvZnzD+eCvQ1jzeTp5kS5tCZL2nNYQC5oC3l7J3cnNvcYfhxTyg==', 1, '2016-02-29 01:14:01', '36974014e53b76d8a125fa00f606a153c51db0952fadcf651922f28aba90630a7a8a9aab2e93102b8bc1b8c6fe2e56d088cd7514b73972e8b9cc72e75bd261be'),
(67, 'jwd5623', 'jDunn', 'test@test.com', 'VLt0Gj+H/jjSkhTC/xp8vYP0OUyAWB2HptT/p5qyEQU6sZWz/CmTk3FuxS9ecqWtcIR0q5achlAIwvQNTZs7MQ==', 1, '2016-03-16 04:08:32', '7d6037b59c62a21b5217da6f951b60252c5b64539eb8ef244513f3e9bc41cfdece49d4dbfc0f2dbc3e9a6146459ed1d3dfbc95901a2a62835353a6e750d4d24e'),
(68, 'mjgood91', 'Michael', 'mjgood91@yahoo.com', 'k4VkcZTcr8aqLglywCpxHJRZjaa8kyiKo50dNNuZbVD98kXzWCOnIrCa9AFzX6PUe40JyyEnYkiomEskoOkAxg==', 0, '2016-03-16 17:45:41', '846db710827f34e2f626acfa63ac5ef9e2a36e9ad0228061eba117804b41703fb222e320dc809005375f7955c986f628fe2f786b56d5f726f7b3e7215298f30c'),
(74, 'Hanibal', 'Hanibal', 'hanibal@botbattle.com', '6RTac0xoUQqyzlQnEawWaC12FJHF/ReQLRB3OabrdjGgVZJhCDo0Ep+8QsyI+dsNfxKo20aynjuWvBVAGJwMmQ==', 0, '2016-03-17 21:27:11', '1aba14b14d34c3d42b5136429a920675eacbd2af1da48148f768d2d867d7e9997cff59038a5a023a646f19590186b79e5f1bdd2728fb72a182f9fa95987a064d'),
(78, 'jonathan', 'jDunn', 'test@test.com', '+2OJpC8tm72W/MYMkRLYeFqAZ5Fk6lzA8lSFouRYKHfLrDJzVNVzwrNO7Dah16D7Kv2TZjXQat0+ANLnKZSQ7A==', 0, '2016-03-23 15:00:22', 'ddad5a84af7ad2c3066c01769f7c25aef9d3915335f41d7cf6b8ef30b9daa4abc979bc9f8160aa5887861979166aeaefaebd9a2cf488cf5b0ead1e1fb0aa3e1d');

-- --------------------------------------------------------

--
-- Table structure for table `user_bots`
--

DROP TABLE IF EXISTS `user_bots`;
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
  KEY (`challenge_id`),
  KEY (`uid`),
  KEY (`bot_id`, `default_version`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=54 ;

--
-- Dumping data for table `user_bots`
--

INSERT INTO `user_bots` (`bot_id`, `uid`, `challenge_id`, `default_version`, `name`, `creation_date`, `description`, `public`) VALUES
(1, 59, 1, 1, 'test bot', '2016-03-23 16:18:45', 'this is a test bot', 0),
(2, 74, 1, 1, 'test', '2016-03-27 00:02:57', 'test', 0),
(3, 1, 1, 1, 'game', '2016-03-30 17:30:01', 'game', 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_bots_versions`
--

DROP TABLE IF EXISTS `user_bots_versions`;
CREATE TABLE IF NOT EXISTS `user_bots_versions` (
  `bot_id` int(11) NOT NULL,
  `version` int(11) NOT NULL,
  `creation_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `language_id` int(11),
  `comments` varchar(255) DEFAULT NULL,
  `errors`   int(11), 
  `warnings` int(11),
  `error_messages` text,
  `warning_messages` text,
  `source_code` mediumtext NOT NULL,
  PRIMARY KEY (`bot_id`,`version`),
  KEY (`bot_id`),
  KEY (`version`),
  KEY (`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_bots_versions`
--

INSERT INTO `user_bots_versions` (`bot_id`, `version`, `creation_date`, `language_id`, `comments`, `errors`, `warnings`,`error_messages`, `warning_messages`, `source_code`) VALUES
(1, 1, '2016-03-23 16:18:45', 1, 'test bot', 0, 0, 'no errors', 'no warnings', 'this is the source code'),
(2, 1, '2016-03-23 16:18:45', 1, 'test', 0, 0, 'no errors', 'no warnings', 'this is the source code'),
(3, 1, '2016-03-23 16:18:45', 1, 'game', 0, 0, 'no errors', 'no warnings', 'this is the source code');

--
-- Indices
--

CREATE INDEX challenge_lessons_map_index ON challenge_lessons_map (challenge_id);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `challenge_lessons_map`
--

ALTER TABLE `challenge_lessons_map`
  ADD CONSTRAINT `challenge_lessons_map_ibfk_1` FOREIGN KEY (`lesson_id`) REFERENCES `lessons` (`lid`),
  ADD CONSTRAINT `challenge_lessons_map_ibfk_2` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`challenge_id`);

--
-- Constraints for table `contests_registration`
--

ALTER TABLE `contests_registration`
  ADD CONSTRAINT `contests_registration_ibfk_1` FOREIGN KEY (`contest_id`) REFERENCES `contests` (`contest_id`),
  ADD CONSTRAINT `contests_registration_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`),
  ADD CONSTRAINT `contests_registration_ibfk_3` FOREIGN KEY (`bot_id`, `bot_version`) REFERENCES `user_bots_versions` (`bot_id`, `version`);

--
-- Constraints for table `challenges_code`
--

ALTER TABLE `challenges_code`
  ADD CONSTRAINT `challenges_code_ibfk_1` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`challenge_id`);



--
-- Constraints for table `contest_map`
--

ALTER TABLE `contest_map`
  ADD CONSTRAINT `contest_map_ibfk_1` FOREIGN KEY (`contest_id`) REFERENCES `contests` (`contest_id`),
  ADD CONSTRAINT `contest_map_ibfk_2` FOREIGN KEY (`match_id`) REFERENCES `matches` (`match_id`);

--
-- Constraints for table `challenge_map`
--

ALTER TABLE `challenge_map`
  ADD CONSTRAINT `challenge_map_ibfk_1` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`challenge_id`),
  ADD CONSTRAINT `challenge_map_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`),
  ADD CONSTRAINT `challenge_map_ibfk_3` FOREIGN KEY (`match_id`) REFERENCES `matches` (`match_id`);

--
-- Constraints for table `test_arena_matches`
--
ALTER TABLE `test_arena_matches`
  ADD CONSTRAINT `test_arena_matches_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`),
  ADD CONSTRAINT `test_arena_matches_ibfk_2` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`challenge_id`);

--
-- Constraints for table `pending_challenge_matches`
--
ALTER TABLE `pending_challenge_matches`
  ADD CONSTRAINT `pending_challenge_matches_ibfk_1` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`challenge_id`),
  ADD CONSTRAINT `pending_challenge_matches_ibfk_2` FOREIGN KEY (`match_id`) REFERENCES `matches` (`match_id`);

--
-- Constraints for table `pending_contests`
--
ALTER TABLE `pending_contests`
  ADD CONSTRAINT `pending_contests_ibfk_1` FOREIGN KEY (`contest_id`) REFERENCES `contests` (`contest_id`);

--
-- Constraints for table `pending_test_arena_turns`
--
ALTER TABLE `pending_test_arena_turns`
  ADD CONSTRAINT `pending_test_arena_turns_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`),
  ADD CONSTRAINT `pending_test_arena_turns_ibfk_2` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`challenge_id`),
  ADD CONSTRAINT `pending_test_arena_turns_ibfk_3` FOREIGN KEY (`language_id`) REFERENCES `languages` (`language_id`),
  ADD CONSTRAINT `pending_test_arena_turns_ibfk_4` FOREIGN KEY (`bot_id`, `bot_version`) REFERENCES `user_bots_versions` (`bot_id`, `version`);

--
-- Constraints for table ``test_arena_template_bots`
--
ALTER TABLE `test_arena_template_bots`
  ADD CONSTRAINT `test_arena_template_bots_ibfk_1` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`challenge_id`),
  ADD CONSTRAINT `test_arena_template_bots_ibfk_2` FOREIGN KEY (`language_id`) REFERENCES `languages` (`language_id`);

--
-- Constraints for table ``test_arena_bots`
--
ALTER TABLE `test_arena_bots`
  ADD CONSTRAINT `test_arena_bots_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`),
  ADD CONSTRAINT `test_arena_bots_ibfk_2` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`challenge_id`),
  ADD CONSTRAINT `test_arena_bots_ibfk_3` FOREIGN KEY (`language_id`) REFERENCES `languages` (`language_id`);

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
  ADD CONSTRAINT `contests_ibfk_3` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`);

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
  ADD CONSTRAINT `user_bots_ibfk_2` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`challenge_id`),
  ADD CONSTRAINT `user_bots_ibfk_3` FOREIGN KEY (`bot_id`, `default_version`) REFERENCES `user_bots_versions` (`bot_id`, `version`);

--
-- Constraints for table `user_bots_versions`
--
ALTER TABLE `user_bots_versions`
  ADD CONSTRAINT `user_bots_versions_ibfk_1` FOREIGN KEY (`bot_id`) REFERENCES `user_bots` (`bot_id`),
  ADD CONSTRAINT `user_bots_versions_ibfk_2` FOREIGN KEY (`language_id`) REFERENCES `languages` (`language_id`);
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
