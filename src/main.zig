const CommandParser = @import("command-parser.zig").CommandParser;
const ActivatedFlags = @import("command-parser.zig").ActivatedFlags;

pub fn main() !void {

    CommandParser.calculateArgumentNum() catch |err| {
        switch (err) {
            error.ReachedMaxArgCount => {
                return err;
            },
            error.TooLittleArgumentsProvided => {
                return err;
            }
        }
    };

    var activated_flags: ActivatedFlags = .{};
    CommandParser.parseCommandFlags(&activated_flags);
}
