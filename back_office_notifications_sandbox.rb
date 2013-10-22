require 'sinatra'
require 'json'

get '/' do
  "Go to /httppost_v2.json for the JSON response for HTTP POST notifications. More to come..."
end

post '/httppost_v2.json' do
  status 200
  description = "Accepted"
  reference = params[:transaction_reference]
  first_name = params[:first_name]
  last_name = params[:last_name]
  if !reference.empty? && !first_name.empty? && !last_name.empty?
  	subscriber_message = "Subscriber message ndio hii: Transaction reference: #{params[:transaction_reference]}. Customer: #{params[:first_name]} #{params[:last_name]}."
  else
  	subscriber_message = ""
  end
  content_type :json
  { :status => '01', :description => description, :subscriber_message => subscriber_message }.to_json
end

post '/httppost_v2_failed_reconciliation.json' do
end

post '/httppost_v2_hmac.json' do
end

post '/xml_http_v2.xml' do
  content_type 'text/xml'
  '<?xml version = "1.0" encoding = "UTF-8"?>
<transaction_response>
    <internal_transaction_id>3222</internal_transaction_id>
    <transaction_reference>DE45GK45</transaction_reference>
    <status>01</status>
    <description>Accepted</description>
    <subscriber_message>Thank you John Doe for your payment</subscriber_message>
</transaction_response>'
end



