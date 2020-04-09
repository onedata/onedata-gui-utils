#!/usr/bin/env python
# Copy the line from GUI test error containing eg. vendor.js to open it and focus on
# the line that threw exception. Facilitates finding errors when code mapping fails.

import os, sys, re

url = sys.argv[1]

lines = re.match(r".*?(\d+(:\d+)?)$", url).group(1)
seg_count = len(lines.split(':'))
file_name = ":".join(url.split(":")[-seg_count-1:-seg_count]).split("/")[-1]
file_url = ":".join(url.split(":")[0:-seg_count])
local_file_path = '/tmp/' + file_name

os.system('wget --no-check-certificate ' + file_url + ' -O ' + local_file_path)
os.system('open vscode://file/' + local_file_path + ':' + lines)
