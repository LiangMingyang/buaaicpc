@teams = [
  "TheWaySoFar"
, "Damocles"
, "undetermined"
, "TDL"
, "LovelyDonuts"
, "NewBeer"
, "TheThreeMusketeers"
, "I-PPPei+"
, "Prometheus"
, "Nostalgia"
, "Time After Time"
, "TriMusketeers"
, "null"
, "拖拽我"
]
@solve = ()->
  dic = {}
  for team,i in @teams
    dic[team] = i
  array = $('.list>li')
  array = (ele.innerText for ele in array)
  form = []
  for t,i in array
    if i > @teams.length
      break
    form.push dic[t] if dic[t] isnt undefined
  console.log form
  @table ?= []
  @contest_num ?= 1
  table.push form
  res = @build(table, @teams)
  res_team = $('.team>li')
  res_rating = $('.rating>li')
  for i in [0...@teams.length]
    res_team[i].innerHTML = res[i].teamName
    res_rating[i].innerHTML = parseInt(res[i].rating)
  ++@contest_num
  $('#contest')[0].innerHTML = "Contest ##{@contest_num}"
  $('#rating')[0].innerHTML = "Rating ##{@contest_num-1}"

@showNow = ->
  @table = [
    [0, 2, 1, 4, 3, 5, 6, 12, 8, 11, 7, 9, 10, 13]
  ,
    [0, 5, 7, 6, 3, 1, 2, 8, 12, 9, 4, 11, 10, 13]
  ,
    [0, 2, 1, 3, 4, 12, 8, 6, 9, 10, 5, 7, 11, 13]
  ]
  @contest_num = table.length+1
  res = @build(table, @teams)
  res_team = $('.team>li')
  res_rating = $('.rating>li')
  for i in [0...@teams.length]
    res_team[i].innerHTML = res[i].teamName
    res_rating[i].innerHTML = parseInt(res[i].rating)
  $('#contest')[0].innerHTML = "Contest ##{@contest_num}"
  $('#rating')[0].innerHTML = "Rating ##{@contest_num-1}"
