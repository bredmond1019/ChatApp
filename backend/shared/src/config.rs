use std::env;

pub fn get_database_url() -> String {
    env::var("DATABASE_URL").expect("DATABASE_URL must be set")
}

pub fn get_secret_key() -> Vec<u8> {
    env::var("SECRET_KEY")
        .expect("SECRET_KEY must be set")
        .as_bytes()
        .to_vec()
}
