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

