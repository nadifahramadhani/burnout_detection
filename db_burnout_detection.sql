-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 16 Jul 2026 pada 15.16
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_burnout_detection`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `detections`
--

CREATE TABLE `detections` (
  `detection_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `journal_id` int(11) NOT NULL,
  `burnout_level` enum('Aman dan Sehat','Mulai Penat','Burnout Sedang','Burnout Berat') NOT NULL,
  `burnout_score` decimal(5,2) NOT NULL,
  `prob_normal` decimal(6,4) NOT NULL DEFAULT 0.0000,
  `prob_rendah` decimal(6,4) NOT NULL DEFAULT 0.0000,
  `prob_sedang` decimal(6,4) NOT NULL DEFAULT 0.0000,
  `prob_tinggi` decimal(6,4) NOT NULL DEFAULT 0.0000,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `detections`
--

INSERT INTO `detections` (`detection_id`, `user_id`, `journal_id`, `burnout_level`, `burnout_score`, `prob_normal`, `prob_rendah`, `prob_sedang`, `prob_tinggi`, `created_at`) VALUES
(1, 1, 9, '', 97.16, 0.5348, 0.9508, 1.3501, 97.1643, '2026-06-08 08:09:14'),
(2, 1, 10, 'Burnout Berat', 97.16, 0.5348, 0.9508, 1.3501, 97.1643, '2026-06-08 08:12:53'),
(3, 1, 11, 'Burnout Berat', 97.16, 0.5348, 0.9508, 1.3501, 97.1643, '2026-06-08 08:14:14'),
(4, 1, 12, 'Burnout Berat', 97.24, 0.5239, 0.9315, 1.3036, 97.2409, '2026-06-08 08:15:37'),
(5, 2, 13, 'Burnout Berat', 65.38, 1.2437, 31.2641, 2.1106, 65.3815, '2026-06-08 08:27:26'),
(6, 2, 14, 'Aman dan Sehat', 94.79, 94.7940, 2.3395, 1.9279, 0.9386, '2026-06-08 08:27:51'),
(7, 2, 15, 'Burnout Berat', 65.38, 1.2437, 31.2641, 2.1106, 65.3815, '2026-06-08 08:28:09'),
(8, 2, 16, 'Burnout Berat', 65.75, 1.2485, 30.8966, 2.1047, 65.7502, '2026-06-08 08:29:03'),
(9, 2, 17, 'Burnout Sedang', 88.90, 1.0306, 8.7298, 88.8989, 1.3407, '2026-06-08 08:29:23'),
(10, 2, 18, 'Burnout Berat', 97.42, 0.4986, 0.8163, 1.2701, 97.4150, '2026-06-08 08:29:57'),
(11, 2, 19, 'Burnout Sedang', 89.20, 1.0367, 8.4297, 89.1964, 1.3372, '2026-06-08 08:33:17'),
(12, 2, 20, 'Mulai Penat', 97.60, 1.1790, 97.5960, 0.7784, 0.4465, '2026-06-08 08:33:30'),
(13, 2, 21, 'Mulai Penat', 97.27, 1.3874, 97.2713, 0.8524, 0.4890, '2026-06-08 08:34:26'),
(14, 2, 22, 'Mulai Penat', 97.27, 1.3874, 97.2713, 0.8524, 0.4890, '2026-06-10 22:04:17'),
(15, 2, 23, 'Mulai Penat', 97.27, 1.3874, 97.2713, 0.8524, 0.4890, '2026-06-10 22:24:23'),
(16, 2, 24, 'Mulai Penat', 97.27, 1.3874, 97.2713, 0.8524, 0.4890, '2026-06-16 08:35:45'),
(17, 2, 25, 'Mulai Penat', 97.27, 1.3874, 97.2713, 0.8524, 0.4890, '2026-06-16 08:46:38'),
(18, 4, 26, 'Mulai Penat', 86.40, 1.6788, 86.3965, 11.0711, 0.8536, '2026-06-25 01:02:24'),
(19, 4, 27, 'Mulai Penat', 86.40, 1.6788, 86.3965, 11.0711, 0.8536, '2026-06-25 01:02:24'),
(20, 4, 28, 'Mulai Penat', 86.40, 1.6788, 86.3965, 11.0711, 0.8536, '2026-06-25 01:07:37'),
(21, 4, 29, 'Mulai Penat', 77.35, 1.0189, 77.3507, 1.2634, 20.3669, '2026-06-25 01:08:36'),
(22, 4, 30, 'Mulai Penat', 97.77, 0.9650, 97.7710, 0.4695, 0.7946, '2026-06-25 01:15:53'),
(23, 1, 31, 'Burnout Sedang', 97.85, 0.5095, 0.8312, 97.8481, 0.8112, '2026-06-26 07:23:14'),
(24, 1, 32, 'Burnout Sedang', 97.85, 0.5095, 0.8312, 97.8481, 0.8112, '2026-06-26 07:23:22'),
(25, 1, 33, 'Burnout Sedang', 97.85, 0.5095, 0.8312, 97.8481, 0.8112, '2026-06-26 07:23:51'),
(26, 1, 34, 'Burnout Sedang', 97.85, 0.5095, 0.8312, 97.8481, 0.8112, '2026-06-26 07:24:00'),
(27, 1, 35, 'Mulai Penat', 97.54, 1.2097, 97.5401, 0.8017, 0.4485, '2026-06-26 07:31:10'),
(28, 1, 36, 'Mulai Penat', 97.54, 1.2097, 97.5401, 0.8017, 0.4485, '2026-06-26 07:34:30'),
(29, 1, 37, 'Mulai Penat', 97.32, 1.3295, 97.3244, 0.8657, 0.4804, '2026-06-26 07:38:32'),
(30, 4, 38, 'Mulai Penat', 97.43, 1.1957, 97.4252, 0.8800, 0.4991, '2026-07-08 10:09:40'),
(31, 4, 39, 'Mulai Penat', 97.43, 1.1957, 97.4252, 0.8800, 0.4991, '2026-07-08 10:09:49'),
(32, 2, 40, 'Mulai Penat', 97.27, 1.3874, 97.2713, 0.8524, 0.4890, '2026-07-08 22:32:22');

-- --------------------------------------------------------

--
-- Struktur dari tabel `journals`
--

CREATE TABLE `journals` (
  `journal_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `text_jurnal` text NOT NULL,
  `mood` enum('Senang','Biasa Aja','Sedih','Marah') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `journals`
--

INSERT INTO `journals` (`journal_id`, `user_id`, `text_jurnal`, `mood`, `created_at`) VALUES
(4, 1, 'Hari ini sangat lelah, banyak tugas yang harus dikerjakan. Saya tidak bisa tidur dengan nyenyak, terus mikir tentang deadline. Mood saya jelek dan tidak bisa fokus belajar. Ini sudah minggu ketiga seperti ini. Saya merasa burnout sekali.', 'Sedih', '2026-06-08 07:53:49'),
(5, 1, 'Hari ini sangat lelah, banyak tugas yang harus dikerjakan. Saya tidak bisa tidur dengan nyenyak, terus mikir tentang deadline. Mood saya jelek dan tidak bisa fokus belajar. Ini sudah minggu ketiga seperti ini. Saya merasa burnout sekali.', 'Sedih', '2026-06-08 07:56:11'),
(6, 1, 'Hari ini sangat lelah, banyak tugas yang harus dikerjakan. Saya tidak bisa tidur dengan nyenyak, terus mikir tentang deadline. Mood saya jelek dan tidak bisa fokus belajar. Ini sudah minggu ketiga seperti ini. Saya merasa burnout sekali.', 'Sedih', '2026-06-08 07:56:58'),
(7, 1, 'Hari ini sangat lelah, banyak tugas yang harus dikerjakan. Saya tidak bisa tidur dengan nyenyak, terus mikir tentang deadline. Mood saya jelek dan tidak bisa fokus belajar. Ini sudah minggu ketiga seperti ini. Saya merasa burnout sekali.', 'Sedih', '2026-06-08 07:57:15'),
(8, 1, 'Hari ini sangat lelah, banyak tugas yang harus dikerjakan. Saya tidak bisa tidur dengan nyenyak, terus mikir tentang deadline. Mood saya jelek dan tidak bisa fokus belajar. Ini sudah minggu ketiga seperti ini. Saya merasa burnout sekali.', 'Sedih', '2026-06-08 08:05:09'),
(9, 1, 'Hari ini sangat lelah, banyak tugas yang harus dikerjakan. Saya tidak bisa tidur dengan nyenyak, terus mikir tentang deadline. Mood saya jelek dan tidak bisa fokus belajar. Ini sudah minggu ketiga seperti ini. Saya merasa burnout sekali.', 'Sedih', '2026-06-08 08:09:08'),
(10, 1, 'Hari ini sangat lelah, banyak tugas yang harus dikerjakan. Saya tidak bisa tidur dengan nyenyak, terus mikir tentang deadline. Mood saya jelek dan tidak bisa fokus belajar. Ini sudah minggu ketiga seperti ini. Saya merasa burnout sekali.', 'Sedih', '2026-06-08 08:12:47'),
(11, 1, 'Hari ini sangat lelah, banyak tugas yang harus dikerjakan. Saya tidak bisa tidur dengan nyenyak, terus mikir tentang deadline. Mood saya jelek dan tidak bisa fokus belajar. Ini sudah minggu ketiga seperti ini. Saya merasa burnout sekali.', 'Sedih', '2026-06-08 08:14:09'),
(12, 1, 'Hari ini sangat lelah, banyak tugas yang harus dikerjakan. Saya tidak bisa tidur dengan nyenyak, terus mikir tentang deadline. Mood saya jelek dan tidak bisa fokus belajar. Ini sudah minggu ketiga seperti ini. Saya merasa burnout sekali.', 'Sedih', '2026-06-08 08:15:37'),
(13, 2, 'Hari ini lumayan melelahkan. Tugas mulai menumpuk dan aku harus begadang sedikit untuk mengejar materi minggu depan. Rasanya sedikit bosan dan lelah, tapi aku yakin masih bisa mengatasinya setelah akhir pekan nanti.', 'Biasa Aja', '2026-06-08 08:27:18'),
(14, 2, 'Hari ini sangat menyenangkan! Saya berhasil menyelesaikan tugas dengan santai. Semalam tidur nyenyak sekali, jadi hari ini badan terasa segar dan siap untuk belajar lagi. Sore tadi juga sempat jogging ringan bersama teman-teman.', 'Senang', '2026-06-08 08:27:51'),
(15, 2, 'Hari ini lumayan melelahkan. Tugas mulai menumpuk dan aku harus begadang sedikit untuk mengejar materi minggu depan. Rasanya sedikit bosan dan lelah, tapi aku yakin masih bisa mengatasinya setelah akhir pekan nanti.', 'Biasa Aja', '2026-06-08 08:28:09'),
(16, 2, 'Hari ini lumayan melelahkan. Tapi aku cukup senang karena bisa kumpul dan ketawa bareng teman-teman, itu mengobati lelahnya menghadapi duaniawi.', 'Biasa Aja', '2026-06-08 08:29:03'),
(17, 2, 'Hari ini lumayan melelahkan. Tapi aku cukup senang karena bisa kumpul dan ketawa bareng teman-teman, itu mengobati lelahnya menghadapi duaniawi.', 'Biasa Aja', '2026-06-08 08:29:23'),
(18, 2, 'Aku benci semua ini! Aku tidak sanggup lagi, aku ingin menyerah saja! Kepala rasanya mau pecah setiap kali melihat buku pelajaran. Aku tidak bisa tidur berhari-hari karena cemas mikirin nilai dan deadline. Percuma aku paksa belajar belasan jam kalau akhirnya aku hancur seperti ini. Aku benar-benar muak!', 'Marah', '2026-06-08 08:29:57'),
(19, 2, 'aku masih bisa loh menghadapi gadebak geadbuk duniawi ini, aku walupun aku kadang merasa sedikit capek tapi aku yakin aku bisa gitu loh, kayak maasalah tempat magang aku udah capek kan cari2 kesana kemari, aku penganya sih mau sama teman2 yang aku doa2kan itu tapi ternyata mereka ada keinginanya sendiri jadi aku gak bisa memaksa, jadi aku lebih memilih untuk magang bareng mutia, waluapun itu diluar rencana aku dan hati aku agak berat gituloh sama dia, tapi aku yakin mungkin ini adalh rencana allah, semoga ini pilhan yang tepat!', 'Biasa Aja', '2026-06-08 08:33:17'),
(20, 2, 'aku masih bisa loh menghadapi gadebak geadbuk duniawi ini, aku walupun aku kadang merasa sedikit capek tapi aku yakin aku bisa gitu loh, kayak maasalah tempat magang aku udah capek kan cari2 kesana kemari, aku penganya sih mau sama teman2 yang aku doa2kan itu tapi ternyata mereka ada keinginanya sendiri jadi aku gak bisa memaksa, jadi aku lebih memilih untuk magang bareng mutia, waluapun itu diluar rencana aku dan hati aku agak berat gituloh sama dia, tapi aku yakin mungkin ini adalh rencana allah, semoga ini pilhan yang tepat!', 'Biasa Aja', '2026-06-08 08:33:30'),
(21, 2, 'aku masih bisa loh menghadapi gadebak geadbuk duniawi ini, aku walupun aku kadang merasa sedikit capek tapi aku yakin aku bisa gitu loh, kayak maasalah tempat magang aku udah capek kan cari2 kesana kemari, aku penganya sih mau sama teman2 yang aku doa2kan itu tapi ternyata mereka ada keinginanya sendiri jadi aku gak bisa memaksa, jadi aku lebih memilih untuk magang bareng mutia, waluapun itu diluar rencana aku dan hati aku agak berat gituloh sama dia, tapi aku yakin mungkin ini adalh rencana allah, semoga ini pilhan yang tepat!', 'Biasa Aja', '2026-06-08 08:34:26'),
(22, 2, 'aku masih bisa loh menghadapi gadebak geadbuk duniawi ini, aku walupun aku kadang merasa sedikit capek tapi aku yakin aku bisa gitu loh, kayak maasalah tempat magang aku udah capek kan cari2 kesana kemari, aku penganya sih mau sama teman2 yang aku doa2kan itu tapi ternyata mereka ada keinginanya sendiri jadi aku gak bisa memaksa, jadi aku lebih memilih untuk magang bareng mutia, waluapun itu diluar rencana aku dan hati aku agak berat gituloh, tapi aku yakin mungkin ini adalh rencana allah, semoga ini pilhan yang tepat!', 'Biasa Aja', '2026-06-10 22:03:54'),
(23, 2, 'aku masih bisa loh menghadapi gadebak geadbuk duniawi ini, aku walupun aku kadang merasa sedikit capek tapi aku yakin aku bisa gitu loh, kayak maasalah tempat magang aku udah capek kan cari2 kesana kemari, aku penganya sih mau sama teman2 yang aku doa2kan itu tapi ternyata mereka ada keinginanya sendiri jadi aku gak bisa memaksa, jadi aku lebih memilih untuk magang bareng mutia, waluapun itu diluar rencana aku dan hati aku agak berat gituloh, tapi aku yakin mungkin ini adalh rencana allah, semoga ini pilhan yang tepat!', 'Biasa Aja', '2026-06-10 22:24:23'),
(24, 2, 'aku masih bisa loh menghadapi gadebak geadbuk duniawi ini, aku walupun aku kadang merasa sedikit capek tapi aku yakin aku bisa gitu loh, kayak maasalah tempat magang aku udah capek kan cari2 kesana kemari, aku penganya sih mau sama teman2 yang aku doa2kan itu tapi ternyata mereka ada keinginanya sendiri jadi aku gak bisa memaksa, jadi aku lebih memilih untuk magang bareng mutia, waluapun itu diluar rencana aku dan hati aku agak berat gituloh, tapi aku yakin mungkin ini adalh rencana allah, semoga ini pilhan yang tepat!', 'Biasa Aja', '2026-06-16 08:35:24'),
(25, 2, 'aku masih bisa loh menghadapi gadebak geadbuk duniawi ini, aku walupun aku kadang merasa sedikit capek tapi aku yakin aku bisa gitu loh, kayak maasalah tempat magang aku udah capek kan cari2 kesana kemari, aku penganya sih mau sama teman2 yang aku doa2kan itu tapi ternyata mereka ada keinginanya sendiri jadi aku gak bisa memaksa, jadi aku lebih memilih untuk magang bareng mutia, waluapun itu diluar rencana aku dan hati aku agak berat gituloh, tapi aku yakin mungkin ini adalh rencana allah, semoga ini pilhan yang tepat!', 'Biasa Aja', '2026-06-16 08:46:31'),
(26, 4, 'capek banget gilaa gak kuat anjerr', 'Sedih', '2026-06-25 01:01:41'),
(27, 4, 'capek banget gilaa gak kuat anjerr', 'Sedih', '2026-06-25 01:02:18'),
(28, 4, 'capek banget gilaa gak kuat anjerr', 'Sedih', '2026-06-25 01:07:36'),
(29, 4, 'capek banget gilaa gak kuat anjerr', 'Sedih', '2026-06-25 01:08:36'),
(30, 4, 'capek banget gilaa gak kuat anjerr', 'Sedih', '2026-06-25 01:15:53'),
(31, 1, 'aku masih bisa loh menghadapi gadebak geadbuk duniawi ini, aku walupun aku kadang merasa sedikit capek tapi aku yakin aku bisa gitu loh, kayak maasalah tempat magang aku udah capek kan cari2 kesana kemari, aku penganya sih mau sama teman2 yang aku doa2kan itu tapi ternyata mereka ada keinginanya sendiri jadi aku gak bisa memaksa, jadi aku lebih memilih untuk magang bareng mutia, waluapun itu diluar rencana aku dan hati aku agak berat gituloh, tapi aku yakin mungkin ini adalh rencana allah, semoga ini pilhan yang tepat!', 'Sedih', '2026-06-26 07:22:44'),
(32, 1, 'aku masih bisa loh menghadapi gadebak geadbuk duniawi ini, aku walupun aku kadang merasa sedikit capek tapi aku yakin aku bisa gitu loh, kayak maasalah tempat magang aku udah capek kan cari2 kesana kemari, aku penganya sih mau sama teman2 yang aku doa2kan itu tapi ternyata mereka ada keinginanya sendiri jadi aku gak bisa memaksa, jadi aku lebih memilih untuk magang bareng mutia, waluapun itu diluar rencana aku dan hati aku agak berat gituloh, tapi aku yakin mungkin ini adalh rencana allah, semoga ini pilhan yang tepat!', 'Sedih', '2026-06-26 07:23:22'),
(33, 1, 'aku masih bisa loh menghadapi gadebak geadbuk duniawi ini, aku walupun aku kadang merasa sedikit capek tapi aku yakin aku bisa gitu loh, kayak maasalah tempat magang aku udah capek kan cari2 kesana kemari, aku penganya sih mau sama teman2 yang aku doa2kan itu tapi ternyata mereka ada keinginanya sendiri jadi aku gak bisa memaksa, jadi aku lebih memilih untuk magang bareng mutia, waluapun itu diluar rencana aku dan hati aku agak berat gituloh, tapi aku yakin mungkin ini adalh rencana allah, semoga ini pilhan yang tepat!', 'Sedih', '2026-06-26 07:23:51'),
(34, 1, 'aku masih bisa loh menghadapi gadebak geadbuk duniawi ini, aku walupun aku kadang merasa sedikit capek tapi aku yakin aku bisa gitu loh, kayak maasalah tempat magang aku udah capek kan cari2 kesana kemari, aku penganya sih mau sama teman2 yang aku doa2kan itu tapi ternyata mereka ada keinginanya sendiri jadi aku gak bisa memaksa, jadi aku lebih memilih untuk magang bareng mutia, waluapun itu diluar rencana aku dan hati aku agak berat gituloh, tapi aku yakin mungkin ini adalh rencana allah, semoga ini pilhan yang tepat!', 'Sedih', '2026-06-26 07:24:00'),
(35, 1, 'aku masih bisa loh menghadapi gadebak geadbuk duniawi ini, aku walupun aku kadang merasa sedikit capek tapi aku yakin aku bisa gitu loh, kayak maasalah tempat magang aku udah capek kan cari2 kesana kemari, aku penganya sih mau sama teman2 yang aku doa2kan itu tapi ternyata mereka ada keinginanya sendiri jadi aku gak bisa memaksa, jadi aku lebih memilih untuk magang bareng mutia, waluapun itu diluar rencana aku dan hati aku agak berat gituloh, tapi aku yakin mungkin ini adalh rencana allah, semoga ini pilhan yang tepat!', 'Biasa Aja', '2026-06-26 07:31:10'),
(36, 1, 'aku masih bisa loh menghadapi gadebak geadbuk duniawi ini, aku walupun aku kadang merasa sedikit capek tapi aku yakin aku bisa gitu loh, kayak maasalah tempat magang aku udah capek kan cari2 kesana kemari, aku penganya sih mau sama teman2 yang aku doa2kan itu tapi ternyata mereka ada keinginanya sendiri jadi aku gak bisa memaksa, jadi aku lebih memilih untuk magang bareng mutia, waluapun itu diluar rencana aku dan hati aku agak berat gituloh, tapi aku yakin mungkin ini adalh rencana allah, semoga ini pilhan yang tepat!', 'Biasa Aja', '2026-06-26 07:34:30'),
(37, 1, 'aku masih bisa loh menghadapi gadebak geadbuk duniawi ini, aku walupun aku kadang merasa sedikit capek tapi aku yakin aku bisa gitu loh, kayak maasalah tempat magang aku udah capek kan cari2 kesana kemari, aku penganya sih mau sama teman2 yang aku doa2kan itu tapi ternyata mereka ada keinginanya sendiri jadi aku gak bisa memaksa, jadi aku lebih memilih untuk magang bareng mutia, waluapun itu diluar rencana aku dan hati aku agak berat gituloh, tapi aku yakin mungkin ini adalh rencana allah, semoga ini pilhan yang tepat!', 'Biasa Aja', '2026-06-26 07:38:32'),
(38, 4, 'aduh senang bangetttt', 'Senang', '2026-07-08 10:09:13'),
(39, 4, 'aduh senang bangetttt', 'Senang', '2026-07-08 10:09:49'),
(40, 2, 'aku masih bisa loh menghadapi gadebak geadbuk duniawi ini, aku walupun aku kadang merasa sedikit capek tapi aku yakin aku bisa gitu loh, kayak maasalah tempat magang aku udah capek kan cari2 kesana kemari, aku penganya sih mau sama teman2 yang aku doa2kan itu tapi ternyata mereka ada keinginanya sendiri jadi aku gak bisa memaksa, jadi aku lebih memilih untuk magang bareng mutia, waluapun itu diluar rencana aku dan hati aku agak berat gituloh, tapi aku yakin mungkin ini adalh rencana allah, semoga ini pilhan yang tepat!', 'Biasa Aja', '2026-07-08 22:31:55');

-- --------------------------------------------------------

--
-- Struktur dari tabel `lifestyles`
--

CREATE TABLE `lifestyles` (
  `lifestyle_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `journal_id` int(11) NOT NULL,
  `study_hours_per_day` float(4,2) NOT NULL DEFAULT 0.00,
  `sleep_hours` float(4,2) NOT NULL DEFAULT 0.00,
  `exercise_minute` int(5) NOT NULL DEFAULT 0,
  `breaks_per_day` tinyint(2) NOT NULL DEFAULT 0,
  `coffee_intake_mg` smallint(5) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `lifestyles`
--

INSERT INTO `lifestyles` (`lifestyle_id`, `user_id`, `journal_id`, `study_hours_per_day`, `sleep_hours`, `exercise_minute`, `breaks_per_day`, `coffee_intake_mg`, `created_at`) VALUES
(1, 1, 4, 8.00, 4.50, 0, 1, 300, '2026-06-08 07:53:49'),
(2, 1, 5, 8.00, 4.50, 0, 1, 300, '2026-06-08 07:56:11'),
(3, 1, 6, 8.00, 4.50, 0, 1, 300, '2026-06-08 07:56:58'),
(4, 1, 7, 8.00, 4.50, 0, 0, 0, '2026-06-08 07:57:15'),
(5, 1, 8, 8.00, 4.50, 0, 1, 300, '2026-06-08 08:05:09'),
(6, 1, 9, 8.00, 4.50, 0, 1, 300, '2026-06-08 08:09:08'),
(7, 1, 10, 8.00, 4.50, 0, 1, 300, '2026-06-08 08:12:47'),
(8, 1, 11, 8.00, 4.50, 0, 1, 300, '2026-06-08 08:14:09'),
(9, 1, 12, 8.00, 4.50, 20, 1, 300, '2026-06-08 08:15:37'),
(10, 2, 13, 6.00, 6.00, 15, 2, 100, '2026-06-08 08:27:18'),
(11, 2, 14, 3.00, 8.00, 60, 3, 0, '2026-06-08 08:27:51'),
(12, 2, 15, 6.00, 6.00, 15, 2, 100, '2026-06-08 08:28:09'),
(13, 2, 16, 6.00, 6.00, 15, 2, 100, '2026-06-08 08:29:03'),
(14, 2, 17, 6.00, 10.00, 15, 2, 0, '2026-06-08 08:29:23'),
(15, 2, 18, 13.00, 3.00, 0, 0, 600, '2026-06-08 08:29:57'),
(16, 2, 19, 6.00, 10.00, 0, 8, 0, '2026-06-08 08:33:17'),
(17, 2, 20, 3.00, 10.00, 0, 8, 0, '2026-06-08 08:33:30'),
(18, 2, 21, 1.00, 10.00, 0, 14, 0, '2026-06-08 08:34:26'),
(19, 2, 22, 1.00, 10.00, 0, 14, 0, '2026-06-10 22:03:54'),
(20, 2, 23, 1.00, 10.00, 0, 14, 0, '2026-06-10 22:24:23'),
(21, 2, 24, 1.00, 10.00, 0, 14, 0, '2026-06-16 08:35:24'),
(22, 2, 25, 1.00, 10.00, 0, 14, 0, '2026-06-16 08:46:31'),
(23, 4, 26, 5.00, 10.72, 30, 2, 50, '2026-06-25 01:01:41'),
(24, 4, 27, 5.00, 10.72, 30, 2, 50, '2026-06-25 01:02:18'),
(25, 4, 28, 5.00, 10.72, 30, 6, 50, '2026-06-25 01:07:36'),
(26, 4, 29, 5.00, 2.78, 30, 6, 50, '2026-06-25 01:08:36'),
(27, 4, 30, 3.50, 4.50, 30, 5, 50, '2026-06-25 01:15:53'),
(28, 1, 31, 7.00, 9.50, 35, 5, 0, '2026-06-26 07:22:44'),
(29, 1, 32, 7.00, 9.50, 35, 5, 0, '2026-06-26 07:23:22'),
(30, 1, 33, 7.00, 9.50, 35, 5, 0, '2026-06-26 07:23:51'),
(31, 1, 34, 7.00, 9.50, 35, 5, 0, '2026-06-26 07:24:00'),
(32, 1, 35, 2.00, 9.50, 0, 3, 0, '2026-06-26 07:31:10'),
(33, 1, 36, 2.00, 9.50, 0, 3, 0, '2026-06-26 07:34:30'),
(34, 1, 37, 0.50, 8.50, 0, 3, 0, '2026-06-26 07:38:32'),
(35, 4, 38, 4.50, 7.50, 15, 7, 30, '2026-07-08 10:09:13'),
(36, 4, 39, 4.50, 7.50, 15, 7, 30, '2026-07-08 10:09:49'),
(37, 2, 40, 1.00, 10.00, 0, 14, 0, '2026-07-08 22:31:55');

-- --------------------------------------------------------

--
-- Struktur dari tabel `token_blacklist`
--

CREATE TABLE `token_blacklist` (
  `id` int(11) NOT NULL,
  `jti` varchar(36) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `revoked_at` datetime NOT NULL,
  `expires_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `token_blacklist`
--

INSERT INTO `token_blacklist` (`id`, `jti`, `user_id`, `revoked_at`, `expires_at`) VALUES
(1, '34e2e174-ced5-40f1-a64c-128ee78f82fa', 2, '2026-06-16 13:39:01', '2026-06-16 14:37:43'),
(2, '09e3eb1f-76cb-4fe0-816e-ad4ba9285ec6', 1, '2026-06-27 17:13:57', '2026-06-27 17:39:54'),
(3, 'eded441c-5662-4ddc-a9b2-7fa53fbc3c70', 4, '2026-07-02 16:42:25', '2026-07-02 17:19:46'),
(4, '3de65b2d-9fec-455d-bcae-7d293191fd42', 1, '2026-07-02 16:47:25', '2026-07-02 17:42:49'),
(5, '2287f804-bdd7-44c0-b072-606fabd5d41b', 4, '2026-07-08 17:02:58', '2026-07-08 18:02:04'),
(6, '591b7817-c222-465f-96f6-3da7115deefb', 4, '2026-07-08 17:25:42', '2026-07-08 18:06:38');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `age` tinyint(2) DEFAULT NULL,
  `gender` enum('L','P') DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`user_id`, `first_name`, `last_name`, `email`, `password`, `age`, `gender`, `created_at`, `updated_at`) VALUES
(1, 'Nadifah cantikkkkk', 'Ramadhani Updated', 'nadifah.test@email.com', 'scrypt:32768:8:1$w6PvoAgViFieM9UP$73b449d5c19d248543ff92fc781841bef02f809329308a0c612e4bff6d634c5f8fa31ab47c348ef466817ac5f276f725f8768aa827f1d298e6cfd812df76a990', 23, 'P', '2026-06-08 06:40:34', '2026-06-27 10:08:33'),
(2, 'Nadifah', 'Ramadhani Updated Baru', 'coba.test@email.com', 'scrypt:32768:8:1$37SsOtKy3CIdZZs3$5f435a87b5def7682b5aaa17ab42f1f7bbb3c013e91ef41ff26d6d89966f713148cbd1a50c4772c8d4714ee63737a4607c085533947ea5a53db2ef7ebe04b5a1', 21, 'P', '2026-06-08 07:03:28', '2026-07-08 22:29:39'),
(3, 'nadifahhh', 'coba', 'cipahh.test@email.com', 'scrypt:32768:8:1$NdLFg5k5BxiLBMjG$59484549c31b9a2a36b397f74bc80bac85b479466990da5d680afa24c6f35fdc9554931f227773951b8bf0034b11cf17f979feb5eccc94e0765e216da687ba31', 21, 'P', '2026-06-10 22:26:38', '2026-06-10 22:26:38'),
(4, 'budi', 'santoso', 'nadifah@gmail.com', 'scrypt:32768:8:1$AeKYFT8nq0M9t1r5$1aefcca8f0bb8f4ff01e93e4cae372b965c5445eb204e8d3f9e729a9c672cefaebff01ede6d4d7e49e25e8bc859d16b3abf2b3c6140aecb18b80224f8773accb', 17, 'L', '2026-06-24 07:01:41', '2026-07-08 10:22:26'),
(5, 'test', 'testt', 'coba', 'scrypt:32768:8:1$bs8EclSyfTuOgkeh$b8123ff3e4c0377a2d119a4a28e54c6303f5f52c2bbe899e0ec74a8677c46641862b1367e5c4dcb9723bae5967520bbe3c39a9de1a62db6e8a4e337313a1b86b', NULL, NULL, '2026-07-08 10:03:40', '2026-07-08 10:03:40'),
(6, 'coba', 'test', 'coba@gmail.com', 'scrypt:32768:8:1$LjLyY0qXtP7ezhif$c30b2d866798a53d61c2bd345a1abcf5621bf2929ed0aeef6534c7f780e0fb9ad6f5f9e9a96e6875b85a15e76ef2d74bbe03f4feec04317ba656f6731dea13c1', NULL, NULL, '2026-07-08 10:04:52', '2026-07-08 10:04:52'),
(7, 'nadifahhh', 'coba', 'tututu.test@email.com', 'scrypt:32768:8:1$hlI25wtJh4RiPMnM$81db0cd7ea9c08cdf7da12c4f0df9e2a059dd56f7182c118e2284031423086e1b95c03fe9a9db7a362524643c8b2bb0bb3f47fc44dfec7cb3d4d3b03e34fe69f', 21, 'P', '2026-07-08 22:23:34', '2026-07-08 22:23:34');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `detections`
--
ALTER TABLE `detections`
  ADD PRIMARY KEY (`detection_id`),
  ADD UNIQUE KEY `uq_detection_jurnal` (`journal_id`),
  ADD KEY `fk_detection_user_idx` (`user_id`);

--
-- Indeks untuk tabel `journals`
--
ALTER TABLE `journals`
  ADD PRIMARY KEY (`journal_id`),
  ADD KEY `fk_journal_user_idx` (`user_id`);

--
-- Indeks untuk tabel `lifestyles`
--
ALTER TABLE `lifestyles`
  ADD PRIMARY KEY (`lifestyle_id`),
  ADD KEY `fk_lifestyle_user_idx` (`user_id`),
  ADD KEY `fk_lifestyle_journal_idx` (`journal_id`);

--
-- Indeks untuk tabel `token_blacklist`
--
ALTER TABLE `token_blacklist`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ix_token_blacklist_jti` (`jti`),
  ADD KEY `ix_token_blacklist_user_id` (`user_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `uq_user_email` (`email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `detections`
--
ALTER TABLE `detections`
  MODIFY `detection_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT untuk tabel `journals`
--
ALTER TABLE `journals`
  MODIFY `journal_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT untuk tabel `lifestyles`
--
ALTER TABLE `lifestyles`
  MODIFY `lifestyle_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT untuk tabel `token_blacklist`
--
ALTER TABLE `token_blacklist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `detections`
--
ALTER TABLE `detections`
  ADD CONSTRAINT `fk_detection_journal` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_detection_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `journals`
--
ALTER TABLE `journals`
  ADD CONSTRAINT `fk_journal_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `lifestyles`
--
ALTER TABLE `lifestyles`
  ADD CONSTRAINT `fk_lifestyle_journal` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_lifestyle_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `token_blacklist`
--
ALTER TABLE `token_blacklist`
  ADD CONSTRAINT `token_blacklist_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
