// @generated automatically by Diesel CLI.

diesel::table! {
    chat_messages (id) {
        id -> Int4,
        conversation_id -> Int4,
        user_id -> Int4,
        content -> Text,
        created_at -> Timestamp,
        updated_at -> Timestamp,
    }
}

diesel::table! {
    conversation_memberships (id) {
        id -> Int4,
        conversation_id -> Int4,
        user_id -> Int4,
        created_at -> Timestamp,
        updated_at -> Timestamp,
    }
}

diesel::table! {
    conversations (id) {
        id -> Int4,
        name -> Nullable<Text>,
        created_at -> Timestamp,
        updated_at -> Timestamp,
    }
}

diesel::joinable!(chat_messages -> conversations (conversation_id));
diesel::joinable!(conversation_memberships -> conversations (conversation_id));

diesel::allow_tables_to_appear_in_same_query!(
    chat_messages,
    conversation_memberships,
    conversations,
);
