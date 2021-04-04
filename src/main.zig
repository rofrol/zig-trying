const print = std.debug.print;
const std = @import("std");
const os = std.os;
const assert = std.debug.assert;
const mem = @import("std").mem;
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;

pub fn main() anyerror!void {
    std.log.info("All your codebase are belong to us.", .{});
    print("Hello, {s}!\n", .{"world"});

    // optional
    var optional_value: ?[]const u8 = null;
    assert(optional_value == null);

    print("\noptional 1\ntype: {s}\nvalue: {s}\n", .{
        @typeName(@TypeOf(optional_value)),
        optional_value,
    });

    optional_value = "hi ł \u{1f4a9} \x10ffff";
    assert(optional_value != null);

    print("\noptional 2\ntype: {s}\nvalue: {s}\n", .{
        @typeName(@TypeOf(optional_value)),
        optional_value,
    });

    const multiline_string_literal =
        \\this is
        \\multiline string literal
    ;

    print("multiline:\n{s}\n", .{multiline_string_literal});

    // 2^128 - 1

    var max_i16_decimal: i16 = 32767; // 2^15 - 1
    print("max_i16_decimal: {}\n", .{max_i16_decimal});
    var max_i16_binary: i16 = 0b111_1111_1111_1111;
    print("max_i16_binary: {}\n", .{max_i16_binary});
    var min_i16_decimal: i16 = -32768;
    print("min_i16_decimal: {}\n", .{min_i16_decimal});
    // var min_i16_binary: i16 = -0b0100_0000_0000_0000;
    // var min_i16_binary: i16 = -0b1111_1111_1111_1111;
    var min_i16_binary: i16 = -0b1000_0000_0000_0000;
    print("min_i16_binary: {}\n", .{min_i16_binary});
    // var var3: i16 = -0b1000_0000_0000_0001;
    // print("var3: {}\n", .{var3});
    var var4: i16 = -0b1000_0000_0000_0000 + 1;
    print("var4: {}\n", .{var4});
    var var5: i16 = -0b0111_1111_1111_1111;
    print("var5: {}\n", .{var5});
    var var6: i16 = 0b0111_1111_1111_1111;
    print("var6: {}\n", .{var6});
    var var7: i16 = -0b1000_0000_0000_0000;
    print("var7: {}\n", .{var7});
    var var8: i16 = 0b111_1111_1111_1111;
    print("var8: {}\n", .{var8});
    var max_u16_decimal: u16 = 65535;
    var max_u16_binary: u16 = 0b1111_1111_1111_1111;
    print("max_u16_binary: {}\n", .{max_u16_binary});
    print("std.math.maxInt(i16): {}\n", .{std.math.maxInt(i16)});
    print("std.math.maxInt(i16) binary: {b}\n", .{std.math.maxInt(i16)});
    print("std.math.minInt(i16): {}\n", .{std.math.minInt(i16)});
    print("std.math.minInt(i16) binary: {b}\n", .{std.math.minInt(i16)});
    print("std.math.minInt(i16) binary: {b}\n", .{std.math.minInt(i16) + 1});
    print("std.math.maxInt(u32): {}\n", .{std.math.maxInt(u32)});
    print("std.math.maxInt(u64): {}\n", .{std.math.maxInt(u64)});
    print("std.math.minInt(u64): {}\n", .{std.math.minInt(u64)});
    print("std.math.minInt(i64): {}\n", .{std.math.minInt(i64)});
    // var var1: i16 = -65535;
    // var max_u32_binary: u16 = 0b1111_1111_1111_1111_1111_1111_1111_1111;
    // std.math.maxInt(u32)

    // 2^127 - 1
    // var max_i128_decimal: i128 = -170141183460469231731687303715884105727;

    // const a = [_]u32{ 1, 2 } ++ [_]u32{ 3, 4 } == &[_]u32{ 1, 2, 3, 4 };
    // print("{}", .{a});

    print("{}\n", .{@as(i2, -0b10)});
    print("{b}\n", .{@as(i2, -0b10)});
    print("std.math.minInt(i2): {}\n", .{std.math.minInt(i2)});
    print("{b}\n", .{@as(i2, -0b01)});
    print("{b}\n", .{@as(i4, -0b1000)});
    print("std.math.minInt(i4): {}\n", .{std.math.minInt(i4)});
    print("std.math.minInt(i1): {}\n", .{std.math.minInt(i1)});
    print("std.math.maxInt(i1): {}\n", .{std.math.maxInt(i1)});
    print("std.math.maxInt(i0): {}\n", .{std.math.maxInt(i0)});

    const array1 = [_]u32{ 1, 2 };
    const array2 = [_]u32{ 3, 4 };
    const together = array1 ++ array2;
    expect(mem.eql(u32, &together, &[_]u32{ 1, 2, 3, 4 }));
    print("{any}\n", .{together});
    print("{s}\n", .{"ab" ** 3});

    const message = [_]u8{ 'h', 'e', 'l', 'l', 'o' };
    expect(message.len == 5);
    print("{any}\n", .{message.len});

    const same_message = "hello";

    print("{any}\n", .{mem.eql(u8, &message, same_message)});
    expect(mem.eql(u8, &message, same_message));

    var integers = [_]i32{ 1, 2 };
    print("{any}\n", .{integers});
    print("{any}\n", .{integers[0]});

    var some_integers: [100]i32 = undefined;
    for (some_integers) |*item, i| {
        item.* = @intCast(i32, i);
    }

    const more_integers: [4]u8 = .{ 12, 12, 32, 5 };
    print("{any}\n", .{more_integers});

    print("S.x: {}\n", .{S.x});

    // can specify the tag type.
    const Value = enum(u2) {
        zero,
        one,
        two,
        four,
    };

    expect(@enumToInt(Value.four) == 3);

    var_file_scope += 1;
    print("var_file_scope: {}\n", .{var_file_scope});

    var buffer: [100]u8 = undefined;
    const allocator = &std.heap.FixedBufferAllocator.init(&buffer).allocator;
    const digits = try decimals(allocator, 345);
    print("{any}\n", .{digits.items});

    print("{}\n", .{std.Target.current.os.tag});

    // https://zigforum.org/t/defining-slice-of-mutable-array-literal-in-one-statement/218/13
    var slice_of_mutable_array_literal: []u8 = blk: {
        var arr = [_]u8{ 1, 2, 3 };
        break :blk arr[0..];
    };

    print("{any}\n", .{slice_of_mutable_array_literal});

    const two_nested_blocks = blk: {
        {
            const a: i32 = 2;
            break :blk a;
        }
    };

    print("{}\n", .{two_nested_blocks});

    var two_nested_blocks_var: i32 = blk: {
        {
            var a: i32 = 2;
            break :blk a;
        }
    };

    print("{}\n", .{two_nested_blocks_var});

    var cond = true;
    var many_nested_blocks: usize = blk: {
        var a: usize = 1;
        {
            var b: usize = 2;
            {
                var c: usize = 3;
                if (cond) break :blk c;
            }
            if (cond) break :blk b;
        }
        break :blk a;
    };

    print("{}\n", .{many_nested_blocks});

    const s = [_][7]i32{
        [_]i32{ 08, 02, 22, 97, 38, 15, 00 },
        [_]i32{ 49, 49, 99, 40, 17, 81, 18 },
        [_]i32{ 81, 49, 31, 73, 55, 79, 14 },
        [_]i32{ 52, 70, 95, 23, 04, 60, 11 },
        [_]i32{ 22, 31, 16, 71, 51, 67, 63 },
        [_]i32{ 24, 47, 32, 60, 99, 03, 45 },
        [_]i32{ 32, 98, 81, 28, 64, 23, 67 },
        [_]i32{ 67, 26, 20, 68, 02, 62, 12 },
        [_]i32{ 24, 55, 58, 05, 66, 73, 99 },
        [_]i32{ 21, 36, 23, 09, 75, 00, 76 },
    };

    const x = .{ .y = &.{ .z = 10 } };
    print("x: {}\n", x);

    interger_overflow();

    const thing1 = 1;
    const thing2 = 2;
    @call(.{}, call_bypasses_a_tuple, .{ thing1, thing2 });

    print("{d}, {d}\n", .{11} ++ .{22});

    //  check that the third bit is true? 0b111101101 & 0b000000100 == 0b000000100
    // (1 shifted left 2 times = 3rd bit)
    print("3rd bit: {b}\n", .{1 << 2});
    print("0b111101101 & 0b000000100: {b}\n", .{0b111101101 & 0b000000100});
    print("0b111101101 & 1 << 2: {b}\n", .{0b111101101 & 1 << 2});
    print("0b111101101 & 1 << 2: 0b{b:0>9}\n", .{0b111101101 & 1 << 2});

    // AstroKing
    // I work mostly on C for low level fimware and embedded projects. I am having some trouble with casting rules. I want to call  rand() (returns c_int type). I then @rem on the result with 0xFF to get a random number between 0 and 0xFE. I want to do this 3 times to get random values for R G and B for getting a random color.

    // https://www.reddit.com/r/Zig/comments/cdw88t/does_zig_have_random_number_and_random_string/
    // https://ziglang.org/documentation/master/std/#std;rand
    // https://ziglearn.org/chapter-4/#linking-libc
    // zig build-exe src/main -lc
    // zig build-exe src/main --library c
    // The CLI now accepts -l parameters as an alias for --library. As an example, one may specify -lc rather than --library c
    // https://ziglang.org/download/0.5.0/release-notes.html
    // https://github.com/ziglang/zig/blob/6fc822a9481c0d2c8b37f26f41be603dd77ab5a4/lib/libcxx/include/stdlib.h
    cstd.srand(@intCast(u32, time.time(0)));

    const rand = cstd.rand();
    print("rand: {x}\n", .{rand});
    print("rand: {d}\n", .{rand});
    print("0xFF: {d}\n", .{0xFF});
    const R_int = @rem(rand, 0xFF);
    const R_hex = @bitCast(u8, @truncate(i8, R_int));
    print("R_hex: {x}\n", .{R_hex});
    print("R_hex: {d}\n", .{R_hex});
    const R_hex2 = @truncate(u8, @bitCast(c_uint, R_int));
    print("R_hex2: {x}\n", .{R_hex});

    var i: usize = 0;

    while (i <= 10) {
        std.debug.warn("{} ", .{@rem(cstd.rand(), 100) + 1});
        i += 1;
    }
}

const time = @cImport(@cInclude("time.h"));
const cstd = @cImport(@cInclude("stdlib.h"));

fn interger_overflow() void {
    var i: u8 = 1;
    // panic: integer overflow
    // var x: u8 = 255 + i;

    // this works
    var y: u8 = 255 - i + 1;
    print("y: {}\n", .{y});
}

fn call_bypasses_a_tuple(thing1: i32, thing2: i32) void {
    print("{d}, {d}\n", .{ thing1, thing2 });
}

var var_file_scope: i32 = 1;

const S = struct {
    var x: i32 = 1234;
};

fn foo() void {
    var y: i32 = 6587;
    y += 1;
}

fn foo2() i32 {
    S.x += 1;
    return S.x;
}

test "assignment" {
    foo();
}

const expect = std.testing.expect;
test "namespaced global variable" {
    expect(foo2() == 1235);
    expect(foo2() == 1236);
}

// https://web.archive.org/web/20210301143402/https://medium.com/swlh/zig-the-introduction-dcd173a86975
fn decimals(alloc: *Allocator, n: u32) !ArrayList(u32) {
    var x = n;
    var digits = ArrayList(u32).init(alloc);
    errdefer digits.deinit();

    while (x >= 10) {
        digits.append(x % 10) catch |err| return err;
        x = x / 10;
    }
    digits.append(x) catch |err| return err;
    return digits;
}
