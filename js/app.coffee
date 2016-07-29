
global = @

@series = []

angular.module('bcpc-rating', [
  'as.sortable'
])

.controller 'main', ($scope)->

  $scope.currentRanks = []

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
  , "firebug"
  , "The South China Sea"
  ]

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
    $scope.result = ({name:team,rating:parseInt(res[i])} for team,i in $scope.teamNames)
    $scope.result.sort(
      (a,b)->
        if a.rating < b.rating
          return 1
        return -1
    )
    $scope.drawChart()
    return

  $scope.showNow = ()->
    $scope.currentRanks = [[4,9,2,1,10,6,3,8,5,7,11,12],[2,4,3,1,10,5,6,7,8,12,11,9]]
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
          if @x == 0
            return "<span style='color:#{@color}'>\u25CF</span> #{@series.name}: <b>#{@y}</b><br/>"
          else
            delta = @y-@series.data[@x-1].y
            sign = '+'
            sign = '' if delta < 0
            return "<span style='color:#{@color}'>\u25CF</span> #{@series.name}: <b>#{@y}</b><br/><b>#{sign}#{delta}</b>"

      legend:
        layout: "vertical"
        align: "right"
        verticalAlign: "middle"
        borderWidth: 0

      series: series
    return

  fileExport = (data, fileName, extension)->
    aLink = document.createElement("a")
    blob = new Blob([data])
    evt = document.createEvent("MouseEvents")
    evt.initEvent("click", false, false)
    aLink.download = fileName + "." + extension
    aLink.href = URL.createObjectURL(blob)
    aLink.dispatchEvent(evt)

  $scope.downloadRank = ()->
    fileExport(JSON.stringify($scope.currentRanks), "rank_#{(new Date())}", "txt")

  $scope.color = (rank)->
    return "gold" if rank <= 2
    return "silver" if rank <= 5
    return "brown" if rank <=8
    return "white"