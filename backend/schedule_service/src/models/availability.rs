use chrono::{Local, NaiveDateTime};
use diesel::{deserialize::Queryable, prelude::Insertable, Selectable};
use juniper::GraphQLObject;
use serde::{Deserialize, Serialize};

use crate::schema::availabilities;

#[derive(Queryable, Serialize, Deserialize, GraphQLObject, Selectable)]
#[diesel(table_name = crate::schema::availabilities)]
pub struct Availability {
    pub id: i32,
    pub user_id: i32,
    pub gym_id: i32,
    pub start_time: NaiveDateTime,
    pub end_time: NaiveDateTime,
    pub created_at: NaiveDateTime,
    pub updated_at: NaiveDateTime,
}

#[derive(Insertable)]
#[diesel(table_name = availabilities)]
pub struct NewAvailability {
    pub user_id: i32,
    pub gym_id: i32,
    pub start_time: NaiveDateTime,
    pub end_time: NaiveDateTime,
    pub created_at: NaiveDateTime,
    pub updated_at: NaiveDateTime,
}

impl NewAvailability {
    pub fn new(
        user_id: i32,
        gym_id: i32,
        start_time: NaiveDateTime,
        end_time: NaiveDateTime,
    ) -> Self {
        NewAvailability {
            user_id,
            gym_id,
            start_time,
            end_time,
            created_at: Local::now().naive_local(),
            updated_at: Local::now().naive_local(),
        }
    }
}
