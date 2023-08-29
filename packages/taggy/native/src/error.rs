use thiserror::Error;

#[derive(Error, Debug)]
pub enum TaggyError {
    #[error("the given path does not exist")]
    PathNotFount(#[from] std::io::Error),
    #[error("{}", 0)]
    General(String),
    #[error("Unknown error occurred")]
    Unknown,
}
