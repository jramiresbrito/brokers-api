# @markup markdown

# Brokers-API

**This repository has an Academic purpose only.**
The Brokers-API works together with the [Exchange-API](https://github.com/jramiresbrito/exchange-api) in order to allow the
negotiation of Assets.

## Software versions

- Ruby 2.6.6p146
- Rails 6.0.4.1

## Setup

This software was created only to be used in development environment.
Although it is very easy to add, test and production environments are not available.

In order to run the software you will need docker and docker-compose which can be found in:
* [Docker](https://docs.docker.com/install/)
* [Docker Compose](https://docs.docker.com/compose/install/)

A script to manage the containers is available. Therefore, after installing
both **docker** and **docker-compose**, run the following command:
```sh
./scripts/development start
```
> Obs: all commands may require sudo if your user does not belong
to the [docker group](https://docs.docker.com/install/linux/linux-postinstall/)

To list all running containers, run:
```sh
docker ps
```

You should see a list of containers, including the following ones:
* brokers-rails - the main container that runs the rails server. It binds
the port 3000 from localhost.
* brokers-mongo - the only container of MongoDB, the service's database.
It binds the localhost's port 27017, which is the default port for MongoDB
in most OSs. Make sure you are not running any local MongoDB service.
* brokers-rabbitmq - message broker used for asynchronous message between
services. It expose several ports, but the main connections are performed
to port 5672. An Web page for admins is available in port 15672. You can acess
it using the default credentials `guest:guest`.
* brokers-hutch - the container responsible to send messages using rabbitmq
* brokers-docs - a server that provides the code documentation.
It is accessible through localhost's port 8808.
* brokers-mailcatcher - Web UI to catch emails in development environment.
Currently we send only a few emails, mainly when a new account is created or to get the
password recovery token. In the future I'm planning to send some reports via emails.
It runs in port 1080.

Also, the docker-compose will use the external newtork named **brokers-bridge** created
by the [Brokers-API](https://github.com/jramiresbrito/brokers-api).

### Atention ⚠
Please make sure **all containers are up and running**. You can manually run a container
if it doesn't work automatically using the provided script.
> Obs: You may need to wait a bit until run the hutch container. As it lies on rabbitmq container, it need to wait until the rabbitmq is properlly running. I'll improve the starting script to ensure that (one day 😛).


## Using the API

A [Insomnia](https://insomnia.rest/) json is [available](https://github.com/jramiresbrito/brokers-api/blob/master/insomnia_bolsa_de_valores.json) in the root of both API's.
After import the data you can easily run requests using the Insomnia software.
If you prefer other softwares, such as [Postman](https://www.postman.com/), you can
create your own collections based on the provided json file.