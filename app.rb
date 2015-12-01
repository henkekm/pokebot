require 'sinatra'
require 'httparty'
require 'json'
# Message:-
#     giubot: issues _ twbs/bootstrap

# Response:-
#     There are currently 433 open issues on twbs/bootstrap.

post '/gateway' do
  message = params[:text].gsub(params[:trigger_word], '').strip
  # puts message

  action, poke = message.split('_').map {|c| c.strip.downcase }

  uri_directory, pokenumber = 'pokemon', '1'
  api_url = "http://pokeapi.co/api/v1/#{uri_directory}/#{pokenumber}"
  # api_url = "http://pokeapi.co/api/v1/pokemon/1"

  case action
		# return if params[:token] != ENV['7FP2gNGr1zMck7T9eUAfGTlI']
    when 'pokemon'
      response = HTTParty.get(api_url)
      response = JSON.parse response.body
      respond_message "Meet #{response[name]}. #{response[name]} is a #{response[species]}, with a speed of #{response[speed]} to start."
      # respond_message "Stock Response"
  end
end

def respond_message message
  content_type :json
  {:text => message}.to_json
end