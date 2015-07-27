@solve = ()->
  teams = [
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
  dic = {}
  for team,i in teams
    dic[team] = i
  array = $('.list>li')
  array = (ele.innerText for ele in array)
  form = []
  for t in array
    form.push dic[t]
  @table ?= []
  @contest_num ?= 1
  table.push form
  res = @build(table, teams)
  res_team = $('.team>li')
  res_rating = $('.rating>li')
  for i in [0...teams.length]
    res_team[i].innerHTML = res[i].teamName
    res_rating[i].innerHTML = parseInt(res[i].rating)
  ++@contest_num
  $('#contest')[0].innerHTML = "Contest #{@contest_num}"

