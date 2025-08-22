const std = @import("std");

const ParserError = error {
    ReachedMaxArgCount,
    TooLittleArgumentsProvided,
    UnknownFlag,
};

pub const AvailableFlags = struct {
    help: []const u8 = "--help",
    help_short: []const u8 = "-h",
    version: []const u8 = "--version",
};

pub const ActivatedFlags = packed struct {
    help: u1 = 0,
    version: u1 = 0,
    open: u1 = 0,
};

pub const CommandParser = struct {
    pub fn calculateArgumentNum() ParserError!void {
        const argument_count: u8 = @intCast(std.os.argv.len);
        std.log.debug("(calculateArgumentNum) Command number: {d}", .{argument_count});

        const max_argument_count: u16 = comptime 65500;
        if (argument_count > max_argument_count) {
            return error.ReachedMaxArgCount;
        }
        
        const minimum_argument_count = comptime 1;
        if (argument_count <= minimum_argument_count) {
            return error.TooLittleArgumentsProvided;
        }
    }

    pub fn parseCommandFlags(active_flags: *ActivatedFlags) void {

        if (parseHelperFlag(active_flags)) { return; }
        active_flags.*.open = 1;
    }

    fn parseHelperFlag(active_flags: *ActivatedFlags) bool {
        const flag_list: AvailableFlags = .{};

        // argument 0 is always the exec path, so ignore it and start from index 1..
        const first_argument: [*:0]const u8 = std.os.argv[1];

        if (std.mem.eql(u8, std.mem.sliceTo(first_argument, 0), flag_list.version)) {
            active_flags.*.version = 1;
            std.log.debug("(parseCommandFlags) {s} hit!", .{flag_list.version});
            return true;
        }
        if (std.mem.eql(u8, std.mem.sliceTo(first_argument, 0), flag_list.help_short)) {
            active_flags.*.help = 1;
            std.log.debug("(parseCommandFlags) {s} hit!", .{flag_list.help_short});
            return true;
        }
        if (std.mem.eql(u8, std.mem.sliceTo(first_argument, 0), flag_list.help)) {
            active_flags.*.help = 1;
            std.log.debug("(parseCommandFlags) {s} hit!", .{flag_list.help});
            return true;
        }
        return false;
    }
};
