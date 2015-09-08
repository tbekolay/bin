import sys
import os

if len(sys.argv) <= 1:
    print "Please pass in a path."
    sys.exit()

PREP = "Gilmore Girls."
path = sys.argv[1]

for fp in os.listdir(path):
    if not fp.startswith(PREP):
        os.rename(path + "/" + fp, path + "/" + PREP + fp)
