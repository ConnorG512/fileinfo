const std = @import("std");

pub const StdOutWriter = struct {
    pub fn writeMessage(message: []const u8) !void {
        const std_out_writer = std.io.getStdOut().writer();

        try std_out_writer.print("{s}\n", .{message});
    }
};
