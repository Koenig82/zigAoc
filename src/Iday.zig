const std = @import("std");

pub const Day = struct {
    star1: fn (input: []const []const u8) void,
    star2: fn (input: []const []const u8) void,
    secondStar: bool,
    inputPath: []const u8,
};

pub const all_days = [_]Day{
    .{ .star1 = @import("2024/day01/day01.zig").star1, .star2 = @import("2024/day01/day01.zig").star2, .secondStar = @import("2024/day01/day01.zig").secondStar, .inputPath = @import("2024/day01/day01.zig").inputPath },
    .{ .star1 = @import("2024/day02/day02.zig").star1, .star2 = @import("2024/day02/day02.zig").star2, .secondStar = @import("2024/day02/day02.zig").secondStar, .inputPath = @import("2024/day02/day02.zig").inputPath },
    .{ .star1 = @import("2024/day03/day03.zig").star1, .star2 = @import("2024/day03/day03.zig").star2, .secondStar = @import("2024/day03/day03.zig").secondStar, .inputPath = @import("2024/day03/day03.zig").inputPath },
};
