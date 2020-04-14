-- This file will be executed when running migrate up
CREATE TABLE IF NOT EXISTS website.users(
   id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   status int NOT NULL DEFAULT 0
);