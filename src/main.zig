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
