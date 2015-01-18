FROM centos:centos6

RUN yum install -y java-1.7.0-openjdk-devel unzip rpm-build tar
ENV JAVA_HOME /usr/lib/jvm/jre-1.7.0-openjdk.x86_64

# setup gradle
RUN \
  cd /tmp && \
  curl -LO https://raw.githubusercontent.com/dcapwell/gradlew/master/gradlew && \
  mkdir -p gradle/wrapper && \
  echo "distributionPath=wrapper/dists" >> gradle/wrapper/gradle-wrapper.properties && \
  echo "zipStorePath=wrapper/dists" >> gradle/wrapper/gradle-wrapper.properties && \
  echo "distributionUrl=https\://services.gradle.org/distributions/gradle-2.1-bin.zip" >> gradle/wrapper/gradle-wrapper.properties && \
  ./gradlew clean || echo ""

# install maven for tachyon build
RUN \
  mkdir -p /opt/maven && \
  cd /opt/maven && \
  curl -LO 'http://mirrors.ibiblio.org/apache/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.tar.gz' && \
  tar zxvf apache-maven-3.2.5-bin.tar.gz
ENV M2_HOME /opt/maven/apache-maven-3.2.5
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/maven/apache-maven-3.2.5/bin

# run tachyon build, so it gets the full m2 repo
RUN \
  cd /tmp && \
  curl -LO https://github.com/pivotalsoftware/tachyon/archive/develop.tar.gz && \
  tar zxvf develop.tar.gz && \
  cd tachyon-develop && \
  mvn -q clean install -DskipTests -Dhadoop.version=2.5.1

# Add user so when you mount, the id is valid
RUN useradd tachyon --uid 1000
