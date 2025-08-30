const std = @import("std");

const CommandParser = @import("command-parser.zig").CommandParser;
const FlagState = @import("command-parser.zig").FlagState;
const AvailableFlags = @import("command-parser.zig").AvailableFlags;

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

    // Execute commands.
    const available_flags: AvailableFlags = .{};
    switch (CommandParser.parseHelperFlag(&available_flags)) {
        .Open => {
            const file_paths_start = comptime 1;
            for (std.os.argv[file_paths_start..]) |current_file| {

                try FileReader.scanAndPrintFileSigPath(current_file);
                try FileStats.startFileSize(current_file);
            }
        },
        .Help => {
            try available_flags.printHelpFlag();
        },
        .Version => {
            try AvailableFlags.printVersionFlag();
        },
    }
}
