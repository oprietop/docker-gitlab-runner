# docker-gitlab-runner
Gitlab runner plus some packages and a custom entrypoint for autoregistration

## Usage example
```
docker run -it --rm --user 999 \
    -e DEBUG=true \
    -e CI_SERVER_URL=https://gitlab.com/ \
    -e REGISTRATION_TOKEN=xxxxxxxxxxxxxxxxx \
    -e RUNNER_TAG_LIST=tag1,tag2 \
    -e RUNNER_LIMIT=1 \
    -e REGISTER_MAXIMUM_TIMEOUT=600 \
    -e CI_SERVER_TLS_CA_FILE=/mnt/gitlab-runner/certs/ca.crt \
    -v $(pwd)/ca.crt:/mnt/gitlab-runner/certs/ca.crt \
    oprietop/gitlab-runner
```

## Notes
You can get the ca into a ca.crt file with openssl if needed
```
openssl s_client -connect gitlab.com:443 -showcerts </dev/null 2>/dev/null | sed -e '/-----BEGIN/,/-----END/!d'
```
