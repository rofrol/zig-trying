const print = @import("std").debug.print;

const Bar = struct {
    const Self = @This();
    number: u32,

    // cast discards const qualifier
    // error: expected type '*Bar', found '*const Bar
    // pub fn printMe(self: *@This()) void {
    // pub fn printMe(self: *Self) void {

    // pub fn printMe(self: Self) void { // also works
    // pub fn printMe(self: @This()) void {
    // https://github.com/ratfactor/ziglings/pull/54#issuecomment-841265975
    pub fn printMe(self: *const @This()) void {
        print("{}\n", .{self.number});
    }
};

pub fn main() !void {
    const bar = Bar{ .number = 1000 };
    bar.printMe();
    var bar2 = Bar{ .number = 1001 };
    bar2.printMe();
}
