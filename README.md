Base created with `zig init-exe`

## run

Windows

'zig build-exe src/main.zig && main'

or Linux

'zig build-exe src/main.zig && ./main'

## autorun

Install Rust https://rustup.rs/

```bash
cargo install watchexec
# on windows
watchexec -w src/main.zig -i zig-cache -e zig 'zig build-exe src/main.zig && main'
# on linux
watchexec -w src/main.zig -i zig-cache -e zig 'zig build-exe src/main.zig && ./main'
```
