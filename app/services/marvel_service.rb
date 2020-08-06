class MarvelService

  require 'faraday'
  require 'digest'

  attr_reader :params

  def initialize(params)
    @params = setup_params(params || {})
  end

  def base_url
    "https://gateway.marvel.com/v1/public"
  end

  def base_connection
    Faraday.new(url: base_url, headers: headers) do |conn|
      conn.adapter Faraday.default_adapter
    end
  end

  def retrieve_characters
    connection = base_connection
    connection.get('characters') do |req|
      req.params = params
    end
  end

  def retrieve_character
    connection = base_connection
    connection.get("characters/#{params[:id]}") do |req|
      req.params = params
    end
  end

  private

  def setup_params(params)
    time = Time.now.to_s
    time_md5_hash = Digest::MD5.hexdigest time + ENV['MARVEL_PRIVATE_KEY'] + ENV['MARVEL_PUBLIC_KEY']
    params[:apikey] = ENV['MARVEL_PUBLIC_KEY']
    params[:ts] = time
    params[:hash] = time_md5_hash
    params
  end

  def headers
    { 'Content-Type' => 'application/json' }
  end


end