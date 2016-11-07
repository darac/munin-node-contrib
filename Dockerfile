FROM phusion:baseimage-docker:0.9.19
MAINTAINER Paul Saunders

# Declarations
EXPOSE 4949
VOLUME ""


# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Update Ubuntu's packages
RUN apt-get update
#RUN apt-get upgrade -y -o Dpkg::Options::="--force-confold"

# Install the packages we need
RUN apt-get install -y \
	git \
	munin-node
RUN systemctl disable munin-node

# Pull the GIT repo
RUN mkdir -p /opt/munin/contrib
RUN git clone https://github.com/munin-monitoring/contrib.git /opt/munin/contrib

# Create the runit script
RUN mkdir /etc/service/munin-node
COPY munin-node.sh /etc/service/munin-node/run

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
