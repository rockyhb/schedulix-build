FROM centos:7
MAINTAINER Claas Rockmann-Buchterkirche <claas@rockbu.de>
EXPOSE 80 22 5666 6556
# ADD otrdecoder-bin-x86_64-unknown-linux-gnu-0.4.1132.tar.bz2 /usr/lib

RUN rpm -Uvh "https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm"
RUN yum clean all
RUN yum -y update
RUN yum -y install java-1.7.0-openjdk-devel gcc gcc-c++ make jna wget git unzip
RUN rpm -Uvh "http://sourceforge.net/projects/jflex/files/jflex/1.4.1/jflex-1.4.1-0.rpm/download"
WORKDIR /tmp
RUN wget "http://eclipse.mirror.triple-it.nl/eclipse/downloads/drops4/R-4.5-201506032000/swt-4.5-gtk-linux-x86_64.zip"
RUN unzip swt-4.5-gtk-linux-x86_64.zip swt.jar
COPY swt.jar /usr/share/java/
RUN useradd schedulix
RUN su schedulix -c "cd /home/schedulix && git clone https://github.com/schedulix/schedulix.git -b v2.6.1 schedulix-2.6.1"
ADD bashrc /home/schedulix/.bashrc
RUN su - schedulix -c "cd /home/schedulix/schedulix-2.6.1/src && make && cd /home/schedulix && tar czf schedulix-2.6.1.tgz schedulix-2.6.1"
RUN echo Done.
CMD /bin/bash
