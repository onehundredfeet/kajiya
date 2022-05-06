#include "ircache_constants.hlsl"

[[vk::binding(0)]] ByteAddressBuffer ircache_meta_buf;
[[vk::binding(1)]] RWByteAddressBuffer dispatch_args;

[numthreads(1, 1, 1)]
void main() {
    const uint entry_count = ircache_meta_buf.Load(IRCACHE_META_ENTRY_COUNT);

    // Main ray tracing
    dispatch_args.Store4(16 * 0, uint4(entry_count, 1, 1, 0));

    // Accessibility tracing
    dispatch_args.Store4(16 * 1, uint4(entry_count * IRCACHE_OCTA_DIMS2, 1, 1, 0));

    // Sum up irradiance
    dispatch_args.Store4(16 * 2, uint4((entry_count + 63) / 64, 1, 1, 0));
}
