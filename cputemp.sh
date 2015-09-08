#!/bin/bash
echo "<txt>$(sensors | grep "Physical id 0" | sed 's/\ \ */ /g' | cut -f4 -d" ")</txt>"
