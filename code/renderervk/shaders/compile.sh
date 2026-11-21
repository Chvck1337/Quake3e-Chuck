#!/bin/bash
set -e

bh="./bin2hex"
cl="glslangValidator"
tmpf="spirv/data.spv"
outf="+spirv/shader_data.c"

mkdir -p spirv
rm -f spirv/shader_data.c "$tmpf"

# 1. Compilar shaders individuales
for f in *.vert; do
    [ -e "$f" ] || continue
    name="${f%.vert}"
    "$cl" -S vert -V -o "$tmpf" "$f"
    "$bh" "$tmpf" "$outf" "${name}_vert_spv"
    rm -f "$tmpf"
done

for f in *.frag; do
    [ -e "$f" ] || continue
    name="${f%.frag}"
    "$cl" -S frag -V -o "$tmpf" "$f"
    "$bh" "$tmpf" "$outf" "${name}_frag_spv"
    rm -f "$tmpf"
done

# 2. Compilar plantillas ignorando comentarios (@rem) y bucles de Windows (%%f)
grep -E '^"(%cl%|%bh%)"' compile.bat | grep -v '%%' | \
sed -e 's|"%cl%"|'"$cl"'|g' \
    -e 's|"%bh%"|'"$bh"'|g' \
    -e 's|"%tmpf%"|'"$tmpf"'|g' \
    -e 's|%outf%|'"$outf"'|g' \
    -e 's/\r//g' | bash -e

rm -f "$tmpf"
echo "Shaders SPIR-V compilados 100% limpios."
