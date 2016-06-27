#!/bin/bash

go get github.com/golang/glog
go get k8s.io/kubernetes/pkg/api
go get k8s.io/kubernetes/pkg/client/unversioned

go build elasticsearch_logging_discovery.go
