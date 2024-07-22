-- This file should undo anything in `up.sql`
DROP TRIGGER diesel_manage_updated_at ON gym;
DROP TRIGGER diesel_manage_updated_at ON gym_memberships;
DROP TABLE gym_memberships;
DROP TABLE gyms;
