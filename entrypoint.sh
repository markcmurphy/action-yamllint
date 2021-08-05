#!/bin/sh

cd "$GITHUB_WORKSPACE" || exit

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

npx @stoplight/spectral@6.0.0-alpha3 lint ./reference/*.yml -f stylish \
  | reviewdog \
      -efm='%-P%f' \
      -efm=' %#%l:%c %# %trror  %m' \
      -efm=' %#%l:%c %# %tarning  %m' \
      -efm='%-Q' \
      -efm='%-G%.%#' \
      -reporter="${INPUT_REPORTER:-github-pr-check}" \
      -filter-mode="${INPUT_FILTER_MODE}" \
      -fail-on-error="${INPUT_FAIL_ON_ERROR}" \
      -level="${INPUT_LEVEL}" \
      ${INPUT_REVIEWDOG_FLAGS} \
      -tee
