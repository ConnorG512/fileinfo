const std = @import("std");

const FileError = error {
    FailedToStat,
};

pub const FileOpen = struct {
    pub fn openFile(file_stat: *std.os.linux.Stat) !void {
        const file_path: [*:0]const u8 = std.os.argv[1];

        const result: usize = std.os.linux.stat(file_path, file_stat);
        if (result != 0) {
            return error.FailedToStat;
        }
    }
};
