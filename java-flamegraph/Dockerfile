#
# Build and launch a JVM that will generate flamegraph from profiling
# Linux flamegraphs will also be generated and can be used to view the full system.
#
# References :
# http://www.brendangregg.com/blog/2014-06-12/java-flame-graphs.html
#

FROM centos:centos6

# http://superuser.com/questions/381160/how-to-install-gcc-4-7-x-4-8-x-on-centos
RUN \
  yum install -y wget && \
  cd /etc/yum.repos.d && \
  wget http://people.centos.org/tru/devtools-1.1/devtools-1.1.repo && \
  yum --enablerepo=testing-1.1-devtools-6 install -y devtoolset-1.1-gcc devtoolset-1.1-gcc-c++ && \
  yum install -y svn which java-1.7.0-openjdk-devel.x86_64

# export CC=/opt/centos/devtoolset-1.1/root/usr/bin/gcc  
# export CPP=/opt/centos/devtoolset-1.1/root/usr/bin/cpp
# export CXX=/opt/centos/devtoolset-1.1/root/usr/bin/c++
# export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/centos/devtoolset-1.1/root/usr/bin

ENV CC    /opt/centos/devtoolset-1.1/root/usr/bin/gcc  
ENV CPP   /opt/centos/devtoolset-1.1/root/usr/bin/cpp
ENV CXX   /opt/centos/devtoolset-1.1/root/usr/bin/c++
ENV PATH  /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/centos/devtoolset-1.1/root/usr/bin

RUN \
  svn checkout http://lightweight-java-profiler.googlecode.com/svn/trunk/ lightweight-java-profiler-read-only && \
  cd lightweight-java-profiler-read-only && \
  sed -i 's/BITS?=32/BITS?=64/g' Makefile && \
  sed -i 's;INCLUDES=-I$(JAVA_HOME)/$(HEADERS) -I$(JAVA_HOME)/$(HEADERS)/$(UNAME);INCLUDES=-I$(JAVA_HOME)/$(HEADERS) -I$(JAVA_HOME)/$(HEADERS)/$(UNAME) -I/opt/centos/devtoolset-1.1/root/usr/include/c++/4.7.2/x86_64-redhat-linux;g' Makefile && \
  sed -i 's/fprintf(file_, "\%"PRIdPTR" ", traces\[i\].count)/fprintf(file_, "\%" PRIdPTR " ", traces\[i\].count)/g' src/display.cc && \
  make all
