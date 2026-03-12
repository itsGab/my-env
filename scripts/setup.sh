#!/bin/bash

TARGET="/home/dev/.bashrc"
MARKER="# --- DEV CONFIG ---"

# 1. Injeção do Bloco Principal (Aliases + CD)
if ! grep -q "$MARKER" "$TARGET"; then
    cat <<EOT >> "$TARGET"

$MARKER
# Carrega aliases se existirem
if [ -f /workspace/.bash_aliases ]; then . /workspace/.bash_aliases; fi

# Prompt colorido e histórico
export PS1='\[\e[1;32m\]\u@dev-env\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\$ '

# Entra na pasta de trabalho
cd /workspace
EOT
    chown dev:dev "$TARGET"
    echo "✅ Bashrc configurado."
fi

# 2. Ajuste de permissões de arquivos críticos
chown -R dev:dev /home/dev/
chmod 700 /home/dev/.ssh 2>/dev/null

echo "🚀 Setup concluído com sucesso!"
