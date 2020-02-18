FROM ruby:alpine
WORKDIR ["/root"]
RUN ["gem", "install", "bundler"]
ADD Gemfile .
RUN ["bundle", "install"]
ADD feedly_sans_sports.rb .
ENTRYPOINT ["bundle", "exec", "./feedly_sans_sports.rb"]
