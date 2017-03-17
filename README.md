Description

This project is a concourse pipeline based on the IaaSSmokeTest project. IaaSSmokeTest is an application to test network connectivity between two hosts over a configurable set of TCP/UDP ports.

Prerequisites

1. A running concourse installation and fly CLI.
1. The pipeline requires the use of a docker image that allows `ssh` and has `expect`. Connectivity to `http://hub.docker.com` from Concourse is needed to download this image.

Setup

1. Fork this repo and clone it to your machine
1. Create a configuration file for each host
  1. Use the `config_template.json` file as a template
  1. Rename the file `config_HOSTNAME.json`, where `HOSTNAME` is an ssh-reachable host address
1. Edit the configuration file
  1. Specify the remote host name and TCP/UDP ports to test
  1. Specify the local hosts' TCP/UDP ports used to listen for requests
1. Create a hosts file.
  1. Use the `hosts.template.yml` file as a template
  1. Rename the file to `hosts.yml`
  1. Replace the host1 and host2 values in the file with the appropriate values
1. Add pipeline to Concourse with the fly CLI
  1. Login to concourse server
    - e.g. `fly -t iaas-smoke-test login -c [concourse server url]`
  1. Add pipeline
    - e.g. `fly -t iaas-smoke-test set-pipeline -c pipeline.yml -l hosts.yml -p iaas-smoke-test`
  1. Unpause pipeline
    - e.g. `fly -t iaas-smoke-test unpause-pipeline -p iaas-smoke-test`
