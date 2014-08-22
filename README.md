rotate-log-to-s3 Cookbook
========================
This cookbook rotate logs and upload them to S3.

Usage
-----
Add `rotate-log-to-s3` recipe in your node's `run_list` and attributes.

```json
{
  ...
  "rotate-log-to-s3": {
    "name_of_logrotate": {
      "log-dir": "/target/directory", # (All *.log files in the directory are processed.
      "permission": "0644",
      "user": "user1",
      "group": "user1",
      "limits": "5",                  # number of rotated files
      "post-rotate-command": "",      # run shell command after log rotate
      "aws-id": "XXXXXXXXXXXXXXX",    # AWS_ACCESS_KEY_ID
      "aws-key": "YYYYYYYYYYYYYYYY",  # AWS_SECRET_ACCESS_KEY
      "s3-dir": "bucket/path/to/backup",
      "s3-region": "ap-northeast-1",
      "option": "--exclude \"*\" --include \"*.gz\" --recursive"
    }
  },
  "run_list": [
    ...
    "recipe[rotate-log-to-s3]",
    ...
  ],
  ...
}
```

After logrotate, their compressed files will be uploaded to S3.

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License
-------------------

MIT
