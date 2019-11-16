#!/bin/bash

cd $(dirname $0)

cat <<EOF
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <title>Presentationer</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta  name="author" content="Jonas J Linde">
    <link rel="stylesheet" href="b3.css" type="text/css" />
    <style type="text/css">
      <!--
      td { padding-left: 30px; }
      a:hover { color: #ff4f94 !important; text-decoration: underline; }
      a:visited { color: #ff4f94 !important; }
      -->
    </style>
  </head>
  <body>
    <h1>Presentationer</h1>
    <div id="parc"></div><div id="pcut"></div>
    <div id="yarc"></div><div id="ycut"></div>
    <table>
EOF
for file in $(ls *rst | sort -t2 -k2r)
do
    title=$(grep -i '^ *[a-z]' $file | head -1 | sed 's/^ *//')
    date=$(echo $file | grep -o '2[0-9-]*')
    html=${file%.rst}.html
    pdf=${file%.rst}.pdf
    test -f $pdf && pdf=" <a href='$pdf'>PDF</a>" || pdf=
    echo "      <tr><td>$title</td><td>$date</td><td><a href='$html'>HTML</a></td><td>$pdf</td><td><a href='https://github.com/krakan/slides/blob/master/$file'>RST</a></td></tr>"
done
cat <<EOF
    </table>
  </body>
</html>
EOF

# #5c5c5c;
# #f7df04;
# #0ccccc;
# #ff4f94;
