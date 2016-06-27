# Copyright 2016 The Kubernetes Authors All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# A Dockerfile for creating an Elasticsearch instance that is designed
# to work with Kubernetes logging. Inspired by the Dockerfile
# dockerfile/elasticsearch

FROM java:openjdk-8-jre
MAINTAINER Satnam Singh "satnam@google.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y curl && \
    apt-get clean

RUN cd / && \
    curl -O https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/2.3.3/elasticsearch-2.3.3.tar.gz && \
    tar xf elasticsearch-2.3.3.tar.gz && \
    rm elasticsearch-2.3.3.tar.gz

RUN mkdir -p /elasticsearch-2.3.3/config/templates

COPY elasticsearch.yml /elasticsearch-2.3.3/config/elasticsearch.yml
COPY template-k8s-logstash.json /elasticsearch-2.3.3/config/templates/template-k8s-logstash.json
COPY run.sh /
COPY elasticsearch_logging_discovery /

VOLUME ["/data"]
EXPOSE 9200 9300

CMD ["/run.sh"]
