const std = @import("std");
const print = std.debug.print;
const allocator = std.heap.page_allocator;
pub fn main() void {
    var list = std.ArrayList(u8).init(allocator);
    errdefer list.deinit();

    // error: array literal requires address-of operator to coerce to slice type '[]u8'
    // for ([]u8{ 1, 2, 3, 4 }) |item| {
    for ([_]u8{ 1, 2, 3, 4 }) |item| {
        // error: expected type 'void', found '@typeInfo(@typeInfo(@TypeOf(std.array_list.ArrayListAligned(u8,null).append)).Fn.return_type.?).ErrorUnion.error_set'
        // try list.append(42);
        list.append(42) catch unreachable;
    }

    var slice = list.toOwnedSlice();
    defer allocator.free(slice);
    print("{any} ", .{slice});
}
