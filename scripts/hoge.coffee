request = require('request')

module.exports = (robot) ->
  get_channel = (response) ->
    if response.message.room == response.message.user.name
      "@#{response.message.room}"
    else
      "##{response.message.room}"

  robot.hear /^(?!.*ない).+$/i, (msg)->
    if get_channel(msg) == "@"+msg.message.user.name
      #send message to user from DM
      msg.send msg.random [
        "おなかすいたね！",
        "そろそろごはんだね〜",
        "ぐぅ...",
        "腹が減ってはなんとやら、だね"
      ]
      teishoku = ["ピグ","食堂もり川","こだわりや","一番餃子","おおさわ"]
      teishoku2= ["美味しいや","こくわがた","ごち屋","いなか家"]
      ramen = ["用心棒","家家家","織恩","山手ラーメン","IZASA","瀬佐味亭"]
      teishoku_index = Math.floor(Math.random()*teishoku.length)
      teishoku2_index = Math.floor(Math.random()*teishoku2.length)
      ramen_index = Math.floor(Math.random()*ramen.length)
      enquete = ":one:"+teishoku[teishoku_index]+"\n" +":two:"+teishoku2[teishoku2_index]+"\n" + ":three:"+ramen[ramen_index]+"\n"
      #send message to specific channel TODO: change channel to gohan when deploy
      robot.messageRoom "onakasuita_bot_test", "おなかすいてきた？きょうのおすすめはこちら(´・ω・`)\n" +enquete

  robot.hear /ない/i, (msg)->
    if get_channel(msg) == "@"+msg.message.user.name
      msg.send msg.random [
        "おなかへってないの？",
        "おなかへってないのか...",
        "まだおなかへってないの？",
        "へってない？またおなかへったらおしえてね"
      ]
