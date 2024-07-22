-- This file should undo anything in `up.sql`
ALTER TABLE events DROP COLUMN additional_users;
ALTER TABLE events ADD COLUMN additional_users INTEGER[] NULL;