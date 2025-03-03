/**
 * Fixes multiline angle bracket component formatting after using
 * ember-angle-brackets-codemod
 *
 * For example, the codemod outputs this:
 *
 * ```hbs
 * <PerfectScrollbarElement @class="membership-scrollbar-element" @suppressScrollY={{true}} @onScroll={{action "scroll"}}>
 * ```
 *
 * which exceedes line length. Accorging to our formatting guidelines, this script
 * converts lines exceeding maximum length to:
 *
 * ```hbs
 * <PerfectScrollbarElement
 *   class="membership-scrollbar-element"
 *   @suppressScrollY={{true}}
 *   @onScroll={{action "scroll"}}
 * >
 * ```
 *
 * It also changes `@class=` to `class=`.
 *
 * Note, that this script is not perfect and you should review manually every file after
 * refactor to fix unexpected formatting problems.
 *
 * @author Jakub Liput
 * @copyright (C) 2025 ACK CYFRONET AGH
 * @license This software is released under the MIT license cited in 'LICENSE.txt'.
 */

/* eslint-env node */
'use strict';

const fs = require('fs');

class Formatter {
  static lineFormatRegexp = /^(\s*)(.*)<([A-Z][\w:]+|\w+\.\w+)(.*?)(\/?>)(.*)$/;
  static argsRegexp = /(@\w+={{.*?}}|\w+={{.*?}}|@\w+=".*?"|\w+=".*?"|as \|.*?\|)/g;

  /**
   * @param {string} path
   */
  constructor(path) {
    this.path = path;
  }

  shouldBeFormatted(line) {
    return line.length > 90 && Formatter.lineFormatRegexp.test(line);
  }
  /**
   * @param {string} componentArgsString
   * @returns {Array<string>}
   */
  destructureArgs(componentArgsString) {
    const regexpIterator = componentArgsString.matchAll(Formatter.argsRegexp);
    return [...regexpIterator].map(([text]) => text);
  }
  destructureLine(line) {
    const match = line.match(Formatter.lineFormatRegexp);
    const indent = match[1];
    const before = match[2];
    const componentName = match[3];
    const componentArgsString = match[4];
    const componentArgs = this.destructureArgs(componentArgsString);
    const closingTag = match[5];
    const after = match[6];
    return {
      indent,
      before,
      componentName,
      componentArgs,
      closingTag,
      after,
    };
  }
  formatLine(line) {
    const {
      indent,
      before,
      componentName,
      componentArgs,
      closingTag,
      after,
    } = this.destructureLine(line);
    const argIndent = indent + '  ';
    let result = `${indent}${before}<${componentName}\n`;
    for (const componentArg of componentArgs) {
      const effComponentArg = componentArg.replace('@class=', 'class=');
      result += `${argIndent}${effComponentArg}\n`;
    }
    result += `${indent}${closingTag}${after}`;
    return result;
  }
  /**
   * @param {string} originalContent
   * @returns {string}
   */
  convertDocumentString(originalContent) {
    const originalLines = originalContent.split('\n');
    let resultContent = '';
    const lastLineNum = originalLines.length - 1;
    for (const [num, line] of originalLines.entries()) {
      resultContent += this.shouldBeFormatted(line) ? this.formatLine(line) : line;
      if (num !== lastLineNum) {
        resultContent += '\n';
      }
    }
    return resultContent;
  }
  convertDocument() {
    const originalContent = fs.readFileSync(this.path).toString();
    const newContent = this.convertDocumentString(originalContent);
    fs.writeFileSync(this.path, newContent);
  }
}

[
  // put file paths here (relative to working dir)
].forEach(path => {
  new Formatter(path).convertDocument();
});
