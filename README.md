# 📊 Modelagem de Dados com dbt

Projeto dbt completo com modelos SQL, testes, documentação e CI/CD para transformação de dados.

## ✨ Funcionalidades

- **Modelos dbt**: Staging, intermediate, marts
- **Testes SQL**: Data quality checks customizados
- **Documentação**: YAML e schema.yml por camada
- **Macros**: Reutilização de lógica SQL
- **Seeds**: Dados de referência (status de pedidos)
- **Snapshots**: Histórico de mudanças (SCD Type 2)
- **CI/CD**: Integração com GitHub Actions

## 🛠️ Tecnologias

- **dbt Core 1.7.0**
- **PostgreSQL**: Data warehouse
- **Python**: Hooks customizados
- **GitHub Actions**: CI/CD

## 🚀 Como Executar
```bash
# Instalar dependências
pip install -r requirements.txt

# Configurar variáveis de ambiente
export DB_HOST="localhost"
export DB_USER="postgres"
export DB_PASSWORD="sua-senha"
export DB_NAME="analytics"

# Copiar profiles.yml para a home do dbt
cp profiles.yml ~/.dbt/profiles.yml

# Verificar conexão
dbt debug

# Carregar seeds
dbt seed

# Executar modelos
dbt run

# Executar testes
dbt test

# Gerar documentação
dbt docs generate
dbt docs serve

# Criar snapshots
dbt snapshot

# Limpar artefatos
dbt clean
```

## 📁 Estrutura
```
dbt_project/
├── models/
│   ├── staging/
│   │   ├── stg_orders.sql           # Limpeza e tipagem dos pedidos brutos
│   │   └── schema.yml               # Testes e documentação do staging
│   ├── intermediate/
│   │   └── int_orders_enriched.sql  # Pedidos enriquecidos com métricas
│   └── marts/
│       ├── dim_customers.sql        # Dimensão de clientes
│       ├── fct_orders.sql           # Fato de pedidos
│       └── schema.yml               # Testes e documentação dos marts
├── tests/
│   └── assert_positive_amounts.sql  # Teste: valores sempre positivos
├── macros/
│   └── generate_surrogate_key.sql   # Macros reutilizáveis
├── seeds/
│   └── order_status.csv             # Tabela de referência de status
├── snapshots/
│   └── orders_snapshot.sql          # Histórico SCD Type 2 de pedidos
├── profiles.yml                     # Configuração de conexão (dev/prod)
├── dbt_project.yml                  # Configuração do projeto
├── requirements.txt                 # Dependências Python
├── .gitignore                       # Arquivos ignorados pelo Git
└── README.md
```

## 🔄 Fluxo de Dados
```
raw_data.orders (source)
    │
    ▼
stg_orders (staging/view)
    │
    ▼
int_orders_enriched (intermediate/table)
    │
    ├──▶ dim_customers (marts/table)
    │
    └──▶ fct_orders (marts/table)
```

## 🧪 Testes

| Teste | Arquivo | O que valida |
|---|---|---|
| `unique` + `not_null` | `schema.yml` | Chaves primárias íntegras |
| `accepted_values` | `schema.yml` | Status válidos |
| `assert_positive_amounts` | `tests/` | Valores de pedido > 0 |

## 💡 Macros Disponíveis

| Macro | Descrição |
|---|---|
| `generate_surrogate_key` | Gera chave surrogate via MD5 |
| `cents_to_dollars` | Converte centavos para reais/dólares |
| `date_spine` | Gera série de datas |
| `safe_divide` | Divisão sem erro de divisão por zero |

## 🌱 Seeds

| Arquivo | Descrição |
|---|---|
| `order_status.csv` | Tabela de referência de status de pedidos |

## 📸 Snapshots

| Arquivo | Estratégia | Descrição |
|---|---|---|
| `orders_snapshot.sql` | `timestamp` | Histórico SCD Type 2 dos pedidos |

## 📈 Recursos

- [dbt Documentation](https://docs.getdbt.com)
- [dbt Community](https://community.getdbt.com)
- [dbt Best Practices](https://docs.getdbt.com/guides/best-practices)

## 📝 Licença

MIT License

---

⭐ Se este projeto foi útil, deixe uma star!
⭐ Se este projeto foi útil, deixe uma star!
