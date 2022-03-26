FROM ruby:2.7.2
RUN apt-get update -qq && apt-get install -y build-essential nodejs postgresql-client libpq-dev

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn

# RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
# RUN apt-get update -qq && apt-get install -y build-essential libxslt-dev libxml2-dev cmake
# RUN apt-get install -y nodejs npm && npm install n -g && n 12.0.0

RUN apt-get update -qq && apt-get install -y nodejs
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get install -y nodejs

RUN mkdir /qa
WORKDIR /qa
COPY Gemfile /qa/Gemfile
COPY Gemfile.lock /qa/Gemfile.lock
RUN bundle install
COPY . /qa

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]