const std = @import("std");
const days = @import("Iday.zig");
const root = @import("util.zig");

pub fn main() !void {
    const args = try std.process.argsAlloc(std.heap.page_allocator);
    defer std.process.argsFree(std.heap.page_allocator, args);

    const stdout = std.io.getStdOut().writer();

    if (args.len == 1) {
        try stdout.print("No arguments provided. Running the latest day.\n", .{});
        run_latest_day() catch |err| {
            std.debug.print("Error loading input: {}\n", .{err});
            return err;
        };
    } else if (args.len == 2 and std.mem.eql(u8, args[1], "all")) {
        try stdout.print("Argument 'all' detected. Running all days.\n", .{});
        // run_all_days();
    } else {
        try stdout.print("Usage: zigAoc.exe [all]\n", .{});
        return;
    }
}

fn run_latest_day() !void {
    const latest_day = days.all_days[days.all_days.len - 1];

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const file = try std.fs.cwd().openFile(latest_day.inputPath, .{});
    defer file.close();

    const buffer = try file.readToEndAlloc(allocator, 100000);
    defer allocator.free(buffer);

    const lines = try split_buffer_into_lines(buffer, &allocator);
    defer allocator.free(lines);

    if (latest_day.secondStar) {
        const start = std.time.milliTimestamp();
        latest_day.star2(lines);
        const end = std.time.milliTimestamp();
        std.debug.print("Time: {} ms\n", .{end - start});
    } else {
        const start = std.time.milliTimestamp();
        latest_day.star1(lines);
        const end = std.time.milliTimestamp();
        std.debug.print("Time: {} ms\n", .{end - start});
    }
}

fn split_buffer_into_lines(buffer: []const u8, allocator: *const std.mem.Allocator) ![]const []const u8 {
    var line_count: usize = 0;
    for (buffer) |byte| {
        if (byte == '\n') {
            line_count += 1;
        }
    }

    if (buffer.len > 0 and buffer[buffer.len - 1] != '\n') {
        line_count += 1;
    }

    const lines = try allocator.alloc([]const u8, line_count);
    var start: usize = 0;
    var line_idx: usize = 0;
    var idx: usize = 0;

    while (idx < buffer.len) {
        if (buffer[idx] == '\n') {
            lines[line_idx] = buffer[start..idx];
            line_idx += 1;
            start = idx + 1;
        }
        idx += 1;
    }

    if (start < buffer.len) {
        lines[line_idx] = buffer[start..];
    }

    return lines;
}
