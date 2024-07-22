use diesel::deserialize::Queryable;
use juniper::GraphQLObject;
use serde::{Deserialize, Serialize};

#[derive(Queryable, Serialize, Deserialize, GraphQLObject)]
pub struct GymMembership {
    pub id: i32,
    pub user_id: i32,
    pub gym_id: i32,
}
