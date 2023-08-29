use crate::audio_info::AudioInfo;
use crate::error::TaggyError;
use crate::tag::Tag;
use crate::taggy_file::TaggyFile;
use crate::utils::perlude::Result;
use lofty::{AudioFile, Probe, TaggedFile, TaggedFileExt};
use std::fs;
use std::path::Path;

/// Returns a [`lofty::TaggedFile`] at the given path.
fn get_tagged_file(path: &str) -> Result<TaggedFile> {
    fn err_handler(e: lofty::LoftyError) {
        TaggyError::General(e.to_string());
    }
    //
    match Probe::open(path) {
        Ok(file) => match file.read() {
            Ok(tf) => Ok(tf),
            Err(e) => Err(TaggyError::General(e.to_string())),
        },
        Err(e) => Err(TaggyError::General(e.to_string())),
    }
}

/// Read & parse audio tags from the file at given `path`.
///
/// # Example
/// ```rust
///  let taggy_file = read_from_path("path/to/file/sample.mp3");
///  match taggy_file {
///         Ok(f) => /* use the acquired file */,
///         Err(e)=> /* handle an error */,
///     };
/// ```
pub fn read_from_path(path: String) -> Result<TaggyFile> {
    let file_result = get_tagged_file(path.as_ref());
    if file_result.is_err() {
        return Err(file_result.err().unwrap());
    }
    let file = file_result.unwrap();
    Ok(TaggyFile {
        file_type: Some(file.file_type().into()),
        size: get_file_size(&path),
        audio: AudioInfo::from(file.properties()),
        /// convert the [`TaggedFile::tags`] to a `Vec` of taggy's [`Tag`]
        tags: file.tags().iter().map(Tag::from).collect(),
    })
}
fn get_file_size(path: &String) -> Option<u64> {
    match fs::metadata(Path::new(&path)) {
        Ok(meta) => Some(meta.len()),
        Err(_) => None,
    }
}
/// Write all provided `tags` for the file at given `path`.
///
/// when `should_override` is set to `true`, this will remove all existing tags.
/// Otherwise, it will add to/update the existing ones.
pub fn write_all(path: String, tags: Vec<Tag>, should_override: bool) -> Result<()> {
    if tags.is_empty() {
        return Ok(()); // If there is no tags to be written, do nothing & return.
    }
    let file_result = get_tagged_file(path.as_ref());
    if file_result.is_err() {
        return Err(file_result.err().unwrap());
    }

    let mut file = file_result.unwrap();
    if should_override {
        file.clear(); // remove tags, but not from the file on disk
    }

    // convert the provided tags to a list of lofty's Tag
    let lofty_tags: Vec<lofty::Tag> = vec![];
    // tags.as_slice().iter().map(lofty::Tag::from).collect();

    for tag in lofty_tags {
        if file.insert_tag(tag.clone()).is_none() {
            eprintln!(
                "The tag type {:?} is not supported for the file type {:?}",
                tag.tag_type(),
                file.file_type()
            );
        }
    }
    //
    // if let Some(title) = data.title {
    //     tag.insert_text(ItemKey::TrackTitle, title);
    // }
    //
    // // Artist
    // if let Some(artist) = data.artist {
    //     tag.insert_text(ItemKey::TrackArtist, artist);
    // }
    //
    // // Album Title
    // if let Some(album) = data.album {
    //     tag.insert_text(ItemKey::AlbumTitle, album);
    // }
    //
    // // Year
    // if let Some(year) = data.year {
    //     tag.set_year(year);
    // }
    //
    // // Genre
    // if let Some(genre) = data.genre {
    //     tag.insert_text(ItemKey::Genre, genre);
    // }
    //
    // // Pictures
    // for (i, picture) in data.pictures.into_iter().enumerate() {
    //     tag.set_picture(
    //         i,
    //         lofty::Picture::new_unchecked(
    //             picture.picture_type.into(),
    //             picture.mime_type.into(),
    //             None,
    //             picture.bytes,
    //         ),
    //     );
    // }

    match file.save_to_path(path) {
        Ok(_) => Ok(()),
        Err(e) => Err(TaggyError::General(e.to_string())),
    }
}

#[cfg(test)]
mod tests {

    use super::*;

    #[test]
    fn test_reading_non_existing_file_returns_an_error() {
        let taggy_file = read_from_path(String::from("fake/path/file.mp3"));
        assert!(taggy_file.is_err());
    }
    // #[test]
    // fn read_tag_mp3() {
    //     let tag = read_from_path("samples/test.mp3".to_string()).expect("Could not read tag.");
    //
    //     println!("{:?}", tag.title);
    //     println!("{:?}", tag.artist);
    //     println!("{:?}", tag.album);
    //     println!("{:?}", tag.year);
    //     println!("{:?}", tag.genre);
    //     println!("{:?}", tag.duration);
    //     println!("{:?}", tag.pictures);
    // }
    //
    // #[test]
    // fn clear_tag_mp3() {
    //     write(
    //         "samples/test.mp3".to_string(),
    //         Tag {
    //             title: None,
    //             artist: None,
    //             album: None,
    //             year: None,
    //             genre: None,
    //             duration: None,
    //             pictures: Vec::new(),
    //         },
    //     )
    //     .expect("Could not write tag.");
    //     read_tag_mp3();
    // }

    // #[test]
    // fn write_tag_mp3() {
    //     let picture1 = picture::Picture::new(
    //         picture::PictureType::CoverFront,
    //         picture::MimeType::Jpeg,
    //         std::fs::File::open("samples/picture1.jpg")
    //             .unwrap()
    //             .bytes()
    //             .map(|b| b.unwrap())
    //             .collect(),
    //     );
    //
    //     let picture2 = picture::Picture::new(
    //         picture::PictureType::CoverBack,
    //         picture::MimeType::Jpeg,
    //         std::fs::File::open("samples/picture2.jpg")
    //             .unwrap()
    //             .bytes()
    //             .map(|b| b.unwrap())
    //             .collect(),
    //     );
    //
    //     write(
    //         "samples/test.mp3".to_string(),
    //         Tag {
    //             title: Some("Title".to_string()),
    //             artist: Some("Artist".to_string()),
    //             album: Some("Album".to_string()),
    //             year: Some(2022),
    //             genre: Some("Genre".to_string()),
    //             pictures: vec![picture1, picture2],
    //             ..Default::default()
    //         },
    //     )
    //     .expect("Failed to write tag.");

    // read_tag_mp3();
    // }
    //
    // #[test]
    // fn read_tag_mp4() {
    //     let tag = read("samples/test.mp4".to_string()).expect("Could not read tag.");
    //
    //     println!("{:?}", tag.title);
    //     println!("{:?}", tag.artist);
    //     println!("{:?}", tag.album);
    //     println!("{:?}", tag.year);
    //     println!("{:?}", tag.genre);
    //     println!("{:?}", tag.duration);
    //     println!("{:?}", tag.pictures);
    // }
    //
    // #[test]
    // fn clear_tag_mp4() {
    //     write(
    //         "samples/test.mp4".to_string(),
    //         Tag {
    //             title: None,
    //             artist: None,
    //             album: None,
    //             year: None,
    //             genre: None,
    //             duration: None,
    //             pictures: Vec::new(),
    //         },
    //     )
    //     .expect("Could not write tag.");
    //     read_tag_mp4();
    // }
    //
    // #[test]
    // fn write_tag_mp4() {
    //     let picture1 = picture::Picture::new(
    //         picture::PictureType::CoverFront,
    //         picture::MimeType::Jpeg,
    //         std::fs::File::open("samples/picture1.jpg")
    //             .unwrap()
    //             .bytes()
    //             .map(|b| b.unwrap())
    //             .collect(),
    //     );
    //
    //     let picture2 = picture::Picture::new(
    //         picture::PictureType::CoverBack,
    //         picture::MimeType::Jpeg,
    //         std::fs::File::open("samples/picture2.jpg")
    //             .unwrap()
    //             .bytes()
    //             .map(|b| b.unwrap())
    //             .collect(),
    //     );
    //
    //     write(
    //         "samples/test.mp4".to_string(),
    //         Tag {
    //             title: Some("Title".to_string()),
    //             artist: Some("Artist".to_string()),
    //             album: Some("Album".to_string()),
    //             year: Some(2022),
    //             genre: Some("Genre".to_string()),
    //             pictures: vec![picture1, picture2],
    //             ..Default::default()
    //         },
    //     )
    //     .expect("Failed to write tag.");
    //
    //     read_tag_mp4();
    // }
}
