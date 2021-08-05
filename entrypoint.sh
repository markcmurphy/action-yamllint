#!/bin/sh

cd "$GITHUB_WORKSPACE" || exit

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

npx @stoplight/spectral@6.0.0-alpha3 lint ./reference/*.yml -f text --ruleset=https://raw.githubusercontent.com/bigcommerce/api-specs/master/.spectral.yaml \
  | reviewdog \
    -efm="%f:%l:%c: %m" \
    -name "spectral" \
    -reporter="${INPUT_REPORTER:-github-pr-review}" \
    -level="${INPUT_LEVEL}" \
    -filter-mode="${INPUT_FILTER_MODE}" \
    -fail-on-error="${INPUT_FAIL_ON_ERROR}" \
    ${INPUT_REVIEWDOG_FLAGS}
