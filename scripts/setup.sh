#!/bin/bash

echo "🔧 Ajustando permissões para o usuário ${DEV_USER:-dev}..."

# Ajusta o dono da pasta workspace (onde seus projetos ficam)
chown -R "${DEV_USER:-dev}":"${DEV_USER:-dev}" /workspace 2>/dev/null

# Ajusta a home do usuário dentro do container
chown -R "${DEV_USER:-dev}":"${DEV_USER:-dev}" "/home/${DEV_USER:-dev}" 2>/dev/null

# Garante que a pasta .ssh tem a permissão correta
chmod 700 "/home/${DEV_USER:-dev}/.ssh" 2>/dev/null

echo "✅ Permissões ajustadas e ambiente pronto!"
