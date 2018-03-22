# Surrounding Suburbs

This is a project for REA's 30th REAio. The main goal is to find all the listings in a suburb selected by the user and to include in the result listings from surrounding suburbs as well. For example, if the user enters "_Torquay_", the search engine will return listings for Torquay, as well as Jan Juc, Bradlea and so forth. The core of this project is the search performed through PostGIS.

![demo](resources/images/demo.gif)

## Requirements

* Docker: please refer to the [installation guide](https://docs.docker.com/install/)
* Docker Compose: please refer to the [installation guide](https://docs.docker.com/compose/install/)

## Setup

Let's start by building the containers:

```
docker-compose build
```

After this, start the application:

```
docker-compose up
```

Now, in a __different tab__, create the DB by running the script:

```
./bin/create_and_seed_gis_db.s
```

You will also need some test data, so seed the DB with:

```
docker-compose run web bundle exec rake db:seed
```

After this, visit [http://localhost:3000/](http://localhost:3000/) to see the main (_and only_) page.
