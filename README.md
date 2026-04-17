# my-env: Ambiente de Desenvolvimento Container Debian:Trixie

Ambiente de desenvolvimento containerizado baseado em Debian Trixie com Python (via `uv`) e ferramentas essenciais.

## Requisitos

- Docker
- Docker Compose

## Instalação


## Como criar a imagem `devenv`

```bash
./build.sh
```

O script detecta automaticamente seu UID/GID local e passa para o container, garantindo que arquivos criados dentro do container mantenham as permissões corretas no host.

## Como criar o container

```bash
docker compose up -d
```

## Como acessar

```bash
docker compose exec dev bash
```

## Comandos úteis

| Comando | O que faz |
|---------|-----------|
| `./build.sh` | Constrói / Reconstrói a imagem |
| `docker compose up -d` | Inicia o container |
| `docker compose down` | Remove o container |
| `docker compose restart` | Reinicia o container |
| `docker compose logs -f` | Mostra logs em tempo real |

## Estrutura do Workspace

```
/workspace/Projects    # Seus projetos ficam aqui
```

O diretório `./Projects` do host é montado em `/workspace/Projects` no container.

### Aliases disponíveis

| Comando | Função |
|---------|-----------|
| `ll` | Lista arquivos com detalhes |
| `la` | Lista arquivos ocultos |
| `aptinstall <pacote>` | Instala pacote via apt |
| `aptclean` | Limpa cache do apt |

Para ver todos:
[aliases](.bash_aliases) ou `alias` no container.
