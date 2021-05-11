// author: lia https://discord.com/channels/605571803288698900/605572581046747136/841534866482266132

// $ zig run test.zig
// serialised: { 7, 0, 0, 0, 0, 0, 0, 0, 98, 114, 111, 115, 101, 112, 104, 17,
// 0, 0, 0, 0, 0, 0, 0, 107, 105, 110, 103, 32, 111, 102, 32, 97, 108, 108, 32,
// 107, 105, 110, 103, 115, 41, 35 }
// thing name:  broseph
// thing title: king of all kings
// thing hp:    9001
// $

const std = @import("std");

const MyThing = struct {
    name: []u8,
    title: []u8,
    hp: u16,

    fn init(allocator: *std.mem.Allocator, name: []const u8, title: []const u8, hp: u16) !MyThing {
        var name_copy = try allocator.dupe(u8, name);
        errdefer allocator.free(name_copy);
        var title_copy = try allocator.dupe(u8, title);

        return MyThing{
            .name = name_copy,
            .title = title_copy,
            .hp = hp,
        };
    }

    fn deinit(self: *MyThing, allocator: *std.mem.Allocator) void {
        allocator.free(self.title);
        allocator.free(self.name);
    }

    fn serialise(self: MyThing, writer: anytype) !void {
        try writer.writeIntLittle(usize, self.name.len);
        try writer.writeAll(self.name);

        try writer.writeIntLittle(usize, self.title.len);
        try writer.writeAll(self.title);

        try writer.writeIntLittle(u16, self.hp);
    }

    fn deserialise(allocator: *std.mem.Allocator, reader: anytype) !MyThing {
        const name_len = try reader.readIntLittle(usize);
        var name = try allocator.alloc(u8, name_len);
        errdefer allocator.free(name);

        try reader.readNoEof(name);

        const title_len = try reader.readIntLittle(usize);
        var title = try allocator.alloc(u8, title_len);
        errdefer allocator.free(title);

        try reader.readNoEof(title);

        const hp = try reader.readIntLittle(u16);

        return MyThing{
            .name = name,
            .title = title,
            .hp = hp,
        };
    }
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    var buf = std.ArrayList(u8).init(&gpa.allocator);
    defer buf.deinit();

    {
        var thing = try MyThing.init(&gpa.allocator, "broseph", "king of all kings", 9001);
        defer thing.deinit(&gpa.allocator);

        try thing.serialise(buf.writer());
    }

    std.debug.print("serialised: {any}\n", .{buf.items});

    {
        var thing = try MyThing.deserialise(&gpa.allocator, std.io.fixedBufferStream(buf.items).reader());
        defer thing.deinit(&gpa.allocator);

        std.debug.print("thing name:  {s}\n", .{thing.name});
        std.debug.print("thing title: {s}\n", .{thing.title});
        std.debug.print("thing hp:    {}\n", .{thing.hp});
    }
}
