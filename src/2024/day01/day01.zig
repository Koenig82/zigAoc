const std = @import("std");

pub const secondStar: bool = true;
pub const inputPath: []const u8 = "zig-out/bin/data/2024/01/input.txt";

pub fn star1(input: []const []const u8) void {
    var colA: [1000]i32 = undefined;
    var colB: [1000]i32 = undefined;
    var i: usize = 0;
    for (input) |line| {
        const numeric_partA = line[0..5];
        const number1 = std.fmt.parseInt(i32, numeric_partA, 10) catch |err| {
            std.debug.print("std.fmt.parseInt error with line '{s}': {}\n", .{ line, err });
            continue;
        };

        const numeric_partB = line[8..13];
        const number2 = std.fmt.parseInt(i32, numeric_partB, 10) catch |err| {
            std.debug.print("std.fmt.parseInt error with line '{s}': {}\n", .{ line, err });
            continue;
        };
        colA[i] = number1;
        colB[i] = number2;
        i += 1;
    }
    std.mem.sort(i32, &colA, {}, comptime std.sort.asc(i32));
    std.mem.sort(i32, &colB, {}, comptime std.sort.asc(i32));
    var sum: i32 = 0;
    for (0..input.len) |index| {
        sum += @intCast(@abs(colA[index] - colB[index]));
    }
    std.debug.print("{}\n", .{sum});
}

pub fn star2(input: []const []const u8) void {
    var sum: i32 = 0;
    var timesPresent: i32 = 0;
    for (input) |line| {
        const numeric_partA = line[0..5];
        const number1 = std.fmt.parseInt(i32, numeric_partA, 10) catch |err| {
            std.debug.print("std.fmt.parseInt error with line '{s}': {}\n", .{ line, err });
            continue;
        };
        for (input) |lineB| {
            const numeric_partB = lineB[8..13];
            if (std.mem.eql(u8, numeric_partA, numeric_partB)) {
                timesPresent += 1;
            }
        }
        sum += (number1 * timesPresent);
        timesPresent = 0;
    }
    std.debug.print("{}\n", .{sum});
}
