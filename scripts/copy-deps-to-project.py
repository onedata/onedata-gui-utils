#!/usr/bin/env python
# coding=utf-8

from __future__ import print_function

"""Authors: Jakub Liput
Copyright (C) 2017-2022 ACK CYFRONET AGH
This software is released under the MIT license cited in 'LICENSE.txt'

The script copies npm devDependencies from the in-repo-addon into project
that uses it.
It should be done because of: https://github.com/ember-cli/ember-cli/issues/4164
"""

import json
import os
import collections
import re

SCRIPT_DIR = os.path.dirname(os.path.realpath(__file__))
ADDON_DIR = os.path.join(SCRIPT_DIR, '../../')

# dependenciesType - one of: 'devDependencies', 'dependencies'
def get_addon_dev_deps(dependenciesType):
    addon_package_path = os.path.join(ADDON_DIR, 'package.json')
    with open(addon_package_path) as addon_package_file:
        return json.load(addon_package_file)[dependenciesType]

def replace_npm_versions(dependenciesType = 'devDependencies'):
    project_package_path = os.path.join(ADDON_DIR, '../../package.json')
    with open(project_package_path, 'r+') as project_package_file:
        project_package = json.load(project_package_file, object_pairs_hook=collections.OrderedDict)
        project_deps = project_package[dependenciesType]
        addon_deps = get_addon_dev_deps(dependenciesType)
        for (pkg, ver) in addon_deps.items():
            if pkg in project_deps:
                if ver != project_deps[pkg]:
                    print('WARN: changing package version: %s %s -> %s' % (pkg, project_deps[pkg], ver))
                    project_deps[pkg] = ver
            else:
                print('INFO: adding package: %s %s' % (pkg, ver))
                project_deps[pkg] = ver

        project_deps = collections.OrderedDict(sorted(project_deps.items()))
        project_package[dependenciesType] = project_deps
        project_package_file.seek(0)
        new_package_json = json.dumps(project_package, indent=2)
        new_package_json = re.sub(r'\s+$', '', new_package_json)
        project_package_file.write(json.dumps(project_package, indent=2))
        project_package_file.write('\n')
        project_package_file.truncate()

replace_npm_versions('dependencies')
replace_npm_versions('devDependencies')
