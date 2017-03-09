#!/bin/sh

ls -lR iaas-smoke-test-release
ls -lR cna-iaas-smoke-test
cp -r iaas-smoke-test-release/IaaSSmokeTest_linux cna-iaas-smoke-test/config.json smoke-test/.
ls -lR smoke-test
