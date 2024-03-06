<div align='center'>

# Desafio Desenvolvedor de Aplicativos móveis no Magazord

![magazord-logo](./docs/LogoMagazord.png)

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![React Native](https://img.shields.io/badge/react_native-%2320232a.svg?style=for-the-badge&logo=react&logoColor=%2361DAFB)
![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)

Este repositório contém minhas resoluções das tarefas propostas [nesse link](https://github.com/magazord-plataforma/magazord-dev-app-test).

</div>

Caso queira utilizar as exatas mesmas versões que eu, recomendo a instalação desses utilitários:

- [fnm](https://github.com/Schniz/fnm) para o NodeJS
- [rbenv](https://github.com/rbenv/rbenv) para o Ruby
- [sdkman](https://sdkman.io/) para a JDK
- [fvm](https://fvm.app/) para o Flutter

## Tarefa 1: Componente de Lista

Aplicativo desenvolvido com React Native (CLI), disponível na pasta [apps/01_todo_list](https://github.com/mrocha98/magazord-mobile-challenge/tree/main/apps/01_todo_list).

![app 1 demo](./docs/demo_todo_list.png)

Para executar o aplicativo é necessário atender aos requisitos listados na [documentação do React Native](https://reactnative.dev/docs/environment-setup).

Versões utilizadas:
- Node v20.11.1
- Ruby 2.6.10
- OpenJDK 17.0.10 Zulu

Tendo tudo configurado, basta executar `npm start` no diretório do app e escolher entre o iOS ou o Android.

## Tarefa 2: Integração com API

Aplicativo desenvolvido com React Native (Expo), disponível na pasta [apps/02_weather](https://github.com/mrocha98/magazord-mobile-challenge/tree/main/apps/02_weather).

<div align='center'>

![app 2 demo](./docs/demo_weather.png)

</div align='center'>

As versões utilizadas bem como o processo de execução são exatamente os mesmos da [Tarefa 1](#tarefa-1-componente-de-lista).

A API escolhida para obter os dados de clima foi a [Open-Meteo](https://open-meteo.com/).

## Tarefa 3: Navegação entre Telas

Aplicativo desenvolvido com Flutter, disponível na pasta [apps/03_products_catalog](https://github.com/mrocha98/magazord-mobile-challenge/tree/main/apps/03_products_catalog).

![app 3 demo](./docs/demo-products-catalog.gif)

A API escolhida para obter os produtos foi a [Fake Store API](https://fakestoreapi.com/).

Versão utilizada: **3.19.2**

Para executar o app é preciso ter um emulador de iOS ou Android em pé, ou dispositivo real configurado.

Entre no diretório do projeto e execute `fvm flutter run -d '<id-do-seu-emulador>'` ou pelo VSCode, abra qualquer arquivo `.dart` e clique em `Run` > `Run Without Debugging`.

> [!NOTE]
> Antes de executar no iOS é preciso executar o script `pre-run-ios.sh`. Isso fará com que o MMKV não conflite com uma lib nativa, conforme explicado [aqui](https://github.com/Tencent/MMKV/tree/master/flutter#ios).

## Tarefa 4: Personalização de Tema

Implementado na [tarefa 3](#tarefa-3-navegação-entre-telas).

## Tarefa 5: Bônus (opcional)

- Armazenamento local implementado nas tarefas [1](#tarefa-1-componente-de-lista) e [3](#tarefa-3-navegação-entre-telas).
- Animações entre alternância de telas implementadas na [tarefa 3](#tarefa-3-navegação-entre-telas)
- Compartilhamento com WhatApp implementado na [tarefa 3](#tarefa-3-navegação-entre-telas)

## Considerações Finais

Os apps ficaram em inglês porque a API de produtos retorna os textos nesse idioma. Como comecei pela tarefa 3, preferi manter nas demais para ficar condizente 😜.
