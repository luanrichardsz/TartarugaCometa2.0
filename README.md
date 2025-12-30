# 🚚 Tartaruga Cometa

Sistema web para **gerenciamento de transporte de cargas**, desenvolvido com **Java Web puro**, utilizando **Servlets, JSP e JDBC**, com foco em **aprendizado, organização de código e boas práticas**.

---

## 📌 Descrição do Projeto

O **Tartaruga Cometa** é uma aplicação web que simula um sistema de logística para transporte de cargas, permitindo:

- Cadastro de clientes (CPF/CNPJ)
- Cadastro de produtos
- Lançamento de entregas
- Associação de produtos às entregas
- Controle de status das entregas (Pendente / Entregue)
- Cálculo de valores (subtotal, frete e valor total)

Projeto desenvolvido **sem frameworks**, priorizando o entendimento da base do **Java Web**.

---

## 🎯 Requisitos de Negócio

- Transporte de cargas (origem → destino)
- Captura de **Remetente** e **Destinatário**
  - CPF/CNPJ
  - Nome / Razão Social
  - Endereço
- Captura de **Produtos**
  - Nome
  - Peso
  - Volume
  - Valor
- Lançamento de entrega no sistema
- Associação de produtos à entrega
- Controle de status:
  - ✔ Realizada
  - ❌ Não Realizada

---

## ⚙️ Requisitos Técnicos

- **Backend:** Java Web (JDK 8+)
- **Servidor:** Apache Tomcat 8+
- **Banco de Dados:** PostgreSQL
- **Persistência:** JDBC
- **Build:** Gradle
- **Frontend:** JSP (HTML / CSS)
- **Padrão de Projeto:** DAO
- **Arquitetura:** MVC
- **Frameworks:** ❌ Nenhum (aprendizado puro)

---

## 🧠 Conhecimentos Aplicados

- Java e Orientação a Objetos
- Servlets e JSP
- JDBC e SQL
- Padrão DAO
- Clean Code
- Princípios básicos de SOLID
- Modelagem relacional de banco de dados
- Separação de responsabilidades (MVC)

---

## 🗄️ Banco de Dados

### 📌 Pré-requisitos
- PostgreSQL instalado
- Banco de dados criado (exemplo: `tartaruga_cometa`)

### ▶️ Executar o script

1. Crie o banco de dados:
```sql
CREATE DATABASE tartaruga_cometa;
```
2. Conecte-se ao banco
3. Copie os comandos do arquivo createTable.sql
   
    /home/estagiario3/eclipse-workspace/TartarugaCometa/bd/createTable.sql
4. Crie as tabelas

- Cliente
- Endereco
- Produto
- Entrega
- Produto_Entrega

## 🔧 Configuração do Projeto

### 📌 Conexão com o Banco de Dados

**Arquivo:**
src/main/java/bd/ConnectionFactory.java
Edite as variáveis conforme o seu ambiente local:

```java
private static final String URL = "jdbc:postgresql://localhost:5432/tartaruga_cometa";
private static final String USER = "seu_usuario";
private static final String PASSWORD = "sua_senha";
```

 ## 🚀 Deploy no Apache Tomcat
### 📌 Pré-requisitos

- JDK 8 ou superior
- Apache Tomcat 8+

## ▶️ Passos para Deploy

1. Clone o projeto:
git clone https://github.com/seu-usuario/TartarugaCometa.git
2. Configure o Apache Tomcat no ambiente de desenvolvimento
3. Execute o projeto no servidor

## 🌐 Acesso à Aplicação

Após o deploy, acesse no navegador:

http://localhost:8080/TartarugaCometa

📍 Rotas Principais

Listar clientes:
/cliente?acao=listar


Listar produtos:
/produto?acao=listar


Listar entregas:
/entrega?acao=listar
