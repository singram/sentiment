# encoding: utf-8

class Sentiment < Sinatra::Application
  get '/' do
    erb :'index.html'
  end

  get '/twitter/search.json' do
    content_type :json
    puts "Searching tweets for '#{params['search_term']}'"
    tweets = TwitterSearch.search(params['search_term'])
    tweets.map! { |t| { text: t, sentiment_css: sentiment_to_css(Sentiment.extract(t).to_s) } }
    puts "Found #{tweets}"
    { search_term: params['search_term'], tweets: tweets }.to_json
  end

  get '/sentiment.json' do
    content_type :json
    sentiment = Sentiment.extract(params['search_term'])
    { sentiment: sentiment.to_s }.to_json
  end

  def sentiment_to_css(sentiment)
    case sentiment
    when 'very negative' then 'alert-danger'
    when 'negative'      then 'alert-danger'
    when 'neutral'       then 'alert-warning'
    when 'positive'      then 'alert-success'
    when 'very positive' then 'alert-success'
    else ''
    end
  end

end
