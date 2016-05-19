#!/bin/bash

export BUILD_COMMIT=${WERCKER_GIT_COMMIT-`git rev-parse HEAD`}
export APP_NAME=${WERCKER_APPLICATION_NAME-`basename $(git rev-parse --show-toplevel)`}
export GIT_SYNC_DOCKER_REPO=${GIT_SYNC_DOCKER_REPO-corekube/git-sync}
export GIT_SYNC_IMAGE_TAG=a31e09303432144cf9a5e306ebec70015e09d0aa
export HUGO_DOCKER_REPO=${HUGO_DOCKER_REPO-corekube/hugo}
export HUGO_IMAGE_TAG=40912bd1ee1dc9a8cb36c0c04c759df568850855
