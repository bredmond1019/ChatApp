use chrono::NaiveDateTime;
use diesel::{deserialize::Queryable, prelude::Insertable, Selectable};
use juniper::GraphQLObject;
use serde::{Deserialize, Serialize};

use crate::schema::events;

#[derive(Queryable, Serialize, Deserialize, GraphQLObject, Selectable)]
#[diesel(table_name = crate::schema::events)]
pub struct Event {
    pub id: i32,
    pub gym_id: i32,
    pub requester_id: i32,
    pub start_time: NaiveDateTime,
    pub end_time: NaiveDateTime,
    pub created_at: NaiveDateTime,
    pub updated_at: NaiveDateTime,
}

#[derive(Insertable)]
#[diesel(table_name = events)]
pub struct NewEvent {
    pub gym_id: i32,
    pub requester_id: i32,
    pub start_time: NaiveDateTime,
    pub end_time: NaiveDateTime,
    pub created_at: NaiveDateTime,
    pub updated_at: NaiveDateTime,
}

impl NewEvent {
    pub fn new(
        gym_id: i32,
        requester_id: i32,
        start_time: NaiveDateTime,
        end_time: NaiveDateTime,
    ) -> Self {
        NewEvent {
            gym_id,
            requester_id,
            start_time,
            end_time,
            created_at: chrono::Local::now().naive_local(),
            updated_at: chrono::Local::now().naive_local(),
        }
    }
}
