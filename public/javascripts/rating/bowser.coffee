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
  rank = $('.rank>li')
  rank = (parseInt(ele.innerText) for ele in rank)
  #console.log rank
  table = (0 for i in [0...@teams.length])
  for i in [0...array.length]
    table[dic[array[i]]] = rank[i] if dic[array[i]] isnt undefined
  console.log table
  @table ?= []
  @contest_num ?= 1
  @table.push table
  res = @build(@table, @teams)
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
    [ 1, 3, 2, 5, 4, 6, 7, 11, 9, 12, 13, 10, 8, 14 ]
  , [ 1, 6, 7, 5, 11, 2, 4, 3, 8, 10, 13, 12, 9, 14 ]
  , [ 1, 3, 2, 4, 5, 11, 8, 12, 7, 9, 10, 13, 6, 14 ]
  , [ 1, 1, 1, 1, 1, 1, 1, 4, 1, 2, 1, 3, 1, 1] #第一次练习赛
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
