-- This file should undo anything in `up.sql`
ALTER TABLE events DROP COLUMN created_at;
ALTER TABLE events DROP COLUMN updated_at;

ALTER TABLE availabilities DROP COLUMN created_at;
ALTER TABLE availabilities DROP COLUMN updated_at;