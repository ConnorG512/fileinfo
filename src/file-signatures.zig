pub const FileSignature = struct {
    signature: []u8 = undefined,
    name: []u8 = "Unknown",
};

const FileSignatureList = enum {
    PNG,
    JPEG2000,
    MPEG4ISO,
};

fn createFileSignature(comptime signature: []const u8, comptime name: []const u8) FileSignature {
   const created_signature: FileSignature = .{
       .signature = signature,
       .name = name,
   };

   return created_signature;
}

// Base:
pub const unknown_format: FileSignature = createFileSignature(
    &[_]u8{ 0xAA, 0xAA, 0xAA, 0xAA, 0xAA }, 
    "Unknown");

// Image format:
pub const png_file: FileSignature = createFileSignature(
    &[_]u8{ 0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A }, 
    "PNG (Portable Network Graphics)" );

pub const jpeg_2000: FileSignature = createFileSignature(
    &[_]u8{ 0x00, 0x00, 0x00, 0x0C, 0x6A, 0x50, 0x20, 0x20, 0x0D, 0x0A, 0x87, 0x0A }, 
    "JPEG 2000");

// Video format:
pub const mpeg4_iso: FileSignature = createFileSignature(
    &[_]u8{ 0x66, 0x74, 0x79, 0x70, 0x69, 0x73, 0x6F, 0x6D }, 
    "ISO Base Media File (MPEG-4)");
