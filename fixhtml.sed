# because the output of pod2html is a bit broken
/INDEX BEGIN/,/INDEX END/d
s/href="#\([^"]*\)"/href="\1.html"/g
/rev="made"/d
