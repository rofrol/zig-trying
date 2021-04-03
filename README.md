Base created with `zig init-exe`

## run

run_win.sh or run_lin.sh

## autorun

Install Rust https://rustup.rs/

on Ubuntu:

```
sudo apt update
sudo apt install build-essential
```

On Windows

```
# Sometimes this is blocked by some old python 2.7 installed. Uninstall it first.
npm i -g windows-build-tools
```

Then for all systems

```bash
cargo install watchexec
```

To run on Linux

```bash
watchexec -w src/main.zig -i zig-cache -e zig 'zig build-exe src/main.zig && ./main'
```

To run on Windows

```bash
watchexec -w src/main.zig -i zig-cache -e zig 'zig build-exe src/main.zig && main'
```
