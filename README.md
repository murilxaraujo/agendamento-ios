# Aplicativo de Agendamento

O aplicativo de agendamento fornece uma forma simples e rápida para que os clientes comprem os serviços de limpeza da sua empresa.
O processo se torma completamente automatizado, a seleção de datas, horários, e pagamento. Após a confirmação do pagamento você pode checar os agendamentos através da plataforma de administração, disponível para Windows, Mac e Linux (Apliação de administrador produzida usando o framework Angular e Electron).

## ⚠️ Atenção ⚠️
Este projeto reflete apenas a interface e o fluxo de navegação do app e, para este fim, a lógica foi codificada diretamente nas classes ViewController, sem seguir algum design pattern, com um MockBackend Firebase para testes. Em um ambiente de produção a lógica deve ser programada separadamente.

## Instalação
Após clonar o repositório use o comando `pod install` no terminal para instalar as dependências e bibliotecas necessárias.

Caso queira usar o backend firebase para testes, antes de programar seu próprio, crie seu projeto no console e substitua o arquivo `.json` de configuração. Lembre-se de: <br>
1. Ativar autenticação via email e senha no painel de autenticação<br>
2. Definir as regras de read and write do cloud firestore para `true if auth.currentuser != null`

## Funcionalidades
* Adicionar endereços
* Apagar endereços
* Agendar visita
* Ver visitas agendadas
* Avaliar visitas realizadas
* Pagar a visita dentro da aplicação usando o gateway MercadoPago
* Realizar login
* Criar conta
* Recuperar senha
* Simular preço do serviço

<img src="https://i.imgur.com/JXRY25x.png" width="100px">
