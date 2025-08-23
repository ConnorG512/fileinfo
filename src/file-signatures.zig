pub const FileSignature = struct {
    signature: []u8 = undefined,
    name: []u8 = "Unknown",
};

fn createFileSignature(comptime signature: []const u8, comptime name: []const u8) FileSignature {
   const created_signature: FileSignature = .{
       .signature = signature,
       .name = name,
   };

   return created_signature;
}

const png_file: FileSignature = createFileSignature(
    &[_]u8{ 0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A }, 
    "PNG (Portable Network Graphics)" );
