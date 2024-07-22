use std::env;
use std::sync::Arc;

use actix_cors::Cors;
use actix_web::{middleware::Logger, web, web::Data, App, HttpServer};
use diesel::r2d2::{ConnectionManager, Pool};
use diesel::PgConnection;
use dotenv::dotenv;
use graphql::handlers::{graphiql, graphql_handler, graphql_playground};
use graphql::schema::create_schema;

use shared::db;
mod graphql;
mod models;
mod schema;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    dotenv().ok();
    env::set_var("RUST_LOG", "info");
    env::set_var("RUST_BACKTRACE", "1");
    env_logger::init();

    let pool: Pool<ConnectionManager<PgConnection>> = db::init_pool();
    let schema = Arc::new(create_schema());

    HttpServer::new(move || {
        App::new()
            .app_data(Data::new(pool.clone()))
            .app_data(Data::new(schema.clone()))
            .wrap(Logger::default())
            .wrap(Cors::permissive())
            .service(
                web::resource("/graphql")
                    .route(web::get().to(graphql_handler))
                    .route(web::post().to(graphql_handler)),
            )
            .service(web::resource("/playground").route(web::get().to(graphql_playground)))
            .service(web::resource("/graphiql").route(web::get().to(graphiql)))
    })
    .bind("0.0.0.0:3002")?
    .run()
    .await
}
