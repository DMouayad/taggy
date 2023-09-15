## Contributing Guide

First of all, thank you for taking the time to help improve this project, it's much appreciated even if it's a tiny one!

Secondly, **if** you'd like, here's **some steps to follow:**

1. Setup a local clone of this repo and make a new branch to hold your changes.
2. If you don't have an issue-fix\feature\improvement in mind, check the 
 [Taggy project tasks](https://github.com/users/DMouayad/projects/4/views/1) for inspiration and the issues tab.
3. Do your magic🧙🏻‍♂️.
4. Write/update tests for the changes you made, if necessary.
5. Run unit tests and make sure all tests pass:
   
   - for Dart & Flutter code unit tests: `melos run test`
   - for Rust code tests: `cargo test`

6. Update `README.md` and `CHANGELOG.md` if necessary.
7. Once you've made sure everything is working, open a Pull Request with a description of your changes.

https://semver.org/

## Run locally guide:

--- 

> You may want to Read about `flutter_runt_bridge`, check out:
>- [Creating a library guide.](https://cjycode.com/flutter_rust_bridge/library.html)
>- [How It Works.](https://cjycode.com/flutter_rust_bridge/contributing/design.html)

### Dependencies

- [Melos](https://melos.invertase.dev)
  - install it be running: `dart pub global activate melos`
  - once installed, run `melos bs` in the project root.

- `Rust` toolchain, which you can get from [rustup](https://rustup.rs).

### Run Dart unit tests

The Dart unit tests located at `~/packages/taggy/test/unit.dart` and to run them we need the dylib of `taggy` for our OS.

A quick way to generate it is running `cargo build` in the project root. The previous command will generate the required 
    binaries.

Now you can *run* the unit tests by executing: `dart test` or `melos run test`

### Run the Flutter example app and Integration tests 

You should be able to run the example app and integration tests without any issues since it will automatically
download the required binaries from GitHub package releases.