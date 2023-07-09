#!/bin/bash

# analyze current directory to generate sbom and pipe to parlay to enrich to get the repo url, ignore empty value
repos=$(./syft -o cyclonedx-json . | ./parlay ecosystems enrich - | jq -r '.components[].externalReferences[]? | select(.type=="vcs" and .url != null and .url != "") | .url' | sort | uniq)

# debugging to stderr
echo $repos >&2

# Loop through each repo and get the kudos
while read -r repo; do
  # Get the kudos for this repo
  ./scripts/download-repo-get-weights.sh $repo
done <<< "$repos"
