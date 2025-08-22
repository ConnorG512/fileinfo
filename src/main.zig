const std = @import("std");
const CommandParser = @import("command-parser.zig").CommandParser;
const ActivatedFlags = @import("command-parser.zig").ActivatedFlags;
const StdOutWriter = @import("stdout-writer.zig").StdOutWriter;

pub fn main() !void {

    CommandParser.calculateArgumentNum() catch |err| {
        switch (err) {
            error.ReachedMaxArgCount => {
                return err;
            },
            error.TooLittleArgumentsProvided => {
                return err;
            },
            error.UnknownFlag => {
                return err;
            }
        }
    };

    var activated_flags: ActivatedFlags = .{};
    CommandParser.parseCommandFlags(&activated_flags) catch {
        try StdOutWriter.writeMessage("Unknown flag! Please see --flags");
    };
}
