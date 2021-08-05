#!/bin/sh

cd "$GITHUB_WORKSPACE" || exit

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

spectral lint reference/*.yml -v -F=error --ruleset=https://raw.githubusercontent.com/bigcommerce/api-specs/master/.spectral.yaml \
  | reviewdog \
    -efm="%f:%l:%c: %m" \
    -name "spectral" \
    -reporter="${INPUT_REPORTER:-github-pr-check}" \
    -level="${INPUT_LEVEL}" \
    -filter-mode="${INPUT_FILTER_MODE}" \
    -fail-on-error="${INPUT_FAIL_ON_ERROR}" \
    ${INPUT_REVIEWDOG_FLAGS}
