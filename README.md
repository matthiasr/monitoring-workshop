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

To save time and the conference WiFi, please ensure that you have [Docker](https://docker.com) installed and run

    ./prepare.sh

from this repository. This will print your Docker version and pull a few images that we will need during the workshop.

## Part 1: An App

The [example application](example_golang/) is a Go application that simulates a web service. It opens an HTTP port with a simple API. It also generates load against this API by sending additional requests.

Start the app with

    docker-compose up -d

and find out the port it is exposed on with

    docker ps

The output should look like

    CONTAINER ID        IMAGE                     COMMAND                  CREATED             STATUS              PORTS                     NAMES
    dc167f6ee1b6        monitoringworkshop_app    "go-wrapper run"         7 seconds ago       Up 6 seconds        0.0.0.0:8080->8080/tcp   monitoringworkshop_app_1

From this you can see that the application is exposed at port 8080 of the machine running Docker. The IP depends on the variant of Docker you are running. For Docker Toolbox, run `docker-machine ip` and note the IP; in everything that follows substitute this IP for "localhost". For Docker For Mac or on native Linux, the IP is 127.0.0.1. Open <http://localhost:8080> in your browser. Follow the link to the metric page to see the metrics the application is currently exposing.

### Push vs. Pull

Prometheus follows the _pull model_ for monitoring. In this model, the monitoring server knows about the application instances and pulls metrics from them. In the _push model_, the application knows where the monitoring server is and sends metrics there.

Our example application exposes metrics about itself on the `/metrics` path. It does not care who or what requests them.

Audience discussion:

* name a push based monitoring system
* what are the trade-offs between the two models?

### Counters

Prometheus uses _counters_ as the primary metric wherever possible. Other metrics, like request rates, are derived from that at a later time.

Look for the metric `codelab_api_request_duration_seconds_count{method="GET",path="/",status="200"}` on the metric page. In a separate tab, reload the index page a few times, then reload the metrics page and watch how the request count increases.

Audience discussion:

* What are the benefits of recording counts instead of request rates? (Hint: if a request happens while noone is measuring, did the request really happen?)

### Label-value metrics model

In Prometheus, all metrics have a _name_ and 0 or more _label-value-pairs_. In the metric above, the name is `codelab_api_request_duration_seconds_count`, and the labels are `method`, `path` and `status`.
