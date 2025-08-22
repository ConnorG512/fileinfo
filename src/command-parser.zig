const std = @import("std");

const ParserError = error {
    ReachedMaxArgCount,
    TooLittleArgumentsProvided,
};

pub const CommandParser = struct {
    pub fn calculateArgumentNum() ParserError!void {
        const argument_count: u8 = @intCast(std.os.argv.len);
        std.log.debug("(calculateArgumentNum) Command number: {d}", .{argument_count});

        const max_argument_count: u8 = comptime 12;
        if (argument_count > max_argument_count) {
            return error.ReachedMaxArgCount;
        }
        
        const minimum_argument_count = comptime 1;
        if (argument_count <= minimum_argument_count) {
            return error.TooLittleArgumentsProvided;
        }
    }

    pub fn parseCommandFlags() void {
        for (std.os.argv) |flag| {
            if (std.mem.eql(u8, std.mem.sliceTo(flag, 0), "--help")) {
                std.log.debug("Help Called!", .{});
            }
            if (std.mem.eql(u8, std.mem.sliceTo(flag, 0), "-h")) {
                std.log.debug("Help Called!", .{});
            }
            if (std.mem.eql(u8, std.mem.sliceTo(flag, 0), "--flags")) {
                std.log.debug("Flags Called!", .{});
            }
            if (std.mem.eql(u8, std.mem.sliceTo(flag, 0), "-f")) {
                std.log.debug("Flags Called!", .{});
            }
        }
    }
};
