-- This file will be executed when running migrate up
CREATE TABLE IF NOT EXISTS website.sources(
   id BIGINT GENERATED ALWAYS AS IDENTITY,
   account_id BIGINT NOT NULL,
   timepoint_id BIGINT NOT NULL,
   title VARCHAR(2048),
   uri VARCHAR(2048) NOT NULL,
   created_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
   updated_date TIMESTAMP WITH TIME ZONE,
   status int NOT NULL DEFAULT 0,
   CONSTRAINT sources_primary_key_id PRIMARY KEY (id),
   CONSTRAINT sources_reference_key_account_id FOREIGN KEY (account_id) REFERENCES website.accounts(id),
   CONSTRAINT sources_reference_key_timepoint_id FOREIGN KEY (timepoint_id) REFERENCES website.timepoints(id)
);