request = require('request')

module.exports = (robot) ->
  get_channel = (response) ->
    if response.message.room == response.message.user.name
      "@#{response.message.room}"
    else
      "##{response.message.room}"

  robot.hear /^(?!.*ない).+$/i, (msg)->
    if get_channel(msg) == msg.message.user.name
      #send message to user from DM
      msg.send msg.random [
        "おなかすいたね！",
        "そろそろごはんだね〜",
        "ぐぅ...",
        "腹が減ってはなんとやら、だね"
      ]
    #send message to specific channel TODO: change channel to gohan when deploy
    robot.messageRoom "onakasuita_bot_test", "おなかすいてきた？きょうのおすすめはこちら(´・ω・`)"

  robot.hear /ない/i, (msg)->
    if get_channel(msg) == msg.message.user.name
      msg.send msg.random [
        "おなかへってないの？",
        "おなかへってないのか...",
        "まだおなかへってないの？",
        "へってない？またおなかへったらおしえてね"
      ]

  addReactions = (msg, name) ->
    options = {
      url: 'https://slack.com/api/reactions.add'
      qs: {
        'token': process.env.HUBOT_SLACK_TOKEN
        'name': name
        'channel': msg.message.rawMessage.channel
        'timestamp': msg.message.rawMessage.ts
      }
    }
    request.post options, (err, res, body) ->
      if err? or res.statusCode isnt 200
        robot.logger.error("Failed to add emoji reaction #{JSON.stringify(err)}")
