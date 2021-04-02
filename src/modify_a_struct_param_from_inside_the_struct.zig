// https://github.com/xpyxel/zstd/blob/03d36b3e3b6bae2095410ba5e6a016e802050d7b/src/lib/file.zig#L20

const std = @import("std");

const Vec3 = struct {
    const Self = @This();
    x: f32,
    pub fn init(x: f32) Self {
        return Self{
            .x = x,
        };
    }
    pub fn foo(self: *Self) void {
        self.x = 10;
    }
};

test "stuff" {
    var v1 = Vec3.init(10.0);
    v1.foo();
    std.debug.print("\n{d}\n", .{v1.x});
}
