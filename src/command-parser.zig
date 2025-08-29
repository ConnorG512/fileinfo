const std = @import("std");

const ParserError = error {
    ReachedMaxArgCount,
    TooLittleArgumentsProvided,
    UnknownFlag,
};

pub const FlagState = enum {
    Help,
    Version,
    Open,
};

pub const AvailableFlags = struct {
    help: []const u8 = "--help",
    help_short: []const u8 = "-h",
    version: []const u8 = "--version",

    pub fn printHelpFlag(self: *const AvailableFlags) !void {
        var stdout_buffer: [64]u8 = undefined;
        var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
        const stdout = &stdout_writer.interface;
        
        try stdout.print("Available commands\n", .{});
        try stdout.print("\t{s} {s}\n", .{self.help_short, self.help});
        try stdout.print("\t{s}\n", .{self.version});
        try stdout.flush();
    }

    pub fn printVersionFlag() !void {
        var stdout_buffer: [64]u8 = undefined;
        var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
        const stdout = &stdout_writer.interface;
        
        try stdout.print("Version: 0.0.1\n", .{});
        try stdout.flush();
    }
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

    pub fn parseHelperFlag(command_flags: *const AvailableFlags) FlagState {

        // argument 0 is always the exec path, so ignore it and start from index 1..
        const first_argument: [*:0]const u8 = std.os.argv[1];

        if (std.mem.eql(u8, std.mem.sliceTo(first_argument, 0), command_flags.*.version)) {
            return .Version;
        }
        if (std.mem.eql(u8, std.mem.sliceTo(first_argument, 0), command_flags.*.help_short)) {
            return .Help;
        }
        if (std.mem.eql(u8, std.mem.sliceTo(first_argument, 0), command_flags.*.help)) {
            return .Help;
        }

        // Returns Open if none of the flags are matched.
        return .Open;
    }
};
