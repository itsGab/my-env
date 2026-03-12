# my-env: Debian Trixie Dev Environment

Um **ambiente de desenvolvimento básico** baseado em Debian Trixie, containerizado com Docker e acessível via SSH para uso local.


> **Aviso de Segurança**: *Este container é destinado apenas para uso **local** em desenvolvimento. O SSH só é acessível via localhost e não deve ser exposto a redes públicas ou à internet.*


## Requisitos

- Docker instalado
- Docker Compose instalado


## Instalação

1. Clone ou baixe este projeto

```bash
git clone https://github.com/itsGab/my-env.git
```

2. Abra o terminal na pasta do projeto

```bash
cd my-env
```

3. Execute:

```bash
docker compose up -d --build
```

Aguarde a construção da imagem (primeira vez demora um pouco).


## Como acessar

### SSH config

Para facilitar o acesso, adicione no seu `~/.ssh/config`:

```
Host my-env
    HostName localhost
    Port 2222
    User dev
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
```

Depois é só usar:

```bash
ssh my-env
```

Senha: `dev`

### Via terminal direto

```bash
docker exec -it dev-env bash
```

## Estrutura de pastas

O diretório do seu projeto (onde você rodar o docker compose) fica mountado em `/workspace` dentro do container. Qualquer alteração feita no seu editor aparece automaticamente no container.

Dentro do `/workspace` existe a pasta:

```
/workspace/Projects
```

Essa pasta é destinada ao **desenvolvimento dos projetos**.
Cada projeto deve ficar em seu próprio diretório dentro de `Projects`.


## Aliases disponíveis

O arquivo `.bash_aliases` já vem com atalhos configurados:

| Comando | Função |
|---------|--------|
| `ll` | Lista arquivos com detalhes |
| `gs` | git status |
| `aptinstall <pacote>` | Instala pacote via apt |
| `aptupgrade` | Atualiza todos os pacotes |
| `aptclean` | Para limpar lista de pacotes |

Para ver todos os aliases, digite: `cat /workspace/.bash_aliases`


## Comandos úteis

| Comando | O que faz |
|---------|-----------|
| `docker compose up -d --build` | Inicia e constrói o container |
| `docker compose stop` | Para o container |
| `docker compose start` | Inicia container parado |
| `docker compose down` | Remove o container |
| `docker compose logs -f` | Mostra logs em tempo real |
| `docker compose ps` | Mostra status do container |
| `docker compose restart` | Reinicia o container |


## Configuração

- Usuário: `dev`
- Senha: `dev`
- Porta SSH: `2222`
- Timezone: America/Sao_Paulo

O container não inicia automaticamente após reboot. Use `docker compose start` para ligar.


## Problemas comuns

**Container não inicia?**
Execute: `docker compose logs` para ver o erro.

**Não consegue conectar no SSH?**
Verifique se a porta 2222 não está sendo usada por outro programa.

**Quer mudar a senha?**
Edite o arquivo `Dockerfile` nas linhas 28-30 e rebuild com `docker compose up -d --build`.
