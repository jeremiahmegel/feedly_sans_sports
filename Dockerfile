FROM ruby:alpine
WORKDIR ["/root"]
ADD Gemfile .
RUN ["gem", "install", "bundler"]
RUN ["bundle", "install"]
ADD feedly_sans_sports.rb .
ENTRYPOINT ["bundle", "exec", "./feedly_sans_sports.rb"]
