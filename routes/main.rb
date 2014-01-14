# encoding: utf-8

class Sentiment < Sinatra::Application

  get '/' do
    erb :'index.html'
  end

  get '/twitter/search.json' do
    content_type :json
    puts "Searching tweets for '#{params['search_term']}'"
    tweets = TwitterSearch.search(params['search_term'])
    tweets.map!{|t| { text: t } }
    puts "Found #{tweets}"
    { :search_term => params['search_term'], :tweets => tweets }.to_json
  end

end
