# Monitoring Workshop at [Containerdays Hamburg](http://www.containerdays.de/)

## Abstract

Container environments make it easy to deploy hundreds of microservices in today’s infrastructures. Monitoring thousands of metrics efficiently introduces new challenges to not lose insight, avoid alert fatigue and maintain a high development velocity. In this talk we’ll present an overview of important metrics including the 4 golden signals, discuss strategies to organize alerting efficiently, give insight into SoundCloud’s monitoring history and highlight a few success and failure stories.
Monitoring is the foundation of reliable products, we hope to provide practical ideas and interesting approaches to achieve that in modern container environments.

## Structure

This is a hands-on workshop. We will bring up an example application using [Docker Compose](https://www.docker.com/products/docker-compose), and then step by step add the components of a modern monitoring infrastructure using Prometheus and Grafana.

For each part, you will check out the corresponding tag of this repository. Each tag contains an example for the results of the previous parts.

# Walkthrough

## Part 0: Preparation

To participate actively in this workshop, you will need to bring a laptop.

To save time and the conference WiFi, please ensure that you have [Docker](https://docker.com) and [Docker Compose](https://docs.docker.com/compose/) installed, then run

    ./prepare.sh

from this repository. This will print your Docker version and pull a few images that we will need during the workshop.

Run

    git checkout part01

to continue.
