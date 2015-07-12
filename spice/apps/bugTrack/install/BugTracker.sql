-- phpMyAdmin SQL Dump
-- version 2.11.7.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 14, 2009 at 09:09 PM
-- Server version: 5.0.41
-- PHP Version: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `BugTracker`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL auto_increment,
  `company` varchar(30) NOT NULL,
  `plan` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` VALUES(1, 'Spice Apps LLC', 0);

-- --------------------------------------------------------

--
-- Table structure for table `bugPriority`
--

CREATE TABLE `bugPriority` (
  `id` int(11) NOT NULL auto_increment,
  `priority` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `styling` varchar(30) NOT NULL,
  `company` int(11) NOT NULL,
  `reportTo` text NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `bugPriority`
--

INSERT INTO `bugPriority` VALUES(1, 0, 'Low', '', 1, '["2"]');
INSERT INTO `bugPriority` VALUES(2, 1, 'Medium', '', 1, '["2"]');
INSERT INTO `bugPriority` VALUES(3, 2, 'High', '', 1, '["2"]');
INSERT INTO `bugPriority` VALUES(4, 3, 'Critical', '', 1, '["2"]');

-- --------------------------------------------------------

--
-- Table structure for table `bugs`
--

CREATE TABLE `bugs` (
  `id` int(11) NOT NULL auto_increment,
  `project` int(11) NOT NULL,
  `description` text NOT NULL,
  `priority` int(11) NOT NULL,
  `tags` text NOT NULL,
  `owner` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `bugs`
--


-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `id` int(11) NOT NULL auto_increment,
  `type` varchar(10) NOT NULL,
  `description` text NOT NULL,
  `metadata` text NOT NULL,
  `project` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `logs`
--


-- --------------------------------------------------------

--
-- Table structure for table `logTypes`
--

CREATE TABLE `logTypes` (
  `id` int(11) NOT NULL auto_increment,
  `project` int(11) NOT NULL,
  `code` int(11) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `logTypes`
--

INSERT INTO `logTypes` VALUES(1, 1, 0, 'Success');
INSERT INTO `logTypes` VALUES(2, 1, 1, 'Warning');
INSERT INTO `logTypes` VALUES(3, 1, 2, 'Memory');
INSERT INTO `logTypes` VALUES(4, 1, 3, 'Error');
INSERT INTO `logTypes` VALUES(5, 1, 4, 'Fatal');

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(60) NOT NULL,
  `description` text NOT NULL,
  `owner` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` VALUES(2, 'Clove', 'Social media aggregator', 2);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `user` varchar(30) NOT NULL,
  `email` varchar(60) NOT NULL,
  `password` varchar(30) NOT NULL,
  `privileges` int(11) NOT NULL,
  `company` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` VALUES(1, 'timerickson', 'tim@spiceapps.com', 'batmanandxenu', 0, 1);
INSERT INTO `users` VALUES(2, 'architectd', 'craig.j.condon@gmail.com', 'kpcofgs', 0, 1);
