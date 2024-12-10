const std = @import("std");
const stringUtil = @import("../../util/stringUtil.zig");

pub const secondStar: bool = true;
pub const inputPath: []const u8 = "zig-out/bin/data/2024/02/input.txt";

pub fn star1(input: []const []const u8) void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    var allocator = arena.allocator();

    var increasing: bool = undefined;
    var last: i32 = -1;
    var safe: i32 = 0;
    var numbers: []i32 = undefined;

    for (input) |line| {
        numbers = stringUtil.splitToInts(line, ' ', &allocator) catch |err| {
            std.debug.print("dickNballs {}\n", .{err});
            return;
        };
        increasing = undefined;
        last = -1;
        for (numbers) |number| {
            if (last >= 0) {
                if (number > last and last >= (number - 3) and increasing) {
                    last = number;
                } else if (number < last and last <= (number + 3) and !increasing) {
                    last = number;
                } else {
                    safe -= 1;
                    break;
                }
            } else {
                if (numbers[1] > number) {
                    last = number;
                    increasing = true;
                } else if (numbers[1] < number) {
                    last = number;
                    increasing = false;
                } else {
                    safe -= 1;
                    break;
                }
            }
        }
        safe += 1;
    }
    std.debug.print("{}\n", .{safe});
}

pub fn star2(input: []const []const u8) void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    var allocator = arena.allocator();

    var numbers: []i32 = undefined;
    var safe: i32 = 0;

    for (input) |line| {
        numbers = stringUtil.splitToInts(line, ' ', &allocator) catch |err| {
            std.debug.print("dickNballs {}\n", .{err});
            return;
        };
        if (validateLine(numbers, &allocator) catch |err| {
            std.debug.print("Error: {}\n", .{err});
            return;
        }) {
            safe += 1;
        }
    }
    std.debug.print("{}\n", .{safe});
}

fn validateLine(numbers: []const i32, allocator: *std.mem.Allocator) !bool {
    // all increasing
    for (0..numbers.len - 1) |i| {
        if (numbers[i + 1] > numbers[i] and numbers[i + 1] <= numbers[i] + 3) {
            if (i == numbers.len - 2) {
                return true;
            }
        } else {
            break;
        }
    }
    // all decreasing
    for (0..numbers.len - 1) |i| {
        if (numbers[i + 1] < numbers[i] and numbers[i + 1] >= numbers[i] - 3) {
            if (i == numbers.len - 2) {
                return true;
            }
        } else {
            break;
        }
    }

    //Trying with elements removed
    const new_len = numbers.len - 1;
    var new_slice = try allocator.alloc(i32, new_len);
    defer allocator.free(new_slice);

    for (0..numbers.len) |ignore| {
        if (ignore > 0) {
            std.mem.copyForwards(i32, new_slice[0..ignore], numbers[0..ignore]);
        }
        if (ignore < new_len - 1) {
            std.mem.copyForwards(i32, new_slice[ignore..], numbers[ignore + 1 ..]);
        }
        for (0..new_slice.len - 1) |i| {
            if (new_slice[i + 1] > new_slice[i] and new_slice[i + 1] <= new_slice[i] + 3) {
                if (i == new_slice.len - 2) {
                    return true;
                }
            } else {
                break;
            }
        }
        for (0..new_slice.len - 1) |i| {
            if (new_slice[i + 1] < new_slice[i] and new_slice[i + 1] >= new_slice[i] - 3) {
                if (i == new_slice.len - 2) {
                    return true;
                }
            } else {
                break;
            }
        }
    }
    return false;
}
