require 'dotenv'
require 'net/http'
require 'uri'
require 'base64'
require 'json'
Dotenv.load

class Spotify
    attr_reader :token

    def initialize
        @token = log_in
        @url = ENV['spotify_url']
    end

    def log_in
        spotify_auth = ENV['spotify_auth']
        client_id = ENV['client_id']
        client_secret = ENV['client_secret']
    
        credentials = Base64.strict_encode64("#{client_id}:#{client_secret}")
        uri = URI(spotify_auth)
        request = Net::HTTP::Post.new(uri)
        request['Authorization'] = "Basic #{credentials}"
        request.set_form_data('grant_type' => 'client_credentials')
    
        response = do_request(uri,request)
    
        if response.is_a?(Net::HTTPSuccess)
            body = JSON.parse(response.body)
            token = body["access_token"]
        else
            puts "Error: #{response.message}"
        end
    end

    def get_album_cover(name)
        query = "Bob Dylan - #{name}"
        uri = URI("#{@url}/search?type=album&q=#{query}")

        request = Net::HTTP::Get.new(uri) # encapsular get y post?
        request['Authorization'] = "Bearer #{@token}"
        response = do_request(uri,request)

        data = JSON.parse(response.body)
        first_data = data['albums']['items'].first
        first_data['images'].first['url']
    end

    def do_request(uri,request)
        response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
            http.request(request)
        end
        response
    end
end
