// fengb
// Tuple literal body is bugged

const std = @import("std");
// const stdout = std.io.getStdOut().writer();
const print = std.debug.print;
pub fn main() void {
    var predicate = true;
    // Remove the bool flip, still prints T
    predicate = !predicate;
    // using std.debug.print as getStdOut on Windows 10 gives me error: unable to evaluate constant expression
    // try stdout.print("{s}\n", .{if (predicate) "T" else "F"});
    print("{s}\n", .{if (predicate) "T" else "F"});
}
