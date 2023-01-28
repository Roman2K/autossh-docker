# autossh-docker

A minimal Dockerfile for [autossh][autossh] with automatic reconnection, running
as a regular user.

[autossh]: https://www.harding.motd.ca/autossh/

## Usage

Example docker-compose configuration:

1. Make `myhost:8086` reachable within a Docker network through
   `myhost-influxdb:8086`:

    ```yaml
      myhost-influxdb:
        image: autossh
        volumes:
          - type: bind
            source: $HOME/.ssh/id_rsa
            target: /home/app/.ssh/id_rsa
            read_only: true
          - type: bind
            source: $HOME/.ssh/config
            target: /home/app/.ssh/config
            read_only: true
        command: ['-N', '-L', '8086:localhost:8086', 'myhost']
    ```

2. Or exposing `:8086` by the host:

    ```yaml
      myhost-influxdb:
        # <same has above>
        command: ['-N', '-L', '0.0.0.0:8086:localhost:8086', 'myhost']
        ports: ['127.0.0.1:8086:8086']
    ```

