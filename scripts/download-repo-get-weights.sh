#!/bin/bash

# get repo from command line
repo=$1

# parentWeight, default to 1
parentWeighting=${2:-1}

# if no repo, exit
if [ -z "$repo" ]; then
  echo "No repo specified"
  exit 1
fi

# clone repo into a temporary directory
tmp=$(mktemp -d)
cd $tmp
git clone --filter=tree:0 $repo .

# Get the list of authors and commit counts
authors=$(git log --format='%ae' | sort | uniq -c | sort -nr)

# Get the total weight
total=$(echo "$authors" | awk '{ sum += $1 } END { print sum }')

# Generate a traceId, a uuid, for this kudos transaction
traceId=$(uuidgen | xxd -r -p | base64 | sed 's/+/-/g; s/\//_/g; s/=//g')

# Loop through each author and get their GitHub username
while read -r line; do
  count=$(echo "$line" | awk '{ print $1 }')
  email=$(echo "$line" | awk '{ print $2 }')
  # username=$(curl -s "https://api.github.com/search/users?q=$email+in:email" | jq -r '.items[0].login')
  
  # Calculate the weight for this author
  weight=$(echo "scale=5; $count / $total * $parentWeighting" | bc)
  weight=$(printf "%.5f" $weight)


  # Generate a unique ID for this kudos
  id=$(uuidgen | xxd -r -p | base64 | sed 's/+/-/g; s/\//_/g; s/=//g')

  # Get the current timestamp in UTC
  ts=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

  # Output the kudos information in JSON format
  # {"identifier":"did:kudos:email:$email","id":"XR8C4DfXjRTWykQF3xMtF2","ts":"2023-06-28T16:08:04Z","weight":1,"traceId":"XR7whJG3zbH5jFbdJpJjv8"}
  echo "{\"identifier\":\"did:kudos:email:$email\",\"id\":\"$id\",\"ts\":\"$ts\",\"weight\":$weight,\"traceId\":\"$traceId\"}"
done <<< "$authors"

# remove temporary directory
rm -rf $tmp
