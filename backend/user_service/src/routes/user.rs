use crate::db::DbPool;
use actix_web::{get, post, web, HttpResponse, Responder};
use diesel::r2d2::{ConnectionManager, PooledConnection};
use diesel::PgConnection;
use log::info;
use shared::models::user::{NewUser, User, UserData};

#[get("/users")]
async fn get_user(pool: web::Data<DbPool>) -> impl Responder {
    let mut conn: PooledConnection<ConnectionManager<PgConnection>> = pool.get().unwrap();
    let all_users: Result<Vec<User>, diesel::result::Error> =
        web::block(move || User::find_all(&mut conn)).await.unwrap();

    if let Ok(all_users) = all_users {
        let cloned_users: Vec<User> = all_users.clone();
        info!("Fetched all users: {:?}", cloned_users);
        HttpResponse::Ok().json(cloned_users)
    } else {
        HttpResponse::InternalServerError().finish()
    }
}

#[post("/users")]
async fn create_user(pool: web::Data<DbPool>, item: web::Json<UserData>) -> impl Responder {
    let mut new_user: NewUser = NewUser::new(item.into_inner());
    new_user.hash_password().expect("Error hashing password");

    let mut conn: PooledConnection<ConnectionManager<PgConnection>> =
        pool.get().expect("Couldn't get connection from pool");

    let created_user: User = web::block(move || User::create(new_user, &mut conn))
        .await
        .expect("Error creating user in blocking thread");

    info!("Created user: {:?}", created_user);
    HttpResponse::Ok().json(created_user)
}
