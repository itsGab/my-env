# my-env: Ambiente de Desenvolvimento Containerizado (Debian Trixie)

Este projeto fornece um ambiente de desenvolvimento isolado e persistente baseado em **Debian Trixie**, otimizado para o ecossistema Python moderno e fluxos de trabalho assistidos por **Inteligência Artificial**.

## Destaques do Ambiente

* **Python Engine:** Gerenciamento de pacotes e ambientes ultrarrápido via `uv`.
* **AI-Powered:** Integrado com `Opencode` para programação assistida por IA.
* **Permission Sync:** Script de build que sincroniza automaticamente seu `UID` e `GID`, evitando problemas de permissão de arquivos no host.
* **Base Atualizada:** Utiliza Debian Trixie (Testing) para acesso a pacotes mais recentes.

## Requisitos

* Docker & Docker Compose
* (Opcional) Ambiente Linux/Unix para execução do script shell.

## Instalação e Uso

### 1. Construir a imagem
O script `./build.sh` configura a imagem `devenv` injetando as permissões do seu usuário local:
```bash
chmod +x build.sh
./build.sh
```

### 2. Subir o ambiente
```bash
docker compose up -d
```

### 3. Acessar o terminal
```bash
docker compose exec -it dev bash
```

## Comandos e Utilitários

### Ciclo de vida do container
| Comando | Descrição |
| --- | --- |
| `./build.sh` | Constrói ou reconstrói a imagem com permissões locais |
| `docker compose up -d` | Inicia o ambiente em segundo plano |
| `docker compose down` | Encerra e remove o container |
| `docker compose logs -f` | Monitora a saída do container em tempo real |

### Atalhos (Aliases) de Produtividade
Dentro do container, utilize os seguintes aliases configurados:
* `ll`: Listagem detalhada de arquivos (`ls -lh`).
* `la`: Listagem de todos os arquivos, incluindo ocultos.
* `aptinstall <pacote>`: Atalho para instalação rápida de dependências.
* `aptclean`: Limpeza profunda do cache do `apt` para manter o container leve.

## Estrutura de Volumes
Para garantir a persistência dos seus códigos:
* O diretório `./Projects` no host é mapeado para `/workspace/Projects` no container.
* Sempre salve seus projetos dentro desta estrutura para não perder dados ao destruir o container.
