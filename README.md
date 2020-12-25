# DockerFilebeat

When using in a `docker-compose.yml` file, use the following settings:

```
volumes:
  - /var/lib/docker:/var/lib/docker:ro
  - /var/run/docker.sock:/var/run/docker.sock
```
