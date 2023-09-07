use crate::picture::Picture;
use crate::tag::{Tag, TagType};
use fake::{
    faker::lorem::en::Sentences, faker::lorem::en::Word, faker::name::en::Name,
    faker::time::en::Date, Fake,
};
use rand::Rng;

/// responsible for creating a [`Tag`] instance
#[derive(Debug)]
pub struct TagBuilder {
    tag_type: Option<TagType>,
    pictures: Vec<Picture>,
    // Track General Info
    track_title: Option<String>,

    track_artist: Option<String>,

    album: Option<String>,

    album_artist: Option<String>,

    producer: Option<String>,
    /// The number of the track on its disk.
    track_number: Option<u32>,
    /// The disk total track count
    track_total: Option<u32>,

    disc_number: Option<u32>,

    disc_total: Option<u32>,

    year: Option<u32>,

    recording_date: Option<String>,

    original_release_date: Option<String>,

    language: Option<String>,

    lyrics: Option<String>,

    genre: Option<String>,
}

impl TagBuilder {
    pub fn new() -> Self {
        Self {
            tag_type: None,
            pictures: vec![],
            track_title: None,
            track_artist: None,
            album: None,
            album_artist: None,
            producer: None,
            track_number: None,
            track_total: None,
            disc_number: None,
            disc_total: None,
            year: None,
            recording_date: None,
            original_release_date: None,
            language: None,
            lyrics: None,
            genre: None,
        }
    }
    pub fn with_tag_type(self, tag_type: impl Into<TagType>) -> Self {
        Self {
            tag_type: Some(tag_type.into()),
            ..self
        }
    }
    pub fn with_title(self, title: impl Into<String>) -> Self {
        Self {
            track_title: Some(title.into()),
            ..self
        }
    }
    pub fn with_album(self, album: impl Into<String>) -> Self {
        Self {
            album: Some(album.into()),
            ..self
        }
    }
    pub fn with_artist(self, artist: impl Into<String>) -> Self {
        Self {
            track_artist: Some(artist.into()),
            ..self
        }
    }
    pub fn with_album_artist(self, album_artist: impl Into<String>) -> Self {
        Self {
            album_artist: Some(album_artist.into()),
            ..self
        }
    }
    pub fn with_track_number(self, track_number: impl Into<u32>) -> Self {
        Self {
            track_number: Some(track_number.into()),
            ..self
        }
    }
    pub fn with_track_total(self, track_total: impl Into<u32>) -> Self {
        Self {
            track_total: Some(track_total.into()),
            ..self
        }
    }
    pub fn with_disk_number(self, disc_number: impl Into<u32>) -> Self {
        Self {
            disc_number: Some(disc_number.into()),
            ..self
        }
    }
    pub fn with_disk_total(self, disc_total: impl Into<u32>) -> Self {
        Self {
            disc_total: Some(disc_total.into()),
            ..self
        }
    }
    pub fn with_recording_date(self, recording_date: impl Into<String>) -> Self {
        Self {
            recording_date: Some(recording_date.into()),
            ..self
        }
    }
    pub fn with_release_date(self, release_date: impl Into<String>) -> Self {
        Self {
            original_release_date: Some(release_date.into()),
            ..self
        }
    }
    pub fn with_year(self, year: impl Into<u32>) -> Self {
        Self {
            year: Some(year.into()),
            ..self
        }
    }
    pub fn with_language(self, language: impl Into<String>) -> Self {
        Self {
            language: Some(language.into()),
            ..self
        }
    }
    pub fn with_genre(self, genre: impl Into<String>) -> Self {
        Self {
            genre: Some(genre.into()),
            ..self
        }
    }
    pub fn with_producer(self, producer: impl Into<String>) -> Self {
        Self {
            producer: Some(producer.into()),
            ..self
        }
    }
    pub fn with_lyrics(self, lyrics: impl Into<String>) -> Self {
        Self {
            lyrics: Some(lyrics.into()),
            ..self
        }
    }
    pub fn with_pictures(self, pictures: impl Into<Vec<Picture>>) -> TagBuilder {
        TagBuilder {
            pictures: pictures.into(),
            ..self
        }
    }

    pub fn create(self) -> Tag {
        let recording_date = self.recording_date.or(Some(Date().fake()));
        Tag {
            tag_type: self.tag_type.or(Some(TagType::random())).unwrap(),
            pictures: self.pictures,
            track_title: self.track_title.or(Some(Word().fake())),
            track_artist: self.track_artist.or(Some(Name().fake())),
            album: self.album.or(Some(Name().fake())),
            album_artist: self.album_artist.or(Some(Name().fake::<String>().into())),
            // don't auto generate a producer if not specified.
            // the reason is due to writing a producer tag value to "ID3v2" tags.
            producer: self.producer,
            track_number: self.track_number.or(Some(get_random_int(None))),
            track_total: self.track_total.or(Some(get_random_int(None))),
            disc_number: self.disc_number.or(Some(get_random_int(None))),
            disc_total: self.disc_total.or(Some(get_random_int(None))),
            // This is similar to how [`lofty::Tag`] sets the year.
            // it also helps to keep a consistent data between our [Tag] and lofty's.
            year: self
                .year
                .or_else(|| try_parse_year(&recording_date.clone().unwrap())),
            recording_date,
            original_release_date: self.original_release_date.or(Some(Date().fake())),
            language: self.language.or(Some(Word().fake())),
            lyrics: self
                .lyrics
                .or(Some(Sentences(1..4).fake::<Vec<String>>().join(" "))),
            genre: self.genre.or(Some(Word().fake::<String>().into())),
        }
    }
}

fn get_random_int(max: Option<u32>) -> u32 {
    let max = max.or(Some(10)).unwrap();
    rand::thread_rng().gen_range(0..=max)
}
fn try_parse_year(input: &str) -> Option<u32> {
    let (num_digits, year) = input
        .chars()
        .skip_while(|c| c.is_whitespace())
        .take_while(char::is_ascii_digit)
        .take(4)
        .fold((0usize, 0u32), |(num_digits, year), c| {
            let decimal_digit = c.to_digit(10).expect("decimal digit");
            (num_digits + 1, year * 10 + decimal_digit)
        });
    (num_digits == 4).then_some(year)
}
