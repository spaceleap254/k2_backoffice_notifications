require 'sinatra'
require 'json'
require 'nokogiri'
require 'pp'

get '/' do
  "Go to /httppost_v2.json for HTTP POST notifications and /xml_http_v2.xml for XML over HTTP notifications."
end

post '/httppost_v2.json' do
  status 200
  description = "Accepted"
  reference = params[:transaction_reference]
  first_name = params[:first_name]
  last_name = params[:last_name]
  if !reference.nil? && !first_name.nil? && !last_name.nil?
  	subscriber_message = "Subscriber message for HTTP POST V2! Transaction reference: #{params[:transaction_reference]}. Customer: #{params[:first_name]} #{params[:last_name]}."
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
  description = "Accepted"
  reference = ""
  first_name = ""
  last_name = ""
  subscriber_message = ""
  req = Nokogiri::XML::Reader(request.body)
  pp req
  if req
    req.each do |node|
      if node.name == "transaction_reference"
        reference = node.inner_xml
      elsif node.name == "first_name"
        first_name = node.inner_xml
      elsif node.name == "last_name"
        last_name = node.inner_xml
      end    
    end
  end
  
  if !reference.nil? && !first_name.nil? && !last_name.nil?
    subscriber_message = "Subscriber message for XML HTTP V2! Transaction reference: #{reference}. Customer: #{first_name} #{last_name}."
  end
  content_type 'text/xml'
  "<?xml version = '1.0' encoding = 'UTF-8'?>
     <transaction_response>
     <internal_transaction_id>3222</internal_transaction_id>
     <transaction_reference>#{reference}</transaction_reference>
     <status>01</status>
     <description>#{description}</description>
     <subscriber_message>#{subscriber_message}</subscriber_message>
   </transaction_response>"
end

post '/xml_http_v2_failed_reconciliation.xml' do
end




