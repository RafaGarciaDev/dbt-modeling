# 📊 Modelagem de Dados com dbt

Projeto dbt completo com modelos SQL, testes, documentação e CI/CD para transformação de dados.

## ✨ Funcionalidades

- **Modelos dbt**: Staging, intermediate, marts
- **Testes SQL**: Data quality checks
- **Documentação**: YAML e schema.yml
- **Macros**: Reutilização de lógica
- **Seeds**: Dados de referência
- **Snapshots**: Histórico de mudanças
- **CI/CD**: Integração com GitHub

## 🛠️ Tecnologias

- **dbt Core**: Transform your data
- **PostgreSQL/Snowflake**: Data warehouse
- **Python**: Hooks customizados
- **GitHub Actions**: CI/CD

## 🚀 Como Executar

```bash
# Instalar dbt
pip install dbt-postgres

# Inicializar projeto
dbt init my_project

# Executar modelos
dbt run

# Executar testes
dbt test

# Gerar documentação
dbt docs generate

# Criar snapshots
dbt snapshot

# Limpar artefatos
dbt clean
```

## 📁 Estrutura

```
dbt_project/
├── models/
│   ├── staging/          # Modelos de staging
│   ├── intermediate/     # Modelos intermediários
│   └── marts/           # Modelos finais
├── tests/               # Testes SQL
├── macros/              # Macros customizadas
├── seeds/               # Dados de referência
├── snapshots/           # Histórico
├── dbt_project.yml      # Configuração
└── README.md
```

## 💡 Exemplo Modelo

```sql
-- models/marts/fact_sales.sql
{{ config(materialized='table') }}

SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    ROW_NUMBER() OVER (ORDER BY order_date) as order_rank
FROM {{ ref('stg_orders') }}
WHERE status = 'completed'
```

## 🧪 Testes

```yaml
models:
  - name: fact_sales
    columns:
      - name: order_id
        tests:
          - unique
          - not_null
      - name: total_amount
        tests:
          - dbt_expectations.expect_column_values_to_be_positive
```

## 📈 Recursos

- [dbt Documentation](https://docs.getdbt.com)
- [dbt Community](https://community.getdbt.com)

## 📝 Licença

MIT License

---

⭐ Se este projeto foi útil, deixe uma star!
