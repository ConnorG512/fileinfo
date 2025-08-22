const std = @import("std");

const CommandParser = @import("command-parser.zig").CommandParser;
const ActivatedFlags = @import("command-parser.zig").ActivatedFlags;
const FlagList = @import("command-parser.zig").AvailableFlags;
const FileStats = @import("file-stats.zig").FileStats;
const FileMath = @import("file-size-math.zig").FileMath;

pub fn main() !void {

    CommandParser.calculateArgumentNum() catch |err| {
        switch (err) {
            error.ReachedMaxArgCount => {
                try std.io.getStdOut().writer().print("Too many flags provided!", .{});
                return err;
            },
            error.TooLittleArgumentsProvided => {
                try std.io.getStdOut().writer().print(
                    "Not Enough flags provided! See \"--flags\" for options.", .{});
                return err;
            },
            else => {},
        }
    };

    var activated_flags: ActivatedFlags = .{};
    CommandParser.parseCommandFlags(&activated_flags);

    // Execute commands.
    if (activated_flags.help == 1) {
        const flag_list: FlagList = .{};

        try std.io.getStdOut().writer().print("Available commands:\n", .{});
        try std.io.getStdOut().writer().print("\t{s} {s}\n", .{flag_list.help_short, flag_list.help});
        try std.io.getStdOut().writer().print("\t{s}\n", .{flag_list.version});
    }
    if (activated_flags.open == 1) {
        var file_stat: std.os.linux.Stat = undefined;

        try FileStats.openFile(&file_stat);

        var file_size: FileMath = .{ .bytes = @intCast(file_stat.size) };
        file_size.calculateFileSize();

        try std.io.getStdOut().writer().print("File Properties:\n", .{});
        try std.io.getStdOut().writer().print("Size (Bytes): {d}\n", .{file_size.bytes});
        try std.io.getStdOut().writer().print("Size (KiB): {d}\n", .{file_size.kib});
        try std.io.getStdOut().writer().print("Size (MiB): {d}\n", .{file_size.mib});
    }
}
