pub const FileSignature = struct {
    signature: []const u8 = undefined,
    name: []const u8 = "Unknown",
    file_type: FileSignatureList = FileSignatureList.Unknown,
};

pub const FileSignatureList = enum {
    Unknown,
    PNG,
    JPEG2000,
    MPEG4ISO,
    Elf,
    Ico,
    Icns,
    Jpeg,
    JpegXl,
    Ogg,
    Pdf,
    Flac,
    Tar,
};

fn createFileSignature(
    comptime signature: []const u8, 
    comptime name: []const u8, 
    comptime file_type: FileSignatureList) FileSignature {

   const created_signature: FileSignature = .{
       .signature = signature,
       .name = name,
       .file_type = file_type,
   };

   return created_signature;
}

pub const file_signatures_array = [_]FileSignature { 
    png_file, 
    jpeg_2000, 
    mpeg4_iso, 
    elf, 
    ico,
    icns,
    jpeg,
    jpeg_xl,
    ogg,
    pdf,
    flac,
    tar0,
};

// Base:
pub const unknown_format: FileSignature = createFileSignature(
    &[_]u8{ 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF }, 
    "Unknown",
    .Unknown);

// Media format:
const png_file: FileSignature = createFileSignature(
    &[_]u8{ 0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A }, 
    "PNG (Portable Network Graphics)",
    .PNG);

const jpeg_2000: FileSignature = createFileSignature(
    &[_]u8{ 0x00, 0x00, 0x00, 0x0C, 0x6A, 0x50, 0x20, 0x20, 0x0D, 0x0A, 0x87, 0x0A }, 
    "JPEG 2000",
    .JPEG2000);

const ico: FileSignature = createFileSignature(
    &[_]u8{ 0x00, 0x00, 0x01, 0x00 }, 
    "Icon file (ico)", 
    .Ico);

const icns: FileSignature = createFileSignature(
    &[_]u8{ 0x69, 0x63, 0x6e, 0x73}, 
    "Apple Icon (icns)", 
    .Icns); 

const jpeg: FileSignature = createFileSignature(
    &[_]u8{ 0xFF, 0xD8, 0xFF }, 
    "JPEG image file. (jpg/jpeg)", 
    .Jpeg);

const jpeg_xl: FileSignature = createFileSignature(
    &[_]u8{ 0x00, 0x00, 0x00, 0x0C, 0x4A, 0x58, 0x4C, 0x20, 0x0D, 0x0A, 0x87, 0x0A }, 
    "JPEG XL image file. (jxl)", 
    .JpegXl);

const mpeg4_iso: FileSignature = createFileSignature(
    &[_]u8{ 0x66, 0x74, 0x79, 0x70, 0x69, 0x73, 0x6F, 0x6D }, 
    "ISO Base Media File (MPEG-4)",
    .MPEG4ISO);

const ogg: FileSignature = createFileSignature(
    &[_]u8{ 0x4F ,0x67 ,0x67 ,0x53 }, 
    "OGG container format (ogg/oga/ogv)", 
    .Ogg);

const flac: FileSignature = createFileSignature(
    &[_]u8{ 0x66, 0x4C, 0x61, 0x43 }, 
    "FLAC Audio (flac)",
    .Flac);

// Document:

const pdf: FileSignature = createFileSignature(
    &[_]u8{ 0x25, 0x50, 0x44, 0x46, 0x2D }, 
    "PDF Document (pdf)", 
    .Pdf);

// Archive:

const tar0: FileSignature = createFileSignature(
    &[_]u8{ 0x75, 0x73, 0x74, 0x61, 0x72, 0x00, 0x30, 0x30 }, 
    "Tar archive file (tar)", 
    .Tar);

const tar1: FileSignature = createFileSignature(
    &[_]u8{ 0x75, 0x73, 0x74, 0x61, 0x72, 0x20, 0x20, 0x00 }, 
    "Tar archive file (tar)", 
    .Tar);

// Executables:
const elf: FileSignature = createFileSignature(
    &[_]u8{ 0x7F, 0x45, 0x4C, 0x46 }, 
    "ELF Executable",
    .Elf);


