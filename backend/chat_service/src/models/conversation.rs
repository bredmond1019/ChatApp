use diesel::{
    associations::Identifiable, deserialize::Queryable, prelude::Insertable, BelongingToDsl,
    ExpressionMethods, PgConnection, QueryDsl, RunQueryDsl, Selectable,
};
use log::info;
use serde::{Deserialize, Serialize};

use super::conversation_membership::ConversationMembership;
use crate::schema::conversation_memberships;
use crate::schema::conversations;

#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Hash, Deserialize, Serialize)]
pub struct ConversationId(pub i32);

#[derive(Debug, Serialize, Deserialize, Queryable, Insertable, Identifiable, Selectable)]
#[diesel(table_name = crate::schema::conversations)]
pub struct Conversation {
    pub id: i32,
    pub name: Option<String>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: chrono::NaiveDateTime,
}

#[derive(Insertable)]
#[diesel(table_name = conversations)]
pub struct NewConversation {
    pub name: Option<String>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: chrono::NaiveDateTime,
}

impl NewConversation {
    pub fn new(name: Option<String>) -> Self {
        NewConversation {
            name,
            created_at: chrono::Utc::now().naive_utc(),
            updated_at: chrono::Utc::now().naive_utc(),
        }
    }
}

impl Conversation {
    pub fn members(&self, conn: &mut PgConnection) -> Vec<ConversationMembership> {
        let members =
            ConversationMembership::belonging_to(self).load::<ConversationMembership>(conn);

        members.expect("Failed to load conversation members")
    }

    pub fn find_membership_by_user_id(
        &self,
        user_id: i32,
        conn: &mut PgConnection,
    ) -> ConversationMembership {
        let membership = ConversationMembership::belonging_to(self)
            .filter(conversation_memberships::user_id.eq(user_id))
            .first::<ConversationMembership>(conn)
            .expect("Failed to find conversation membership");

        membership
    }

    pub fn create(
        new_conversation: NewConversation,
        user_ids: Vec<i32>,
        conn: &mut PgConnection,
    ) -> Conversation {
        let conversation = diesel::insert_into(conversations::table)
            .values(&new_conversation)
            .get_result(conn)
            .expect("Failed to create conversation");

        ConversationMembership::create(user_ids, &conversation, conn);

        conversation
    }

    pub fn find_by_id(conversation_id: i32, conn: &mut PgConnection) -> Conversation {
        let conversation = conversations::table
            .filter(conversations::id.eq(conversation_id))
            .first::<Conversation>(conn)
            .expect("Failed to find conversation");

        conversation
    }

    pub fn find_or_create(
        conn: &mut PgConnection,
        conversation_id: Option<i32>,
        user_ids: Vec<i32>,
    ) -> Conversation {
        info!("Finding or creating conversation");
        let conversation = if conversation_id.is_some() {
            Conversation::find_by_id(conversation_id.unwrap(), conn)
        } else {
            Conversation::create(NewConversation::new(None), user_ids, conn)
        };
        conversation
    }
}
