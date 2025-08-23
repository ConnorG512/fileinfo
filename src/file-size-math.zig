pub const FileSizes = struct {
    bytes: f64 = 0,
    kib: f64 = 0,
    mib: f64 = 0,
};

pub const FileMath = struct {
    pub fn calculateFileSize(file_sizes: *FileSizes) void {
        const division_value = comptime 1024;

        file_sizes.*.kib = file_sizes.*.bytes / division_value;
        file_sizes.*.mib = file_sizes.*.bytes / ( division_value * division_value );
    }
};
