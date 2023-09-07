use std::fmt::Debug;

/// Gives information about a tag's picture.
#[derive(Clone, PartialEq)]
pub struct Picture {
    pub pic_type: PictureType,
    /// The picture's data
    pub pic_data: Vec<u8>,
    /// The picture's mimetype
    pub mime_type: Option<MimeType>,
    /// The picture's width in pixels
    pub width: Option<u32>,
    /// The picture's height in pixels
    pub height: Option<u32>,
    /// The picture's color depth in bits per pixel
    pub color_depth: Option<u32>,
    /// The number of colors used
    pub num_colors: Option<u32>,
}
impl Debug for Picture {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("Picture")
            .field("pic_type", &self.pic_type)
            .field("pic_data", &self.pic_data.len())
            .field("mime_type", &self.mime_type)
            .field("width", &self.width)
            .field("height", &self.height)
            .field("color_depth", &self.color_depth)
            .field("num_colors", &self.num_colors)
            .finish()
    }
}
#[derive(Debug, Clone, Copy, PartialEq)]
pub enum PictureType {
    Other,
    Icon,
    OtherIcon,
    CoverFront,
    CoverBack,
    Leaflet,
    Media,
    LeadArtist,
    Artist,
    Conductor,
    Band,
    Composer,
    Lyricist,
    RecordingLocation,
    DuringRecording,
    DuringPerformance,
    ScreenCapture,
    BrightFish,
    Illustration,
    BandLogo,
    PublisherLogo,
    Undefined,
}

#[derive(Debug, Copy, Clone, PartialEq)]
pub enum MimeType {
    /// PNG image
    Png,
    /// JPEG image
    Jpeg,
    /// TIFF image
    Tiff,
    /// BMP image
    Bmp,
    /// GIF image
    Gif,
    /// Unknown mimetype
    Unknown,
    /// No mimetype
    None,
}
