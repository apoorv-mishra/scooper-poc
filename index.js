// There is source. There is destination.
// Scoop out a subset of data from source and
// dump into dest.

require('dotenv').config();
const knex = require('knex');
const { execSync } = require('child_process');

// Init
(() => {
	execSync(`pg_dump -h ${process.env.SOURCE_DB_HOST} -U ${process.env.SOURCE_DB_USER} ${process.env.SOURCE_DB_NAME} -s > source_schema_dump.sql`);
	execSync(`psql -h ${process.env.DEST_DB_HOST} -U ${process.env.DEST_DB_USER} -d ${process.env.DEST_DB_NAME} -p ${process.env.DEST_DB_PORT} -f source_schema_dump.sql`);
	execSync(`rm -f source_schema_dump.sql`);
})()

// Source
var knexSource = knex({
	client: 'pg',
	connection: {
		host : process.env.SOURCE_DB_HOST,
		port: process.env.SOURCE_DB_PORT,
		user : process.env.SOURCE_DB_USER,
		password : process.env.SOURCE_DB_PASS,
		database : process.env.SOURCE_DB_NAME 
	}
});

// Dest
var knexDest = knex({
	client: 'pg',
	connection: {
		host : process.env.DEST_DB_HOST,
		port: process.env.DEST_DB_PORT,
		user : process.env.DEST_DB_USER,
		password : process.env.DEST_DB_PASS,
		database : process.env.DEST_DB_NAME
	}
});

// Need a query like `select * from todos where id > 3`
async function scoop(table, clause, params) {
	if (!table) {
		return;
	}

	// Get foreign keys of tableName
	const fks = await knexSource.raw(`
		SELECT
			tc.table_schema, 
			tc.constraint_name, 
			tc.table_name, 
			kcu.column_name, 
			ccu.table_schema AS foreign_table_schema,
			ccu.table_name AS foreign_table_name,
			ccu.column_name AS foreign_column_name 
		FROM 
			information_schema.table_constraints AS tc 
			JOIN information_schema.key_column_usage AS kcu
			  ON tc.constraint_name = kcu.constraint_name
			  AND tc.table_schema = kcu.table_schema
			JOIN information_schema.constraint_column_usage AS ccu
			  ON ccu.constraint_name = tc.constraint_name
			  AND ccu.table_schema = tc.table_schema
		WHERE tc.constraint_type = 'FOREIGN KEY' AND tc.table_name='${table}';
	`);

	await asyncForEach(fks.rows, async (r) => {
		const rows = await knexSource.select(r.column_name).distinct().from(table).whereRaw(clause, params);
		if (!r) {
			await scoop();
		} else {
			await scoop(r.foreign_table_name, `${r.foreign_column_name} in (${rows.map(_ => '?').join(',')})`, rows.map(row => row[r.column_name]));
		}
	});

	// Seed data in the new database
	const dataToSeed = await knexSource.select('*').from(table).whereRaw(clause, params);
	console.log(knexDest(table).insert(dataToSeed).toString());
	await knexDest(table).insert(dataToSeed);
}

async function asyncForEach(array, callback) {
	for (let index = 0; index < array.length; index++) {
		await callback(array[index], index, array);
	}
}

(async () => {
	try {
		// TODO: Supply args from CLI
		await scoop('todos', 'user_id = ?', [1]);
	} catch(err) {
		console.log(err);
	} finally {
		await knexSource.destroy();
		await knexDest.destroy();
	}
})();
