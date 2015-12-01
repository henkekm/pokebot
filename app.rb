require 'sinatra'
require 'httparty'
require 'json'

post '/gateway' do
  message = params[:text].gsub(params[:trigger_word], '').strip
  puts message

  action = message.split('_').map {|c| c.strip.downcase }

  repo, pokenumber = 'pokemon', '1'
  repo_url = "http://pokeapi.co/{repo}/{pokenumber}"

  case action
    when 'bulbasaur'
      response = HTTParty.get(repo_url)
      response = JSON.parse response.body
      respond_message "Meet {response[name]}. {response[name]} is a {response[species]}, with a speed of {response[speed]} to start."
  end
end

def respond_message message
  content_type :json
  {:text => message}.to_json
end