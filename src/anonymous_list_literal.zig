const std = @import("std");
const expect = std.testing.expect;

test "fully anonymous list literal" {
    test_args(.{ @as(u32, 1234), 12.34, true, "hi" });
}

fn test_args(args: anytype) void {
    expect(args.@"0" == 1234);
    expect(args.@"1" == 12.34);
    expect(args.@"2");
    expect(args.@"3"[0] == 'h');
    expect(args.@"3"[1] == 'i');
}

pub fn main() void {
    dump(.{ @as(u32, 1234), 12.34, true, "hi" });
}

fn dump(args: anytype) void {
    inline for (std.meta.fields(@TypeOf(args))) |field| {
        std.debug.warn("{any} = {any}\n", .{ field.name, @field(args, field.name) });
    }
}
