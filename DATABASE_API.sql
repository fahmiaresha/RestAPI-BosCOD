-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 28, 2023 at 04:42 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `api_boscod`
--

-- --------------------------------------------------------

--
-- Table structure for table `bank`
--

CREATE TABLE `bank` (
  `id_bank` int(11) NOT NULL,
  `nama_bank` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bank`
--

INSERT INTO `bank` (`id_bank`, `nama_bank`) VALUES
(1, 'BCA'),
(2, 'BNI'),
(3, 'MANDIRI'),
(4, 'BRI');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(3, '2019_08_19_000000_create_failed_jobs_table', 1);

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
-- Table structure for table `rekening_admin`
--

CREATE TABLE `rekening_admin` (
  `id` int(11) NOT NULL,
  `id_bank` int(11) NOT NULL,
  `nomor_rekening` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rekening_admin`
--

INSERT INTO `rekening_admin` (`id`, `id_bank`, `nomor_rekening`) VALUES
(1, 1, '0329009779'),
(2, 2, '0106427035'),
(3, 3, '1110004590473'),
(4, 4, '034101000743333');

-- --------------------------------------------------------

--
-- Table structure for table `transaksi_transfer`
--

CREATE TABLE `transaksi_transfer` (
  `id_transaksi` varchar(50) NOT NULL,
  `nilai_transfer` double NOT NULL,
  `bank_tujuan` varchar(11) NOT NULL,
  `rekening_tujuan` varchar(50) NOT NULL,
  `atasnama_tujuan` varchar(50) NOT NULL,
  `bank_pengirim` varchar(11) NOT NULL,
  `kode_unik` varchar(5) NOT NULL,
  `biaya_admin` double NOT NULL,
  `total_transfer` double NOT NULL,
  `bank_perantara` varchar(11) NOT NULL,
  `rekening_perantara` varchar(50) NOT NULL,
  `berlaku_hingga` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `transaksi_transfer`
--

INSERT INTO `transaksi_transfer` (`id_transaksi`, `nilai_transfer`, `bank_tujuan`, `rekening_tujuan`, `atasnama_tujuan`, `bank_pengirim`, `kode_unik`, `biaya_admin`, `total_transfer`, `bank_perantara`, `rekening_perantara`, `berlaku_hingga`, `created_at`) VALUES
('TF23012800001', 50000, 'BCA', '60184819383', 'Fulan', 'BNI', '845', 0, 50845, 'BNI', '0106427035', '2023-01-28T10:01:02+07:00', '2023-01-28 10:01:02');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(4, 'fahmi', 'fahmi', NULL, '$2y$10$tD7DYKjOBr9GMfFLnZOPXeikncuoRkul1rIZKCZXTg6vPAtZjSTCu', NULL, '2023-01-23 05:34:53', '2023-01-23 05:34:53'),
(5, 'fahmi2', 'fahmi2', NULL, '$2y$10$J10lhOiKblf5L/3KYd8G8eEkesJmpKZCLV5FdwFXDgKpExDp2TaCC', NULL, '2023-01-23 05:42:08', '2023-01-23 05:42:08'),
(6, 'fahmi aresha', 'fahmiaresha', NULL, '$2y$10$u7WfTqUw5mkJ2k9cPIuYGOIkRiqlzXLsqzDxjzvOb2NYG8DbetSoy', NULL, '2023-01-27 20:17:02', '2023-01-27 20:17:02');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bank`
--
ALTER TABLE `bank`
  ADD PRIMARY KEY (`id_bank`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `rekening_admin`
--
ALTER TABLE `rekening_admin`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_ID_BANK` (`id_bank`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bank`
--
ALTER TABLE `bank`
  MODIFY `id_bank` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `rekening_admin`
--
ALTER TABLE `rekening_admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `rekening_admin`
--
ALTER TABLE `rekening_admin`
  ADD CONSTRAINT `FK_ID_BANK` FOREIGN KEY (`id_bank`) REFERENCES `bank` (`id_bank`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
