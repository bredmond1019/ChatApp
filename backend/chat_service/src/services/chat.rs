use actix::Addr;
use actix_web::{web, HttpRequest, Responder};
use actix_web_actors::ws;
use log::info;

use crate::db::DbPool;
use crate::models::conversation::Conversation;

use crate::services::chat_session::ChatSession;
use crate::ChatServer;

pub fn init_routes(cfg: &mut web::ServiceConfig) {
    cfg.route("/ws/", web::get().to(chat_route));
}

pub async fn chat_route(
    req: HttpRequest,
    stream: web::Payload,
    server: web::Data<Addr<ChatServer>>,
    pool: web::Data<DbPool>,
) -> impl Responder {
    let query_string = req.query_string();
    let params = serde_urlencoded::from_str::<Vec<(String, String)>>(query_string)
        .expect("Failed to parse query string");
    info!("Query: {}", query_string);
    info!("Params: {:?}", params);
    let (sender_id, conversation_member_ids, conversation_id) = get_session_data(params);

    let mut conn = pool.get().expect("Failed to get DB connection");
    let chat_server_address = server.get_ref().clone();

    let conversation =
        Conversation::find_or_create(&mut conn, conversation_id, conversation_member_ids);
    let session_member = conversation.find_membership_by_user_id(sender_id, &mut conn);

    let session = ChatSession::new(chat_server_address, conversation, session_member);
    ws::start(session, &req, stream)
}

fn get_session_data(params: Vec<(String, String)>) -> (i32, Vec<i32>, Option<i32>) {
    let mut sender_id = 0;
    let mut conversation_member_ids: Vec<i32> = Vec::new();
    let mut conversation_id: Option<i32> = None;

    for (key, value) in params {
        if key == "sender_id" {
            sender_id = value.parse::<i32>().expect("Invalid user ID");
            conversation_member_ids.push(sender_id);
        } else if key == "receiver_id" {
            let user_id: i32 = value.parse().expect("Invalid receiver ID");
            conversation_member_ids.push(user_id);
        } else if key == "conversation_id" {
            conversation_id = match value.parse() {
                Ok(id) => Some(id),
                Err(_) => None,
            };
        }
    }
    info!(
        "Sender ID: {}, Conversation Member IDs: {:?}, Conversation ID: {:?}",
        sender_id, conversation_member_ids, conversation_id
    );

    if sender_id == 0 {
        panic!("Invalid user IDs in query string");
    } else if conversation_member_ids.len() < 2 && conversation_id.is_none() {
        panic!("Invalid user IDs or conversation ID in query string");
    }

    (sender_id, conversation_member_ids, conversation_id)
}
