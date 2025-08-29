# Fundamentos Linux

Este repositório reúne materiais, exercícios, scripts e exemplos práticos para o estudo e ensino dos fundamentos do sistema operativo Linux, incluindo administração, redes, permissões, automação e serviços.

## Estrutura

- **lablinux-landing-page/**: Aplicação web Flask para landing page do projeto, com rate limiting, contagem de visitas por IP (Redis), e exibição de imagens aleatórias.
	- `docker-compose.yml`, `Dockerfile`: Configuração para execução em Docker, incluindo Redis e RedisInsight.
	- `flaskapp/`: Código da aplicação Flask, templates, ficheiros estáticos e scripts.
- **exercicios_sessao_03_a.sh**: Script Bash para exercícios de gestão de utilizadores e grupos.
- **exercicios_sessao_03_b.md**: Exercícios teóricos sobre permissões de arquivos e pastas.
- **redes.md**: Apontamentos e exemplos de configuração de redes, DHCP e DNS em Linux.
- **pdfs/** e **pdfs_EISnt/**: Materiais de apoio, cheatsheets e exercícios em PDF.
- **prints/**: Imagens e capturas de ecrã para documentação e apoio às aulas.

## Como usar

1. Clone o repositório.
2. Consulte os materiais e scripts conforme necessário.
3. Para executar a landing page, utilize Docker Compose na pasta `lablinux-landing-page`.

## Objetivo

Facilitar o acesso a exemplos práticos, exercícios e documentação para quem está a aprender ou ensinar Linux, especialmente em contexto de laboratório ou sala de aula.

---
## Resumo do Conteúdo Programático
* Conceitos sobre shell
* Tipos de shell
* Bash, sh, csh, tcsh, ash, zsh, ksh
* Bash, o shell padrão da GNU
* Múltiplas consolas
* Consolas e interface gráfica simultânea
* Comandos
* Comandos rápidos de teclado
* Multiutilizadores
* Digitação de um comando
* Correcção de comandos
* Repetição de um comando
* Lista de históricos de comandos
* Cancelamento de um comando
* Comando history
* Logout
* Formas de desligar e reiniciar o servidor
* Comando shutdown e suas opções (mensagens, encerramento programado timer)
* Desactivação das formas de encerramento do servidor
* Obtenção de ajuda para comandos
* Diretório /usr/share/man
* Tipos de pasta normal, diretório, link, bloco, caractere, fifo, socket
* Cores de pastas e pastas numa listagem
* Alteração das cores da listagem de pastas e de fundo da consola
* Alteração da fonte da consola
* Visualização do calendário
* Actualização da data e hora
* Pasta /etc/tzconfig
* Iniciação e encerramento de um programa residente
* Encerramento de um processo em execução
* Utilização da pausa em comandos


## Objectivos Gerais:
* Instalar e configurar o Linux Server.

## Metodologia formativa
* Método Interrogativo, Ativo, Expositivo e Demonstrativo
