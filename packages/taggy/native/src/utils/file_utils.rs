use std::fs;
use std::path::Path;

pub fn get_file_size(path: &String) -> Option<u64> {
    match fs::metadata(Path::new(&path)) {
        Ok(meta) => Some(meta.len()),
        Err(_) => None,
    }
}
