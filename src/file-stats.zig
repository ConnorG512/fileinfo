const std = @import("std");
const FileMath = @import("file-size-math.zig").FileMath;
const FileSizes = @import("file-size-math.zig").FileSizes;

const FileError = error {
    FailedToStat,
};

const file_path_index = 1;

pub const FileStats = struct {

    pub fn startFileSize() !void {
        var file_size_struct: FileSizes = .{};

        try getFileStats(&file_size_struct);
        FileMath.calculateFileSize(&file_size_struct);
        try printFileSizeStats(&file_size_struct);
    } 
    fn getFileStats(file_sizes: *FileSizes) !void {
        const file_path: [*:0]const u8 = std.os.argv[file_path_index];
        var file_stat: std.os.linux.Stat = undefined;

        const result: usize = std.os.linux.stat(file_path, &file_stat);
        if (result != 0) {
            return error.FailedToStat;
        }

        file_sizes.*.bytes = @floatFromInt(file_stat.size);
    }
    fn printFileSizeStats(file_sizes: *FileSizes) !void {
        var stdout_buffer: [512]u8 = undefined;
        var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
        const stdout = &stdout_writer.interface;
        
        try stdout.print("File Size\n", .{});
        try stdout.print("\t{d}(Bytes)\n", .{file_sizes.*.bytes});
        try stdout.print("\t{d:.2}(KiB)\n", .{file_sizes.*.kib});
        try stdout.print("\t{d:.2}(MiB)\n", .{file_sizes.*.mib});
        try stdout.flush();
    }
};
