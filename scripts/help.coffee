request = require 'superagent'

RESPONSES = [
  "I found this  ",
  "I remember finding an article on about this very thing ",
  "Maybe this can help ",
]

MARS_TEAM_PRIVATE_CHANNEL_ID='G0JUTJYCV'

respondWithArticle = (msg) ->
  request.get('https://api.stackexchange.com/2.2/questions?pagesize=100&order=desc&sort=activity&site=stackoverflow')
    .end (err, rsp) ->
      body = rsp.body
      item = msg.random body.items
      text = msg.random RESPONSES
      msg.send text+item.link



module.exports = (robot) ->
  robot.respond /.*(help|what do you know|what can you tell me about|do you have).*/i, (msg) ->
    respondWithArticle(msg)

robot.respond /.*help.*/i, (msg) ->
    if(msg.message.room == MARS_TEAM_PRIVATE_CHANNEL_ID)
      respondWithArticle(msg)

  robot.respond /.*\?$/i, (msg) ->
    if(msg.message.room == MARS_TEAM_PRIVATE_CHANNEL_ID)
      respondWithArticle(msg)