use diesel::deserialize::Queryable;
use juniper::GraphQLObject;
use serde::{Deserialize, Serialize};

#[derive(Queryable, Serialize, Deserialize, GraphQLObject)]
pub struct Gym {
    pub id: i32,
    pub name: String,
}
