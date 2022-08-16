use _prisma::QueryMode;
use prisma::*;

pub mod prisma;

#[tokio::main]
async fn main() {
    let client = prisma::new_client().await;

    match &client {
        Ok(client) => {
            client
                .user()
                .upsert(
                    user::id::equals("0".to_string()),
                    user::create("0".to_string(), "Luna".to_string(), "".to_string(), vec![]),
                    vec![],
                )
                .exec()
                .await
                .unwrap();

            println!(
                "all users: {:?}",
                client.user().find_many(vec![]).exec().await
            );

            use user::*;

            let d = client
                .user()
                .find_first(vec![
                    name::mode(QueryMode::Insensitive),
                    name::equals("Luna".to_string()),
                ])
                .exec()
                .await
                .unwrap();
            println!("search for 'Luna' : {:?}", d);

            let d = client
                .user()
                .find_first(vec![
                    name::mode(QueryMode::Insensitive),
                    name::equals("luna".to_string()),
                ])
                .exec()
                .await
                .unwrap();
            println!("search for 'luna' : {:?}", d);
        }
        Err(e) => {
            println!("error initalizing client: {:?}", e);
        }
    }
}
