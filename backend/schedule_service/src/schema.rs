// @generated automatically by Diesel CLI.

diesel::table! {
    availabilities (id) {
        id -> Int4,
        user_id -> Int4,
        gym_id -> Int4,
        start_time -> Timestamp,
        end_time -> Timestamp,
        created_at -> Timestamptz,
        updated_at -> Timestamptz,
    }
}

diesel::table! {
    event_members (id) {
        id -> Int4,
        event_id -> Int4,
        user_id -> Int4,
        created_at -> Timestamp,
        updated_at -> Timestamp,
    }
}

diesel::table! {
    events (id) {
        id -> Int4,
        gym_id -> Int4,
        requester_id -> Int4,
        start_time -> Timestamp,
        end_time -> Timestamp,
        created_at -> Timestamptz,
        updated_at -> Timestamptz,
    }
}

diesel::joinable!(event_members -> events (event_id));

diesel::allow_tables_to_appear_in_same_query!(
    availabilities,
    event_members,
    events,
);
