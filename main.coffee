calc = require('./calc')


build = (contests, teamName)->
  rating =  calc(contests, teamName.length)
  res = []
  for r,i in rating
    ele = {
      rating : r
      teamname : teamName[i]
    }
    res.push(ele)
  res.sort(
    (a,b)->
      if a.rating < b.rating
        return 1
      return -1
  )
#  console.log res
  return res

module.exports = build