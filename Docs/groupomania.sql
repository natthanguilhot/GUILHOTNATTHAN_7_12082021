-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 21 sep. 2021 à 14:18
-- Version du serveur :  8.0.21
-- Version de PHP : 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `groupomania`
--

-- --------------------------------------------------------

--
-- Structure de la table `comments`
--

DROP TABLE IF EXISTS `comments`;
CREATE TABLE IF NOT EXISTS `comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `post_id` int DEFAULT NULL,
  `content` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_user` (`user_id`),
  KEY `id_post` (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `comments`
--

INSERT INTO `comments` (`id`, `user_id`, `post_id`, `content`, `createdAt`, `updatedAt`) VALUES
(2, 19, 13, 'Mon premier commentaire ! :)', '2021-09-16 08:11:54', '2021-09-16 08:11:54'),
(4, 19, 13, 'Mon premier commentaire ! :)', '2021-09-16 08:31:59', '2021-09-16 08:31:59'),
(5, 19, 13, 'Mon premier commentaire ! :)', '2021-09-16 08:33:37', '2021-09-16 08:33:37'),
(6, 19, 14, 'Mon premier commentaire ! :)', '2021-09-16 08:38:10', '2021-09-16 08:38:10');

-- --------------------------------------------------------

--
-- Structure de la table `likes`
--

DROP TABLE IF EXISTS `likes`;
CREATE TABLE IF NOT EXISTS `likes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `post_id` int DEFAULT NULL,
  `comment_id` int DEFAULT NULL,
  `is_liked` tinyint(1) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_user` (`user_id`),
  KEY `id_post` (`post_id`),
  KEY `id_comment` (`comment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `likes`
--

INSERT INTO `likes` (`id`, `user_id`, `post_id`, `comment_id`, `is_liked`, `createdAt`, `updatedAt`) VALUES
(15, 19, 14, NULL, 1, '2021-09-16 09:13:14', '2021-09-16 09:13:14'),
(16, 19, 14, NULL, 1, '2021-09-16 09:16:16', '2021-09-16 09:16:16'),
(17, 19, NULL, 5, 1, '2021-09-16 09:19:14', '2021-09-16 09:19:14');

-- --------------------------------------------------------

--
-- Structure de la table `posts`
--

DROP TABLE IF EXISTS `posts`;
CREATE TABLE IF NOT EXISTS `posts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `creator` int NOT NULL,
  `files` varchar(255) DEFAULT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator` (`creator`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `posts`
--

INSERT INTO `posts` (`id`, `creator`, `files`, `content`, `createdAt`, `updatedAt`) VALUES
(1, 19, NULL, 'ceci est mon premier post !', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 19, NULL, 'ceci est du texte', '2021-09-03 14:10:10', '2021-09-03 14:10:10'),
(3, 19, NULL, NULL, '2021-09-03 14:10:26', '2021-09-03 14:10:26'),
(4, 19, NULL, 'ceci est mon 3ieme post avec du texte', '2021-09-09 08:12:07', '2021-09-09 08:12:07'),
(11, 19, 'http://localhost:3000/images/posts/PPPNatthan.jpeg1631182767247.jpeg', 'ceci est du texte avec une image', '2021-09-09 10:19:27', '2021-09-09 10:19:27'),
(12, 19, 'http://localhost:3000/images/posts/giphy.gif1631183153120.gif', 'ceci est du texte avec une image', '2021-09-09 10:25:53', '2021-09-09 10:25:53'),
(13, 20, 'http://localhost:3000/images/posts/giphy.gif1631196613674.gif', 'ceci est du texte avec une image', '2021-09-09 14:10:13', '2021-09-09 14:10:13'),
(14, 19, 'http://localhost:3000/images/posts/giphy.gif1631205433446.gif', 'ceci est du texte avec une image', '2021-09-09 16:37:13', '2021-09-09 16:37:13');

-- --------------------------------------------------------

--
-- Structure de la table `sequelizemeta`
--

DROP TABLE IF EXISTS `sequelizemeta`;
CREATE TABLE IF NOT EXISTS `sequelizemeta` (
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `sequelizemeta`
--

INSERT INTO `sequelizemeta` (`name`) VALUES
('20210902083209-create-user.js'),
('20210902084826-create-post.js'),
('20210902085445-create-likes.js'),
('20210902085634-create-comments.js');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(15) NOT NULL,
  `lastname` varchar(15) NOT NULL,
  `job` varchar(20) DEFAULT NULL,
  `account_type` tinyint(1) NOT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `name`, `lastname`, `job`, `account_type`, `profile_picture`, `createdAt`, `updatedAt`) VALUES
(12, '789', '$2b$08$8HRgYIKEae84vboD7CcJ7.uHm315gxmrUT7w.YRG/xwqEb.YC.Be.', 'natt', 'gui', 'jobtest', 0, NULL, '2021-09-02 14:13:19', '2021-09-02 14:13:19'),
(13, 'natt', '$2b$08$.5lqfChMP1PLD3ZQXGy3OuhTE3/LLmxp78rKL5p6tkUQw26.KiqB6', 'natt', 'gui', 'jobtest', 0, NULL, '2021-09-02 14:16:23', '2021-09-02 14:16:23'),
(19, 'azerty12345', '$2b$08$jxI40T4PlSBrkIqTWT82Pe.VVuhs1MbGRwLOaVP6/eDZkVfDrnWtW', 'natthan', 'guilhot', 'test', 0, 'http://localhost:3000/images/users/PPPAlain.jpeg1631197137588.jpeg', '2021-09-03 10:19:43', '2021-09-09 14:18:57'),
(20, 'testimage', '$2b$08$05e1XUgZJ6WvNXi5IQBh4OY5MqN1M8PphdJ7wBpT.BBVbsNtxAyM6', 'testimage', 'testimage', NULL, 0, 'http://localhost:3000/images/users/PPPNatthan.jpeg1631196591944.jpeg', '2021-09-09 13:41:21', '2021-09-09 14:09:51'),
(32, 'natthan.guilhot@laposte.net', '$2b$08$v7vVvgzYySTMBmkD9/hR2.yHAgBuGJ4IsU7JCJonlMoEeARJMjyOK', 'Natthan', 'Guilhot', 'dev', 0, NULL, '2021-09-17 10:14:37', '2021-09-17 10:14:37');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`);

--
-- Contraintes pour la table `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`),
  ADD CONSTRAINT `likes_ibfk_3` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`);

--
-- Contraintes pour la table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`creator`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
