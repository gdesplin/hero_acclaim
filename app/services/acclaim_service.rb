class AcclaimService
  require 'faraday'
  def base_url
    "https://sandbox-api.youracclaim.com/v1/organizations/#{ENV['ACCLAIM_ORG_ID']}"
  end

  def base_connection
    Faraday.new(url: base_url, headers: headers) do |conn|
      conn.adapter Faraday.default_adapter
      conn.basic_auth(auth[:username], auth[:password])
    end
  end

  def retrieve_badge_templates
    connection = base_connection
    connection.get('badge_templates')
  end

  def retrieve_badge_template(template_id)
    connection = base_connection
    connection.get("badge_templates/#{template_id}")
  end

  def retrieve_issued_badges(data)
    connection = base_connection
    connection.get('badges') do |req|
      req.body = data.to_json
    end
  end

  def issue_badge(data)
    # required: recipient_email, issued_to_first_name, issued_to_last_name, badge_template_id, issued_at
    connection = base_connection
    connection.post('badges') do |req|
      req.body = data.to_json
    end
  end

  private

  def auth
    { username: ENV['ACCLAIM_AUTH_TOKEN'], password: '' }
  end

  def headers
    { 'Content-Type' => 'application/json' }
  end

end