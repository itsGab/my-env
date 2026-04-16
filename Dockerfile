FROM debian:trixie

ENV DEBIAN_FRONTEND=noninteractive

ARG USER_UID=1000
ARG USER_GID=1000
ARG USER=dev

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    git \
    locales \
    && rm -rf /var/lib/apt/lists/* \
    nano \
    vim \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV TZ=America/Sao_Paulo

RUN groupadd -g $USER_GID $USER && \
    useradd -u $USER_UID -g $USER_GID -m -s /bin/bash $USER

USER $USER
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
RUN curl -fsSL https://opencode.ai/install | bash

USER root

RUN mkdir -p /workspace/Projects

RUN cat <<'EOF' >> /home/$USER/.bashrc

case $- in
    *i*) ;;
    *) return;;
esac

# Adiciona o binário do usuário ao PATH (necessário pro uv e opencode)
export PATH="/home/$USER/.local/bin:$PATH"

# Carrega aliases do workspace
if [ -f /workspace/.bash_aliases ]; then
    . /workspace/.bash_aliases
fi

export PS1='\[\e[1;32m\]\u@dev-env\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\$'
cd /workspace/Projects

trap 'exit 0' TERM

EOF

RUN chown -R $USER:$USER /workspace

USER $USER

CMD ["/bin/bash"]
