FROM gitlab/gitlab-runner:latest

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        netcat \
        tmux \
        unzip \
        sshpass \
        python3 \
        python3-pip \
        ansible \
    && pip3 install --no-cache-dir pywinrm ansible-lint \
    && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/usr/bin/dumb-init", "/entrypoint.sh"]
CMD ["run", "--user=gitlab-runner", "--working-directory=/home/gitlab-runner"]
