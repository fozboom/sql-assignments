# Database Homework - EPIC Institute of Technology (EPAM)

## Structure

- [`sql/task-*.sql`](./sql/) - SQL queries for each assignment
- [`docs/solution.md`](./docs/solution.md) - solutions and results
- [`postgres/docker-world-pg/`](./postgres/docker-world-pg/docker-compose.yml) - Docker Compose for World database
- [`postgres/docker-aw-pg/`](./postgres/docker-aw-pg/docker-compose.yml) - Docker Compose for AdventureWorks database

## Databases

- **[World](./docker/docker-world-pg/)** - countries, cities, languages data
- **[AdventureWorks](./docker/docker-aw-pg/)** - Microsoft demo database

## Setup with Docker

### Start world database

```bash
cd docker/docker-world-pg
docker compose up -d
```

### Start AdventureWorks database

```bash
cd docker/docker-aw-pg
docker compose up -d
```

## Techniques Used

- Common Table Expressions (CTE)
- Recursive queries
- Window functions
- Statistical functions
- Correlation analysis
