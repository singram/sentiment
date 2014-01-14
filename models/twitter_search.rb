# encoding: utf-8
import Java::Twitter4j.Query
import Java::Twitter4j.Status
import Java::Twitter4j.Twitter
import Java::Twitter4j.TwitterException
import Java::Twitter4j.TwitterFactory
import Java::Twitter4j.conf.ConfigurationBuilder
import Java::Twitter4j.User

class TwitterSearch
  def self.search(search_term)
    cb = ConfigurationBuilder.new
    cb.set_debug_enabled(true)
    cb.set_oauth_consumer_key(ENV['TWITTER_OAUTH_CONSUMER_KEY'])
    cb.set_oauth_consumer_secret(ENV['TWITTER_OAUTH_CONSUMER_SECRET'])
    cb.set_oauth_access_token(ENV['TWITTER_OAUTH_ACCESS_TOKEN'])
    cb.set_oauth_access_token_secret(ENV['TWITTER_OAUTH_ACCESS_TOKEN_SECRET'])
    twitter = TwitterFactory.new(cb.build).instance
    query =   Query.new(search_term + ' -filter:retweets -filter:links -filter:replies -filter:images')
    query.count = 20
    query.locale = 'en'
    query.lang = 'en'
    begin
      return twitter.search(query).tweets.map(&:text)
    rescue TwitterException => e
      puts e.message
    end
    []
  end
end
