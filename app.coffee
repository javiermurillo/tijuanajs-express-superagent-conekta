express = require 'express'
http = require 'http'
parser = require 'body-parser'
logger = require 'morgan'
superagent = require 'superagent'
errorhandler = require 'errorhandler'

app = express()
app.use logger('dev')
app.use parser.json()
app.use parser.urlencoded
  extended: true

if 'development' == app.get('env')
  app.use errorhandler()

  #Callback
  end = (err, response) ->
    if err
      console.log err
    if response.statusCode isnt 200
      console.log err
    console.log response.body

app.post '/charges', (req, res) ->
  console.log(req.body)
  superagent
    .post('https://api.conekta.io/charges')
    .auth('key_v8TTXAcjJMyd3cKg', '')
    .set('Accept', 'application/vnd.conekta-v0.3.0+json')
    .set('Content-type', 'application/json')
    .send(req.body)
    .end(end)

app.listen 3003, ->
  console.log "server running at 3003 port"
