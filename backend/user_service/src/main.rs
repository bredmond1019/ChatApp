use std::env;
use std::sync::Arc;

use actix_cors::Cors;
use actix_web::{middleware::Logger, web, web::Data, App, HttpServer};
use actix_web_httpauth::middleware::HttpAuthentication;
use auth::authenticator;
use diesel::r2d2::{ConnectionManager, Pool};
use diesel::PgConnection;
use dotenv::dotenv;
use graphql::handlers::{graphiql, graphql_handler, graphql_playground};
use graphql::schema::{create_context, create_schema};

use shared::{config, db};
use tokio::sync::Mutex;
mod auth;
mod graphql;
mod models;
mod routes;
mod schema;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    dotenv().ok();
    env::set_var("RUST_LOG", "debug");
    env::set_var("RUST_BACKTRACE", "1");
    env_logger::init();

    let pool: Pool<ConnectionManager<PgConnection>> = db::init_pool();
    let schema = Arc::new(create_schema());
    let context = Arc::new(Mutex::new(create_context(pool.clone())));

    HttpServer::new(move || {
        let auth_middleware = HttpAuthentication::bearer(authenticator);

        App::new()
            .app_data(Data::new(pool.clone()))
            .app_data(Data::new(schema.clone()))
            .app_data(Data::new(context.clone()))
            .wrap(Logger::default())
            .wrap(Cors::permissive())
            .service(routes::login::login)
            .service(web::resource("/playground").route(web::get().to(graphql_playground)))
            .service(web::resource("/graphiql").route(web::get().to(graphiql)))
            .service(
                web::scope("/api")
                    // .wrap(auth_middleware)
                    .configure(routes::init_routes)
                    .service(
                        web::resource("/graphql")
                            .route(web::get().to(graphql_handler))
                            .route(web::post().to(graphql_handler)),
                    ),
            )
    })
    .bind("0.0.0.0:3001")?
    .run()
    .await
}
