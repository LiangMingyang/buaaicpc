
PS = 5 #score of each problem

PT = 2 #score of each training problem

global = @

@series = []

angular.module('bcpc-rating', [
  'as.sortable'
])

.controller 'main', ($scope)->

  $scope.currentRanks = [[4,9,2,1,10,6,3,8,5,7,11],[2,4,3,1,10,5,6,7,8,11,9],[10,3,4,1,11,5,6,8,2,7,9],[2,6,3,1,10,4,7,8,5,9,11],[5,3,4,8,7,6,10,9,1,2,11],[2,8,4,1,11,6,5,9,3,10,7],[1,3,5,10,9,7,2,8,6,4,11],[6,1,3,2,8,5,11,9,7,4,10],[1,3,7,4,5,2,10,8,6,11,9],[2,3,6,1,9,7,5,10,8,10,4],[3,1,2,9,6,10,7,11,8,5,4],[5,6,2,3,10,4,1,11,7,9,8]]

  $scope.problemCount = [71,63,68,71,50,61,60,45,63,54,50]

  $scope.trainingCount = [50,50,50,50,30,48,48,26,50,50,23]

  $scope.updatedDate = new Date("Sat Sep 17 2016 17:31:37 GMT+0800 (HKT)")

  $scope.PS = PS

  $scope.PT = PT

  series = []

  $scope.teamNames = [
    "TDL"
  , "LovelyDonuts"
  , "ACMakeMeHappier"
  , "null"
  , "sto orz"
  , "QAQ"
  , "ResuscitatedHope"
  , "Veleno"
  , "deticxe"
  , "GG"
#  , "firebug"
  , "The South China Sea"
  ]

  teamDic = {}
  for team,i in $scope.teamNames
    teamDic[team] = i

  $scope.teamList = (team for team in $scope.teamNames)

  $scope.result = ({name:team,rating:1000} for team in $scope.teamNames)

  $scope.dragControlListeners=
    itemMoved: (event)->
      console.log event
    orderChanged: (event)->
      console.log event

  $scope.calc = ()->
    rankDic = {}
    for team,i in $scope.teamList
      rankDic[team] = i+1
    rank = (rankDic[team] for team in $scope.teamNames)
    $scope.currentRanks.push rank
    update()

  update = ()->
    $scope.currentRanks ?= []
    series = ({name:team,data:[]} for team in $scope.teamNames)
    res = global.calc($scope.currentRanks, series, $scope.teamNames.length)
    $scope.result = ({name:team,rating: parseInt(res[i])} for team,i in $scope.teamNames)

    for team,i in $scope.result
      team.rating += $scope.problemCount[i]*PS
      team.rating += $scope.trainingCount[i]*PT
      for rating,j in series[i].data
        series[i].data[j] += $scope.problemCount[i]*PS
        series[i].data[j] += $scope.problemCount[i]*PT

    $scope.result.sort(
      (a,b)->
        if a.rating < b.rating
          return 1
        return -1
    )
    $scope.drawChart()
    return
  $scope.update = update
  $scope.reset = ()->
    $scope.currentRanks = []#[[4,9,2,1,10,6,3,8,5,7,11,12],[2,4,3,1,10,5,6,7,8,12,11,9]]
    update()

  $scope.drawChart = ()->
    global.series ?= []
    $("#panel").highcharts
      title:
        text: "Rating变化图"
        x: -20 #center

      subtitle:
        text: "Source: 北航ACM集训队"
        x: -20

      xAxis:
        categories: [1..100]

      yAxis:
        title:
          text: "Rating"

        plotLines: [
          value: 0
          width: 1
          color: "#808080"
        ]

      tooltip:
        valueSuffix: ""
        pointFormatter: ()->
          rank = $scope.currentRanks[@x][teamDic[@series.name]]
          if @x == 0
            return "<span style='color:#{@color}'>\u25CF</span> #{@series.name}: <b>#{@y}</b><br/><b>Rank:#{rank} </b>"
          else
            delta = @y-@series.data[@x-1].y
            sign = '+'
            sign = '' if delta < 0
            return "<span style='color:#{@color}'>\u25CF</span> #{@series.name}: <b>#{@y}</b><br/><b>#{sign}#{delta}</b><br/><b>Rank: #{rank}</b>"

      legend:
        layout: "vertical"
        align: "right"
        verticalAlign: "middle"
        borderWidth: 0

      series: series
    return

  $scope.drawChart()

  fileExport = (data, fileName, extension)->
    aLink = document.createElement("a")
    blob = new Blob([data])
    evt = document.createEvent("MouseEvents")
    evt.initEvent("click", false, false)
    aLink.download = fileName + "." + extension
    aLink.href = URL.createObjectURL(blob)
    aLink.dispatchEvent(evt)

  $scope.downloadRank = ()->
    data = "
           $scope.currentRanks = #{JSON.stringify $scope.currentRanks}   \n
                                                                         \n
           $scope.problemCount = #{JSON.stringify $scope.problemCount}   \n
                                                                         \n
           $scope.trainingCount = #{JSON.stringify $scope.trainingCount} \n
                                                                        \n
           $scope.updatedDate = new Date(\"#{new Date()}\")\n
           "

    fileExport(data, "rating_save_#{(new Date())}", "txt")

  $scope.color = (rank)->
    return "gold" if rank <= 2
    return "silver" if rank <= 5
    return "brown" if rank <=8
    return "white"
  update()