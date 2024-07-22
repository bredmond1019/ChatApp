use std::env;

use actix::Actor;
use actix_cors::Cors;
use actix_web::{middleware::Logger, web::Data, App, HttpServer};
use diesel::r2d2::{ConnectionManager, Pool};
use diesel::PgConnection;
use dotenv::dotenv;
use log::info;
use services::chat_server::ChatServer;
use shared::db;

mod models;
mod schema;
mod services;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    dotenv().ok();
    env::set_var("RUST_LOG", "info");
    env::set_var("RUST_BACKTRACE", "1");
    env_logger::init();

    let pool: Pool<ConnectionManager<PgConnection>> = db::init_pool();
    let chat_server = ChatServer::new(pool.clone()).start();

    info!("{:?}", pool);

    HttpServer::new(move || {
        App::new()
            .app_data(Data::new(pool.clone()))
            .app_data(Data::new(chat_server.clone()))
            .wrap(Logger::default())
            .wrap(Cors::permissive())
            .configure(services::chat::init_routes)
    })
    .bind("0.0.0.0:3000")?
    .run()
    .await
}
