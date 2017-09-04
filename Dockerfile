FROM ubuntu

RUN debconf debconf/frontend select Noninteractive | debconf-set-selections
RUN apt-get update -qq > /dev/null 2>&1
#RUN apt-get install -y dialog apt-utils
RUN apt-get install -y build-essential libpq-dev > /dev/null 2>&1
RUN apt-get install -y libreadline-dev > /dev/null 2>&1

RUN apt-get -y install locales > /dev/null 2>&1
RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get install -y git > /dev/null 2>&1
RUN apt-get install -y curl

RUN git clone https://github.com/sstephenson/ruby-build.git /usr/local/ruby-build
RUN /usr/local/ruby-build/install.sh

RUN /usr/local/bin/ruby-build 2.4.0 /home/rubies/2.4.0
RUN echo export PATH="/home/rubies/2.4.0/bin:$PATH" >> /root/.bashrc
ENV PATH="/home/rubies/2.4.0/bin:${PATH}"

RUN apt-get install -y rubygems-integration > /dev/null 2>&1
RUN gem update --system --no-rdoc --no-ri   > /dev/null 2>&1
RUN gem install bundler --no-rdoc --no-ri   > /dev/null 2>&1

RUN echo "-- Installing postgresql ..."
RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main' >> /etc/apt/sources.list.d/pgdg.list

RUN apt-get install -y wget
RUN wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add -

RUN apt-get update > /dev/null 2>&1
RUN apt-get install -y postgresql-common libpq-dev postgresql-9.5 > /dev/null 2>&1

RUN apt-get -y install sudo > /dev/null 2>&1

EXPOSE 3000
