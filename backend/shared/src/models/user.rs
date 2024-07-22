use crate::schema::users;
use bcrypt::{hash, verify, DEFAULT_COST};
use diesel::{
    deserialize::Queryable,
    prelude::Insertable,
    r2d2::{ConnectionManager, PooledConnection},
    PgConnection, RunQueryDsl,
};
use juniper::GraphQLObject;
use log::info;
use serde::{Deserialize, Serialize};

#[derive(Queryable, Serialize, Debug, Clone, GraphQLObject)]
#[diesel(table_name = crate::schema::users)]
pub struct User {
    pub id: i32,
    pub name: String,
    pub email: String,
    pub password: String,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: chrono::NaiveDateTime,
}

#[derive(Deserialize, Insertable)]
#[diesel(table_name = users)]
pub struct NewUser {
    pub name: String,
    pub email: String,
    pub password: String,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: chrono::NaiveDateTime,
}

#[derive(Deserialize)]
pub struct UserData {
    pub name: String,
    pub email: String,
    pub password: String,
}

impl NewUser {
    pub fn new(user: UserData) -> NewUser {
        NewUser {
            name: user.name,
            email: user.email,
            password: user.password,
            created_at: chrono::Local::now().naive_local(),
            updated_at: chrono::Local::now().naive_local(),
        }
    }
    pub fn hash_password(&mut self) -> Result<(), bcrypt::BcryptError> {
        let hashed = hash(self.password.clone(), DEFAULT_COST)?;
        self.password = hashed;
        Ok(())
    }
}

impl User {
    pub fn find_all(
        conn: &mut PooledConnection<ConnectionManager<PgConnection>>,
    ) -> Result<Vec<User>, diesel::result::Error> {
        let all_users: Result<Vec<User>, diesel::result::Error> = users::table.load(conn);
        info!("{:?}", &all_users);
        all_users
    }

    pub fn create(new_user: NewUser, conn: &mut PgConnection) -> User {
        let user: User = diesel::insert_into(users::table)
            .values(&new_user)
            .get_result(conn)
            .expect("Error creating user");
        user
    }

    pub fn verify_password(&self, password: &str) -> Result<bool, bcrypt::BcryptError> {
        verify(password, &self.password)
    }
}
