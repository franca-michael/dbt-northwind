# 🚀 dbt Northwind Project (Educational / Learning Guide)

> 🎓 **Project Note:** This repository is an educational project designed for hands-on learning and mastering **dbt (Data Build Tool)** and **Analytics Engineering** best practices using the classic Northwind dataset.

---

## 📌 Project Overview

This project implements a complete modern data transformation pipeline using **dbt (Data Build Tool)** on top of a **PostgreSQL** database populated with the **Northwind Trader** dataset (sales, customers, orders, products, and suppliers).

The core objective is to practice end-to-end **Analytics Engineering**:
- Setting up a Python virtual environment and dbt project structure.
- Cleaning, standardizing, and casting raw relational data in the **Staging** layer.
- Applying business logic and calculations in the **Intermediate** layer.
- Preparing consumption-ready data models in the **Marts (Gold)** layer for BI and reporting.

---

## 🛠️ Tech Stack & Key Tools

- **[dbt-postgres](https://www.getdbt.com/)** (`>=1.11.0`): Data transformation and SQL modeling framework.
- **[PostgreSQL](https://www.postgresql.org/)**: Relational Database Management System serving as the Data Warehouse.
- **[Poetry](https://python-poetry.org/)**: Dependency management and Python virtual environment isolation.
- **Python** (`>=3.12`): Runtime environment supporting dbt dependencies.

---

## 🏗️ Data Architecture & Layered Modeling

The dbt project is organized into modular layers located inside [`northwind/models`](file:///p:/jornada%20dados/dbt_northwind/northwind/models):

```text
northwind/models/
├── staging/            # Staging Layer: Standardizes column names, casts data types, abstracts raw sources
│   └── crm/            # CRM Domain (Customers, Orders, etc.)
├── intermediate/       # Intermediate Layer: Business logic joins, metric calculations, and enrichments
│   └── crm/            # CRM Domain Transformations (e.g., shipping delays analysis)
└── marts/              # Gold/Mart Layer: Consolidates dimensional models & fact tables for BI consumption
```

### Materialization Strategy (`dbt_project.yml`):
- **`staging`**: Materialized as **Views** (`+materialized: view`) to maintain light, dynamic source abstraction without extra storage cost.
- **`intermediate`**: Materialized as **Views** (`+materialized: view`) for modular query building blocks.
- **`marts`**: Materialized as **Tables** (`+materialized: table`) in a dedicated `gold` schema (`+schema: gold`) to optimize query performance for analytical reporting tools.

---

## 🔍 Data Flow & Transformation Models

### 1. Raw Sources ([`_crm__sources.yml`](file:///p:/jornada%20dados/dbt_northwind/northwind/models/staging/crm/_crm__sources.yml))
Defines the connection to raw database tables (`customers`, `orders`) under the source `northwind_meq6`.

### 2. Staging Layer
- **[`stg_customer.sql`](file:///p:/jornada%20dados/dbt_northwind/northwind/models/staging/crm/stg_customer.sql)**: Selects raw customer data from source.
- **[`stg_orders.sql`](file:///p:/jornada%20dados/dbt_northwind/northwind/models/staging/crm/stg_orders.sql)**: Explicitly casts string IDs, dates, and freight amounts to proper data types (`VARCHAR`, `DATE`, `DECIMAL`).

### 3. Intermediate Layer
- **[`int_sell.sql`](file:///p:/jornada%20dados/dbt_northwind/northwind/models/intermediate/crm/int_sell.sql)**: Joins staged orders and customers to compute metrics such as delivery delay (`days_late`) using the `dbt.datediff` cross-database macro:
  ```sql
  {{ dbt.datediff('o.required_date', 'o.shipped_date', 'day') }} AS days_late
  ```

---

## 🚀 Step-by-Step Setup Guide

### 1. Prerequisites
Ensure you have the following installed on your machine:
- **Python 3.12+**
- **[Poetry](https://python-poetry.org/)**
- **PostgreSQL** instance running locally or on a remote server.

### 2. Populate PostgreSQL Database
The repository includes a full database dump script at [`northwind.sql`](file:///p:/jornada%20dados/dbt_northwind/northwind.sql).

Execute the script in PostgreSQL to initialize the tables and data:
```bash
# Example via psql CLI:
psql -h localhost -U your_user -d your_database -f northwind.sql
```
> 💡 *Or run the contents of [`northwind.sql`](file:///p:/jornada%20dados/dbt_northwind/northwind.sql) directly inside your preferred SQL client (e.g., DBeaver, pgAdmin, VS Code SQL tools).*

### 3. Install Dependencies & Activate Environment
From the root directory ([`dbt_northwind`](file:///p:/jornada%20dados/dbt_northwind)):

```bash
# Install dependencies specified in pyproject.toml
poetry install

# Activate the virtual environment
poetry shell
```

### 4. Configure `profiles.yml`
Create or edit your local dbt profile configuration at `~/.dbt/profiles.yml` (Linux/macOS) or `%USERPROFILE%\.dbt\profiles.yml` (Windows):

```yaml
northwind:
  target: dev
  outputs:
    dev:
      type: postgres
      host: localhost
      port: 5432
      user: your_postgres_user
      password: your_postgres_password
      dbname: your_database_name
      schema: public
      threads: 4
```

### 5. Execute dbt Commands
Navigate into the dbt project folder:

```bash
cd northwind
```

Run key dbt commands:

```bash
# 1. Test target database connectivity
dbt debug

# 2. Load seed files (if configured)
dbt seed

# 3. Compile SQL and create models in PostgreSQL
dbt run

# 4. Run automated data testing
dbt test

# 5. Generate and launch local documentation site
dbt docs generate
dbt docs serve
```

---

## 📚 Key Learning Outcomes & Best Practices

This project highlights core concepts of modern **Analytics Engineering**:

1. **DAG & Lineage graph**: Connecting transformation pipelines cleanly using `ref()` and `source()` references instead of hardcoded table names.
2. **Automated Testing**: Defining column-level data quality tests (`unique`, `not_null`) in YAML files (`_crm__models.yml`).
3. **Cross-Database Portability**: Utilizing dbt utilities (such as `dbt.datediff`) to avoid vendor-locked SQL syntax.
4. **Layer Separation**: Separating staging, intermediate transformations, and gold marts for scalability and maintainability.
5. **Environment Isolation**: Managing dependencies deterministically using Poetry.

---

## 📄 License & Usage

This repository is built strictly for **educational and learning purposes**. Feel free to fork, explore, adapt, and practice your dbt skills!
