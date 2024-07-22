-- This file should undo anything in `up.sql`
DROP TRIGGER diesel_manage_updated_at ON event_members;
DROP TRIGGER diesel_manage_updated_at ON events;
DROP TRIGGER diesel_manage_updated_at ON availabilities;

DROP TABLE availabilities;
DROP TABLE events;
DROP TABLE event_members;