#!/usr/bin/env bats

#load '/usr/local/lib/bats/load.bash'

@test "Pre-command copies down cache if it exists" {
  export BUILDKITE_ORGANIZATION_SLUG="my-org"
  export BUILDKITE_PIPELINE_SLUG="my-pipeline"
  export BUILDKITE_PLUGIN_CACHE_CACHED_FOLDERS_0="my_directory/"
  export BUILDKITE_PLUGIN_CACHE_S3_BUCKET="my-bucket"

  stub aws \
    "aws s3 cp s3://my-bucket/my-pipeline/my-label/my-directory.tar.gz . : echo s3 cp"

  run $PWD/hooks/pre-command
  
  assert_success
  assert_output --partial "s3 cp"

  unstub aws
  
  unset BUILDKITE_PLUGIN_CACHE_CACHED_FOLDERS_0
  unset BUILDKITE_PIPELINE_SLUG
  unset BUILDKITE_ORGANIZATION_SLUG
  unset BUILDKITE_PLUGIN_CACHE_S3_BUCKET
}

@test "Post-command copies cache to S3" {
  export BUILDKITE_ORGANIZATION_SLUG="my-org"
  export BUILDKITE_PIPELINE_SLUG="my-pipeline"
  export BUILDKITE_PLUGIN_CACHE_CACHED_FOLDERS_0="my_directory/"
  export BUILDKITE_PLUGIN_CACHE_S3_BUCKET="my-bucket"

  stub aws \
   "aws s3 cp my-directory.tar.gz s3://my-bucket/my-pipeline/my-label/my-directory.tar.gz : echo s3 cp"

  run $PWD/hooks/post-command

  assert_success
  assert_output --partial "s3 cp"

  unstub aws

  unset BUILDKITE_PLUGIN_CACHE_CACHED_FOLDERS_0
  unset BUILDKITE_PIPELINE_SLUG
  unset BUILDKITE_ORGANIZATION_SLUG
  unset BUILDKITE_PLUGIN_CACHE_S3_BUCKET
}