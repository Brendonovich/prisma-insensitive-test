use prisma::PrismaClient;
use prisma_client_rust::NewClientError;

use crate::prisma::_prisma::QueryMode;

pub mod prisma;
#[tokio::main]
async fn main() {
    dotenv::dotenv().ok();
    let client: Result<PrismaClient, NewClientError> = prisma::new_client().await;
    match &client {
        Ok(client) => {
            println!("all users: {:?}", client.user().find_many(vec![]).exec().await);
            let d = client.user().find_first(vec![
                prisma::user::name::mode(QueryMode::Insensitive),
                prisma::user::name::equals("Luna".to_string())
        
            ]).exec().await.unwrap();
            println!("search for 'Luna' : {:?}", d);
            let d = client.user().find_first(vec![
                prisma::user::name::mode(QueryMode::Insensitive),
                prisma::user::name::equals("luna".to_string())
        
            ]).exec().await.unwrap();
            println!("search for 'luna' : {:?}", d);
        }
        Err(e) => {

            println!("error initalizing client: {:?}", e);
        }
    }
}
