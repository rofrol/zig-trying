const std = @import("std");

pub fn main() anyerror!void {
    const file_path = "src/print_content_of_itself.zig";

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    var arena_allocator = &arena.allocator;

    const file_character_list = try relative_file_path_to_u8_list(arena_allocator, file_path);

    std.debug.print("{s}", .{file_character_list.items});
}

fn relative_file_path_to_u8_list(
    allocator: *std.mem.Allocator,
    relative_file_path: []const u8,
) !std.ArrayList(u8) {
    const file = try std.fs.cwd().openFile(relative_file_path, .{});
    defer file.close();
    const file_size = (try file.stat()).size;
    const file_buffer = try allocator.alloc(u8, file_size);
    defer allocator.free(file_buffer);
    _ = try file.readAll(file_buffer);

    var list_of_strings = std.ArrayList(u8).init(allocator);

    for (file_buffer) |character| {
        try list_of_strings.append(character);
    }
    return list_of_strings;
}
