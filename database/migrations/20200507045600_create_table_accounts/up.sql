-- This file will be executed when running migrate up
CREATE TABLE IF NOT EXISTS website.accounts(
   id BIGINT GENERATED ALWAYS AS IDENTITY,
   user_id BIGINT NOT NULL,
   created_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
   updated_date TIMESTAMP WITH TIME ZONE,
   status int NOT NULL DEFAULT 0,
   CONSTRAINT accounts_primary_key_id PRIMARY KEY (id),
   CONSTRAINT accounts_reference_key_user_id FOREIGN KEY (user_id) REFERENCES website.users(id)
);