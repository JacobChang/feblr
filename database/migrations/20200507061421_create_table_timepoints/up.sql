-- This file will be executed when running migrate up
CREATE TABLE IF NOT EXISTS website.timepoints(
   id BIGINT GENERATED ALWAYS AS IDENTITY,
   account_id BIGINT NOT NULL,
   timeline_id BIGINT NOT NULL,
   title VARCHAR(2048) NOT NULL,
   description TEXT,
   created_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
   updated_date TIMESTAMP WITH TIME ZONE,
   status int NOT NULL DEFAULT 0,
   CONSTRAINT timepoints_primary_key_id PRIMARY KEY (id),
   CONSTRAINT timepoints_reference_key_account_id FOREIGN KEY (account_id) REFERENCES website.accounts(id),
   CONSTRAINT timepoints_reference_key_timeline_id FOREIGN KEY (timeline_id) REFERENCES website.timelines(id)
);