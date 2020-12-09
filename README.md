# docker-gitlab-runner
Gitlab runner plus some packages

## Usage example
`docker run -it --rm -e DEBUG=true -e CI_SERVER_URL=https://gitlab.com -e REGISTRATION_TOKEN=xxxxxxxxxxxxx -e RUNNER_TAG_LIST=tag1,tag2 -e RUNNER_LIMIT=1 -e REGISTER_MAXIMUM_TIMEOUT=600 --user 999 oprietop/gitlab-runner`
