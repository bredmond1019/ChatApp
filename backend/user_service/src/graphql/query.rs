use crate::{
    graphql::schema::Context,
    models::{gym::Gym, gym_membership::GymMembership},
};

use diesel::{ExpressionMethods, QueryDsl, RunQueryDsl};
use juniper::{graphql_object, FieldResult};
use shared::{models::user::User, schema::users};

pub struct Query;

#[graphql_object(context = Context)]
impl Query {
    async fn users(&self, context: &Context) -> FieldResult<Vec<User>> {
        let mut connection = context.pool.get()?;
        let result = User::find_all(&mut connection)?;
        Ok(result)
    }

    fn user(context: &mut Context, user_id: i32) -> Option<User> {
        let mut connection = context.pool.get().expect("Error getting db connection");
        let user = users::table
            .filter(users::columns::id.eq(user_id))
            .first::<User>(&mut connection)
            .ok();
        user
    }

    fn gym(context: &Context, gym_id: i32) -> Option<Gym> {
        use crate::schema::gyms::dsl::*;
        let mut connection = context.pool.get().expect("Error getting db connection");

        gyms.filter(id.eq(gym_id)).first(&mut connection).ok()
    }

    fn gym_memberships(context: &Context, member_id: i32) -> Vec<GymMembership> {
        use crate::schema::gym_memberships::dsl::*;
        let mut connection = context.pool.get().expect("Error getting db connection");

        gym_memberships
            .filter(user_id.eq(member_id))
            .load(&mut connection)
            .expect("Error loading gym memberships")
    }
}
