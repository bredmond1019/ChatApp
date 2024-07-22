use chrono::Utc;
use diesel::{
    associations::{Associations, Identifiable},
    deserialize::Queryable,
    prelude::Insertable,
    query_dsl::methods::FilterDsl,
    ExpressionMethods, PgConnection, RunQueryDsl,
};

use super::conversation::Conversation;
use crate::schema::{conversation_memberships, conversations};
use shared::models::user::User;

#[derive(Queryable, Associations, Identifiable, Debug, Clone, PartialEq, Eq, Hash)]
#[diesel(table_name = conversation_memberships)]
#[diesel(belongs_to(Conversation))]
#[diesel(belongs_to(User))]
pub struct ConversationMembership {
    pub id: i32,
    pub conversation_id: i32,
    pub user_id: i32,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: chrono::NaiveDateTime,
}
#[derive(Insertable)]
#[diesel(table_name = conversation_memberships)]
pub struct NewConversationMembership {
    pub conversation_id: i32,
    pub user_id: i32,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: chrono::NaiveDateTime,
}

impl NewConversationMembership {
    pub fn new(conversation_id: i32, user_id: i32) -> Self {
        NewConversationMembership {
            conversation_id,
            user_id,
            created_at: Utc::now().naive_utc(),
            updated_at: Utc::now().naive_utc(),
        }
    }
}

impl ConversationMembership {
    pub fn conversation(
        &self,
        conn: &mut PgConnection,
    ) -> Result<Conversation, diesel::result::Error> {
        let conversation = conversations::table
            .filter(conversations::id.eq(self.conversation_id))
            .first::<Conversation>(conn);

        conversation
    }

    pub fn create(
        user_ids: Vec<i32>,
        conversaton: &Conversation,
        conn: &mut PgConnection,
    ) -> ConversationMembership {
        let new_conversation_memberships = user_ids
            .into_iter()
            .map(|user_id| NewConversationMembership::new(conversaton.id, user_id))
            .collect::<Vec<_>>();

        diesel::insert_into(crate::schema::conversation_memberships::table)
            .values(new_conversation_memberships)
            .get_result(conn)
            .expect("Failed to create conversation memberships")
    }
}
