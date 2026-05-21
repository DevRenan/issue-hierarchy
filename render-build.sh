#!/usr/bin/env bash
set -o errexit

# Instala Python 3 e pip
apt-get update && apt-get install -y python3 python3-pip

# Instala PyMuPDF
pip3 install pymupdf

# Instala dependências do Rails
bundle install

# Pré-compila assets
bundle exec rails assets:precompile

# Executa migrations
bundle exec rails db:migrate
