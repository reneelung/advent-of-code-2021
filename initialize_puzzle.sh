#!/usr/bin/env bash

mkdir "$1"
cd $1
touch input.txt testInput.txt puzzle1.rb puzzle2.rb

cat > puzzle1.rb <<'_EOF'
#!/usr/bin/env ruby\n\n
require('pry')
INPUT_FILE = 'testInput.txt'
_EOF

echo "#!/usr/bin/env ruby" >> puzzle2.rb

chmod +ux puzzle*