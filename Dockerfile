FROM debian:trixie-slim

ENV DEBIAN_FRONTEND=noninteractive

# Argumentos configuráveis
ARG DEV_USER=dev
ARG DEV_PASS=dev
ARG USER_UID=1000
ARG USER_GID=1000

# Instalação de pacotes
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    git \
    locales \
    nano \
    openssh-server \
    procps \
    sudo \
    tzdata \
    vim \
    wget \
    tini \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Instalação ferramentas de desenvolvimento
RUN curl -LsSf https://astral.sh/uv/install.sh | bash
RUN curl -fsSL https://opencode.ai/install | bash


ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV TZ=America/Sao_Paulo

# Criação do grupo e usuário com UID e GID do host
RUN groupadd -g "$USER_GID" "$DEV_USER" && \
    useradd -m -s /bin/bash -u "$USER_UID" -g "$USER_GID" "$DEV_USER" && \
    echo "$DEV_USER:$DEV_PASS" | chpasswd && \
    echo "$DEV_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Configuração do workspace
RUN mkdir -p /workspace/Projects && \
    chown -R "$DEV_USER":"$DEV_USER" /workspace

# SSH Config
RUN mkdir -p /var/run/sshd \
    && mkdir -p /home/$DEV_USER/.ssh \
    && chown "$DEV_USER":"$DEV_USER" /home/$DEV_USER/.ssh \
    && chmod 700 /home/$DEV_USER/.ssh \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Configuração Global do Bash (Funciona para SSH, docker exec, etc)
RUN cat <<'EOF' >> /etc/bash.bashrc

    case $- in
        *i*) ;;
        *) return;;
    esac

    # Carrega aliases do workspace
    if [ -f /workspace/.bash_aliases ]; then
        . /workspace/.bash_aliases
    fi

    export PS1='\[\e[1;32m\]\u@dev-env\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\$ '
    cd /workspace/Projects
EOF

WORKDIR /workspace

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
