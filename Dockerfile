FROM ubuntu:22.04

# 1. Install required packages
RUN apt-get update && apt-get install -y \
    curl git jq sudo wget tar \
    && rm -rf /var/lib/apt/lists/*

# 3. Create a user for the runner
RUN useradd -m runner && mkdir -p /actions-runner && chown runner:runner /actions-runner
USER runner
WORKDIR /actions-runner

# 4. Download GitHub Actions runner
RUN curl -o runner.tar.gz -L https://github.com/actions/runner/releases/latest/download/actions-runner-linux-x64.tar.gz \
    && tar xzf runner.tar.gz && rm runner.tar.gz

# 5. Copy entrypoint
COPY entrypoint.sh /entrypoint.sh
USER root
RUN chmod +x /entrypoint.sh && chown runner:runner /entrypoint.sh
USER runner

ENTRYPOINT ["/entrypoint.sh"]
