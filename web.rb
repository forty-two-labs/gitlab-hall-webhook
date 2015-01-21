require 'sinatra'
require 'json'
require "net/https"
require "uri"
require 'dotenv'

Dotenv.load

def submit_message_to_hall(title, message)
  uri = URI.parse(ENV['HALL_WEBHOOK_URL'])

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  request = Net::HTTP::Post.new(uri.request_uri)
  request.body = {
    title: title,
    message: message
  }.to_json
  request["Content-Type"] = "application/json"

  http.request(request)
end

before do
  request.body.rewind
  @request_payload = JSON.parse request.body.read
end

post '/gitlab/webhook' do
  user_name = @request_payload["user_name"]
  repository_name = @request_payload["repository"]["name"]
  commits = @request_payload["commits"]

  title = "#{user_name} pushed to git.42la.bs #{repository_name}"
  message = '<ul>' + commits.map do |commit|
    "<li>#{commit['message']}</li>"
  end.join + '</ul>'

  submit_message_to_hall(title, message)
end
