// clad
// 1. I want to open that executable
// 2. I want to send it "command 1"
// 3. I want to send it "command 2"
// Can you tell me how do I use use the ChildProcess to perform these three tasks?

// mikdusan
// ah got it to work. but you have to take a special step. consider this case:
// 1. spawn "cat" and write some lines to it. let it just inherit stdout/stderr.
// 2. waiting on child won't return until stdin pipe is closed
// 3. you can child.stdin.?.close() but I had to follow it up with child.stdin = null; so the regular child_process code doesn't try to close it in cleanupAfterWait()
// this simple just-write to child seems to work:
// https://zigbin.io/0f4af2

const std = @import("std");

pub fn main() !void {
    var arena_state = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena_state.deinit();

    const arena = &arena_state.allocator;

    var args = std.ArrayList([]const u8).init(arena);
    try args.append("/bin/cat");

    const child = try std.ChildProcess.init(args.items, arena);
    defer child.deinit();

    child.stdin_behavior = .Pipe;
    child.stdout_behavior = .Inherit;
    child.stderr_behavior = .Inherit;

    child.spawn() catch |err| std.debug.panic("unable to spawn {s}: {s}\n", .{ args.items[0], @errorName(err) });

    const out = child.stdin.?.writer();
    try out.print("hello {s}.\n", .{"world"});
    try out.print("done.\n", .{});

    child.stdin.?.close();
    child.stdin = null;

    const term = child.wait() catch |err| std.debug.panic("unable to spawn {s}: {s}\n", .{ args.items[0], @errorName(err) });

    switch (term) {
        .Exited => |code| {
            const expect_code: u32 = 0;
            if (code != expect_code) {
                std.debug.warn("process {s} exited with error code {d} but expected code {d}\n", .{
                    args.items[0],
                    code,
                    expect_code,
                });
                return error.SpawnExitedWithError;
            }
        },
        .Signal => |signum| {
            std.debug.warn("process {s} terminated on signal {d}\n", .{ args.items[0], signum });
            return error.SpawnWasSignalled;
        },
        .Stopped => |signum| {
            std.debug.warn("process {s} stopped on signal {d}\n", .{ args.items[0], signum });
            return error.SpawnWasStopped;
        },
        .Unknown => |code| {
            std.debug.warn("process {s} terminated unexpectedly with error code {d}\n", .{ args.items[0], code });
            return error.SpawnWasTerminated;
        },
    }
}
