FROM ruby:3.2.0

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs postgresql-client nano

# Set an environment variable to store the app's root path
ENV RAILS_ROOT /var/www/twitter-clone-ruby-gql
RUN mkdir -p $RAILS_ROOT

# Set the working directory
WORKDIR $RAILS_ROOT

# Copy the Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install Gems
RUN bundle install

# Copy the rest of the app code
COPY . .

# The main command to run when the container starts. Also include the environment variable
RUN gem install foreman

# Expose the port 3000 to the Docker host, so we can access it from the outside
EXPOSE 3000