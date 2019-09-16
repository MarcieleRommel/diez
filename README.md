# Diez &middot; [![Build Status](https://travis-ci.com/diez/diez.svg?token=R7p5y7u83p1oNU4bsu1p&branch=master)](https://travis-ci.com/diez/diez) [![codecov](https://codecov.io/gh/diez/diez/branch/master/graph/badge.svg?token=pgB9U8YLUU)](https://codecov.io/gh/diez/diez)

Diez is a tool for creating highly scalable, cross-platform design systems. The core of Diez is a framework for composing design tokens in TypeScript, plus a [compiler](https://github.com/diez/diez/tree/master/packages/compiler) (transpiler) that builds those tokens into pure-native SDKs for iOS, Android, and the Web.

This monorepo also includes:

 * [Design extractors](https://github.com/diez/diez/tree/master/packages/extractors): Extract image assets and strongly typed style definitions from any Sketch, Figma, InVision DSM, or Adobe XD file
 * [Prefabs](https://github.com/diez/diez/tree/master/packages/prefabs): Pre-built, reusable components for common design system elements like Colors and Typography
 * [Diez CLI](https://github.com/diez/diez/tree/master/packages/cli-core): Generate, configure, and manage Diez projects
 * You can find all of the packages in the repo [here](https://github.com/diez/diez/tree/master/packages). Feel free to take a look around!

## Getting Started

Please refer to [beta.diez.org/getting-started](https://diez:supersecure@beta.diez.org/getting-started) for installation instructions and a thorough set of getting started guides. If prompted, the username is `diez` and the password is `supersecure`.

## Target Platform Support

Diez can be extended to support any language, platform, or development environment. The [native bindings](https://diez:supersecure@beta.diez.org/glossary/#bindings) included with Diez support the following targets:

### iOS

The minimum deployment target for a generated iOS SDK is iOS 11.

### Android

The SDK generated by the provided Android implementation has been tested against Android Q (10).

### Web

In the provided web target implementation, we support CSS, Sass, and vanilla JS. Browser and build tooling support is very broad, and Diez web SDKs should work in any modern web browser.

## Questions, guides, FAQ

Join our [Spectrum Community](https://spectrum.chat/diez) to open a direct line to our team. Feel free also to file a GitHub issue if you encounter any bugs or problems.

Also check out the beta website: [beta.diez.org](https://diez:supersecure@beta.diez.org/). If prompted, the username is `diez` and the password is `supersecure`.

## Universal commands

The following commands are available in all subpackages, as well as in the monorepo itself. Running these commands in the monorepo will run across all subpackages.

 * `yarn compile` - compile all TypeScript to JS.
 * `yarn watch` - compile, then watch for changes.
 * `yarn lint` - lint TypeScript sources.
 * `yarn fix` - lint and automatically fix any automatically fixable lint issues found.
 * `yarn test` - run unit/integration tests.
 * `yarn health` - run tests and lint code with machine-readable outputs for CI.

## Monorepo-specific commands

 * `yarn create-package` - creates a package and registers it with `lerna`. This command will create a new TypeScript package in `packages/` in the `@diez` namespace with a dependency on `@diez/engine`.
 * `yarn create-example` - creates an example project in `examples/`.
 * `yarn docs` - generates the latest version of API docs in `./api`.
 * `yarn build-examples --target [ios|android|web]` - programmatically build all example projects for a given platform.
