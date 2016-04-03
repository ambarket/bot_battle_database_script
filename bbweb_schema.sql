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
  PRIMARY KEY (`challenge_id`),
  KEY `creator_uid` (`creator_uid`,`category`),
  KEY `category` (`category`),
  KEY `difficulty` (`difficulty`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=25 ;

--
-- Dumping data for table `challenges`
--

INSERT INTO `challenges` (`challenge_id`, `creator_uid`, `name`, `description`, `difficulty`, `creation_date`, `active`, `category`) VALUES
(1, 1, 'Challenge_1', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum ultricies diam vel feugiat accumsan. Praesent lectus velit, auctor at sollicitudin quis, iaculis non diam. Aliquam est enim, tristique at est non, placerat mattis emis mauris. Maecenas id dictum justo. Nullam condimentum nisi quis diam tincidunt, nec placerat quam pulvinar. Proin tincidunt nec eros eleifend fisk consectetur. Donec in tortor sed nibh cursus yeset  tincidunt. Ut vitae nisi erat. Proin a arcu mi. Sed vitae pretium tortor.', 1, '2016-02-29 13:18:01', 0, 1),
(2, 1, 'Challenge_1', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum ultricies diam vel feugiat accumsan. Praesent lectus velit, auctor at sollicitudin quis, iaculis non diam. Aliquam est enim, tristique at est non, placerat mattis mauris. Maecenas id dictum justo. Nullam condimentum nisi quis diam tincidunt, nec placerat quam pulvinar. Proin tincidunt nec eros eleifend consectetur. Donec in tortor sed nibh cursus tincidunt. Ut vitae nisi erat. Proin a arcu mi. Sed vitae pretium tortor.', 2, '2016-02-29 13:19:47', 0, 2),
(7, 1, 'Challenge_3', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum ultricies diam vel feugiat accumsan. Praesent lectus velit, auctor at sollicitudin quis, iaculis non diam. Aliquam est enim, tristique at est non, placerat mattis mauris. Maecenas id dictum justo. Nullam condimentum nisi quis diam tincidunt, nec placerat quam pulvinar. Proin tincidunt nec eros eleifend consectetur. Donec in tortor sed nibh cursus tincidunt. Ut vitae nisi erat. Proin a arcu mi. Sed vitae pretium tortor.', 4, '2016-02-29 13:19:47', 0, 3),
(11, 1, 'Variables', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum ultricies diam vel feugiat accumsan. Praesent lectus velit, auctor at sollicitudin quis, iaculis non diam. Aliquam est enim, tristique at est non, placerat mattis mauris. Maecenas id dictum justo. Nullam condimentum nisi quis diam tincidunt, nec placerat quam pulvinar. Proin tincidunt nec eros eleifend consectetur. Donec in tortor sed nibh cursus tincidunt. Ut vitae nisi erat. Proin a arcu mi. Sed vitae pretium tortor.', 2, '2016-03-17 17:08:51', 1, 4);

-- --------------------------------------------------------

--
-- Table structure for table `challenge_map`
--

DROP TABLE IF EXISTS `challenge_map`;
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

DROP TABLE IF EXISTS `contests`;
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

--
-- Dumping data for table `contests`
--

INSERT INTO `contests` (`contest_id`, `admin_uid`, `challenge_id`, `name`, `description`, `matches`, `creation_date`, `run_date`, `finished`, `category`) VALUES
(7, 1, 1, 'Tournament_1', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce eget laoreet orci. Duis mauris nulla, elementum sit amet justo rutrum, venenatis suscipit purus. Sed dui libero, pellentesque ut magna mattis, mollis interdum urna. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin semper faucibus tristique. Nunc interdum turpis vitae mattis viverra. Donec nec condimentum justo. Vivamus ac pellentesque arcu. Sed at porttitor tortor. Nullam a augue velit.', 1, '2016-03-01 18:58:12', '2016-04-01 12:30:00', 0, 3),
(8, 1, 1, 'Tournament_2', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce eget laoreet orci. Duis mauris nulla, elementum sit amet justo rutrum, venenatis suscipit purus. Sed dui libero, pellentesque ut magna mattis, mollis interdum urna. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin semper faucibus tristique. Nunc interdum turpis vitae mattis viverra. Donec nec condimentum justo. Vivamus ac pellentesque arcu. Sed at porttitor tortor. Nullam a augue velit.', 1, '2016-03-01 18:58:12', '2016-04-01 12:30:00', 0, 4),
(10, 1, 2, 'Tournament_6', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce eget laoreet orci. Duis mauris nulla, elementum sit amet justo rutrum, venenatis suscipit purus. Sed dui libero, pellentesque ut magna mattis, mollis interdum urna. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin semper faucibus tristique. Nunc interdum turpis vitae mattis viverra. Donec nec condimentum justo. Vivamus ac pellentesque arcu. Sed at porttitor tortor. Nullam a augue velit.1', 0, '2016-03-02 17:37:16', '2015-02-18 00:00:00', 1, 1),
(11, 1, 1, 'Tournament_7', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce eget laoreet orci. Duis mauris nulla, elementum sit amet justo rutrum, venenatis suscipit purus. Sed dui libero, pellentesque ut magna mattis, mollis interdum urna. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin semper faucibus tristique. Nunc interdum turpis vitae mattis viverra. Donec nec condimentum justo. Vivamus ac pellentesque arcu. Sed at porttitor tortor. Nullam a augue velit. ', 0, '2016-03-02 17:37:16', '2014-11-13 00:00:00', 1, 2),
(12, 1, 2, 'Tournament_8', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce eget laoreet orci. Duis mauris nulla, elementum sit amet justo rutrum, venenatis suscipit purus. Sed dui libero, pellentesque ut magna mattis, mollis interdum urna. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin semper faucibus tristique. Nunc interdum turpis vitae mattis viverra. Donec nec condimentum justo. Vivamus ac pellentesque arcu. Sed at porttitor tortor. Nullam a augue velit.', 0, '2016-03-02 17:37:16', '2015-07-01 00:00:00', 1, 3),
(13, 1, 11, 'Tournament_9', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce eget laoreet orci. Duis mauris nulla, elementum sit amet justo rutrum, venenatis suscipit purus. Sed dui libero, pellentesque ut magna mattis, mollis interdum urna. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin semper faucibus tristique. Nunc interdum turpis vitae mattis viverra. Donec nec condimentum justo. Vivamus ac pellentesque arcu. Sed at porttitor tortor. Nullam a augue velit.', 0, '2016-03-02 17:37:16', '2015-01-22 00:00:00', 1, 4),
(79, 1, 7, 'Tournament_4', '', 0, '2016-03-27 00:20:26', '2016-02-27 05:00:00', 0, 3),
(85, 1, 11, 'Tournament_3', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce eget laoreet orci. Duis mauris nulla, elementum sit amet justo rutrum, venenatis suscipit purus. Sed dui libero, pellentesque ut magna mattis, mollis interdum urna. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin semper faucibus tristique. Nunc interdum turpis vitae mattis viverra. Donec nec condimentum justo. Vivamus ac pellentesque arcu. Sed at porttitor tortor. Nullam a augue velit.', 0, '2016-03-31 00:29:51', '2016-03-16 04:00:00', 0, 4);

-- --------------------------------------------------------

--
-- Table structure for table `contests_registration`
--

DROP TABLE IF EXISTS `contests_registration`;
CREATE TABLE IF NOT EXISTS `contests_registration` (
  `contest_id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `bot_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`contest_id`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contests_registration`
--

INSERT INTO `contests_registration` (`contest_id`, `uid`, `bot_id`) VALUES
(6, 1, NULL),
(6, 74, NULL),
(7, 1, NULL),
(7, 67, 39),
(7, 74, NULL),
(8, 1, NULL),
(8, 59, NULL),
(78, 1, 50),
(78, 74, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `contest_map`
--

DROP TABLE IF EXISTS `contest_map`;
CREATE TABLE IF NOT EXISTS `contest_map` (
  `contest_id` int(11) DEFAULT NULL,
  `round_id` int(11) DEFAULT NULL,
  `match_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contest_map`
--

INSERT INTO `contest_map` (`contest_id`, `round_id`, `match_id`) VALUES
(11, 1, 1),
(11, 1, 1),
(11, 1, 3),
(11, 1, 4),
(11, 2, 1),
(11, 2, 5),
(11, 3, 6);

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
-- Table structure for table `enqueued_challenges`
--

DROP TABLE IF EXISTS `enqueued_challenges`;
CREATE TABLE IF NOT EXISTS `enqueued_challenges` (
  `match_id` int(11) DEFAULT NULL,
  `bot_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `enqueued_contests`
--

DROP TABLE IF EXISTS `enqueued_contests`;
CREATE TABLE IF NOT EXISTS `enqueued_contests` (
  `contest_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `enqueued_testarena`
--

DROP TABLE IF EXISTS `enqueued_testarena`;
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
-- Table structure for table `maps`
--

DROP TABLE IF EXISTS `maps`;
CREATE TABLE IF NOT EXISTS `maps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `map` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `maps`
--

INSERT INTO `maps` (`id`, `map`) VALUES
(1, '{"map":[{"mapColumn":[{"sheet":"tiles"},{"sheet":"tiles"}]},{"mapColumn":[{"sheet":"tiles"},{"sheet":"tiles"}]}]}');

-- --------------------------------------------------------

--
-- Table structure for table `match_turns`
--

DROP TABLE IF EXISTS `match_turns`;
CREATE TABLE IF NOT EXISTS `match_turns` (
  `id` int(11) NOT NULL,
  `command` text,
  `winner_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `match_turns`
--

INSERT INTO `match_turns` (`id`, `command`, `winner_id`) VALUES
(1, NULL, 59),
(3, NULL, 67),
(4, NULL, 78),
(5, NULL, 74),
(6, NULL, 74),
(105, '[ { "command":"test game instance, please delete later" } ]', 20),
(12345, '"[ {\\"background\\":\\"background.png\\",\\"defaultTimestep\\":1,\\"entity\\":[{\\"id\\":101,\\"type\\":\\"spriteRabbit\\",\\"visible\\":true,\\"initX\\":50,\\"initY\\":100,\\"width\\":50,\\"height\\":50,\\"flipped\\":false,\\"rotation\\":0},{\\"id\\":102,\\"type\\":\\"spriteChicken\\",\\"visible\\":true,\\"initX\\":500,\\"initY\\":400,\\"width\\":50,\\"height\\":50,\\"flipped\\":true,\\"rotation\\":0},{\\"id\\":103,\\"type\\":\\"object\\",\\"visible\\":true,\\"initX\\":250,\\"initY\\":350,\\"width\\":50,\\"height\\":50,\\"flipped\\":true,\\"rotation\\":0,\\"value\\":\\"brickWall\\"},{\\"id\\":104,\\"type\\":\\"text\\",\\"visible\\":true,\\"initX\\":50,\\"initY\\":50,\\"width\\":50,\\"height\\":50,\\"flipped\\":false,\\"rotation\\":0,\\"value\\":\\"Turn: 1\\",\\"fill\\":\\"#808080\\"}],\\"stdIn\\":\\"000\\",\\"stdOut\\":\\"111\\",\\"stdErr\\":\\"222\\"} , [{\\"timeScale\\":1,\\"turnChanges\\":[{\\"id\\":101,\\"changes\\":[{\\"action\\":\\"walk\\",\\"start\\":0,\\"end\\":0.2,\\"x\\":300,\\"y\\":200},{\\"action\\":\\"walk\\",\\"start\\":0.2,\\"end\\":0.3,\\"x\\":350,\\"y\\":150},{\\"action\\":\\"walk\\",\\"start\\":0.3,\\"end\\":1,\\"x\\":300,\\"y\\":50,\\"rotation\\":90}]},{\\"id\\":102,\\"changes\\":[{\\"action\\":\\"walk\\",\\"start\\":0.2,\\"end\\":0.8,\\"x\\":550,\\"y\\":450,\\"width\\":200,\\"height\\":200}]},{\\"id\\":103,\\"changes\\":[{\\"action\\":\\"move\\",\\"start\\":0,\\"end\\":1,\\"x\\":250,\\"y\\":250,\\"width\\":20,\\"height\\":20,\\"rotation\\":360}]},{\\"id\\":104,\\"changes\\":[{\\"action\\":\\"setText\\",\\"start\\":1,\\"value\\":\\"Turn: 2\\",\\"fill\\":\\"#000000\\"}]}],\\"stdIn\\":\\"aaa\\",\\"stdOut\\":\\"bbb\\",\\"stdErr\\":\\"ccc\\"},{\\"timeScale\\":2,\\"turnChanges\\":[{\\"id\\":101,\\"changes\\":[{\\"start\\":0,\\"end\\":0.2,\\"x\\":300,\\"y\\":200},{\\"start\\":0.2,\\"end\\":0.3,\\"x\\":350,\\"y\\":150},{\\"start\\":0.3,\\"end\\":1,\\"x\\":50,\\"y\\":100,\\"rotation\\":90}]},{\\"id\\":102,\\"changes\\":[{\\"action\\":\\"walk\\",\\"visible\\":false,\\"start\\":0.2,\\"end\\":0.8}]},{\\"id\\":104,\\"changes\\":[{\\"action\\":\\"setText\\",\\"start\\":1,\\"value\\":\\"Turn: 3\\",\\"backgroundColor\\":\\"rgba(255,0,0,0.25)\\",\\"fill\\":\\"#808080\\"}]}],\\"stdIn\\":\\"ddd\\",\\"stdOut\\":\\"eee\\",\\"stdErr\\":\\"fff\\"},{\\"timeScale\\":1,\\"turnChanges\\":[{\\"id\\":101,\\"changes\\":[{\\"action\\":\\"walk\\",\\"start\\":0,\\"end\\":0.2,\\"x\\":300,\\"y\\":200},{\\"action\\":\\"walk\\",\\"start\\":0.2,\\"end\\":0.3,\\"x\\":350,\\"y\\":150},{\\"action\\":\\"walk\\",\\"start\\":0.3,\\"end\\":1,\\"x\\":300,\\"y\\":50}]},{\\"id\\":102,\\"changes\\":[{\\"action\\":\\"walk\\",\\"visible\\":true,\\"start\\":0.2,\\"end\\":0.8,\\"x\\":400,\\"y\\":300,\\"flipped\\":false}]},{\\"id\\":104,\\"changes\\":[{\\"action\\":\\"setText\\",\\"start\\":1,\\"value\\":\\"Turn: 4\\"}]}],\\"stdIn\\":\\"ggg\\",\\"stdOut\\":\\"hhh\\",\\"stdErr\\":\\"iii\\"}] ]"', 1);

-- --------------------------------------------------------

--
-- Table structure for table `testarena_turns`
--

DROP TABLE IF EXISTS `testarena_turns`;
CREATE TABLE IF NOT EXISTS `testarena_turns` (
  `challenge_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `command` text,
  PRIMARY KEY (`challenge_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `testarena_turns`
--

INSERT INTO `testarena_turns` (`challenge_id`, `user_id`, `command`) VALUES
(101, 1, '[ { "command":"test testing_arena instance, please delete later" } ]');

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
  KEY `challenge_id` (`challenge_id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=54 ;

--
-- Dumping data for table `user_bots`
--

INSERT INTO `user_bots` (`bot_id`, `uid`, `challenge_id`, `default_version`, `name`, `creation_date`, `description`, `public`) VALUES
(7, 59, 1, 0, 'test bot', '2016-03-23 16:18:45', 'this is a test bot', 0),
(18, 74, 11, 1, 'test', '2016-03-27 00:02:57', 'test', 0),
(50, 1, 7, 1, 'game', '2016-03-30 17:30:01', 'game', 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_bots_versions`
--

DROP TABLE IF EXISTS `user_bots_versions`;
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
-- Dumping data for table `user_bots_versions`
--

INSERT INTO `user_bots_versions` (`bot_id`, `version`, `creation_date`, `source_code`, `comments`, `type`) VALUES
(18, 1, '2016-03-29 14:32:45', 'number(-1,"[negative,one]").\nnumber(-2,"[negative,two]").\nnumber(-3,"[negative,three]").\nnumber(-4,"[negative,four]").\nnumber(-5,"[negative,five]").\nnumber(-6,"[negative,six]").\nnumber(-7,"[negative,seven]").\nnumber(-8,"[negative,eight]").\nnumber(-9,"[negatve,nine]").\nnumber(0,"zero").\nnumber(1,"one").\nnumber(2,"two").\nnumber(3,"three").\nnumber(4,"four").\nnumber(5,"five").\nnumber(6,"six").\nnumber(7,"seven").\nnumber(8,"eight").\nnumber(9,"nine").\ncount(X,Y,C):-\n    	X=<Y,\n        number(X,C);\n    	M is X+1,\n    	M=<Y,\n	count(M,Y,C).\n\n', NULL, NULL),
(50, 1, '2016-03-30 17:30:01', 'word(abalone,a,b,a,l,o,n,e).\nword(abandon,a,b,a,n,d,o,n).\nword(anagram,a,n,a,g,r,a,m).\nword(connect,c,o,n,n,e,c,t).\nword(elegant,e,l,e,g,a,n,t).\nword(enhance,e,n,h,a,n,c,e).\npuzzle(H1,H2,H3,V1,V2,V3) :-\nword(H1,_,A,_,B,_C,_),\nword(H2,_,D,_,E,_F,_),\nword(H3,_,G,_,H,_I,_),\nword(V1,_,A,_,D,_G,_),\nword(V2,_,B,_,E,_H,_),\nword(V3,_,C,_,F,_I,_).\n', NULL, NULL);

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
