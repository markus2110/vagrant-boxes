#!/bin/bash

# Import SQL Files from sql folder
SQL_FILE_PATH='/vagrant/sql-imports/*.sql'

for f in $SQL_FILE_PATH
do
	echo "Processing $f file..."
	sudo mysql --user=root --comments < $f
done
