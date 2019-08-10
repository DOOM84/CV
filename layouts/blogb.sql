-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 05, 2019 at 11:37 AM
-- Server version: 5.7.26-0ubuntu0.18.04.1
-- PHP Version: 7.2.19-1+ubuntu18.04.1+deb.sury.org+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `blogb`
--

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE `likes` (
  `id` int(10) UNSIGNED NOT NULL,
  `likeable_id` int(10) UNSIGNED NOT NULL,
  `likeable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `likes`
--

INSERT INTO `likes` (`id`, `likeable_id`, `likeable_type`, `user_id`, `created_at`, `updated_at`) VALUES
(15, 5, 'App\\Post', 6, '2019-06-03 08:42:50', '2019-06-03 08:42:50'),
(16, 4, 'App\\Post', 6, '2019-06-03 08:42:54', '2019-06-03 08:42:54'),
(17, 9, 'App\\Post', 6, '2019-06-03 08:43:07', '2019-06-03 08:43:07'),
(18, 6, 'App\\Post', 6, '2019-06-03 08:44:42', '2019-06-03 08:44:42');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_05_28_084514_create_topics_table', 2),
(4, '2019_05_28_084527_create_posts_table', 2),
(5, '2019_06_03_081802_create_likes_table', 3);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(10) UNSIGNED NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `topic_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `body`, `topic_id`, `user_id`, `created_at`, `updated_at`) VALUES
(4, 'Body for new topic', 4, 9, '2019-05-28 07:35:36', '2019-05-28 07:35:36'),
(5, 'Second topic body', 5, 1, '2019-05-28 07:36:54', '2019-05-28 07:36:54'),
(6, 'New post by me', 30, 1, '2019-06-02 06:51:00', '2019-06-02 07:34:14'),
(9, 'New body (upd)', 33, 1, '2019-06-02 07:45:59', '2019-06-02 08:00:25'),
(10, 'Another body', 33, 6, '2019-06-02 08:06:21', '2019-06-02 08:06:21');

-- --------------------------------------------------------

--
-- Table structure for table `topics`
--

CREATE TABLE `topics` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `topics`
--

INSERT INTO `topics` (`id`, `title`, `user_id`, `created_at`, `updated_at`) VALUES
(4, 'New topic 1', 9, '2019-05-28 07:35:36', '2019-06-02 05:33:25'),
(5, 'Second topic title', 1, '2019-05-28 07:36:54', '2019-05-28 07:36:54'),
(6, 'New topic2', 1, '2019-05-28 07:37:36', '2019-05-28 07:37:36'),
(7, 'Second topic title2', 1, '2019-05-28 07:38:54', '2019-05-28 07:38:54'),
(8, 'New topic3', 1, '2019-05-28 07:39:36', '2019-05-28 07:39:36'),
(9, 'Second topic title3', 1, '2019-05-28 07:40:54', '2019-05-28 07:40:54'),
(10, 'New topic4', 1, '2019-05-28 07:41:36', '2019-05-28 07:41:36'),
(11, 'Second topic title4', 1, '2019-05-28 07:42:54', '2019-05-28 07:42:54'),
(22, 'New topic', 1, '2019-05-28 07:35:36', '2019-05-28 07:35:36'),
(23, 'Second topic title', 1, '2019-05-28 07:36:54', '2019-05-28 07:36:54'),
(24, 'New topic2', 1, '2019-05-28 07:37:36', '2019-05-28 07:37:36'),
(25, 'Second topic title2', 1, '2019-05-28 07:38:54', '2019-05-28 07:38:54'),
(26, 'New topic3', 1, '2019-05-28 07:39:36', '2019-05-28 07:39:36'),
(27, 'Second topic title3', 1, '2019-05-28 07:40:54', '2019-05-28 07:40:54'),
(28, 'New topic4', 1, '2019-05-28 07:41:36', '2019-05-28 07:41:36'),
(29, 'Second topic title4', 1, '2019-05-28 07:42:54', '2019-05-28 07:42:54'),
(30, 'New topic5', 1, '2019-05-28 07:43:36', '2019-05-28 07:43:36'),
(31, 'Second topic title4', 1, '2019-05-28 07:42:54', '2019-05-28 07:42:54'),
(32, 'New topic5', 1, '2019-05-28 07:43:36', '2019-05-28 07:43:36'),
(33, 'New topic (upd)', 1, '2019-06-02 07:45:59', '2019-06-02 07:59:02');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'DOOM', 'd00m7@ukr.net', NULL, '$2y$10$CwZwjgb4auDoXCoH5bjxeOr.JZl0hlBcnyFSTUV.TjGN1Kv7LNRVi', NULL, '2019-05-23 06:54:21', '2019-05-23 06:54:21'),
(6, 'DOOM84', '_doom_@ukr.net', NULL, '$2y$10$O2/ojtFJCt5HtqvivgUvWup8r4px855xSM52SNM5IxRkobd0phjiG', NULL, '2019-05-23 07:38:33', '2019-05-23 07:38:33'),
(8, 'DOOM7', 'd00m7@bk.ru', NULL, '$2y$10$4hKfOtynCwjpvqmV50Lzw.JfnqXouZKt5.lOWEVYISBvo1iphxfZS', NULL, '2019-05-27 06:34:36', '2019-05-27 06:34:36'),
(9, 'DOOM77', 'asd@asd.com', NULL, '$2y$10$8ZJkJMjk/zYqbxPykPL8QOp/L4sDlbqKUuFNYJJ2.4NJaNQeZs.Mq', NULL, '2019-05-27 09:44:42', '2019-05-27 09:44:42');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `likes_user_id_index` (`user_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `posts_topic_id_index` (`topic_id`),
  ADD KEY `posts_user_id_index` (`user_id`);

--
-- Indexes for table `topics`
--
ALTER TABLE `topics`
  ADD PRIMARY KEY (`id`),
  ADD KEY `topics_user_id_index` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `likes`
--
ALTER TABLE `likes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `topics`
--
ALTER TABLE `topics`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `likes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_topic_id_foreign` FOREIGN KEY (`topic_id`) REFERENCES `topics` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `posts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `topics`
--
ALTER TABLE `topics`
  ADD CONSTRAINT `topics_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
