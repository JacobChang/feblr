-- This file will be executed when running migrate up
CREATE TABLE IF NOT EXISTS website.emails(
   addr VARCHAR(2048) NOT NULL PRIMARY KEY,
   status int NOT NULL DEFAULT 0
);