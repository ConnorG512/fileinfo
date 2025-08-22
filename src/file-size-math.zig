pub const FileMath = struct {
    
    bytes: u64 = undefined,
    kib: u64 = undefined,
    mib: u64 = undefined,

    pub fn calculateFileSize(self: *FileMath) void {
        const division_value = comptime 1024;

        self.kib = self.bytes / division_value;
        self.mib = self.bytes / (division_value * division_value);
    }
};
