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

  action, arg = message.split('_').map {|c| c.strip.downcase }

  uri_directory, pokenumber, movenumber, abilitynumber = 'pokemon', '1', '1', '1'
  # api_url = "http://pokeapi.co/api/v1/#{uri_directory}/#{pokenumber}"

  case action
		# return if params[:token] != ENV['7FP2gNGr1zMck7T9eUAfGTlI']
    when 'pokemon'
    	# pokenumber = {pokemon lookup to convert arg from string to a number}
      ## need to handle case where input poke is unknown
    	uri_directory = 'pokemon'
		  api_url = "http://pokeapi.co/api/v1/#{uri_directory}/#{pokenumber}"
      response = HTTParty.get(api_url)
      response = JSON.parse response.body
      respond_message "Meet #{response['name']}. #{response['name']} is a #{response['species']}, with a speed of #{response['speed']} to start."
    when 'number'
      ## need to handle case where input number is unknown
    	pokenumber = arg
    	uri_directory = 'pokemon'
		  api_url = "http://pokeapi.co/api/v1/#{uri_directory}/#{pokenumber}"
      response = HTTParty.get(api_url)
      response = JSON.parse response.body
      respond_message "Meet #{response['name']}. #{response['name']} is a #{response['species']}, with a speed of #{response['speed']} to start."
    when 'move'
      ## need to handle case where input move is unknown
    	movenumber = arg
    	uri_directory = 'move'
		  api_url = "http://pokeapi.co/api/v1/#{uri_directory}/#{movenumber}"
      response = HTTParty.get(api_url)
      response = JSON.parse response.body
      respond_message "Move #{response['id']} is called #{response['name']}, has an accuracy of #{response['accuracy']}, and has a power of #{response['power']}"
    when 'ability'
      ## need to handle case where input ability is unknown
    	abilitynumber = arg
    	uri_directory = 'ability'
		  api_url = "http://pokeapi.co/api/v1/#{uri_directory}/#{abilitynumber}"
      response = HTTParty.get(api_url)
      response = JSON.parse response.body
      respond_message "Ability #{response['id']} is #{response['name']}. #{response['name']} is so cool."
  end
end

def respond_message message
  content_type :json
  {:text => message}.to_json
end