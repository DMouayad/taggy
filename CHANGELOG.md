# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## 2023-09-16

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`flutter_taggy` - `v0.1.2+2`](#flutter_taggy---v0122)
 - [`taggy` - `v0.1.2+2`](#taggy---v0122)

---

#### `flutter_taggy` - `v0.1.2+2`

 - **DOCS**: create separate README files.
 - **DOCS**: direct sub-packages README file to the root package file.

#### `taggy` - `v0.1.2+2`

 - **DOCS**: create separate README files.


## 2023-09-15

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`flutter_taggy` - `v0.1.2+1`](#flutter_taggy---v0121)
 - [`taggy` - `v0.1.2+1`](#taggy---v0121)

---

#### `flutter_taggy` - `v0.1.2+1`

 - **DOCS**: direct sub-packages README file to the root package file.

#### `taggy` - `v0.1.2+1`

 - **DOCS**: direct sub-packages README file to the root package file.

# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## 2023-09-15

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`flutter_taggy` - `v0.1.2`](#flutter_taggy---v012)
 - [`taggy` - `v0.1.2`](#taggy---v012)

---

#### `flutter_taggy` - `v0.1.2`

 - **REFACTOR**: update `remove_tag` function to take a `TagType`.
 - **FIX**: correct the library version.
 - **FEAT**(flutter_taggy): add example app.
 - **FEAT**(flutter_taggy): add `initialize` method.
 - **DOCS**: rename LICENSE-MIT to LICENSE.
 - **DOCS**: update README.md.
 - **DOCS**: move CHANGELOG, README and CONTRIBUTING files to root package.
 - **DOCS**: move CHANGELOG.md to parent package".
 - **DOCS**: add CHANGELOG.md to parent package.
 - **DOCS**(License): update License.
 - **DOCS**: add CHANGELOG.md for both packages.
 - **DOCS**: add license files.

#### `taggy` - `v0.1.2`

 - **REFACTOR**(taggy): extract loading the Dylib to a helper function.
 - **REFACTOR**(taggy): add `formatAsAString` to `Tag` extensions.
 - **REFACTOR**: update `remove_tag` function to take a `TagType`.
 - **REFACTOR**(taggy): add `ExternalLibrary` as parameter for `Taggy.initialize()`.
 - **REFACTOR**(taggy): add `ExternalLibrary` as parameter for `Taggy.initialize()`.
 - **REFACTOR**(native): add `with_duplicate_file` test helper.
 - **FIX**(native): `remove_all` deletes all tags not only primary one.
 - **FIX**(native): log tag type not supported.
 - **FEAT**(flutter_taggy): add `initialize` method.
 - **FEAT**(taggy): add utils for api classes.
 - **FEAT**(taggy): implement a `Dart` API for `Taggy`.
 - **DOCS**: rename LICENSE-MIT to LICENSE.
 - **DOCS**(taggy): update Dart example app README.md.
 - **DOCS**: move CHANGELOG, README and CONTRIBUTING files to root package.
 - **DOCS**: move CHANGELOG.md to parent package".
 - **DOCS**: add CHANGELOG.md to parent package.
 - **DOCS**(License): update License.
 - **DOCS**: add CHANGELOG.md for both packages.
 - **DOCS**: add license files.


## 2023-09-14

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`flutter_taggy` - `v0.1.1`](#flutter_taggy---v011)
 - [`taggy` - `v0.1.1`](#taggy---v011)

---

#### `flutter_taggy` - `v0.1.1`

 - **REFACTOR**: update `remove_tag` function to take a `TagType`.
 - **FIX**: correct the library version.
 - **FEAT**(flutter_taggy): add example app.
 - **FEAT**(flutter_taggy): add `initialize` method.
 - **DOCS**: update README.md.
 - **DOCS**: move CHANGELOG, README and CONTRIBUTING files to root package.
 - **DOCS**: move CHANGELOG.md to parent package".
 - **DOCS**: add CHANGELOG.md to parent package.
 - **DOCS**(License): update License.
 - **DOCS**: add CHANGELOG.md for both packages.
 - **DOCS**: add license files.

#### `taggy` - `v0.1.1`

 - **REFACTOR**(taggy): extract loading the Dylib to a helper function.
 - **REFACTOR**(taggy): add `formatAsAString` to `Tag` extensions.
 - **REFACTOR**: update `remove_tag` function to take a `TagType`.
 - **REFACTOR**(taggy): add `ExternalLibrary` as parameter for `Taggy.initialize()`.
 - **REFACTOR**(taggy): add `ExternalLibrary` as parameter for `Taggy.initialize()`.
 - **REFACTOR**(native): add `with_duplicate_file` test helper.
 - **FIX**(native): `remove_all` deletes all tags not only primary one.
 - **FIX**(native): log tag type not supported.
 - **FEAT**(flutter_taggy): add `initialize` method.
 - **FEAT**(taggy): add utils for api classes.
 - **FEAT**(taggy): implement a `Dart` API for `Taggy`.
 - **DOCS**(taggy): update Dart example app README.md.
 - **DOCS**: move CHANGELOG, README and CONTRIBUTING files to root package.
 - **DOCS**: move CHANGELOG.md to parent package".
 - **DOCS**: add CHANGELOG.md to parent package.
 - **DOCS**(License): update License.
 - **DOCS**: add CHANGELOG.md for both packages.
 - **DOCS**: add license files.

## 0.1.0

### Initial version.

Supports the following:

- Reading all tags.
- Writing multiple tags.
- Reading/writing primary tag.
- Removing all tags.
- Removing a specific tag.