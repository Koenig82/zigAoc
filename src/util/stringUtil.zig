pub const std = @import("std");

pub fn splitToInts(
    input: []const u8,
    delimiter: u8,
    allocator: *std.mem.Allocator,
) ![]i32 {
    var result = std.ArrayList(i32).init(allocator.*);
    defer result.deinit();

    var start: usize = 0;
    var idx: usize = 0;
    while (idx < input.len) {
        const c = input[idx];
        if (c == delimiter) {
            if (start < idx) {
                const slice = std.mem.trim(u8, input[start..idx], " \n\r"); // Trim newlines and spaces
                if (slice.len > 0) {
                    const value = std.fmt.parseInt(i32, slice, 10) catch |err| {
                        std.debug.print("Failed to parseInt for slice: {s}, error: {}\n", .{ slice, err });
                        return error.InvalidInput;
                    };
                    try result.append(value);
                }
            }
            start = idx + 1;
        }
        idx += 1;
    }

    // Handle the last segment, trimming any trailing newline or spaces
    if (start < input.len) {
        const slice = std.mem.trim(u8, input[start..], " \n\r"); // Trim newlines and spaces
        if (slice.len > 0) {
            const value = std.fmt.parseInt(i32, slice, 10) catch |err| {
                std.debug.print("Failed to parseInt for slice: {s}, error: {}\n", .{ slice, err });
                return error.InvalidInput;
            };
            try result.append(value);
        }
    }

    return result.toOwnedSlice();
}
