fn of_codon(codon: []const u8) error{InvalidCodon}![]const u8 {
    inline for (std.meta.fields(@TypeOf(codons_aminoacids))) |field| {
        if (std.mem.eql(u8, field.name, codon))
            return @field(codons_aminoacids, field.name);
    }

    return error.InvalidCodon;
}

fn of_rna(rna: []const u8) [6]error{InvalidCodon}![]const u8 {
    var aminoacids = [_]error{InvalidCodon}![]const u8{""} ** 6;
    //var aminoacids = [_][]const u8{""} ** 6;

    for ([_]u2{0} ** 6) |_, i| {
        var aminoacid = of_codon(rna[i * 3 .. 3 * i + 3]); //catch return error.InvalidRNA;

        if (aminoacid) |aminoacid_string| {
            if (!mem.eql(u8, aminoacid_string, "STOP")) aminoacids[i] = aminoacid_string else return aminoacids;
        } else |aminoacid_error| aminoacids[i] = aminoacid_error;
    }

    return aminoacids;
}

pub fn main() !void {
    print("{s}\n", .{try of_rna("UGGUGUUAUUAAUGGUUU")});
}
