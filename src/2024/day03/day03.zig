const std = @import("std");
const regex = @import("regex");
const exre = @import("exre");

pub const secondStar: bool = false;
pub const inputPath: []const u8 = "zig-out/bin/data/2024/03/input.txt";

pub fn star1(input: []const []const u8) void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    var re = regex.Regex.compile(allocator, "(test)") catch |err| {
        std.debug.print("Compile error {}\n", .{err});
        return;
    };
    const captures = re.captures(input[0]) catch |err| {
        std.debug.print("Captures error {}\n", .{err});
        return;
    };
    if (captures) |capture| {
        std.debug.print(
            "cap 0:{s}, cap 1:{s}, cap 2:{s}, cap3:{s}\n",
            .{
                capture.sliceAt(0) orelse "no match",
                capture.sliceAt(1) orelse "no match",
                capture.sliceAt(2) orelse "no match",
                capture.sliceAt(3) orelse "no match",
            },
        );
    } else {
        std.debug.print("No captures found\n", .{});
    }
    std.debug.print("Not implemented\n", .{});
}

pub fn star2(input: []const []const u8) void {
    _ = input;
    std.debug.print("Not implemented\n", .{});
}
