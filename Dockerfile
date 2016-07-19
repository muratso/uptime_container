FROM debian
MAINTAINER eric.ferreira@xys.com.br

RUN apt-get update && \
    apt-get install -y sudo build-essential libssl-dev libreadline6-dev curl git libffi-dev git-core libpq-dev redis-server --fix-missing

ADD docker/install-rbenv.sh /usr/sbin/
ADD docker/init.sh /usr/sbin/
ADD docker/start.sh /

RUN chmod 755 /usr/sbin/install-rbenv.sh && \
    chmod 755 /usr/sbin/init.sh && \
    chmod 755 /start.sh

RUN useradd -m -d /home/ruby -p ruby ruby && adduser ruby sudo && chsh -s /bin/bash ruby

RUN init.sh
RUN install-rbenv.sh

USER ruby
ENV HOME /home/ruby
ENV PATH /home/ruby/.rbenv/shims:/home/ruby/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV LOCALE pt-BR
ENV TIMEZONE America/Sao_Paulo
ENV TELEGRAM_API_TOKEN 169652651:AAF01F4pRIRvZayLMtbyjkq3_tdVQDBFEfk
ENV INTERVAL 20

RUN cd /home/ruby && git clone https://github.com/fnando/uptime_checker.git
ADD docker/checkers.yml /home/ruby/uptime_checker/

RUN sudo service redis-server start

RUN cd /home/ruby/uptime_checker && bundle install && gem install foreman

CMD ["/bin/bash", "/start.sh"]
EXPOSE 6379
