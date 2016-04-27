request = require('request')

module.exports = (robot) ->
  robot.hear /^(?!.*ない).+$/i, (msg)->

    #send message to user from DM

    msg.send msg.random [
      "おなかすいたね！",
      "そろそろごはんだね〜",
      "ぐぅ...",
      "腹が減ってはなんとやら、だね"
    ]

    #send message to specific channel TODO: change channel to gohan when deploy

    robot.messageRoom "labo_benri_tools", "おなかすいてきた？おすすめのおみせだよ"
    addReactions(msg,'pig')

  robot.hear /ない/i, (msg)->
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
        'channel': 'labo_benri_tools'
        'timestamp': msg.message.rawMessage.ts
      }
    }
    request.post options, (err, res, body) ->
      if err? or res.statusCode isnt 200
        robot.logger.error("Failed to add emoji reaction #{JSON.stringify(err)}")
