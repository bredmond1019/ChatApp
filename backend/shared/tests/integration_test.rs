use diesel::prelude::*;
use shared::{establish_connection, models::user::User, schema::users};

#[test]
fn test_connection() {
    let mut connection = establish_connection();
    let results = users::table
        .load::<User>(&mut connection)
        .expect("Error loading users");

    for user in results {
        println!("User: {:?}", user);
    }
}
