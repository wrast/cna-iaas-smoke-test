#!/bin/sh

ls -l iaas-smoke-test-release
ls -l cna-iaas-smoke-test
cp -r iaas-smoke-test-release/IaasSmokeTest_linux cna-iaas-smoke-test/config.json smoke-test/.
ls -l smoke-test
