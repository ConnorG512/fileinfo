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
    Oar,
    Mlvi,
    SevenZip,
    MicroTape,
    RichText,
    Lua,
    Deb,
    Vpk,
    Wmf,
    Blend,
    Flv,
    TrueType,
    Grib,
    WinReg,
};

fn createFileSignature(
    comptime signature: []const u8, 
    comptime name: []const u8, 
    comptime file_type: FileSignatureList) FileSignature {

   return .{
       .signature = signature,
       .name = name,
       .file_type = file_type,
   };
}

pub const file_signatures_array = [_]FileSignature {

    createFileSignature(
        &[_]u8{ 0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A }, 
        "PNG (Portable Network Graphics)",
        .PNG),

    createFileSignature(
        &[_]u8{ 0x00, 0x00, 0x00, 0x0C, 0x6A, 0x50, 0x20, 0x20, 0x0D, 0x0A, 0x87, 0x0A }, 
        "JPEG 2000",
        .JPEG2000),

    createFileSignature(
        &[_]u8{ 0x00, 0x00, 0x01, 0x00 }, 
        "Icon file (ico)", 
        .Ico),

    createFileSignature(
        &[_]u8{ 0x69, 0x63, 0x6e, 0x73 }, 
        "Apple Icon (icns)", 
        .Icns), 

    createFileSignature(
        &[_]u8{ 0xFF, 0xD8, 0xFF }, 
        "JPEG image file. (jpg/jpeg)", 
        .Jpeg),

    createFileSignature(
        &[_]u8{ 0x00, 0x00, 0x00, 0x0C, 0x4A, 0x58, 0x4C, 0x20, 0x0D, 0x0A, 0x87, 0x0A }, 
        "JPEG XL image file. (jxl)", 
        .JpegXl),

    createFileSignature(
        &[_]u8{ 0x66, 0x74, 0x79, 0x70, 0x69, 0x73, 0x6F, 0x6D }, 
        "ISO Base Media File (MPEG-4)",
        .MPEG4ISO),

    createFileSignature(
        &[_]u8{ 0x4F ,0x67 ,0x67 ,0x53 }, 
        "OGG container format (ogg/oga/ogv)", 
        .Ogg),

    createFileSignature(
        &[_]u8{ 0x66, 0x4C, 0x61, 0x43 }, 
        "FLAC Audio (flac)",
        .Flac),

    createFileSignature(
        &[_]u8{ 0x25, 0x50, 0x44, 0x46, 0x2D }, 
        "PDF Document (pdf)", 
        .Pdf),

    createFileSignature(
        &[_]u8{ 0x75, 0x73, 0x74, 0x61, 0x72, 0x00, 0x30, 0x30 }, 
        "Tar archive file (tar)", 
        .Tar),

    createFileSignature(
        &[_]u8{ 0x75, 0x73, 0x74, 0x61, 0x72, 0x20, 0x20, 0x00 }, 
        "Tar archive file (tar)", 
        .Tar),

    createFileSignature(
        &[_]u8{ 0x7F, 0x45, 0x4C, 0x46 }, 
        "ELF Executable",
        .Elf), 

    createFileSignature(
        &[_]u8{ 0x4F, 0x41, 0x52 }, 
        "OAR file.",
        .Oar), 

    createFileSignature(
        &[_]u8{ 0x4D, 0x4C, 0x56, 0x49 }, 
        "Magic Lantern Video (MLVI)", 
        .Mlvi),
    
    createFileSignature(
        &[_]u8{ 0x37, 0x7A, 0xBC, 0xAF, 0x27, 0x1C }, 
        "7-Zip Archive File (7z)", 
        .SevenZip),
    
    createFileSignature(
        &[_]u8{ 0x54, 0x41, 0x50, 0x45 }, 
        "Microsoft Tape Format", 
        .MicroTape),

    createFileSignature(
        &[_]u8{ 0x7B, 0x5C, 0x72, 0x74, 0x66, 0x31 }, 
        "Rich Text format (rtf)", 
        .RichText),
    
    createFileSignature(
        &[_]u8{ 0x1B, 0x4C, 0x75, 0x61 }, 
        "Lua Bytecode (lua)", 
        .Lua),
    
    createFileSignature(
        &[_]u8{ 0x21, 0x3C, 0x61, 0x72, 0x63, 0x68, 0x3E, 0x0A }, 
        "Linux Deb file (deb)", 
        .Deb),
    
    createFileSignature(
        &[_]u8{ 0x34, 0x12, 0xAA, 0x55 }, 
        "Source Engine data file (vpk)", 
        .Vpk),
    
    createFileSignature(
        &[_]u8{ 0xD7, 0xCD, 0xC6, 0x9A }, 
        "Windows metafile (wmf)", 
        .Wmf),
    
    createFileSignature(
        &[_]u8{ 0x42, 0x4C, 0x45, 0x4E, 0x44, 0x45, 0x52 }, 
        "Blender file (blend)", 
        .Blend),
    
    createFileSignature(
        &[_]u8{ 0x46, 0x4C, 0x56 }, 
        "Flash Video file (flv)", 
        .Flv),
    
    createFileSignature(
        &[_]u8{ 0x00, 0x01, 0x00, 0x00, 0x00 }, 
        "TrueType Font (ttf/tte/dfont)", 
        .TrueType),
    
    createFileSignature(
        &[_]u8{ 0x47, 0x52, 0x49, 0x42 }, 
        "Gridded data (grib/grib2)", 
        .Grib),
    
    createFileSignature(
        &[_]u8{ 0x72, 0x65, 0x67, 0x66 }, 
        "Windows Registry (dat/hiv)", 
        .WinReg),
};

// Base:
pub const unknown_format: FileSignature = createFileSignature(
    &[_]u8{ 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF }, 
    "Unknown",
    .Unknown);

