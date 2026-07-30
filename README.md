# 🚀 Projeto dbt Northwind (Fins Didáticos)

> 🎓 **Nota sobre o projeto:** Este repositório é um **projeto inicial voltado exclusivamente para fins de aprendizado e consolidação de conhecimentos sobre dbt (Data Build Tool)** e engenharia de dados.

---

## 📌 Visão Geral

Este projeto consiste na estruturação e transformação de dados utilizando o **dbt (Data Build Tool)** sobre o dataset **Northwind Trader** (sistema de vendas, produtos, clientes, pedidos e fornecedores).

O objetivo principal é praticar o fluxo completo de **Analytics Engineering**:
- Organização do repositório e ambiente de desenvolvimento.
- Padronização e limpeza de dados brutos.
- Aplicação de regras de negócio em camadas intermediárias.
- Construção de Data Marts (tabelas fato e dimensão) prontos para consumo e relatórios.

---

## 🛠️ Tecnologias Utilizadas

- **[dbt-postgres](https://www.getdbt.com/)** (`>=1.11.0`): Ferramenta de transformação de dados e modelagem SQL.
- **[PostgreSQL](https://www.postgresql.org/)**: Banco de dados relacional / Data Warehouse para execução das queries.
- **[Poetry](https://python-poetry.org/)**: Gerenciador de dependências e ambientes virtuais em Python.
- **Python** (`>=3.12`): Ambiente de suporte para execução do dbt.

---

## 🏗️ Arquitetura e Estrutura de Camadas

O projeto dbt segue a organização modular em camadas dentro do diretório `northwind/models`:

```text
northwind/models/
├── raw/            # Espelhamento inicial das fontes brutas
├── staging/        # Padronização de nomes, casts de tipos de dados e limpezas iniciais
├── intermediate/   # Junções (joins) e lógica de negócios intermediária
└── mart/           # Camada Gold (Data Marts) orientada a consumo/BI (materializada como tabela)
```

### Materializações configuradas no `dbt_project.yml`:
- **`raw`**, **`staging`**, **`intermediate`**: Criadas como Views para consultas dinâmicas.
- **`mart`**: Criadas como Tabelas no schema `gold` para otimização de leitura.

---

## 🚀 Como Executar o Projeto Localmente

### 1. Pré-requisitos
- Python 3.12+ instalado.
- [Poetry](https://python-poetry.org/) instalado.
- Instância do PostgreSQL rodando com a base de dados Northwind.

### 2. Criar a Base de Dados Northwind no PostgreSQL
Para facilitar a replicação do projeto, o repositório inclui o script SQL completo no arquivo [`northwind.sql`](file:///p:/jornada%20dados/dbt_northwind/northwind.sql) na raiz do projeto.

Execute o script em seu PostgreSQL para criar a estrutura e popular todas as tabelas brutas da base Northwind:

```bash
# Exemplo de execução via psql:
psql -h localhost -U seu_usuario -d seu_banco -f northwind.sql
```
> 💡 *Você também pode abrir o arquivo `northwind.sql` e executá-lo em um cliente SQL de sua preferência (ex: DBeaver, pgAdmin, VS Code).*

### 3. Instalar Dependências e Ativar Ambiente Virtual
```bash
# Na raiz do projeto, instale as dependências via Poetry
poetry install

# Ative o ambiente virtual
poetry shell
```

### 4. Configurar Conexão no `profiles.yml`
Certifique-se de ter a configuração do perfil `northwind` definida no seu `profiles.yml` (localizado em `~/.dbt/profiles.yml` ou `C:\Users\<seu-usuario>\.dbt\profiles.yml`):

```yaml
northwind:
  target: dev
  outputs:
    dev:
      type: postgres
      host: localhost
      port: 5432
      user: seu_usuario
      password: sua_senha
      dbname: seu_banco
      schema: public
      threads: 4
```

### 5. Comandos Essenciais do dbt
Navegue até a pasta do projeto dbt (`northwind`):

```bash
cd northwind

# Verificar a conexão com o banco de dados
dbt debug

# Carregar seeds em CSV (se houver)
dbt seed

# Executar a compilação e criação dos modelos SQL
dbt run

# Executar testes de qualidade de dados
dbt test

# Gerar e visualizar a documentação interativa do projeto
dbt docs generate
dbt docs serve
```

---

## 📚 Aprendizados e Boas Práticas Praticadas

Neste projeto didático são praticados conceitos fundamentais de **Analytics Engineering**:
1. **Linhagem de Dados (DAG)**: Encadeamento modular de transformações via `ref(...)`.
2. **Qualidade de Dados**: Validações com testes automatizados (`not_null`, `unique`, etc.).
3. **Modelagem por Camadas**: Separação clara entre Staging, Intermediate e Mart (Arquitetura em camadas).
4. **Documentação Viva**: Documentação de tabelas e colunas centralizada nos arquivos de configuração YAML.

---

## 📄 Licença e Uso

Este projeto tem fins estritamente **educacionais e de estudo**. Fique à vontade para consultar, reutilizar e adaptar para seus aprendizados em dbt!
