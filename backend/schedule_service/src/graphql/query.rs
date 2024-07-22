use crate::graphql::schema::Context;
use chrono::NaiveDateTime;
use diesel::{ExpressionMethods, QueryDsl, RunQueryDsl};
use juniper::graphql_object;
use log::info;

use crate::models::availability::Availability;
use crate::schema::availabilities::{self, columns};

pub struct Query;

#[graphql_object(context = Context)]
impl Query {
    fn availabilities(
        context: &Context,
        gym_id: i32,
        date: NaiveDateTime,
        start_time: NaiveDateTime,
        end_time: NaiveDateTime,
    ) -> Vec<Availability> {
        let mut connection = context
            .pool
            .get()
            .expect("Error connecting to the database");
        info!("Fetching availabilities for gym_id: {}", gym_id);
        info!("Date: {}", date);
        info!("Start time: {}", start_time);
        info!("End time: {}", end_time);

        let current_availabilities = availabilities::table
            .filter(columns::gym_id.eq(gym_id))
            .filter(columns::start_time.le(end_time))
            .filter(columns::end_time.ge(start_time))
            .load::<Availability>(&mut connection)
            .expect("Error loading availabilities");

        current_availabilities
    }
}
