request = require('request')
fs = require('fs')

module.exports = (robot) ->
  get_channel = (response) ->
    if response.message.room == response.message.user.name
      "@#{response.message.room}"
    else
      "##{response.message.room}"

  robot.hear /^(?!.*(ない|追加)).+$/i, (msg)->
    if get_channel(msg) == "@"+msg.message.user.name
      #send message to user from DM
      msg.send msg.random [
        "おなかすいたね！",
        "そろそろごはんだね〜",
        "ぐぅ...",
        "腹が減ってはなんとやら、だね"
      ]
      robot.messageRoom "onakasuita_bot_test", "おなかすいてきた？きょうのおすすめはこちら(´・ω・`)\n"
      #get data from text file
      fs.readFile 'scripts/teishoku.txt', 'utf8', (err, data) ->
        throw err if err
        teishoku = data.split(",")
        robot.messageRoom "onakasuita_bot_test", ":one:"+msg.random(teishoku)+"\n"
      #teishoku = ["ピグ","食堂もり川","こだわりや","一番餃子","おおさわ"]
      fs.readFile 'scripts/teishoku2.txt', 'utf8', (err, data) ->
        throw err if err
        teishoku2 = data.split(",")
        robot.messageRoom "onakasuita_bot_test", ":two:"+msg.random(teishoku2)+"\n"
      #teishoku2= ["美味しいや","こくわがた","ごち屋","いなか家"]
      fs.readFile 'scripts/ramen.txt', 'utf8', (err, data) ->
        throw err if err
        ramen = data.split(",")
        robot.messageRoom "onakasuita_bot_test", ":three:"+msg.random(ramen)+"\n"
      #ramen = ["用心棒","家家家","織恩","山手ラーメン","IZASA","瀬佐味亭"]
      #enquete = ":one:"+msg.random(teishoku)+"\n" +":two:"+msg.random(teishoku2)+"\n" + ":three:"+msg.random(ramen)+"\n"
      #send message to specific channel TODO: change channel to gohan when deploy
      #robot.messageRoom "onakasuita_bot_test", "おなかすいてきた？きょうのおすすめはこちら(´・ω・`)\n" +enquete
      #robot.messageRoom "onakasuita_bot_test", msg.random(teishoku)

  robot.hear /ない/i, (msg)->
    if get_channel(msg) == "@"+msg.message.user.name
      msg.send msg.random [
        "おなかへってないの？",
        "おなかへってないのか...",
        "まだおなかへってないの？",
        "へってない？またおなかへったらおしえてね"
      ]

  robot.hear /追加　定食　(.*)/i, (msg)->
    data = ","+msg.match[1]
    fs.appendFile 'scripts/teishoku.txt', data, 'utf8', (err) ->
      throw err if err
    msg.send "#{msg.match[1]}を定食に追加したよ"

  robot.hear /追加　ラーメン　(.*)/i, (msg)->
    data = ","+msg.match[1]
    fs.appendFile 'scripts/ramen.txt', data, 'utf8', (err) ->
      throw err if err
    msg.send "#{msg.match[1]}をラーメンに追加したよ"
