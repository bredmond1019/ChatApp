use std::sync::Arc;

use actix_web::web::Data;
use actix_web::{post, web, HttpResponse, Responder};
use diesel::deserialize::Queryable;
use diesel::RunQueryDsl;
use diesel::{query_dsl::methods::FilterDsl, ExpressionMethods};
use log::info;
use serde::{Deserialize, Serialize};
use shared::models::user::User;
use shared::schema::users;
use tokio::sync::Mutex;

use crate::auth::{create_jwt, UserResponse};
use crate::graphql::schema::Context;

#[derive(Queryable, Serialize, Debug, Clone)]
struct LoginResponse {
    user: UserResponse,
    token: String,
}

impl From<User> for UserResponse {
    fn from(user: User) -> Self {
        UserResponse {
            id: user.id,
            email: user.email.to_string(),
            name: user.name.to_string(),
        }
    }
}

#[derive(Deserialize, Debug)]
struct LoginInfo {
    email: String,
    password: String,
}

#[post("/login")]
pub async fn login(info: web::Json<LoginInfo>, ctx: Data<Arc<Mutex<Context>>>) -> impl Responder {
    info!("Login request: {:?}", info);
    info!("Context: {:?}", ctx.as_ref());
    let mut conn = ctx.lock().await.pool.get().unwrap();
    let email_address = info.email.clone();
    let pass = &info.password;

    let user = web::block(move || {
        users::table
            .filter(users::columns::email.eq(&email_address))
            .first::<User>(&mut conn)
    })
    .await
    .expect("Error loading user");

    info!("User: {:?}", user);

    match user {
        Ok(user) => {
            if user.verify_password(&pass).unwrap() {
                let user_response = UserResponse::from(user);
                let token = create_jwt(&user_response.email).expect("Failed to create JWT");
                info!("Token: {:?}", token);

                return HttpResponse::Ok().json(LoginResponse {
                    user: user_response,
                    token: token,
                });
            } else {
                return HttpResponse::InternalServerError().finish();
            }
        }
        Err(_) => {
            return HttpResponse::Unauthorized().finish();
        }
    }
}
