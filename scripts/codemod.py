#!/usr/bin/env python

"""Run multiple codemods on JavaScript files."""

__author__ = "Jakub Liput"
__copyright__ = "Copyright (C) 2025 ACK CYFRONET AGH"
__license__ = "This software is released under the MIT license cited in LICENSE.txt"

import argparse
from subprocess import run
from typing import List
import sys
import os

DEFAULT_ONEZONE_TELEMETRY_URL = (
    "https://dev-onezone.default.svc.cluster.local/ozw/onezone/i"
)

DEFAULT_TELEMETRY_URL = "http://localhost:4200"

SCRIPT_PATH = os.path.dirname(os.path.abspath(__file__))


class Codemod:
    def __init__(self, parsed_args: argparse.Namespace):
        self.files: List[str] = parsed_args.files
        self.converter_names: List[str] = parsed_args.converters[0].split(",")
        self.preserve_log = parsed_args.preserve_log
        self.functions = {
            # ember-native-class-codemod which converts EmberObject-based classes to
            # native counterparts
            "native_class": cmd_native_class,
            # ember-angle-brackets-codemod which converts templates (and inline code in JS
            # files) to use <AngleBracket> component invocation
            "angle_brackets": cmd_angle_brackets,
            # script that formats too long lines in templates with <AngleBracket>
            # components to have line breaks
            "format_hbs": cmd_format_hbs,
        }

    def cmd_generators(self):
        return [
            lambda name=converter_name: self.functions[name](files=self.files)
            for converter_name in self.converter_names
        ]


def main():
    codemod: Codemod = parse_cli_args(sys.argv[1:])
    cmd_generators = codemod.cmd_generators()
    for cmd_generator in cmd_generators:
        cmd = cmd_generator()
        print("---")
        print(f"RUN: {' '.join(cmd)}")
        print("---")
        run(cmd, check=True)
    log_path = "./codemods.log"
    if not codemod.preserve_log and os.path.exists(log_path):
        os.remove(log_path)


def parse_cli_args(argv):
    parser = argparse.ArgumentParser(
        prog="codemod.py",
        description="""Runs selected codemods on specified files. Typically you should
                       launch `ember s` of application to use codemods. Example usage from
                       onezone-gui root directory in ZSH shell:
                       ./onedata-gui-utils/scripts/codemod.py
                       --converters=angle_brackets,format_hbs src/app/**/*.hbs
                    """,
    )
    parser.add_argument("files", nargs="+", help="File path(s).")
    parser.add_argument(
        "--converters",
        nargs=1,
        help="""List of converters separated with comma, that will be invoked in given
                order. Possible values: native_class, angle_brackets, format_hbs.""",
    )
    parser.add_argument(
        "--preserve-log",
        action="store_true",
        help="""If specified, the codemods.log that is created by codemod scripts will
                not be deleted after successful execution.""",
    )
    return Codemod(parser.parse_args(argv))


def cmd_native_class(files: List[str], telemetry_url=DEFAULT_TELEMETRY_URL):
    return [
        "npx",
        "ember-native-class-codemod",
        telemetry_url,
    ] + files


def cmd_angle_brackets(files: List[str], telemetry_url=DEFAULT_TELEMETRY_URL):
    return [
        "npx",
        "ember-angle-brackets-codemod",
        f"--telemetry={telemetry_url}",
    ] + files


def cmd_format_hbs(files: List[str]):
    return [
        "node",
        f"{SCRIPT_PATH}/format-hbs.js",
    ] + files


main()
