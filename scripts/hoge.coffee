count = 0;

module.exports = (robot) ->
  robot.hear /^(?!.*ない).+$/i, (msg)->
    msg.send msg.random [
      "おなかすいたね！",
      "そろそろごはんだね〜",
      "ぐぅ...",
      "腹が減ってはなんとやら、だね"
    ]
    count++;

  robot.hear /ない/i, (msg)->
    msg.send msg.random [
      "おなかへってないの？",
      "おなかへってないのか...",
      "まだおなかへってないの？",
      "へってない？またおなかへったらおしえてね"
    ]
