use diesel::{deserialize::Queryable, prelude::Insertable};
use juniper::GraphQLObject;
use serde::{Deserialize, Serialize};

use crate::schema::event_members;

#[derive(Queryable, Serialize, Deserialize, GraphQLObject)]
#[diesel(table_name = event_members)]
pub struct EventMember {
    pub id: i32,
    pub event_id: i32,
    pub user_id: i32,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: chrono::NaiveDateTime,
}

#[derive(Insertable)]
#[diesel(table_name = event_members)]
pub struct NewEventMember {
    pub event_id: i32,
    pub user_id: i32,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: chrono::NaiveDateTime,
}

impl NewEventMember {
    pub fn new(event_id: i32, user_id: i32) -> Self {
        NewEventMember {
            event_id,
            user_id,
            created_at: chrono::Local::now().naive_local(),
            updated_at: chrono::Local::now().naive_local(),
        }
    }
}
