# Jenkins SBT Build Node

A Jenkins secondary node that can build [sbt](http://www.scala-sbt.org) projects and create Docker containers.

## Notes

### Why not Docker-in-Docker?

See [this article from the creator of Docker-in-Docker](http://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/) about why it shouldn't be used for CI builds.
