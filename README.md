# 📚 Biblioteca Digital - Sistema CRUD de Livros

<div align="center">

![Java](https://img.shields.io/badge/Java-11+-orange?style=for-the-badge&logo=java)
![JSP](https://img.shields.io/badge/JSP-2.3-blue?style=for-the-badge&logo=java)
![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Maven](https://img.shields.io/badge/Maven-3.6+-C71A36?style=for-the-badge&logo=apache-maven)
![Tomcat](https://img.shields.io/badge/Tomcat-9.0+-F8DC75?style=for-the-badge&logo=apache-tomcat&logoColor=black)

### Sistema completo de gerenciamento de acervo literário desenvolvido em Java Server Pages

[Sobre](#-sobre-o-projeto) • [Funcionalidades](#-funcionalidades) • [Instalação](#-instalação-passo-a-passo) • [Como Usar](#-como-usar) • [Tecnologias](#-tecnologias)

</div>

---

## 📖 Sobre o Projeto

Sistema web desenvolvido como projeto acadêmico para gerenciamento de biblioteca digital. Implementa todas as operações **CRUD** (Create, Read, Update, Delete) para controle completo do acervo de livros.

O projeto utiliza o **framework AFDAL/ALDAL**, desenvolvido pelo Prof. Mauricio Asenjo, que oferece uma camada de abstração para operações de banco de dados utilizando **Java Reflection**.

### 🎯 Objetivos do Projeto

- Aplicar conceitos de programação web com **JSP**
- Implementar operações CRUD completas
- Utilizar banco de dados relacional (**MySQL**)
- Desenvolver interface responsiva e moderna
- Aplicar validações de dados no frontend e backend

---

## ✨ Funcionalidades

### 1. 📋 Listagem de Livros (READ)

**Tela principal do sistema**

- ✅ Visualização de todos os livros cadastrados em formato de tabela
- ✅ **Ordenação automática** por ID numérico (001, 002, 003...)
- ✅ **Ícones de categorização** por período de publicação:
  - 📖 **Livros antigos** (antes de 2000)
  - 📗 **Livros médios** (2000-2019)
  - 📘 **Livros recentes** (2020+)
- ✅ **Contador de livros** cadastrados no sistema
- ✅ Design responsivo com gradientes modernos

**Campos exibidos:**
- ID do livro
- Título (com ícone visual)
- Autor
- Editora
- Ano de publicação
- Localização física (prateleira)
- Botões de ação (Editar/Excluir)

---

### 2. 🔍 Busca Inteligente

**Sistema de filtragem em tempo real**

- ✅ Campo de busca no topo da página
- ✅ Filtra por **título**, **autor** ou **ID**
- ✅ Busca parcial (não precisa digitar o nome completo)
- ✅ Botão "Limpar" para resetar a busca
- ✅ Feedback visual quando não há resultados

**Exemplo de uso:**
- Digite "Clean" → Encontra "Clean Code"
- Digite "Martin" → Encontra todos os livros de autores com "Martin"
- Digite "001" → Encontra o livro com ID 001

---

### 3. ➕ Cadastro de Livros (CREATE)

**Formulário completo para adicionar novos livros**

**Campos obrigatórios:**
- 📋 **ID** - Identificador único do livro
- 📖 **Título** - Nome do livro
- ✍️ **Autor** - Nome do autor
- 🏢 **Editora** - Nome da editora
- 📅 **Ano** - Ano de publicação
- 📍 **Localização** - Prateleira onde está armazenado

**Recursos especiais:**

✅ **Gerador automático de ID**
- Sistema sugere o próximo ID disponível
- Exemplo: Se o último ID é 005, sugere 006
- Usuário pode aceitar ou digitar outro ID

✅ **Validações implementadas:**

1. **ID único** - Não permite cadastrar livro com ID já existente
2. **Localização única** - Impede dois livros na mesma prateleira
3. **Validação de ano** - Aceita apenas anos entre 1500 e 2025
4. **Campos obrigatórios** - Todos os campos devem ser preenchidos

✅ **Feedback visual:**
- Mensagens de erro em vermelho
- Formulário mantém dados preenchidos em caso de erro
- Redirecionamento automático após sucesso

---

### 4. ✏️ Edição de Livros (UPDATE)

**Atualização de informações de livros existentes**

**Como funciona:**
1. Clique no botão "✏️ Editar" na linha do livro desejado
2. Formulário é pré-preenchido com os dados atuais
3. Campo **ID** fica desabilitado (não pode ser alterado)
4. Modifique os campos desejados
5. Clique em "💾 Atualizar Livro"

**Validações na edição:**
- ✅ Localização única (permite manter a mesma, mas impede usar localização de outro livro)
- ✅ Validação de ano (1500-2025)
- ✅ Mensagem de sucesso após atualização

---

### 5. 🗑️ Exclusão de Livros (DELETE)

**Remoção segura de livros do acervo**

**Fluxo de exclusão:**
1. Clique no botão "🗑️ Excluir" na linha do livro
2. Navegador exibe confirmação JavaScript
3. Usuário confirma ou cancela
4. Sistema remove o livro do banco de dados
5. Mensagem de sucesso é exibida
6. Redirecionamento automático para a lista

---

### 6. 📊 Dashboard e Estatísticas

- 📚 **Contador total** de livros cadastrados
- 🎨 **Layout moderno** com gradientes
- 📱 **Interface responsiva**
- ⚡ **Performance otimizada**

---

## 🛠️ Tecnologias Utilizadas

### Backend
- ☕ **Java 11+** - Linguagem de programação
- 📄 **JSP 2.3** - JavaServer Pages
- 🔌 **JDBC** - Conexão com banco de dados
- 🏗️ **Framework AFDAL/ALDAL** - Data Access Layer customizado

### Frontend
- 🌐 **HTML5** - Estrutura das páginas
- 🎨 **CSS3** - Estilização e design
- ⚡ **JavaScript** - Interatividade

### Banco de Dados
- 🗄️ **MySQL 8.0+** - Sistema gerenciador

### Build & Deploy
- 📦 **Apache Maven** - Gerenciamento de dependências
- 🚀 **Apache Tomcat 9.0+** - Servidor de aplicação

---

## 📋 Pré-requisitos

| Software | Versão Mínima | Link |
|----------|---------------|------|
| ☕ Java JDK | 11+ | [Adoptium](https://adoptium.net/) |
| 🗄️ MySQL | 8.0+ | [MySQL](https://dev.mysql.com/downloads/mysql/) |
| 🚀 Tomcat | 9.0+ | [Apache Tomcat](https://tomcat.apache.org/download-90.cgi) |
| 💻 NetBeans | 12+ | [NetBeans](https://netbeans.apache.org/download/) |

---

## 🚀 Instalação Passo a Passo

### PASSO 1: Clonar o Repositório

```bash
git clone https://github.com/EnzoVarani/desafioAsenjo2.git
cd desafioAsenjo2
```

---

### PASSO 2: Configurar o Banco de Dados

#### 2.1 - Acessar o MySQL

```bash
mysql -u root -p
```

#### 2.2 - Executar Script SQL

**Opção A - Via arquivo:**
```sql
source caminho/para/sql/create_database.sql
```

**Opção B - Manualmente:**
```sql
CREATE DATABASE biblioteca_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE biblioteca_db;

CREATE TABLE TabLivro (
    id VARCHAR(255) NOT NULL PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    autor VARCHAR(255) NOT NULL,
    editora VARCHAR(255) NOT NULL,
    ano VARCHAR(255) NOT NULL,
    localizacao VARCHAR(255) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO TabLivro VALUES
('001', 'Clean Code', 'Robert C. Martin', 'Alta Books', '2009', 'Prateleira A-01'),
('002', 'Design Patterns', 'Gang of Four', 'Addison-Wesley', '1994', 'Prateleira A-02'),
('003', 'Refactoring', 'Martin Fowler', 'Addison-Wesley', '1999', 'Prateleira A-03'),
('004', 'The Pragmatic Programmer', 'Andrew Hunt', 'Addison-Wesley', '1999', 'Prateleira B-01'),
('005', 'Introduction to Algorithms', 'Thomas H. Cormen', 'MIT Press', '2009', 'Prateleira B-02');
```

#### 2.3 - Verificar

```sql
SELECT * FROM TabLivro;
```

Você deve ver **5 livros** cadastrados.

---

### PASSO 3: Configurar Credenciais

**Edite:** `src/main/java/tpsemana11/AFDAL.java`

**Linhas 18-20:**
```java
private static final String DB_URL = "jdbc:mysql://localhost:3306/biblioteca_db";
private static final String DB_USER = "root";
private static final String DB_PASSWORD = "SUA_SENHA";  // ← ALTERE
```

---

### PASSO 4: Compilar o Projeto

#### Usando NetBeans:

1. Abra o NetBeans
2. `File` → `Open Project`
3. Selecione a pasta do projeto
4. Botão direito no projeto → `Clean and Build`
5. Aguarde a compilação

✅ **BUILD SUCCESS** deve aparecer

#### Usando Maven (terminal):

```bash
mvn clean install
```

---

### PASSO 5: Configurar Tomcat

#### No NetBeans:

1. `Tools` → `Servers` → `Add Server`
2. Selecione `Apache Tomcat or TomEE`
3. Clique `Next`
4. **Server Location**: Navegue até pasta do Tomcat
5. **Username/Password**: Deixe em branco ou use `admin`
6. Marque: ✅ `Create user if it does not exist`
7. Clique `Finish`

---

### PASSO 6: Executar o Projeto

#### No NetBeans:
- Botão direito no projeto → `Run`

#### Manualmente:
1. Copie o `.war` de `target/` para `tomcat/webapps/`
2. Inicie o Tomcat: `bin/startup.bat` (Windows) ou `bin/startup.sh` (Linux/Mac)
3. Acesse: `http://localhost:8080/crud-livros-jsp/`

---

## 📁 Estrutura do Projeto

```
biblioteca-digital/
├── src/main/
│   ├── java/tpsemana11/
│   │   ├── AFDAL.java          # Framework - Access Layer
│   │   ├── ALDAL.java          # Framework - Logic Layer
│   │   ├── Erro.java           # Error Handler
│   │   └── Livro.java          # Entity Model
│   └── webapp/
│       ├── index.jsp           # Listagem
│       ├── inserir.jsp         # Cadastro
│       ├── editar.jsp          # Edição
│       ├── excluir.jsp         # Exclusão
│       └── WEB-INF/web.xml     # Config
├── sql/create_database.sql     # Script SQL
├── pom.xml                     # Maven config
└── README.md
```

---

## 💻 Como Usar

### Listar Livros
- Acesse a página inicial
- Use a busca para filtrar

### Adicionar Livro
1. Clique em "➕ Novo Livro"
2. Preencha os campos
3. ID será sugerido automaticamente
4. Clique em "💾 Salvar"

### Editar Livro
1. Clique em "✏️ Editar"
2. Modifique os campos
3. Clique em "💾 Atualizar"

### Excluir Livro
1. Clique em "🗑️ Excluir"
2. Confirme a exclusão

---

## 🔧 Solução de Problemas

### Erro: ClassNotFoundException
**Solução:** `mvn clean install`

### Erro: Access denied
**Solução:** Verifique usuário/senha em `AFDAL.java`

### Erro: Unknown database
**Solução:** Execute o script SQL de criação

### Erro: Porta 8080 ocupada
**Windows:**
```cmd
netstat -ano | findstr :8080
taskkill /PID [número] /F
```

**Linux/Mac:**
```bash
lsof -i :8080
kill -9 [PID]
```

---

## 🗄️ Modelo de Dados

### Tabela: TabLivro

| Campo | Tipo | Restrições |
|-------|------|------------|
| id | VARCHAR(255) | PRIMARY KEY |
| titulo | VARCHAR(255) | NOT NULL |
| autor | VARCHAR(255) | NOT NULL |
| editora | VARCHAR(255) | NOT NULL |
| ano | VARCHAR(255) | NOT NULL |
| localizacao | VARCHAR(255) | NOT NULL, UNIQUE |

---

## 🎓 Conceitos Aplicados

- ✅ **MVC Pattern** - Separação de camadas
- ✅ **DAO Pattern** - Data Access Object
- ✅ **Reflection** - Mapeamento objeto-relacional
- ✅ **CRUD Operations** - Create, Read, Update, Delete
- ✅ **Input Validation** - Frontend e backend
- ✅ **SQL Injection Prevention** - Via framework

---

## 👨‍💻 Autor

**Enzo Varani**

- GitHub: [@EnzoVarani](https://github.com/EnzoVarani)
- Email: enzo.varani@exemplo.com

---

## 🙏 Agradecimentos

- Prof. Mauricio Asenjo - Framework AFDAL/ALDAL
- CAMPS Santos - Ambiente de desenvolvimento

---

<div align="center">

### ⭐ Se este projeto foi útil, considere dar uma estrela!

**Desenvolvido com ☕ e 💙 por Enzo Varani**

</div>
