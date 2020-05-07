-- This file will be executed when running migrate up
CREATE TABLE IF NOT EXISTS website.emails(
   user_id BIGINT NOT NULL,
   addr VARCHAR(2048) NOT NULL,
   created_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
   updated_date TIMESTAMP WITH TIME ZONE,
   status int NOT NULL DEFAULT 0,
   CONSTRAINT emails_primary_key_addr PRIMARY KEY (addr),
   CONSTRAINT emials_unique_key_addr UNIQUE (addr),
   CONSTRAINT emails_reference_key_user_id FOREIGN KEY (user_id) REFERENCES website.users(id)
);