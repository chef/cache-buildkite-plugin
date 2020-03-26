# Cache Buildkite Plugin

A [Buildkite plugin](https://buildkite.com/docs/agent/v3/plugins) to restore and save directories to and from an s3 bucket.

- Built off of BUILDKITE env variables so there is no necessary exporting needed

Example push: `aws s3 cp vendor.tar.gz s3://mybucket/my-pipeline/my-label/vendor.tar.gz`

Example pull: `aws s3 cp s3://mybucket/my-pipeline/my-label/vendor.tar.gz .`

## Example

```yml
steps:
  - label: cache_s3
    plugins:
    - chef/cache#v1.1.0:
        cached_folders:
        - .vendor/
        s3_bucket: 'my-bucket'
```

## Configuration

### `cached_folders` (required)

The directory which you would like saved to s3 as well as where you would like s3 to pull contents into.

Example: `.vendor/`

### `s3_bucket` (required)

The bucket in S3 which is used to push and pull the cached_folders into.

Example: `my-bucket`
