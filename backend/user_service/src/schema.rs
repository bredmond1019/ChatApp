// @generated automatically by Diesel CLI.

diesel::table! {
    gym_memberships (id) {
        id -> Int4,
        user_id -> Int4,
        gym_id -> Int4,
    }
}

diesel::table! {
    gyms (id) {
        id -> Int4,
        name -> Varchar,
    }
}

diesel::table! {
    users (id) {
        id -> Int4,
        name -> Varchar,
        email -> Varchar,
        password -> Varchar,
        created_at -> Timestamp,
        updated_at -> Timestamp,
    }
}

diesel::joinable!(gym_memberships -> gyms (gym_id));
diesel::joinable!(gym_memberships -> users (user_id));

diesel::allow_tables_to_appear_in_same_query!(
    gym_memberships,
    gyms,
    users,
);
