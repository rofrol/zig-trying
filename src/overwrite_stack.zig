// https://zigforum.org/t/annoying-things/208/5
// rofrol: How to reproduce it?
// as(Sobeston, undefined): This isn't something that you can, from a language perspective, reliably reproduce
// You don't define where and how locals are stored

const std = @import("std");

fn oopsie() *u32 {
    var x: u32 = 123;
    std.debug.print("&x: {_}\n", .{&x});
    return &x;
}

fn f() *i32 {
    var i: i32 = 44;
    return &i;
}

fn dosomething() void {
    var buffer: [100]u32 = undefined;
}

pub fn main() !void {
    var xptr = oopsie();
    std.debug.print("xptr: {}\n", .{xptr});
    dosomething();
    std.debug.warn("xptr.*: {}\n", .{xptr.*});
}
