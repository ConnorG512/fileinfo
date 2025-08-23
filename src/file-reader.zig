const std = @import("std");
const FileSignatures = @import("file-signatures.zig");

pub const FileReader = struct {

    pub fn scanForFileSignature() !void {
        var file_buffer: [32]u8 = undefined; 
        const file_descriptor = openFile();
        try readFileSignatureBytes(&file_descriptor, &file_buffer);
    }
    fn openFile() usize {
        const file_descriptor: usize = std.os.linux.open(std.os.argv[1], .{ .ACCMODE = .RDONLY }, 0);
        return file_descriptor;
    }
    fn readFileSignatureBytes(file_descriptor: *const usize, read_buffer: []u8) !void {
        const num_bytes_read = std.os.linux.read(@intCast(file_descriptor.*), read_buffer.ptr, read_buffer.len);
        std.log.debug("{X}", .{read_buffer[0..]});
        std.log.debug("Num bytes read: {d}.", .{num_bytes_read});
    }
    fn determineFileSignature() void {

    }
};
