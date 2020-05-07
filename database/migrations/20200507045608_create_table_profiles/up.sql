-- This file will be executed when running migrate up
CREATE TABLE IF NOT EXISTS website.profiles(
   id BIGINT GENERATED ALWAYS AS IDENTITY,
   account_id BIGINT NOT NULL,
   name VARCHAR(512) NOT NULL,
   age INT,
   created_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
   updated_date TIMESTAMP WITH TIME ZONE,
   status int NOT NULL DEFAULT 0,
   CONSTRAINT profiles_primary_key_id PRIMARY KEY (id),
   CONSTRAINT profiles_unique_key_account_id UNIQUE (account_id),
   CONSTRAINT profiles_reference_key_account_id FOREIGN KEY (account_id) REFERENCES website.accounts(id)
);