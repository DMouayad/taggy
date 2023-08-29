use super::*;
// Section: wire functions

#[no_mangle]
pub extern "C" fn wire_read_from_path(port_: i64, path: *mut wire_uint_8_list) {
    wire_read_from_path_impl(port_, path)
}

#[no_mangle]
pub extern "C" fn wire_write_all(
    port_: i64,
    path: *mut wire_uint_8_list,
    tags: *mut wire_list_tag,
    should_override: bool,
) {
    wire_write_all_impl(port_, path, tags, should_override)
}

// Section: allocate functions

#[no_mangle]
pub extern "C" fn new_box_autoadd_mime_type_0(value: i32) -> *mut i32 {
    support::new_leak_box_ptr(value)
}

#[no_mangle]
pub extern "C" fn new_box_autoadd_tag_type_0(value: i32) -> *mut i32 {
    support::new_leak_box_ptr(value)
}

#[no_mangle]
pub extern "C" fn new_box_autoadd_u32_0(value: u32) -> *mut u32 {
    support::new_leak_box_ptr(value)
}

#[no_mangle]
pub extern "C" fn new_list_picture_0(len: i32) -> *mut wire_list_picture {
    let wrap = wire_list_picture {
        ptr: support::new_leak_vec_ptr(<wire_Picture>::new_with_null_ptr(), len),
        len,
    };
    support::new_leak_box_ptr(wrap)
}

#[no_mangle]
pub extern "C" fn new_list_tag_0(len: i32) -> *mut wire_list_tag {
    let wrap = wire_list_tag {
        ptr: support::new_leak_vec_ptr(<wire_Tag>::new_with_null_ptr(), len),
        len,
    };
    support::new_leak_box_ptr(wrap)
}

#[no_mangle]
pub extern "C" fn new_uint_8_list_0(len: i32) -> *mut wire_uint_8_list {
    let ans = wire_uint_8_list {
        ptr: support::new_leak_vec_ptr(Default::default(), len),
        len,
    };
    support::new_leak_box_ptr(ans)
}

// Section: related functions

// Section: impl Wire2Api

impl Wire2Api<String> for *mut wire_uint_8_list {
    fn wire2api(self) -> String {
        let vec: Vec<u8> = self.wire2api();
        String::from_utf8_lossy(&vec).into_owned()
    }
}

impl Wire2Api<MimeType> for *mut i32 {
    fn wire2api(self) -> MimeType {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        Wire2Api::<MimeType>::wire2api(*wrap).into()
    }
}
impl Wire2Api<TagType> for *mut i32 {
    fn wire2api(self) -> TagType {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        Wire2Api::<TagType>::wire2api(*wrap).into()
    }
}
impl Wire2Api<u32> for *mut u32 {
    fn wire2api(self) -> u32 {
        unsafe { *support::box_from_leak_ptr(self) }
    }
}

impl Wire2Api<Vec<Picture>> for *mut wire_list_picture {
    fn wire2api(self) -> Vec<Picture> {
        let vec = unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        };
        vec.into_iter().map(Wire2Api::wire2api).collect()
    }
}
impl Wire2Api<Vec<Tag>> for *mut wire_list_tag {
    fn wire2api(self) -> Vec<Tag> {
        let vec = unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        };
        vec.into_iter().map(Wire2Api::wire2api).collect()
    }
}

impl Wire2Api<Picture> for wire_Picture {
    fn wire2api(self) -> Picture {
        Picture {
            pic_type: self.pic_type.wire2api(),
            mime_type: self.mime_type.wire2api(),
            width: self.width.wire2api(),
            height: self.height.wire2api(),
            color_depth: self.color_depth.wire2api(),
            num_colors: self.num_colors.wire2api(),
        }
    }
}

impl Wire2Api<Tag> for wire_Tag {
    fn wire2api(self) -> Tag {
        Tag {
            tag_type: self.tag_type.wire2api(),
            pictures: self.pictures.wire2api(),
            track_title: self.track_title.wire2api(),
            track_artist: self.track_artist.wire2api(),
            album: self.album.wire2api(),
            album_artist: self.album_artist.wire2api(),
            producer: self.producer.wire2api(),
            track_number: self.track_number.wire2api(),
            track_total: self.track_total.wire2api(),
            disk_number: self.disk_number.wire2api(),
            disk_total: self.disk_total.wire2api(),
            year: self.year.wire2api(),
            recording_date: self.recording_date.wire2api(),
            original_release_date: self.original_release_date.wire2api(),
            language: self.language.wire2api(),
            lyrics: self.lyrics.wire2api(),
            genre: self.genre.wire2api(),
        }
    }
}

impl Wire2Api<Vec<u8>> for *mut wire_uint_8_list {
    fn wire2api(self) -> Vec<u8> {
        unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        }
    }
}
// Section: wire structs

#[repr(C)]
#[derive(Clone)]
pub struct wire_list_picture {
    ptr: *mut wire_Picture,
    len: i32,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_list_tag {
    ptr: *mut wire_Tag,
    len: i32,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_Picture {
    pic_type: i32,
    mime_type: *mut i32,
    width: *mut u32,
    height: *mut u32,
    color_depth: *mut u32,
    num_colors: *mut u32,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_Tag {
    tag_type: *mut i32,
    pictures: *mut wire_list_picture,
    track_title: *mut wire_uint_8_list,
    track_artist: *mut wire_uint_8_list,
    album: *mut wire_uint_8_list,
    album_artist: *mut wire_uint_8_list,
    producer: *mut wire_uint_8_list,
    track_number: *mut u32,
    track_total: *mut u32,
    disk_number: *mut u32,
    disk_total: *mut u32,
    year: *mut u32,
    recording_date: *mut wire_uint_8_list,
    original_release_date: *mut wire_uint_8_list,
    language: *mut wire_uint_8_list,
    lyrics: *mut wire_uint_8_list,
    genre: *mut wire_uint_8_list,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_uint_8_list {
    ptr: *mut u8,
    len: i32,
}

// Section: impl NewWithNullPtr

pub trait NewWithNullPtr {
    fn new_with_null_ptr() -> Self;
}

impl<T> NewWithNullPtr for *mut T {
    fn new_with_null_ptr() -> Self {
        std::ptr::null_mut()
    }
}

impl NewWithNullPtr for wire_Picture {
    fn new_with_null_ptr() -> Self {
        Self {
            pic_type: Default::default(),
            mime_type: core::ptr::null_mut(),
            width: core::ptr::null_mut(),
            height: core::ptr::null_mut(),
            color_depth: core::ptr::null_mut(),
            num_colors: core::ptr::null_mut(),
        }
    }
}

impl Default for wire_Picture {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}

impl NewWithNullPtr for wire_Tag {
    fn new_with_null_ptr() -> Self {
        Self {
            tag_type: core::ptr::null_mut(),
            pictures: core::ptr::null_mut(),
            track_title: core::ptr::null_mut(),
            track_artist: core::ptr::null_mut(),
            album: core::ptr::null_mut(),
            album_artist: core::ptr::null_mut(),
            producer: core::ptr::null_mut(),
            track_number: core::ptr::null_mut(),
            track_total: core::ptr::null_mut(),
            disk_number: core::ptr::null_mut(),
            disk_total: core::ptr::null_mut(),
            year: core::ptr::null_mut(),
            recording_date: core::ptr::null_mut(),
            original_release_date: core::ptr::null_mut(),
            language: core::ptr::null_mut(),
            lyrics: core::ptr::null_mut(),
            genre: core::ptr::null_mut(),
        }
    }
}

impl Default for wire_Tag {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}

// Section: sync execution mode utility

#[no_mangle]
pub extern "C" fn free_WireSyncReturn(ptr: support::WireSyncReturn) {
    unsafe {
        let _ = support::box_from_leak_ptr(ptr);
    };
}
