# Apache Exporter for Prometheus

Exports apache mod_status statistics via HTTP for Prometheus consumption.

An update of the `apache_exporter` script from https://github.com/neezgee/apache_exporter to work with the latest Prometheus go-lang API (as at October 2016 - 1.3beta).

## Building

Checkout to a local directory:

    git clone https://github.com/craigmj/apache_exporter.git

cd into the directory and, with an installed version of golang (https://golang.org):

    cd apache_exporter
    ./build.sh

You should now have a working `bin/apache_exporter`

## Installation (systemd)

Once the binary is built, you need to auto-start it on your box.

With my apache_exporter checked out to `/opt/apache_exporter`, create this systemd unit script in `/lib/systemd/system/apache_exporter.service`

    [Unit]
    Description=apache_exporter exports apache stats to prometheus
    [Install]
    WantedBy=multi-user.target
    [Service]
    Type=simple
    ExecStart=/opt/apache_exporter/bin/apache_exporter

Start apache_exporter:

    sudo systemctl daemon-reload
    sudo systemctl enable apache_exporter.service
    sudo systemctl start apache_exporter.service

Check on it:

    sudo systemctl status apache_exporter.service

## Installation (prometheus)

I add this to the `scrape_configs` section of my `prometheus.yml` file:

    - job_name: "apache"
      scrape_interval: "15s"
      static_configs:
      - targets: ['localhost:9117']

(see `prometheus.yml` for my example prometheus.yml file)

## Installation (original article)

The original code suggested:

"With working golang environment it can be built with `go get`.  There is a [good article](https://machineperson.github.io/monitoring/2016/01/04/exporting-apache-metrics-to-prometheus.html) with build HOWTO and usage example."

Note, though, that the prometheus config described on this link does not work with the latest (as at October 2016) version of prometheus (1.3beta).

## Help on flags:

```
  -insecure
    	Ignore server certificate if using https (default false)
  -log.level value
    	Only log messages with the given severity or above. Valid levels: [debug, info, warn, error, fatal, panic]. (default info)
  -scrape_uri string
    	URI to apache stub status page (default "http://localhost/server-status/?auto")
  -telemetry.address string
    	Address on which to expose metrics. (default ":9117")
  -telemetry.endpoint string
    	Path under which to expose metrics. (default "/metrics")
```

Tested on Apache 2.2 and Apache 2.4.


