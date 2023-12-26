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
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0 
      - uses: LoremLabs/kudos-for-code-action@latest
        with:
          search-dir: "."
          destination: "artifact"
          generate-nomerges: true
          generate-validemails: true
          generate-limitdepth: 1
          generate-fromrepo: true
          analyze-repo: false
```

## Inputs

- `search-dir` - Locate your source code directory. Defaults to `.`
- `analyze-repo` - Do deeper analysis of repo to look at included libraries. Defaults to `true`
- `generate-fromrepo` - Include commits from top level repo if true. Defaults to `false`
- `destination` - Decide how kudos are allocated. Defaults to `pool`, also supports `artifact`.
- `pool-id` - Identify the pool for kudos allocation (required for `destination: pool`).
- `setler-keys` - Utilize Setler keys for transaction signing (required for `destination: pool`).
- `pool-storage-token` - Employ the storage token for `destination: pool` (write permission required).
- `pool-endpoint` - Utilize the Pool server for Kudos storage. Defaults to `https://api.semicolons.com`.
- `generate-nomerges` - Exclude merge commits when generating Kudos from the repository. Defaults to `true`.
- `generate-validemails` - Include only valid email addresses during Kudos generation from the repository. Defaults to `true`.
- `generate-limitdepth` - Set the depth limit for dependency inclusion during Kudos generation from the repository. Defaults to `2`.
- `skip-ids` - A space delimited list of ids to skip. Defaults to `""`.

## Monorepo / Multiple Package Usage

If your repo is a monorepo or includes multiple packages that should be analyzed independently, the following can be used as a starting point. Note that it assumes that your sub-repos are contained in a `packages` directory.

```yaml
name: Kudos for Code
on:
  push:
    branches: ["main"]
  workflow_dispatch:

jobs:
  get-packages:
    name: Get Monorepo Packages
    runs-on: ubuntu-latest
    outputs:
      matrix: ${{ steps.set-dirs.outputs.matrix }}
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
          with:
            fetch-depth: 0
      - name: Set packages
        id: set-dirs
        run: |
          changed_files=$(git diff --name-only ${{ github.event.before }} ${{ github.sha }})
          packages=$(echo "${changed_files}" | grep '^packages/' | cut -d'/' -f2-3 | sort -u)

          # Convert packages to a matrix format
          matrix=$(echo "${packages}" | jq -R -s -c 'split("\n")[:-1]')
          echo "::set-output name=matrix::${matrix}"
  kudos:
    needs: get-packages
    name: Semicolons Kudos
    permissions: write-all
    runs-on: ubuntu-latest
    strategy:
      max-parallel: 2
      matrix: 
        directory: ${{fromJson(needs.get-packages.outputs.matrix)}}
    steps:
      - uses: actions/checkout@v2
      - uses: LoremLabs/kudos-for-code-action@latest
        with:
          search-dir: ${{ matrix.directory }}
          destination: "artifact"
          generate-nomerges: true
          generate-validemails: true
          generate-limitdepth: 1
          generate-fromrepo: true
          analyze-repo: false
          skip-ids: ""
```

## Contact

Contact via [semicolons.com](https://www.semicolons.com/contact).

