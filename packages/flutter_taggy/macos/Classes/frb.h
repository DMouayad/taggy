#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
typedef struct _Dart_Handle* Dart_Handle;

typedef struct DartCObject DartCObject;

typedef int64_t DartPort;

typedef bool (*DartPostCObjectFnType)(DartPort port_id, void *message);

typedef struct wire_uint_8_list {
  uint8_t *ptr;
  int32_t len;
} wire_uint_8_list;

typedef struct wire_Picture {
  int32_t pic_type;
  struct wire_uint_8_list *pic_data;
  int32_t *mime_type;
  uint32_t *width;
  uint32_t *height;
  uint32_t *color_depth;
  uint32_t *num_colors;
} wire_Picture;

typedef struct wire_list_picture {
  struct wire_Picture *ptr;
  int32_t len;
} wire_list_picture;

typedef struct wire_Tag {
  int32_t tag_type;
  struct wire_list_picture *pictures;
  struct wire_uint_8_list *track_title;
  struct wire_uint_8_list *track_artist;
  struct wire_uint_8_list *album;
  struct wire_uint_8_list *album_artist;
  struct wire_uint_8_list *producer;
  uint32_t *track_number;
  uint32_t *track_total;
  uint32_t *disc_number;
  uint32_t *disc_total;
  uint32_t *year;
  struct wire_uint_8_list *recording_date;
  struct wire_uint_8_list *original_release_date;
  struct wire_uint_8_list *language;
  struct wire_uint_8_list *lyrics;
  struct wire_uint_8_list *genre;
} wire_Tag;

typedef struct wire_list_tag {
  struct wire_Tag *ptr;
  int32_t len;
} wire_list_tag;

typedef struct DartCObject *WireSyncReturn;

void store_dart_post_cobject(DartPostCObjectFnType ptr);

Dart_Handle get_dart_object(uintptr_t ptr);

void drop_dart_object(uintptr_t ptr);

uintptr_t new_dart_opaque(Dart_Handle handle);

intptr_t init_frb_dart_api_dl(void *obj);

void wire_read_all(int64_t port_, struct wire_uint_8_list *path);

void wire_read_primary(int64_t port_, struct wire_uint_8_list *path);

void wire_read_any(int64_t port_, struct wire_uint_8_list *path);

void wire_write_all(int64_t port_,
                    struct wire_uint_8_list *path,
                    struct wire_list_tag *tags,
                    bool override_existent);

void wire_write_primary(int64_t port_,
                        struct wire_uint_8_list *path,
                        struct wire_Tag *tag,
                        bool keep_others);

void wire_remove_all(int64_t port_, struct wire_uint_8_list *path);

void wire_remove_tag(int64_t port_, struct wire_uint_8_list *path, struct wire_Tag *tag);

int32_t *new_box_autoadd_mime_type_0(int32_t value);

struct wire_Tag *new_box_autoadd_tag_0(void);

uint32_t *new_box_autoadd_u32_0(uint32_t value);

struct wire_list_picture *new_list_picture_0(int32_t len);

struct wire_list_tag *new_list_tag_0(int32_t len);

struct wire_uint_8_list *new_uint_8_list_0(int32_t len);

void free_WireSyncReturn(WireSyncReturn ptr);

static int64_t dummy_method_to_enforce_bundling(void) {
    int64_t dummy_var = 0;
    dummy_var ^= ((int64_t) (void*) wire_read_all);
    dummy_var ^= ((int64_t) (void*) wire_read_primary);
    dummy_var ^= ((int64_t) (void*) wire_read_any);
    dummy_var ^= ((int64_t) (void*) wire_write_all);
    dummy_var ^= ((int64_t) (void*) wire_write_primary);
    dummy_var ^= ((int64_t) (void*) wire_remove_all);
    dummy_var ^= ((int64_t) (void*) wire_remove_tag);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_mime_type_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_tag_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_u32_0);
    dummy_var ^= ((int64_t) (void*) new_list_picture_0);
    dummy_var ^= ((int64_t) (void*) new_list_tag_0);
    dummy_var ^= ((int64_t) (void*) new_uint_8_list_0);
    dummy_var ^= ((int64_t) (void*) free_WireSyncReturn);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    dummy_var ^= ((int64_t) (void*) get_dart_object);
    dummy_var ^= ((int64_t) (void*) drop_dart_object);
    dummy_var ^= ((int64_t) (void*) new_dart_opaque);
    return dummy_var;
}
