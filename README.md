k2_backoffice_notifications_sandbox
===================================

Sinatra app that acts as a sandbox for K2 Back Office notifications. For now receives HTTP POST and XML over HTTP notifications and responds with valid JSON.

Currently only supports Kopo Kopo's version 2 API. The sandbox is hosted on Heroku:

URLs
----

HTTP POST notifications:
http://k2-backoffice-api-sandbox.herokuapp.com/httppost_v2.json

XML over HTTP notifications:
http://k2-backoffice-api-sandbox.herokuapp.com/xml_http_v2.xml

TODO
----
1. Create hook that shows use of HMAC message authentication
2. Create examples for failed reconciliation
