// Vent: Is there a way of declaring a type alias so that other aliases with the same base type cannot be coerced into it.
// [A non-exhaustive enum means that any value in the range of the type is considered a valid value for the purposes of @intToEnum/@enumToInt.]
// const Dog = enum(u32) { _ };
// old C hack:
// const Dog = struct { data: u32 };
// fengb: I prefer enum approach for ids (e.g. distinct stuff that don't math), and the struct wrapper for mathing types
// Tetralux: You can also make use of usingnamespace and generics to make a type with all the same member functions as the base type.

const std = @import("std");
const print = std.debug.print;

const Dog = enum(u32) { _ };
const Cat = enum(u32) { _ };

fn petDog(dog: Dog) void {
    print("petted dog {}\n", .{@enumToInt(dog)});
}

fn petCat(cat: Cat) void {
    print("petted cat {}\n", .{@enumToInt(cat)});
}

pub fn main() anyerror!void {
    const d = @intToEnum(Dog, 5);
    const c = @intToEnum(Cat, 10);

    petDog(d);
    petCat(c);

    // Compile error!
    // petCat(d);
}
