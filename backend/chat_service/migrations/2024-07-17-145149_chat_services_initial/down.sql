-- This file should undo anything in `up.sql`
DROP TRIGGER diesel_manage_updated_at ON conversations;
DROP TRIGGER diesel_manage_updated_at ON conversation_memberships;
DROP TRIGGER diesel_manage_updated_at ON chat_messages;

DROP TABLE chat_messages;
DROP TABLE conversation_memberships;
DROP TABLE conversations;