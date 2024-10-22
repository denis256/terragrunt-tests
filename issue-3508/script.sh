#!/bin/bash

#!/bin/bash

git_info=$(git log -1 --pretty=format:'{"branch":"%d","commit":"%H","author":"%an"}')
echo $git_info