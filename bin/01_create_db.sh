#! /bin/bash

echo "=================================================== 01 - Create DB: START"
docker-compose run web bundle exec rake db:create
echo "==================================================== 01 - Create DB: DONE"

echo
echo
echo

echo "================================================== 02 - Migrate DB: START"
docker-compose run web bundle exec rake db:migrate
echo "=================================================== 02 - Migrate DB: DONE"

echo
echo
echo

echo "=================================== 03 - Install PostGIS extension: START"
docker exec surroundingsuburbs_db_1 psql -c "CREATE EXTENSION postgis;"
docker exec surroundingsuburbs_db_1 psql -c "CREATE EXTENSION postgis_topology;"
docker exec surroundingsuburbs_db_1 psql -c "SELECT PostGIS_full_version();"
echo "==================================== 03 - Install PostGIS extension: DONE"

echo
echo
echo

echo "==================================== 04 - Store layer into Test DB: START"
docker exec surroundingsuburbs_db_1 ogr2ogr -append -f "PostgreSQL" PG:"dbname=app_test" victoria_suburbs.shp -nln victoria_suburbs
echo "===================================== 04 - Store layer into Test DB: DONE"

echo
echo
echo

echo "============================= 05 - Store layer into Development DB: START"
docker exec surroundingsuburbs_db_1 ogr2ogr -append -f "PostgreSQL" PG:"dbname=app_development" victoria_suburbs.shp -nln victoria_suburbs
echo "============================== 05 - Store layer into Development DB: DONE"

echo
echo
echo
