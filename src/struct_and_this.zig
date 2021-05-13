const print = @import("std").debug.print;

const Bar = struct {
    number: u32,

    pub fn printMe(self: *Bar) void {
        print("{}\n", .{self.number});
    }
};

pub fn main() !void {
    var bar = Bar{ .number = 1000 };
    bar.printMe();
}
