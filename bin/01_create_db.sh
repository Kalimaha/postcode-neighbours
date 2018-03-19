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

echo "======================= 03 - Install PostGIS extension for Test DB: START"
docker exec surroundingsuburbs_db_1 psql -c "CREATE EXTENSION postgis;" app_test
docker exec surroundingsuburbs_db_1 psql -c "CREATE EXTENSION postgis_topology;" app_test
docker exec surroundingsuburbs_db_1 psql -c "SELECT PostGIS_full_version();" app_test
echo "======================== 03 - Install PostGIS extension for Test DB: DONE"

echo
echo
echo

echo "================ 04 - Install PostGIS extension for Development DB: START"
docker exec surroundingsuburbs_db_1 psql -c "CREATE EXTENSION postgis;" app_development
docker exec surroundingsuburbs_db_1 psql -c "CREATE EXTENSION postgis_topology;" app_development
docker exec surroundingsuburbs_db_1 psql -c "SELECT PostGIS_full_version();" app_development
echo "================= 04 - Install PostGIS extension for Development DB: DONE"

echo
echo
echo

echo "==================================== 05 - Store layer into Test DB: START"
docker exec surroundingsuburbs_db_1 ogr2ogr -append -f "PostgreSQL" PG:"dbname=app_test" suburbs.shp -nln suburbs
echo "===================================== 05 - Store layer into Test DB: DONE"

echo
echo
echo

echo "============================= 06 - Store layer into Development DB: START"
docker exec surroundingsuburbs_db_1 ogr2ogr -append -f "PostgreSQL" PG:"dbname=app_development" suburbs.shp -nln suburbs
echo "============================== 06 - Store layer into Development DB: DONE"

echo
echo
echo
