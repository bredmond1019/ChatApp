use juniper::graphql_object;

use crate::graphql::schema::Context;
use crate::models::availability::{Availability, NewAvailability};
use crate::models::event::{Event, NewEvent};
use crate::models::event_member::NewEventMember;

use diesel::RunQueryDsl;

pub struct Mutation;

#[graphql_object(context = Context)]
impl Mutation {
    fn create_availability(
        context: &Context,
        user_id: i32,
        gym_id: i32,
        start_time: chrono::NaiveDateTime,
        end_time: chrono::NaiveDateTime,
    ) -> Availability {
        use crate::schema::availabilities;

        let mut connection = context
            .pool
            .get()
            .expect("Error connecting to the database");

        let new_availability = NewAvailability::new(user_id, gym_id, start_time, end_time);

        diesel::insert_into(availabilities::table)
            .values(&new_availability)
            .get_result(&mut connection)
            .expect("Error creating availability")
    }

    fn book_event(
        context: &Context,
        gym_id: i32,
        requester_id: i32,
        additional_users: Vec<i32>,
        start_time: chrono::NaiveDateTime,
        end_time: chrono::NaiveDateTime,
    ) -> Event {
        use crate::schema::events;

        let mut connection = context
            .pool
            .get()
            .expect("Error connecting to the database");

        let new_event = NewEvent::new(gym_id, requester_id, start_time, end_time);

        let event: Event = diesel::insert_into(events::table)
            .values(&new_event)
            .get_result(&mut connection)
            .expect("Error booking event");

        for user_id in additional_users {
            let new_event_member = NewEventMember::new(event.id, user_id);

            diesel::insert_into(crate::schema::event_members::table)
                .values(&new_event_member)
                .execute(&mut connection)
                .expect("Error adding event member");
        }

        event
    }
}
