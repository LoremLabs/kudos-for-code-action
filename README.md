# Kudos for Code GitHub Action

Give credit where credit is due! The **Kudos for Code** GitHub Action, crafted by [LoremLabs](https://github.com/LoremLabs), is your ally in appreciating the contributions of open-source collaborators. This automation streamlines the process of acknowledging [Kudos](https://www.kudos.community) within your codebase.

## Example Usage

You can automatically install this in your repo via the Semicolons GitHub App, available after logging into [semicolons.com](https://www.semicolons.com/).

To manually install this action, add the following to your workflow file `.github/workflows/kudos.yml`:

```yaml
name: Kudos for Code
on:
  push:
    branches: ["main"]
  workflow_dispatch:

jobs:
  kudos:
    name: Supporting Your Open Source Teams
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: LoremLabs/kudos-for-code-action@latest
        with:
          search-dir: "."
          destination: "artifact"
          generate-nomerges: true
          generate-validemails: true
          generate-limitdepth: 2
```

## Inputs

- `search-dir` - Locate your source code directory. Defaults to `.`
- `destination` - Decide how kudos are allocated. Defaults to `pool`, also supports `artifact`.
- `pool-id` - Identify the pool for kudos allocation (required for `destination: pool`).
- `setler-keys` - Utilize Setler keys for transaction signing (required for `destination: pool`).
- `pool-storage-token` - Employ the storage token for `destination: pool` (write permission required).
- `pool-endpoint` - Utilize the Pool server for Kudos storage. Defaults to `https://api.semicolons.com`.
- `generate-nomerges` - Exclude merge commits when generating Kudos from the repository. Defaults to `true`.
- `generate-validemails` - Include only valid email addresses during Kudos generation from the repository. Defaults to `true`.
- `generate-limitdepth` - Set the depth limit for dependency inclusion during Kudos generation from the repository. Defaults to `2`.


## Supported Package Managers

The **Kudos for Code** GitHub Action offers robust support for diverse programming languages and package managers. This integration ensures seamless attribution of kudos to contributors across different ecosystems. Below is the current list of supported package managers grouped by the programming languages they are most closely associated with:

### C / C++

- [Conan](https://conan.io)

### Dart / Flutter

- [Pub](https://pub.dev)

### Go

- dep
- Glide
- Godep
- GoMod

### Haskell

- [Stack](https://docs.haskellstack.org)

### Java

- Gradle
- Maven (limitations: default profile only)

### JavaScript / Node.js

- Bower
- NPM (limitations: no peer dependencies)
- PNPM (limitations: no peer dependencies)
- Yarn 1
- Yarn 2+

### .NET

- DotNet (limitations: no floating versions / ranges, no target framework)
- NuGet (limitations: no floating versions / ranges, no target framework)

### Objective-C / Swift

- Carthage (limitation: no cartfile.private)
- CocoaPods (limitations: no custom source repositories)
- Swift Package Manager

### PHP

- [Composer](https://getcomposer.org)

### Python

- PIP
- Pipenv
- Poetry

### Ruby

- Bundler (limitations: restricted to the version available on the host)

### Rust

- [Cargo](https://doc.rust-lang.org/cargo)

### Scala

- [SBT](https://www.scala-sbt.org)

### Unmanaged

- This represents a unique "package manager" that efficiently handles all files which cannot be associated with any of the aforementioned package managers.

Stay connected with updates to the list of supported package managers, as your project thrives in the realm of open source development.

## Setler

The **Kudos for Code** GitHub Action relies on the [Setler](https://www.setler.app) app to convert Kudos into payments.

### `setler-keys`

Generate keys using this command:

```bash
setler wallet keys env --filter kudos
```

Add these keys to your repository secrets.

### `pool-storage-token`

Retrieve the storage token with:

```bash
setler auth delegate
```

Add this token to your repository secrets.

### `pool-id`

Create a pool by running:

```bash
setler pool create
```

Add the generated pool ID to your repository secrets.

## Contact

Contact via [semicolons.com](https://www.semicolons.com/contact).

