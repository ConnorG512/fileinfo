const std = @import("std");

const CommandParser = @import("command-parser.zig").CommandParser;
const ActivatedFlags = @import("command-parser.zig").ActivatedFlags;
const FlagList = @import("command-parser.zig").AvailableFlags;
const StdOutWriter = @import("stdout-writer.zig").StdOutWriter;
const FileOpen = @import("file-open.zig").FileOpen;

pub fn main() !void {

    CommandParser.calculateArgumentNum() catch |err| {
        switch (err) {
            error.ReachedMaxArgCount => {
                try StdOutWriter.writeMessage("Too many flags provided!");
                return err;
            },
            error.TooLittleArgumentsProvided => {
                try StdOutWriter.writeMessage("Not Enough flags provided! See \"--flags\" for options.");
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

        try StdOutWriter.writeMessage("Available commands:");
        try StdOutWriter.writeMessage(flag_list.help);
        try StdOutWriter.writeMessage(flag_list.help_short);
        try StdOutWriter.writeMessage(flag_list.version);
    }
    if (activated_flags.open == 1) {
        var file_stat: std.os.linux.Stat = undefined;
        try FileOpen.openFile(&file_stat);

        std.log.debug("File size: {d}", .{file_stat.size});
    }
}
