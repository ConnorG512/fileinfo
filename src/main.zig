const std = @import("std");

const CommandParser = @import("command-parser.zig").CommandParser;
const ActivatedFlags = @import("command-parser.zig").ActivatedFlags;
const FlagList = @import("command-parser.zig").AvailableFlags;
const FileStats = @import("file-stats.zig").FileStats;
const FileMath = @import("file-size-math.zig").FileMath;
const FileReader = @import("file-reader.zig").FileReader;

pub fn main() !void {

    var stdout_buffer: [1024]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
    const stdout = &stdout_writer.interface;

    CommandParser.calculateArgumentNum() catch |err| {
        switch (err) {
            error.ReachedMaxArgCount => {
                try stdout.print("Too many flags provided!\n", .{});
                try stdout.flush();
                return err;
            },
            error.TooLittleArgumentsProvided => {
                try stdout.print("Not Enough flags provided! See \"--flags\" for options.\n", .{});
                try stdout.flush();
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

        try stdout.print("Available commands\n", .{});
        try stdout.print("\t{s} {s}\n", .{flag_list.help_short, flag_list.help});
        try stdout.print("\t{s}\n", .{flag_list.version});

        try stdout.flush();
    }
    if (activated_flags.open == 1) {
        const file_paths_start = comptime 1;
        for (std.os.argv[file_paths_start..]) |current_file| {

            try FileReader.scanForFileSignature(current_file);
            try FileStats.startFileSize(current_file);
        }
    }
}
