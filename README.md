# Surrounding Suburbs

This project is a proof of concept to implement a DB search merging spatial and non-spatial data throug Postgis.

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
