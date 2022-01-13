FROM ruby:3.0.0-slim@sha256:47eeeb05f545b5a7d18a84c16d585ed572d38379ebb7106061f800f5d9abeb38
LABEL maintainer="Cristiano Almeida <hello@csalmeida.com>"

# App files will exist here:
WORKDIR /app

# Exits if there's an error
# Installs libpq-dev which is required for Postgres to work with Rails
# Installs sqlite but just for testing purposes for now
# Creates a new user
RUN bash -c "set -o pipefail && apt-get clean && apt-get update \
  && apt-get install -y --no-install-recommends build-essential curl git libpq-dev \
  && apt-get install -y sqlite3 libsqlite3-dev \
  && useradd --create-home ruby"

#  Installs Rails 7
RUN bash -c "gem install rails -v 7.0.1 --verbose"

# Copy app files over
COPY --chown=ruby:ruby . .

# Installs app's dependencies
RUN bundle install

# Exposes the port the Rails server runs by default.
EXPOSE 3000

# Switches to ruby user
USER ruby

CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]