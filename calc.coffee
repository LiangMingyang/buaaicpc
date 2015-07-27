update = require('./update')
INIT_RATING = 1000
INIT_VOL = 400
calc = (results, num = 50)->
  rating = (INIT_RATING for i in [0...num])
  vol = (INIT_VOL for i in [0...num])
  cnt = (0 for i in [0...num])
  for j in [0...results.length]
    contest = results[j]
    form = []
    for id in contest
      if id >= num
        console.log "There is an invalid id in contest[#{j}]. "
        return []
      form.push(
        rating : rating[id]
        vol : vol[id]
        id : id
      )
    for i in [0...form.length]
      ++cnt[form[i].id]
      ARank = i+1
      res = update(ARank, form, cnt[form[i].id])
      ele = form[i]
      rating[ele.id] = res.newRating
      vol[ele.id] = res.newVol
  return rating
module.exports = calc