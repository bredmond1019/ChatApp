-- Your SQL goes here
CREATE TABLE gyms (
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL
);

SELECT diesel_manage_updated_at('gyms');

CREATE TABLE gym_memberships (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id),
    gym_id INTEGER NOT NULL REFERENCES gyms(id)
);

SELECT diesel_manage_updated_at('gym_memberships');