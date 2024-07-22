CREATE TABLE availabilities (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL ,
    gym_id INTEGER NOT NULL ,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL
);

SELECT diesel_manage_updated_at('availabilities');

CREATE TABLE events (
    id SERIAL PRIMARY KEY,
    gym_id INTEGER NOT NULL ,
    requester_id INTEGER NOT NULL ,
    additional_users INTEGER[] NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL
);

SELECT diesel_manage_updated_at('events');

CREATE TABLE event_members (
    id SERIAL PRIMARY KEY,
    event_id INTEGER NOT NULL REFERENCES events(id),
    user_id INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

SELECT diesel_manage_updated_at('event_members');
