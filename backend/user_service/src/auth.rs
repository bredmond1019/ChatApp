use actix_web::{dev::ServiceRequest, Error, HttpMessage};
use actix_web_httpauth::extractors::bearer::BearerAuth;
use jsonwebtoken::{decode, encode, Algorithm, DecodingKey, EncodingKey, Header, Validation};
use lazy_static::lazy_static;
use log::info;
use serde::{Deserialize, Serialize};
use std::time::{SystemTime, UNIX_EPOCH};

use crate::config::get_secret_key;

#[derive(Debug, Serialize, Deserialize)]
pub struct Claims {
    pub sub: String,
    pub exp: usize,
}

#[derive(Serialize, Deserialize, Clone, Debug)]
pub struct UserResponse {
    pub id: i32,
    pub name: String,
    pub email: String,
}

lazy_static! {
    static ref SECRET_KEY: Vec<u8> = get_secret_key();
}

pub fn create_jwt(user_email: &str) -> Result<String, jsonwebtoken::errors::Error> {
    let expiration = SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .expect("Time went backwards")
        .as_secs() as usize
        + 60 * 60; // 1 hour expiration

    let claims = Claims {
        sub: user_email.to_string(),
        exp: expiration,
    };

    encode(
        &Header::default(),
        &claims,
        &EncodingKey::from_secret(&SECRET_KEY),
    )
}

pub fn validate_jwt(token: &str) -> Result<Claims, jsonwebtoken::errors::Error> {
    info!("Validating token {:?}", token);

    decode::<Claims>(
        token,
        &DecodingKey::from_secret(&SECRET_KEY),
        &Validation::new(Algorithm::HS256),
    )
    .map(|data| data.claims)
}

pub async fn authenticator(
    req: ServiceRequest,
    credentials: BearerAuth,
) -> Result<ServiceRequest, (Error, ServiceRequest)> {
    info!("Authenticating request");
    let auth_token = credentials.token();

    info!("Auth token: {:?}", auth_token);

    let validated = validate_jwt(auth_token);
    info!("Validated: {:?}", validated);

    match validate_jwt(auth_token) {
        Ok(claims) => {
            info!("Valid token for user: {:?}", claims.sub);
            req.extensions_mut().insert(claims);

            Ok(req)
        }
        Err(e) => {
            info!("Invalid token");
            Err((actix_web::error::ErrorUnauthorized(e), req))
        }
    }
}
