FROM ruby:2.6.6
RUN apt-get update -qq && apt-get install -y --no-install-recommends build-essential apt-utils ghostscript
RUN apt-get update -qq && apt-get install -y mongo-tools || true
RUN apt-get install -y locales && locale-gen en_US.UTF-8 && locale-gen pt_BR.UTF-8
RUN gem install bundler -v 2.2.15
ENV LANG pt_BR.UTF-8
ENV LANGUAGE pt_BR:pt
ENV LC_ALL pt_BR.UTF-8
RUN mkdir /brokers
WORKDIR /brokers
COPY Gemfile /brokers/Gemfile
COPY Gemfile.lock /brokers/Gemfile.lock
RUN bundle install
COPY . /brokers

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
