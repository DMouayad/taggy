## Thank you for contributing to `Taggy`!

---

**Some steps to follow:**
1. Fork or clone the repo and make a new branch to hold your changes.
2. If you don't have an issue or a feature or an improvement in mind, check the 
 [Taggy project tasks](https://github.com/users/DMouayad/projects/4/views/1) for inspiration.
3. Work your magic.
4. Write/update tests for the changes you made, if necessary.
5. Run unit tests and make sure all tests pass:
 `dart test`, `flutter test` and `cargo test`.
6. Update `README.md` or `CHANGELOG.md` if necessary.
7. Once you've made sure everything is working, open a Pull Request with a description of changes.


## Run locally guide:

--- 

> You may want to Read about `flutter_runt_bridge`, check out:
>- [Creating a library guide.](https://cjycode.com/flutter_rust_bridge/library.html)
>- [How It Works.](https://cjycode.com/flutter_rust_bridge/contributing/design.html)

- [Melos](https://melos.invertase.dev)
  - install it be running: `dart pub global activate melos`
  - once installed, run `melos bs` in the project root.

- `Rust` toolchain, which you can get from [rustup](https://rustup.rs).

### Run Dart unit tests:

Dart unit tests located at `~/packages/taggy/test/unit.dart` and to run them we need the dylib.

A quick way to generate it is running `cargo build` in the project root. The previous command will generate the required 
    binaries.

Now you can *run the tests.*

- To build the Flutter binaries (which you only need to do if you choose to run Flutter integration tests locally):
  - macOS (at least for `build-apple.sh`)
  - [Android NDK](https://developer.android.com/ndk/downloads)
    - NDK version 25 (`r25b`)
  - [Zig](https://ziglang.org/learn/getting-started/#installing-zig)
  - llvm (with `clang-cl`!)
    - Need to run `brew install llvm` on macOS since Apple's doesn't have it