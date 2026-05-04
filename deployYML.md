```bash
name: Deploy Laravel Website to CPanel

on:
  push:
    branches:
      - main

jobs:
  FTP-Deploy-Action:
    name: Build and Deploy
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Code
        uses: actions/checkout@v3
        with:
          fetch-depth: 0

      - name: Setup PHP
        uses: shivammathur/setup-php@v2

      # - name: Install Composer Dependencies
      #   run: composer install --no-dev --optimize-autoloader

      # - name: Install NPM Dependencies & Build
      #   run: |
      #     npm install
      #     npm run build

      - name: FTP Deploy
        uses: SamKirkland/FTP-Deploy-Action@v4.3.4
        with:
          server: ${{ secrets.FTP_SERVER }}
          username: ${{ secrets.FTP_USERNAME }}
          password: ${{ secrets.FTP_PASSWORD }}
          source: "."
          server-dir: /
          target: /

```
