const print = @import("std").debug.print;

const Bar = struct {
    const Self = @This();
    number: u32,

    // pub fn printMe(self: *@This()) void { // Also works
    pub fn printMe(self: *Self) void {
        print("{}\n", .{self.number});
    }
};

pub fn main() !void {
    var bar = Bar{ .number = 1000 };
    bar.printMe();
}
