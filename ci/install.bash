#!/bin/bash

set -e

pip install -e . --no-deps

if [[ "$TRAVIS_BRANCH" == "develop" ]]; then
  export DOCS_VERSION="latest"
elif [[ "$TRAVIS_BRANCH" == "master" ]]; then
  export DOCS_VERSION="stable"
elif [ -n "$TRAVIS_TAG" ]; then
  # this is a tag build
  export DOCS_VERSION="$TRAVIS_TAG"
else
  DOCS_VERSION=`python -c "import mpas_analysis; print(mpas_analysis.__version__)"`
  export DOCS_VERSION
fi
cd docs || exit 1
make clean
make html
cd ..