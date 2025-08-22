const std = @import("std");

const ParserError = error {
    ReachedMaxArgCount,
    TooLittleArgumentsProvided,
};

pub const ActivatedFlags = struct {
    help: u1 = 0,
    flags: u1 = 0,
    version: u1 = 0,
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

    pub fn parseCommandFlags(active_flags: *ActivatedFlags) void {
        const flag_strings = [_][]const u8 {
            "--help",     // 0 
            "-h",         // 1
            "--flags",    // 2
            "-f",         // 3
            "--version",  // 4
        };

        for (std.os.argv) |flag| {
            if (std.mem.eql(u8, std.mem.sliceTo(flag, 0), flag_strings[0])) {
                std.log.debug("Called: {s}", .{flag_strings[0]});
                active_flags.*.help = 1;
            }
            if (std.mem.eql(u8, std.mem.sliceTo(flag, 0), flag_strings[1])) {
                std.log.debug("Called: {s}", .{flag_strings[1]});
                active_flags.*.help = 1;
            }
            if (std.mem.eql(u8, std.mem.sliceTo(flag, 0), flag_strings[2])) {
                std.log.debug("Called: {s}", .{flag_strings[2]});
                active_flags.*.flags = 1;
            }
            if (std.mem.eql(u8, std.mem.sliceTo(flag, 0), flag_strings[3])) {
                std.log.debug("Called: {s}", .{flag_strings[3]});
                active_flags.*.flags = 1;
            }
            if (std.mem.eql(u8, std.mem.sliceTo(flag, 0), flag_strings[4])) {
                std.log.debug("Called: {s}", .{flag_strings[4]});
                active_flags.*.version = 1;
            }
        }
    }
};
