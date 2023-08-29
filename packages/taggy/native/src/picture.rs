#[derive(Debug)]
pub(crate) struct Picture {
    pub(crate) pic_type: PictureType,
    /// The picture's mimetype
    pub(crate) mime_type: Option<MimeType>,
    /// The picture's width in pixels
    pub(crate) width: Option<u32>,
    /// The picture's height in pixels
    pub(crate) height: Option<u32>,
    /// The picture's color depth in bits per pixel
    pub(crate) color_depth: Option<u32>,
    /// The number of colors used
    pub(crate) num_colors: Option<u32>,
}
#[derive(Debug, Clone, Copy)]
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

#[derive(Debug, Copy, Clone)]
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
