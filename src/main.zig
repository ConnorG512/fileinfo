const CommandParser = @import("command-parser.zig").CommandParser;

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

    CommandParser.parseCommandFlags();
}
