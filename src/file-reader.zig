const std = @import("std");
const FileSignatures = @import("file-signatures.zig");

pub const FileReader = struct {

    pub fn scanAndPrintFileSigPath(current_file_path: [*:0]const u8) !void {
        const file_buffer_size: u8 = comptime 64;
        var file_buffer: [file_buffer_size]u8 = undefined; 

        const file_descriptor = openFile(current_file_path);
        
        try readFileSignatureBytes(&file_descriptor, &file_buffer);

        try printFilePath(current_file_path);

        const found_file_type = determineFileSignature(&file_buffer);
        try printFileType(found_file_type);
    }

    fn openFile(current_file_path: [*:0]const u8) usize {
        const file_descriptor: usize = std.os.linux.open(current_file_path[0..], .{ .ACCMODE = .RDONLY }, 0);
        return file_descriptor;
    }

    fn readFileSignatureBytes(file_descriptor: *const usize, read_buffer: []u8) !void {
        const num_bytes_read = std.os.linux.read(@intCast(file_descriptor.*), read_buffer.ptr, read_buffer.len);
        std.log.debug("{X} ", .{read_buffer[0..]});
        std.log.debug("Num bytes read: {d}.", .{num_bytes_read});
    }

    fn determineFileSignature(file_buffer: []const u8) FileSignatures.FileSignatureList {

        for (FileSignatures.file_signatures_array) |current_signature| {
            if (std.mem.eql(u8, file_buffer[0..current_signature.signature.len], current_signature.signature)) {
                std.log.debug("(determineFileSignature) {s} hit!", .{current_signature.name});
                return current_signature.file_type;
            }
        }

        return FileSignatures.FileSignatureList.Unknown;
    }

    fn printFileType(file_type_found: FileSignatures.FileSignatureList) !void {
        for (FileSignatures.file_signatures_array) |current_signature| {
            if (file_type_found == current_signature.file_type) {
                var stdout_buffer: [64]u8 = undefined;
                var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
                const stdout = &stdout_writer.interface;

                try stdout.print("File Type: {s}\n", .{current_signature.name});
                try stdout.flush();
            }
        }
    }

    fn printFilePath(current_file_path: [*:0]const u8) !void {
        var stdout_buffer: [256]u8 = undefined;
        var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
        const stdout = &stdout_writer.interface;

        try stdout.print("File: {s}\n", .{current_file_path});
        try stdout.flush();
    }
};
