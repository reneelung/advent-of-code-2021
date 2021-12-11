#!/usr/bin/env bash

mkdir "$1"
cd $1
touch input.txt testInput.txt puzzle1.rb puzzle2.rb

cat > puzzle1.rb <<'_EOF'
#!/usr/bin/env ruby
require('pry')
INPUT_FILE = 'testInput.txt'
_EOF

cat > puzzle2.rb <<'_EOF'
#!/usr/bin/env ruby
require('pry')
INPUT_FILE = 'testInput.txt'
_EOF

chmod +ux puzzle*