-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 20 oct. 2021 à 14:50
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
  `content` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_user` (`user_id`),
  KEY `id_post` (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `comments`
--

INSERT INTO `comments` (`id`, `user_id`, `post_id`, `content`, `createdAt`, `updatedAt`) VALUES
(22, 83, 78, 'Très belle photo !', '2021-10-15 14:29:16', '2021-10-15 14:29:16');

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
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_user` (`user_id`),
  KEY `id_post` (`post_id`),
  KEY `id_comment` (`comment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `likes`
--

INSERT INTO `likes` (`id`, `user_id`, `post_id`, `comment_id`, `createdAt`, `updatedAt`) VALUES
(51, 82, 79, NULL, '2021-10-20 09:19:14', '2021-10-20 09:19:14'),
(52, 82, 82, NULL, '2021-10-20 11:39:24', '2021-10-20 11:39:24'),
(54, 82, 82, NULL, '2021-10-20 11:40:05', '2021-10-20 11:40:05'),
(55, 82, 82, NULL, '2021-10-20 11:40:34', '2021-10-20 11:40:34'),
(56, 82, 82, NULL, '2021-10-20 13:25:21', '2021-10-20 13:25:21'),
(57, 82, 82, NULL, '2021-10-20 13:27:12', '2021-10-20 13:27:12'),
(58, 82, 82, NULL, '2021-10-20 13:27:40', '2021-10-20 13:27:40'),
(59, 82, 82, NULL, '2021-10-20 13:27:53', '2021-10-20 13:27:53'),
(60, 82, 82, NULL, '2021-10-20 13:28:57', '2021-10-20 13:28:57'),
(62, 82, 82, NULL, '2021-10-20 13:29:20', '2021-10-20 13:29:20'),
(63, 82, 82, NULL, '2021-10-20 13:29:31', '2021-10-20 13:29:31'),
(68, 82, 82, NULL, '2021-10-20 13:32:35', '2021-10-20 13:32:35'),
(69, 82, 82, NULL, '2021-10-20 13:35:20', '2021-10-20 13:35:20'),
(70, 82, 82, NULL, '2021-10-20 13:38:28', '2021-10-20 13:38:28'),
(71, 82, 82, NULL, '2021-10-20 13:39:47', '2021-10-20 13:39:47'),
(72, 82, 82, NULL, '2021-10-20 13:39:53', '2021-10-20 13:39:53'),
(73, 82, 82, NULL, '2021-10-20 14:01:06', '2021-10-20 14:01:06'),
(74, 82, 82, NULL, '2021-10-20 14:01:09', '2021-10-20 14:01:09'),
(75, 82, 79, NULL, '2021-10-20 14:26:34', '2021-10-20 14:26:34'),
(76, 82, 82, NULL, '2021-10-20 14:26:50', '2021-10-20 14:26:50'),
(77, 82, 82, NULL, '2021-10-20 14:27:09', '2021-10-20 14:27:09'),
(78, 82, 82, NULL, '2021-10-20 14:29:06', '2021-10-20 14:29:06'),
(79, 82, 82, NULL, '2021-10-20 14:29:10', '2021-10-20 14:29:10'),
(80, 82, 82, NULL, '2021-10-20 14:29:29', '2021-10-20 14:29:29'),
(81, 82, 82, NULL, '2021-10-20 14:33:28', '2021-10-20 14:33:28'),
(82, 82, 82, NULL, '2021-10-20 14:33:52', '2021-10-20 14:33:52'),
(83, 82, 82, NULL, '2021-10-20 14:34:35', '2021-10-20 14:34:35'),
(84, 82, 82, NULL, '2021-10-20 14:34:43', '2021-10-20 14:34:43'),
(85, 82, 82, NULL, '2021-10-20 14:34:47', '2021-10-20 14:34:47'),
(86, 82, 82, NULL, '2021-10-20 14:34:57', '2021-10-20 14:34:57'),
(87, 82, 82, NULL, '2021-10-20 14:35:03', '2021-10-20 14:35:03'),
(88, 82, 82, NULL, '2021-10-20 14:35:37', '2021-10-20 14:35:37'),
(89, 82, 82, NULL, '2021-10-20 14:35:53', '2021-10-20 14:35:53'),
(90, 82, 82, NULL, '2021-10-20 14:36:25', '2021-10-20 14:36:25'),
(91, 82, 82, NULL, '2021-10-20 14:36:46', '2021-10-20 14:36:46'),
(92, 82, 82, NULL, '2021-10-20 14:36:54', '2021-10-20 14:36:54'),
(93, 82, 79, NULL, '2021-10-20 14:37:09', '2021-10-20 14:37:09'),
(94, 82, 82, NULL, '2021-10-20 14:37:36', '2021-10-20 14:37:36'),
(95, 82, 82, NULL, '2021-10-20 14:37:44', '2021-10-20 14:37:44'),
(96, 82, 82, NULL, '2021-10-20 14:38:14', '2021-10-20 14:38:14'),
(97, 82, 82, NULL, '2021-10-20 14:38:20', '2021-10-20 14:38:20');

-- --------------------------------------------------------

--
-- Structure de la table `posts`
--

DROP TABLE IF EXISTS `posts`;
CREATE TABLE IF NOT EXISTS `posts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `creator` int NOT NULL,
  `files` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator` (`creator`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `posts`
--

INSERT INTO `posts` (`id`, `creator`, `files`, `content`, `createdAt`, `updatedAt`) VALUES
(78, 82, 'http://localhost:3000/images/posts/Screenshot_3.png1634308109317.png', 'Salut ! Voici une photo de mes vacances !', '2021-10-15 14:28:29', '2021-10-15 14:28:29'),
(79, 83, NULL, 'Bonjour ! C\'est mon premier post ! :D', '2021-10-15 14:30:37', '2021-10-15 14:30:37'),
(82, 82, NULL, 'Mon premier post avec emoji 😀 !', '2021-10-20 10:29:49', '2021-10-20 10:29:49');

-- --------------------------------------------------------

--
-- Structure de la table `sequelizemeta`
--

DROP TABLE IF EXISTS `sequelizemeta`;
CREATE TABLE IF NOT EXISTS `sequelizemeta` (
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(15) COLLATE utf8mb4_general_ci NOT NULL,
  `lastname` varchar(15) COLLATE utf8mb4_general_ci NOT NULL,
  `job` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `account_type` tinyint(1) NOT NULL,
  `profile_picture` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'http://localhost:3000/images/users/default_PP.jpg',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `name`, `lastname`, `job`, `account_type`, `profile_picture`, `createdAt`, `updatedAt`) VALUES
(82, 'natthan.guilhot@laposte.net', '$2b$08$emlIu2FNa3iipjB9M.nJBuEHSDrcF8fiDAg54Mrc0WDjsKzYF1Nxy', 'Natthan', 'Guilhot', '', 0, 'http://localhost:3000/images/users/photodeprofilpro.jpg1634308092426.jpeg', '2021-10-15 14:27:48', '2021-10-15 14:28:12'),
(83, 'natthan.guilhot@laposte.fr', '$2b$08$JN0vnyvHW9PFmR8NJ45W/uAD4HYrV.HUcVp.GQJwxVdKGCFyLWiJu', 'Jean', 'Dupont', '', 0, 'http://localhost:3000/images/users/default_PP.jpg', '2021-10-15 14:29:03', '2021-10-15 14:29:03');

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
