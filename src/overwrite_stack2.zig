// https://zigforum.org/t/defining-slice-of-mutable-array-literal-in-one-statement/218/14?u=rofrol
const std = @import("std");
const print = std.debug.print;

fn dosomething() !void {
    var buffer: [100]u32 = undefined;
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    var allocator = &arena.allocator;
    const file_buffer = try allocator.alloc(u8, 10);
}

pub fn fn2() !void {
    var slice_of_mutable_array_literal: []u8 = blk: {
        var arr = [_]u8{ 1, 2, 3 };
        break :blk arr[0..];
    };
    print("slice_of_mutable_array_literal: {any}\n", .{slice_of_mutable_array_literal});
    try dosomething();
    print("slice_of_mutable_array_literal: {any}\n", .{slice_of_mutable_array_literal});
}

pub fn main() !void {
    try fn2();
}
