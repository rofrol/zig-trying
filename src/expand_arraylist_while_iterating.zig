const std = @import("std");
const print = std.debug.print;
const allocator = std.heap.page_allocator;
pub fn main() !void {
    var list = std.ArrayList(u8).init(allocator);
    errdefer list.deinit();

    // error: array literal requires address-of operator to coerce to slice type '[]u8'
    // for ([]u8{ 1, 2, 3, 4 }) |item| {
    for ([_]u8{ 1, 2, 3, 4 }) |item| {
        try list.append(42);
    }

    var slice = list.toOwnedSlice();
    defer allocator.free(slice);
    print("{any} ", .{slice});
}
