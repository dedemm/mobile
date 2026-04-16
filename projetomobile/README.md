# 🏙️ App de Zeladoria Urbana (MVP)

> App para cidadãos reportarem problemas urbanos (buracos, semáforos quebrados, iluminação) com foto e categoria. Desenvolvido para a disciplina de Programação de Dispositivos Móveis - UTFPR-PG.

---

## Instalação Rápida do Git para clonar o projeto (5 minutos)

### 1. Instale o Git (se não tiver)

**Windows:** Baixe em [git-scm.com](https://git-scm.com/download/win) (só clicar em "Next" até o fim)

**Mac:** `brew install git` ou baixe do site

**Linux (Ubuntu):** `sudo apt install git`

Verifique se instalou: `git --version`

---

## Pré-requisitos
Flutter SDK
VS Code ou Android Studio
Android Studio (para emulador) ou celular físico com depuração USB

### 2. Conecte o telefone
#### Opção 1: Emulador (Android Studio)
- Instale e abra o Android Studio
- Clique em Device Manager (ícone de celular na barra lateral)
- Clique em Create device
- Escolha um modelo (ex: Pixel 4)
- Selecione uma versão do Android (ex: API 33) e baixe se necessário
- Clique no botão ▶️ para iniciar o emulador
- Aguarde o dispositivo iniciar

#### Opção 2: Via cabo USB (celular físico)
No celular:
- Vá em Configurações > Sobre o telefone
- Toque 7 vezes em Número da versão (ativa o modo desenvolvedor)
- Vá em Opções do desenvolvedor
- Ative Depuração USB

No computador:
- Conecte o celular via USB e execute:
- flutter devices
- Você verá algo como:
- SM-G975F • android-arm64 • Android 12 (API 31)

No celular,após rodar o projeto aceite o pop-up "Permitir depuração USB?".

## Clonar e Rodar o projeto
### 1. Clonar o repositório
No terminal dentro do VsCode, digite esses comandos
```bash
git clone https://github.com/dedemm/mobile
cd projetomobile
```
### 2. Instalar dependências
```bash
flutter clean

flutter pub get
```
### 3. Rodar no emulador ou celular
Com o emulador aberto ou celular conectado via USB (depuração ativada):

```bash
flutter run
```
O Flutter detecta automaticamente o dispositivo disponível e instala o app nele.

# Equipe
*André:* 
- Criação de telas no figma
- Configuração inicial do projeto
- Criação de telas de cadastro de denuncias, tela de cadastrar usuarios, login de usuarios e tela de perfil
- Configuração de rotas para as telas novas
- Alteração das telas relacionadas ao usuario para seguir o padrão MVVM

*Nathan*
- Criação de telas no figma
- Configuração inicial do arquivo de rotas, main.dart e app.dart
- Ajustado layout do arquivo detalhado de cadastrar denuncias

*Vagner*
- Criação de telas no figma
- Criação visual da tela de denúncias dentro do app
- Ajuste na lógica core da relação de criação de denúncias para tela de denúncias
- Read.md detalhado com assunto do projeto e passos de instalação do App

## Tecnologias
- Flutter + Dart

### Implementações
*MVP*
- As validações dos campos e telas do app estão prontas
- Sem persistência dos dados
- O app não conta com autenticação já funcional, mas tem estrutura para fácil implementação
- GeoLocalização nativa ainda em desenvolvimento
- Possibilidade de subir fotos ainda em desenvolvimento
- Edição de denúncia ainda em desenvolvimento
