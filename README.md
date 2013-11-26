k2_backoffice_notifications_sandbox
===================================

Sinatra app that acts as a sandbox for K2 Back Office notifications. For now receives HTTP POST and XML over HTTP notifications and responds with valid JSON.

Currently only supports Kopo Kopo's version 2 API. The sandbox is hosted on Heroku:

URLs
----

HTTP POST notifications:
http://k2-backoffice-api-sandbox.herokuapp.com/httppost_v2.json

HTTP POST notifications with HMAC Authentication :
http://k2-backoffice-api-sandbox.herokuapp.com/httppost_v2_hmac.json

XML over HTTP notifications:
http://k2-backoffice-api-sandbox.herokuapp.com/xml_http_v2.xml

TODO
----
1. Basic authentication (do this after moving the params to the header)
2. Create examples for failed reconciliation
 