/* eslint-env node */

module.exports = {
  root: true,
  parserOptions: {
    ecmaVersion: 2020,
  },
  plugins: [
    'ember',
    'jsdoc',
    'promise',
  ],
  extends: [
    'eslint:recommended',
    'plugin:ember/recommended',
  ],
  env: {
    browser: true,
    es6: true,
    jquery: true,
  },
  rules: {
    'no-console': 0,
    'dot-location': [
      1,
      'property',
    ],
    'eol-last': 0,
    'comma-dangle': [
      1,
      'always-multiline',
    ],
    'quotes': [
      1,
      'single',
      {
        avoidEscape: true,
      },
    ],
    'quote-props': [
      1,
      'consistent-as-needed',
    ],
    'no-warning-comments': [
      1,
      {
        terms: ['fixme'],
      },
    ],
    'semi': 2,
    'no-restricted-globals': [
      2,
      'name',
      'blur',
      'fetch',
      'find',
      'parent',
    ],
    'prefer-const': [
      1,
      {
        destructuring: 'all',
        ignoreReadBeforeAssign: true,
      },
    ],
    'no-var': 1,
    'one-var': [
      1,
      'never',
    ],
    'no-debugger': 2,
    'no-param-reassign': 1,
    'array-callback-return': 1,
    'max-len': [
      1,
      {
        code: 90,
        tabWidth: 2,
        ignoreStrings: false,
        ignoreComments: true,
        ignoreTrailingComments: false,
        ignoreUrls: true,
        ignoreTemplateLiterals: true,
        ignoreRegExpLiterals: true,
        ignorePattern: '^import|.*[\'"`]\\)?,?;?|\\s*it$',
      },
    ],
    'promise/always-return': 'off', // default: error
    'promise/no-return-wrap': 'error',
    'promise/catch-or-return': 'off', // default: error
    'promise/no-native': 'error',
    'promise/no-nesting': 'off', // default: warn
    'promise/no-promise-in-callback': 'warn',
    'promise/no-callback-in-promise': 'off', // default: warn
    'promise/avoid-new': 'off', // default: warn
    'promise/no-return-in-finally': 'warn',
    'promise/param-names': 'off', // default: error

    // eslint-plugin-jsdoc
    'jsdoc/require-returns': 1,

    // disable some default eslint-plugin-ember rules
    'ember/no-observers': 'off',
    'ember/no-side-effects': 'off',
    'ember/no-restricted-resolver-tests': 'off',
    'ember/classic-decorator-hooks': 'off',
    'ember/classic-decorator-no-classic-methods': 'off',
    'ember/no-actions-hash': 'off',
    'ember/no-arrow-function-computed-properties': 'off',
    'ember/no-assignment-of-untracked-properties-used-in-tracking-contexts': 'off',
    'ember/no-classic-classes': 'off',
    'ember/no-classic-components': 'off',
    'ember/no-component-lifecycle-hooks': 'off',
    'ember/no-computed-properties-in-native-classes': 'off',
    'ember/no-controller-access-in-routes': 'off',
    'ember/no-deeply-nested-dependent-keys-with-each': 'off',
    'ember/no-ember-super-in-es-classes': 'off',
    'ember/no-empty-glimmer-component-classes': 'off',
    'ember/no-get-with-default': 'off',
    'ember/no-get': 'off',
    'ember/no-incorrect-calls-with-inline-anonymous-functions': 'off',
    'ember/no-incorrect-computed-macros': 'off',
    'ember/no-invalid-debug-function-arguments': 'off',
    'ember/no-invalid-dependent-keys': 'off',
    'ember/no-invalid-test-waiters': 'off',
    'ember/no-jquery': 'off',
    'ember/no-legacy-test-waiters': 'off',
    'ember/no-mixins': 'off',
    'ember/no-new-mixins': 'off',
    'ember/no-noop-setup-on-error-in-before': 'off',
    'ember/no-pause-test': 'off',
    'ember/no-private-routing-service': 'off',
    'ember/no-settled-after-test-helper': 'off',
    'ember/no-shadow-route-definition': 'off',
    'ember/no-string-prototype-extensions': 'off',
    'ember/no-test-and-then': 'off',
    'ember/no-test-import-export': 'off',
    'ember/no-test-module-for': 'off',
    'ember/no-test-support-import': 'off',
    'ember/no-test-this-render': 'off',
    'ember/no-try-invoke': 'off',
    'ember/no-unnecessary-route-path-option': 'off',
    'ember/no-volatile-computed-properties': 'off',
    'ember/prefer-ember-test-helpers': 'off',
    'ember/require-computed-macros': 'off',
    'ember/require-computed-property-dependencies': 'off',
    'ember/require-return-from-computed': 'off',
    'ember/require-super-in-lifecycle-hooks': 'off',
    'ember/require-tagless-components': 'off',
    'ember/require-valid-css-selector-in-test-helpers': 'off',
    'ember/use-ember-data-rfc-395-imports': 'off',
  },
};
