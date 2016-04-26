module.exports = (robot) ->

  robot.hear /へった/i, (msg)->
    msg.send msg.random ["おなかすいたね","そろそろごはんだね","ぐぅ..."]
