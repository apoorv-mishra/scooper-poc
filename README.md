# scooper-poc

### Prerequisites
* `docker`
* `docker-compose`
* `node`

### Usage
1. `git clone https://github.com/apoorv-mishra/scooper-poc.git && cd scooper-poc && npm install`
2. `mv .env.example .env && mv .env.docker.example .env.docker`
3. Specify all the required info in the corresponding `.env.*` files. Maintain the relations mentioned below,
```
POSTGRES_USER should be same as DEST_DB_HOST
POSTGRES_PASSWORD should be same as DEST_DB_PASS
POSTGRES_DB should be same as DEST_DB_NAME
```
4. `psql -h <SOURCE_DB_HOST> -U <SOURCE_DB_USER> -d <SOURCE_DB_NAME> -f dump.sql`
5. `npm start`

Run `psql -h <DEST_DB_HOST> -U <DEST_DB_USER> -d <DEST_DB_NAME>`, try `select * from users` and `select * from todos`. Let me know what you see! 
