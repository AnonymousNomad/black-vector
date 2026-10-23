"""Create BLACK VECTOR's original, tileable wet-forest-floor albedo texture."""

import math
import os
import struct
import zlib


SIZE = 512
OUT = os.path.abspath(os.path.join(os.path.dirname(__file__), "../../game/assets/environment/alaskan_forest_floor.png"))


def hash_grid(x, y):
    value = (x * 374761393 + y * 668265263 + 0x4F1BBCDC) & 0xFFFFFFFF
    value = ((value ^ (value >> 13)) * 1274126177) & 0xFFFFFFFF
    value ^= value >> 16
    return (value & 0xFFFFFFFF) / 0xFFFFFFFF


def smooth(value):
    return value * value * (3.0 - 2.0 * value)


def noise(u, v, grid):
    x = u * grid
    y = v * grid
    ix, iy = math.floor(x), math.floor(y)
    fx, fy = smooth(x - ix), smooth(y - iy)
    a = hash_grid(ix % grid, iy % grid)
    b = hash_grid((ix + 1) % grid, iy % grid)
    c = hash_grid(ix % grid, (iy + 1) % grid)
    d = hash_grid((ix + 1) % grid, (iy + 1) % grid)
    return (a * (1 - fx) + b * fx) * (1 - fy) + (c * (1 - fx) + d * fx) * fy


def lerp(a, b, amount):
    return a + (b - a) * amount


def clamp(value, low=0.0, high=1.0):
    return max(low, min(high, value))


def chunk(kind, payload):
    return struct.pack(">I", len(payload)) + kind + payload + struct.pack(">I", zlib.crc32(kind + payload) & 0xFFFFFFFF)


def main():
    rows = bytearray()
    for y in range(SIZE):
        v = y / SIZE
        rows.append(0)  # PNG filter: None
        for x in range(SIZE):
            u = x / SIZE
            broad = noise(u, v, 5) * 0.56 + noise(u, v, 11) * 0.29 + noise(u, v, 23) * 0.15
            grain = noise(u, v, 61) * 0.62 + noise(u, v, 127) * 0.38
            wet = noise(u, v, 7) * 0.65 + noise(u, v, 17) * 0.35
            moss = clamp((broad - 0.30) * 2.2 + (grain - 0.5) * 0.18)
            soil = (104.0, 84.0, 60.0)
            green = (76.0, 101.0, 68.0)
            stone = (111.0, 118.0, 108.0)
            values = [lerp(soil[i], green[i], moss) for i in range(3)]
            stone_amount = clamp((noise(u, v, 83) - 0.77) * 2.8)
            values = [lerp(values[i], stone[i], stone_amount) for i in range(3)]
            damp = clamp((wet - 0.46) * 1.7)
            brightness = 0.86 + grain * 0.24
            speckle = (grain - 0.5) * 16.0
            values = [clamp_byte((value * lerp(1.0, 0.66, damp) + speckle) * brightness) for value in values]
            # A few small ochre and pale-gray traces suggest needles, lichen and shell grit.
            fleck = noise(u, v, 211)
            if fleck > 0.94:
                tint = (136.0, 112.0, 72.0) if fleck < 0.977 else (147.0, 151.0, 137.0)
                mix = 0.32
                values = [round(lerp(values[i], tint[i], mix)) for i in range(3)]
            rows.extend(values)
    raw = bytes(rows)
    ihdr = struct.pack(">2I5B", SIZE, SIZE, 8, 2, 0, 0, 0)
    png = b"\x89PNG\r\n\x1a\n" + chunk(b"IHDR", ihdr) + chunk(b"IDAT", zlib.compress(raw, 9)) + chunk(b"IEND", b"")
    os.makedirs(os.path.dirname(OUT), exist_ok=True)
    with open(OUT, "wb") as stream:
        stream.write(png)
    print(f"Generated self-authored seamless forest-floor albedo: {OUT} ({len(png)} bytes)")


def clamp_byte(value):
    return int(round(clamp(value, 0.0, 255.0)))


if __name__ == "__main__":
    main()
