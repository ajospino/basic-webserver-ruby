FROM ruby:3.3.8-alpine
RUN gem install sqlite3
RUN mkdir webserver-ruby/ webserver-ruby/db/
COPY main.rb webserver-ruby/
WORKDIR webserver-ruby/
EXPOSE 3000
CMD ["ruby","main.rb"]
