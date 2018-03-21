#! /bin/bash

echo "=================================================== 01 - Create DB: START"
docker-compose run web bundle exec rake db:create
echo "==================================================== 01 - Create DB: DONE"

yes '' | sed 3q

echo "================================================== 02 - Migrate DB: START"
docker-compose run web bundle exec rake db:migrate RAILS_ENV=test
docker-compose run web bundle exec rake db:migrate RAILS_ENV=development
echo "=================================================== 02 - Migrate DB: DONE"

yes '' | sed 3q

echo "======================= 03 - Install PostGIS extension for Test DB: START"
docker exec surroundingsuburbs_db_1 psql -c "CREATE EXTENSION postgis;" app_test
docker exec surroundingsuburbs_db_1 psql -c "CREATE EXTENSION postgis_topology;" app_test
docker exec surroundingsuburbs_db_1 psql -c "SELECT PostGIS_full_version();" app_test
echo "======================== 03 - Install PostGIS extension for Test DB: DONE"

yes '' | sed 3q

echo "================ 04 - Install PostGIS extension for Development DB: START"
docker exec surroundingsuburbs_db_1 psql -c "CREATE EXTENSION postgis;" app_development
docker exec surroundingsuburbs_db_1 psql -c "CREATE EXTENSION postgis_topology;" app_development
docker exec surroundingsuburbs_db_1 psql -c "SELECT PostGIS_full_version();" app_development
echo "================= 04 - Install PostGIS extension for Development DB: DONE"

yes '' | sed 3q

echo "==================================== 05 - Store layer into Test DB: START"
docker exec surroundingsuburbs_db_1 ogr2ogr -f "PostgreSQL" PG:"dbname=app_test" suburbs.shp -nln suburbs -nlt PROMOTE_TO_MULTI -overwrite
docker exec surroundingsuburbs_db_1 psql -c "SELECT COUNT(*) FROM suburbs;" app_test
echo "===================================== 05 - Store layer into Test DB: DONE"

yes '' | sed 3q

echo "============================= 06 - Store layer into Development DB: START"
docker exec surroundingsuburbs_db_1 ogr2ogr -f "PostgreSQL" PG:"dbname=app_development" suburbs.shp -nln suburbs -nlt PROMOTE_TO_MULTI -overwrite
docker exec surroundingsuburbs_db_1 psql -c "SELECT COUNT(*) FROM suburbs;" app_development
echo "============================== 06 - Store layer into Development DB: DONE"

yes '' | sed 3q

echo "======================================== 07 - Migrate non-gis data: START"
docker-compose run web bundle exec rake db:seed RAILS_ENV=development
docker exec surroundingsuburbs_db_1 psql -c "SELECT COUNT(*) FROM listings;" app_development
echo "========================================= 07 - Migrate non-gis data: DONE"

yes '' | sed 3q

echo "============================ 08 - Add centroids to suburbs in Test: START"
docker exec surroundingsuburbs_db_1 psql -c 'ALTER TABLE "suburbs" ADD lon double precision;' app_test
docker exec surroundingsuburbs_db_1 psql -c 'ALTER TABLE "suburbs" ADD lat double precision;' app_test
docker exec surroundingsuburbs_db_1 psql -c 'UPDATE "suburbs" SET lon = ST_X(ST_Centroid(wkb_geometry));' app_test
docker exec surroundingsuburbs_db_1 psql -c 'UPDATE "suburbs" SET lat = ST_Y(ST_Centroid(wkb_geometry));' app_test
echo "============================= 08 - Add centroids to suburbs in Test: DONE"

yes '' | sed 3q

echo "===================== 09 - Add centroids to suburbs in Development: START"
docker exec surroundingsuburbs_db_1 psql -c 'ALTER TABLE "suburbs" ADD lon double precision;' app_development
docker exec surroundingsuburbs_db_1 psql -c 'ALTER TABLE "suburbs" ADD lat double precision;' app_development
docker exec surroundingsuburbs_db_1 psql -c 'UPDATE "suburbs" SET lon = ST_X(ST_Centroid(wkb_geometry));' app_development
docker exec surroundingsuburbs_db_1 psql -c 'UPDATE "suburbs" SET lat = ST_Y(ST_Centroid(wkb_geometry));' app_development
echo "====================== 09 - Add centroids to suburbs in Development: DONE"

yes '' | sed 3q
