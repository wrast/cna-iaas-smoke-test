#!/bin/sh

# copy the binary and host's config file for the smoke test

#ls -lR iaas-smoke-test-release
#ls -lR iaas-smoke-test
cp iaas-smoke-test-release/IaaSSmokeTest_$host_platform smoke-test/.
cp iaas-smoke-test/config_$host_name.json smoke-test/config.json
#ls -lR smoke-test
