# Kudos for Code GitHub Action

GitHub Action for https://github.com/LoremLabs/kudos/tree/main/kudos-for-code

## Example

```yaml
name: Kudos for Code
on:
  push:
    branches: ['main']
  workflow_dispatch:

jobs:
  kudos:
    name: Supporting your open source team..
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: pnpm/action-setup@v2
        with: { version: 7 }
      - uses: LoremLabs/kudos-for-code-action@v0.0.4
        with:
          search-dir: "."
          destination: "pool"
          pool-id: ${{ secrets.KUDOS_POOL_ID }}
          setler-keys: ${{ secrets.SETLER_KEYS_0 }}
          pool-storage-token: ${{ secrets.KUDOS_STORAGE_TOKEN }}
          pool-endpoint: "https://api.semicolons.com"
          
```

## Inputs

`search-dir` - The directory to search for package.json files. Defaults to `.`
`destination` - Specify how to ink your kudos. Defaults to `pool`. Also supports `artifact`
`pool-id` - The id of the pool to ink to, required for `destination: pool`
`setler-keys` - The setler keys to use to sign the transaction, required for `destination: pool`. 
`pool-storage-token` - The storage token to use for `destination: pool`. Must have write permission.
`pool-endpoint` - Pool server to use to store the Kudos. Defaults to `https://api.semicolons.com`

### `setler-keys`

Create the keys with:

```bash
setler wallet keys env --filter kudos
```

Then add to your repo secrets.

### `pool-storage-token`

Retrieve your storage token with:

```bash
setler auth delegate
```

Then add to your repo secrets.

### `pool-id`

To create a pool, run:

```bash
setler pool create
```

Then add to your repo secrets.

