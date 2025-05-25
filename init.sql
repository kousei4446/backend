SET NAMES utf8mb4;
CREATE DATABASE IF NOT EXISTS quiz
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE quiz;

CREATE TABLE IF NOT EXISTS trx_user (
  u_id              VARCHAR(255) PRIMARY KEY,
  email             VARCHAR(255) NOT NULL,
  user_name         VARCHAR(255) NOT NULL,
  icon_path         VARCHAR(255) DEFAULT 'default.png',
  role              ENUM('user','admin') DEFAULT 'user',
  hard_clear_num    INT DEFAULT 0,
  normal_clear_num  INT DEFAULT 0,
  easy_clear_num    INT DEFAULT 0,
  hard_correct_num  INT DEFAULT 0,
  normal_correct_num INT DEFAULT 0,
  easy_correct_num  INT DEFAULT 0,
  created_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at        TIMESTAMP NULL
);

CREATE TABLE IF NOT EXISTS quizzes (
  id           INT AUTO_INCREMENT PRIMARY KEY,
  level        ENUM('hard','normal','easy') NOT NULL,
  level_id     INT NOT NULL,
  quiz         TEXT NOT NULL,
  option1      TEXT,
  option2      TEXT,
  option3      TEXT,
  option4      TEXT,
  answer       VARCHAR(255),
  explanation  TEXT,
  created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at   TIMESTAMP NULL
);


INSERT INTO trx_user
  (u_id, email, user_name)
VALUES
  ('user001', 'alice@example.com', 'Alice'),
  ('user002', 'bob@example.com',   'Bob');


CREATE USER IF NOT EXISTS 'quizuser'@'%' IDENTIFIED BY 'quizpass';
GRANT ALL PRIVILEGES ON quiz.* TO 'quizuser'@'%';
FLUSH PRIVILEGES;
