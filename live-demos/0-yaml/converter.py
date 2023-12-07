#!/usr/bin/env python

import json
import yaml
import sys

with open(sys.argv[1]) as f:
    print(json.dumps(yaml.load(f, Loader=yaml.SafeLoader), indent=2))
