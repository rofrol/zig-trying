const print = @import("std").debug.print;

fn foo() void {
    const S = struct {
        var x: i32 = 1234;
    };
}

pub fn main() void {
    print("foo.S.x: {}\n", .{foo.S.x});
}
