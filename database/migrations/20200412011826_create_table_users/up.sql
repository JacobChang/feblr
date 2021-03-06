-- This file will be executed when running migrate up
CREATE TABLE IF NOT EXISTS website.users(
   id BIGINT GENERATED ALWAYS AS IDENTITY,
   created_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
   updated_date TIMESTAMP WITH TIME ZONE,
   status int NOT NULL DEFAULT 0,
   CONSTRAINT users_primary_key_id PRIMARY KEY (id)
);