use core::panic;

use actix::Message;
use chrono::NaiveDateTime;
use diesel::{deserialize::Queryable, prelude::*, PgConnection, RunQueryDsl};

use juniper::GraphQLObject;
use serde::{Deserialize, Serialize};

use crate::schema::chat_messages;

use super::conversation::{Conversation, ConversationId};
use shared::models::user::User;

#[derive(Debug, Serialize, Deserialize, Queryable, Clone, GraphQLObject, Associations)]
#[diesel(table_name = crate::schema::chat_messages)]
#[diesel(belongs_to(Conversation))]
#[diesel(belongs_to(User))]
pub struct ChatMessage {
    pub id: i32,
    pub conversation_id: i32,
    pub user_id: i32,
    pub content: String,
    pub created_at: NaiveDateTime,
    pub updated_at: NaiveDateTime,
}

#[derive(Debug, Deserialize, Insertable)]
#[diesel(table_name = chat_messages)]
pub struct NewChatMessage {
    pub conversation_id: i32,
    pub user_id: i32,
    pub content: String,
    created_at: NaiveDateTime,
    updated_at: NaiveDateTime,
}

#[derive(Deserialize, Serialize, Message, Clone, Debug)]
#[rtype(result = "()")]
pub struct ClientMessage {
    pub sender_id: i32,
    pub content: String,
    pub conversation_id: ConversationId,
}

impl NewChatMessage {
    pub fn new(client_message: &ClientMessage) -> Self {
        NewChatMessage {
            conversation_id: client_message.conversation_id.0,
            user_id: client_message.sender_id,
            content: client_message.content.clone(),
            created_at: chrono::Utc::now().naive_utc(),
            updated_at: chrono::Utc::now().naive_utc(),
        }
    }
}

impl ChatMessage {
    pub fn create(client_message: &ClientMessage, conn: &mut PgConnection) -> ChatMessage {
        let new_message = NewChatMessage::new(client_message);

        let message = diesel::insert_into(chat_messages::table)
            .values(&new_message)
            .get_result(conn);

        match message {
            Ok(message) => message,
            Err(e) => panic!("Error creating message: {:?}", e),
        }
    }
}
