#!/bin/bash

usage() {
    exec >&2
    test "$*" && echo -e "$*\n"
    echo "usage: $0 [--debug] [--pages n[,...]] <html-file-name>"
    exit 1
}

keep=
file=
pages=
while test $# -gt 0
do
    case $1 in
        -p|--pages)
            for page in ${2//,/ }
            do
                case $page in
                    *-*) pages+=$(seq ${page%-*} ${page#*-} | tr '\n' ',');;
                    *) pages+="$page,";;
                esac
            done
            shift;;
        -x|--debug) set -x;;
        -k|--keep) keep=1;;
        -h|--help) usage;;
        -*) usage "unknown option '$1'";;
        *) test $file && usage || file=$1;;
    esac
    shift
done

name=${file%.html}
html=$(mktemp pdfsXXXX.html)
css=$(mktemp pdfsXXXX.css)
dir=$(mktemp -d pdfsXXXX)
test $keep || trap "rm -rf $dir $html $css; mv ui/default/s5-core.css0 ui/default/s5-core.css" EXIT
mv ui/default/s5-core.css ui/default/s5-core.css0
cat <<EOF > $css
.slide { height: 720px !important; }
#slide0 { font-size: 100% !important; }
EOF

header=$(sed -n '/"text\/javascript"/d;
                 /"ui\/default\/outline.css"/,/"operaFix"/d;
                 s/media="projection"//;
                 1,/"presentation"/p' $file)

i=0
for id in $(grep '"slide"' $file | cut -d'"' -f4)
do
    if test -z "$pages" || echo ,$pages | grep -q ,$i,
    then
        {
            echo "$header"
            sed -n '/"'$id'"/,/"slide"/p' $file | sed '$d'
            echo -e "</div>\n</body>\n</html>"
        } > $html
        wkhtmltopdf \
            --enable-local-file-access \
            --user-style-sheet $css \
            --dpi 120 \
            --margin-bottom 0 \
            --margin-top 0 \
            --margin-left 0 \
            --margin-right 0 \
            --page-width 1529 \
            --page-height 861px \
            $html $(printf $dir/slide%03d.pdf $i) 2>&1 | grep -Fv '(ignore)'
    fi
    let i=i+1
done

pdfunite $dir/slide???.pdf $name.pdf
