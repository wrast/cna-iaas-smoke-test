# Description

This project is a concourse pipeline based on the [IaaSSmokeTest project](https://github.com/ECSTeam/IaaSSmokeTest). IaaSSmokeTest is an application to test network connectivity between two hosts over a configurable set of TCP/UDP ports.

You might want to set this pipeline up in order to ensure communication between 2 networks where firewall rules have (or haven't) been established. This could be a precursor to a larger application installation that needs connectivity over various TCP/UDP ports.

# Prerequisites

1. A running concourse installation and fly CLI.
1. The pipeline requires the use of a docker image that allows `ssh` and has `expect`. Connectivity to `http://hub.docker.com` from Concourse is needed to download this image.

# Setup

1. Fork this repo and clone it to your machine
2. Create a configuration file for each host
    1. Use the `config_template.json` file as a template
    2. Rename the file `config_HOSTNAME.json`, where `HOSTNAME` is an ssh-reachable host address
3. Edit the configuration file
    1. Specify the remote host name and TCP/UDP ports to test
    2. Specify the local hosts' TCP/UDP ports used to listen for requests
    3. One host's config file content should be the "inverse" of the other host's config file
4. Commit config files to github repo
    1. `git add config_*.json`
    2. `git commit`
    3. `git push`
4. Create a hosts file.
    1. Use the `hosts.template.yml` file as a template
    2. Rename the file to `hosts.yml`
    3. For `git_repo` enter forked github repo location from step 1 above
    3. Replace the `host1_*` and `host2_*` values in the file with the appropriate values
    4. This file should **not** be added to github since it contains credentials
5. Add pipeline to Concourse with the fly CLI
    1. Login to concourse server
        * e.g. `fly -t iaas-smoke-test login -c [concourse server url]`
    2. Add pipeline
        * e.g. `fly -t iaas-smoke-test set-pipeline -c pipeline.yml -l hosts.yml -p iaas-smoke-test`
    3. Unpause pipeline
        * e.g. `fly -t iaas-smoke-test unpause-pipeline -p iaas-smoke-test`

# Run

Open the Concourse server url in your browser, locate the `iaas-smoke-test` pipeline, then click on the `iaas-smoke-test` job.

Click the `+` button to execute the pipeline.

If the configuration is correct the pipeline should execute successfully. If not, you will need to debug the pipeline and/or the configuration files to determine what went wrong.

Alternatively, a sample `run.sh` script is included that will set the pipeline, unpause it, start the job, and watch the log output. Review and update this script as appropriate for your environment.

NOTE: The pipeline is not configured to trigger automatically with a change to the config files checked into the github repository. To do this simply add `trigger: true` to the git resource in the `pipeline.yml` plan like so:

```
- get: iaas-smoke-test
  trigger: true
```

# Validate

Even when the pipeline executes successfully and shows green, you should double-check the output of the `run_test1` and `run_test2` tasks to be sure the hosts are able to connect to each other.

As of the writing of this document, the pipeline itself does not contain any validation of the `IaaSSmokeTest` output to make sure connectivity was successful. Hopefully a future version will add it.
