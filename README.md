# converter

[![wercker status](https://app.wercker.com/status/0500b2ae133f73687c0c249e2c314b7c/m "wercker status")](https://app.wercker.com/project/bykey/0500b2ae133f73687c0c249e2c314b7c)

A Kubernetes pod tasked with:

  1. Performing a git sync on a repo to a directory - (default sync destination directory is an NFS volume)
    * image: [corekube/git-sync](https://hub.docker.com/r/corekube/git-sync)
    * repo: [github.com/corekube/git-sync](https://github.com/corekube/git-sync)
  
  2. Converting markdown into HTML using [Hugo](https://github.com/spf13/hugo) - (default Hugo src & dest directories are an NFS volume)
    * image: [corekube/hugo](https://hub.docker.com/r/corekube/hugo)
    * repo: [github.com/corekube/hugo](https://github.com/corekube/hugo)
