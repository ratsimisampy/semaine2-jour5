#let's create an API connecting to spotify, it will be a funny stuff
require 'dotenv'
require "base64"
require "httparty" 
require "pry"

@client_id = ENV['CLIENT_ID']
@client_secret = ENV['CLIENT_SECRET']
@url = "https://accounts.spotify.com/api/token"

#etape 1
def encoding(client_id,secret_id)
    keys = (client_id + ':' + secret_id)
    return 'Basic ' + Base64.strict_encode64(keys)
end

#etape 2
#cette fonction me retourne un HASH dont le access_token en clé
def get_my_token_access(my_url)
    response = HTTParty.get(my_url)
#   puts response.body #, response.code, response.message, response.headers.inspect
   
    ma_requete = HTTParty.post(
        my_url,
        headers: {"Authorization" => encoding(@client_id,@client_secret)}, 
        body: {"grant_type" => 'client_credentials'}
    )
    binding.pry
    return ma_requete
end

puts get_my_token_access(@url)