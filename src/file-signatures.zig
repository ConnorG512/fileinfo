pub const FileSignature = struct {
    signature: []const u8 = undefined,
    name: []const u8 = "Unknown",
};

fn createFileSignature(
    comptime signature: []const u8, 
    comptime name: []const u8, ) FileSignature {

   return .{
       .signature = signature,
       .name = name,
   };
}

pub const file_signatures_array = [_]FileSignature {

    createFileSignature(
        &[_]u8{ 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF }, 
        "Unknown file format."), 
    
    createFileSignature(
        &[_]u8{ 0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A }, 
        "PNG (Portable Network Graphics)"),

    createFileSignature(
        &[_]u8{ 0x00, 0x00, 0x00, 0x0C, 0x6A, 0x50, 0x20, 0x20, 0x0D, 0x0A, 0x87, 0x0A }, 
        "JPEG 2000"),

    createFileSignature(
        &[_]u8{ 0x00, 0x00, 0x01, 0x00 }, 
        "Icon file (ico)"), 

    createFileSignature(
        &[_]u8{ 0x69, 0x63, 0x6e, 0x73 }, 
        "Apple Icon (icns)"), 

    createFileSignature(
        &[_]u8{ 0xFF, 0xD8, 0xFF }, 
        "JPEG image file. (jpg/jpeg)"), 

    createFileSignature(
        &[_]u8{ 0x00, 0x00, 0x00, 0x0C, 0x4A, 0x58, 0x4C, 0x20, 0x0D, 0x0A, 0x87, 0x0A }, 
        "JPEG XL image file. (jxl)"), 

    createFileSignature(
        &[_]u8{ 0x66, 0x74, 0x79, 0x70, 0x69, 0x73, 0x6F, 0x6D }, 
        "ISO Base Media File (MPEG-4)"),

    createFileSignature(
        &[_]u8{ 0x4F ,0x67 ,0x67 ,0x53 }, 
        "OGG container format (ogg/oga/ogv)"), 

    createFileSignature(
        &[_]u8{ 0x66, 0x4C, 0x61, 0x43 }, 
        "FLAC Audio (flac)"),

    createFileSignature(
        &[_]u8{ 0x25, 0x50, 0x44, 0x46, 0x2D }, 
        "PDF Document (pdf)"), 

    createFileSignature(
        &[_]u8{ 0x75, 0x73, 0x74, 0x61, 0x72, 0x00, 0x30, 0x30 }, 
        "Tar archive file (tar)"), 

    createFileSignature(
        &[_]u8{ 0x75, 0x73, 0x74, 0x61, 0x72, 0x20, 0x20, 0x00 }, 
        "Tar archive file (tar)"), 

    createFileSignature(
        &[_]u8{ 0x7F, 0x45, 0x4C, 0x46 }, 
        "ELF Executable"),

    createFileSignature(
        &[_]u8{ 0x4F, 0x41, 0x52 }, 
        "OAR file."),

    createFileSignature(
        &[_]u8{ 0x4D, 0x4C, 0x56, 0x49 }, 
        "Magic Lantern Video (MLVI)"), 
    
    createFileSignature(
        &[_]u8{ 0x37, 0x7A, 0xBC, 0xAF, 0x27, 0x1C }, 
        "7-Zip Archive File (7z)"), 
    
    createFileSignature(
        &[_]u8{ 0x54, 0x41, 0x50, 0x45 }, 
        "Microsoft Tape Format" ),

    createFileSignature(
        &[_]u8{ 0x7B, 0x5C, 0x72, 0x74, 0x66, 0x31 }, 
        "Rich Text format (rtf)"), 
    
    createFileSignature(
        &[_]u8{ 0x1B, 0x4C, 0x75, 0x61 }, 
        "Lua Bytecode (lua)"), 
    
    createFileSignature(
        &[_]u8{ 0x21, 0x3C, 0x61, 0x72, 0x63, 0x68, 0x3E, 0x0A }, 
        "Linux Deb file (deb)"), 
    
    createFileSignature(
        &[_]u8{ 0x34, 0x12, 0xAA, 0x55 }, 
        "Source Engine data file (vpk)"), 
    
    createFileSignature(
        &[_]u8{ 0xD7, 0xCD, 0xC6, 0x9A }, 
        "Windows metafile (wmf)"), 
    
    createFileSignature(
        &[_]u8{ 0x42, 0x4C, 0x45, 0x4E, 0x44, 0x45, 0x52 }, 
        "Blender file (blend)"), 
    
    createFileSignature(
        &[_]u8{ 0x46, 0x4C, 0x56 }, 
        "Flash Video file (flv)"), 
    
    createFileSignature(
        &[_]u8{ 0x00, 0x01, 0x00, 0x00, 0x00 }, 
        "TrueType Font (ttf/tte/dfont)"), 
    
    createFileSignature(
        &[_]u8{ 0x47, 0x52, 0x49, 0x42 }, 
        "Gridded data (grib/grib2)"), 
    
    createFileSignature(
        &[_]u8{ 0x72, 0x65, 0x67, 0x66 }, 
        "Windows Registry (dat/hiv)"), 
    
    createFileSignature(
        &[_]u8{ 0x4D, 0x5A }, 
        "Windows / DOS executable file"), 
    
    createFileSignature(
        &[_]u8{ 0x42, 0x4D }, 
        "Bitmap Image (bmp)"), 
    
    createFileSignature(
        &[_]u8{ 0x00, 0x00, 0x00, 0x00, 0x14, 0x00, 0x00, 0x00 }, 
        "Windows Disk Image (tbi)"), 

    createFileSignature(
        &[_]u8{ 0x00, 0x00, 0x00, 0x20, 0x66, 0x74, 0x79, 0x70, 0x4D, 0x34, 0x41 }, 
        "Apple Audio / Video file (m4a)"), 
    
    createFileSignature(
        &[_]u8{ 0x00, 0x11 }, 
        "FLIC Animation (fli)"),
    
    createFileSignature(
        &[_]u8{ 0x23, 0x20, 0x4D, 0x69, 0x63, 0x72, 0x6F, 0x73 }, 
        "Microsoft Developer Studio file (dsp)"), 
    
    createFileSignature(
        &[_]u8{ 0x25, 0x62, 0x69, 0x74, 0x6D, 0x61, 0x70 }, 
        "Fuzzy Bitmap file (fbm)"),
};
