// Generated by CoffeeScript 1.10.0
(function() {
  var PS, PT, global;

  PS = 5;

  PT = 2;

  global = this;

  this.series = [];

  angular.module('bcpc-rating', ['as.sortable']).controller('main', function($scope) {
    var fileExport, i, k, len, ref, series, team, teamDic, update;
    $scope.currentRanks = [[4, 9, 2, 1, 10, 6, 3, 8, 5, 7, 11], [2, 4, 3, 1, 10, 5, 6, 7, 8, 11, 9], [10, 3, 4, 1, 11, 5, 6, 8, 2, 7, 9], [2, 6, 3, 1, 10, 4, 7, 8, 5, 9, 11], [5, 3, 4, 8, 7, 6, 10, 9, 1, 2, 11], [2, 8, 4, 1, 11, 6, 5, 9, 3, 10, 7], [1, 3, 5, 10, 9, 7, 2, 8, 6, 4, 11], [6, 1, 3, 2, 8, 5, 11, 9, 7, 4, 10], [1, 3, 7, 4, 5, 2, 10, 8, 6, 11, 9]];
    $scope.problemCount = [54, 47, 52, 54, 38, 46, 43, 39, 49, 41, 35];
    $scope.trainingCount = [24, 24, 24, 24, 18, 24, 24, 19, 24, 24, 13];
    $scope.updatedDate = new Date("Sun Aug 14 2016 18:53:08 GMT+0800 (HKT)");
    $scope.PS = PS;
    $scope.PT = PT;
    series = [];
    $scope.teamNames = ["TDL", "LovelyDonuts", "ACMakeMeHappier", "null", "sto orz", "QAQ", "ResuscitatedHope", "Veleno", "deticxe", "GG", "The South China Sea"];
    teamDic = {};
    ref = $scope.teamNames;
    for (i = k = 0, len = ref.length; k < len; i = ++k) {
      team = ref[i];
      teamDic[team] = i;
    }
    $scope.teamList = (function() {
      var l, len1, ref1, results;
      ref1 = $scope.teamNames;
      results = [];
      for (l = 0, len1 = ref1.length; l < len1; l++) {
        team = ref1[l];
        results.push(team);
      }
      return results;
    })();
    $scope.result = (function() {
      var l, len1, ref1, results;
      ref1 = $scope.teamNames;
      results = [];
      for (l = 0, len1 = ref1.length; l < len1; l++) {
        team = ref1[l];
        results.push({
          name: team,
          rating: 1000
        });
      }
      return results;
    })();
    $scope.dragControlListeners = {
      itemMoved: function(event) {
        return console.log(event);
      },
      orderChanged: function(event) {
        return console.log(event);
      }
    };
    $scope.calc = function() {
      var l, len1, rank, rankDic, ref1;
      rankDic = {};
      ref1 = $scope.teamList;
      for (i = l = 0, len1 = ref1.length; l < len1; i = ++l) {
        team = ref1[i];
        rankDic[team] = i + 1;
      }
      rank = (function() {
        var len2, m, ref2, results;
        ref2 = $scope.teamNames;
        results = [];
        for (m = 0, len2 = ref2.length; m < len2; m++) {
          team = ref2[m];
          results.push(rankDic[team]);
        }
        return results;
      })();
      $scope.currentRanks.push(rank);
      return update();
    };
    update = function() {
      var j, l, len1, len2, m, rating, ref1, ref2, res;
      if ($scope.currentRanks == null) {
        $scope.currentRanks = [];
      }
      series = (function() {
        var l, len1, ref1, results;
        ref1 = $scope.teamNames;
        results = [];
        for (l = 0, len1 = ref1.length; l < len1; l++) {
          team = ref1[l];
          results.push({
            name: team,
            data: []
          });
        }
        return results;
      })();
      res = global.calc($scope.currentRanks, series, $scope.teamNames.length);
      $scope.result = (function() {
        var l, len1, ref1, results;
        ref1 = $scope.teamNames;
        results = [];
        for (i = l = 0, len1 = ref1.length; l < len1; i = ++l) {
          team = ref1[i];
          results.push({
            name: team,
            rating: parseInt(res[i])
          });
        }
        return results;
      })();
      ref1 = $scope.result;
      for (i = l = 0, len1 = ref1.length; l < len1; i = ++l) {
        team = ref1[i];
        team.rating += $scope.problemCount[i] * PS;
        team.rating += $scope.trainingCount[i] * PT;
        ref2 = series[i].data;
        for (j = m = 0, len2 = ref2.length; m < len2; j = ++m) {
          rating = ref2[j];
          series[i].data[j] += $scope.problemCount[i] * PS;
          series[i].data[j] += $scope.problemCount[i] * PT;
        }
      }
      $scope.result.sort(function(a, b) {
        if (a.rating < b.rating) {
          return 1;
        }
        return -1;
      });
      $scope.drawChart();
    };
    $scope.update = update;
    $scope.reset = function() {
      $scope.currentRanks = [];
      return update();
    };
    $scope.drawChart = function() {
      var l, results;
      if (global.series == null) {
        global.series = [];
      }
      $("#panel").highcharts({
        title: {
          text: "Rating变化图",
          x: -20
        },
        subtitle: {
          text: "Source: 北航ACM集训队",
          x: -20
        },
        xAxis: {
          categories: (function() {
            results = [];
            for (l = 1; l <= 100; l++){ results.push(l); }
            return results;
          }).apply(this)
        },
        yAxis: {
          title: {
            text: "Rating"
          },
          plotLines: [
            {
              value: 0,
              width: 1,
              color: "#808080"
            }
          ]
        },
        tooltip: {
          valueSuffix: "",
          pointFormatter: function() {
            var delta, rank, sign;
            rank = $scope.currentRanks[this.x][teamDic[this.series.name]];
            if (this.x === 0) {
              return "<span style='color:" + this.color + "'>\u25CF</span> " + this.series.name + ": <b>" + this.y + "</b><br/><b>Rank:" + rank + " </b>";
            } else {
              delta = this.y - this.series.data[this.x - 1].y;
              sign = '+';
              if (delta < 0) {
                sign = '';
              }
              return "<span style='color:" + this.color + "'>\u25CF</span> " + this.series.name + ": <b>" + this.y + "</b><br/><b>" + sign + delta + "</b><br/><b>Rank: " + rank + "</b>";
            }
          }
        },
        legend: {
          layout: "vertical",
          align: "right",
          verticalAlign: "middle",
          borderWidth: 0
        },
        series: series
      });
    };
    $scope.drawChart();
    fileExport = function(data, fileName, extension) {
      var aLink, blob, evt;
      aLink = document.createElement("a");
      blob = new Blob([data]);
      evt = document.createEvent("MouseEvents");
      evt.initEvent("click", false, false);
      aLink.download = fileName + "." + extension;
      aLink.href = URL.createObjectURL(blob);
      return aLink.dispatchEvent(evt);
    };
    $scope.downloadRank = function() {
      var data;
      data = "$scope.currentRanks = " + (JSON.stringify($scope.currentRanks)) + "   \n \n $scope.problemCount = " + (JSON.stringify($scope.problemCount)) + "   \n \n $scope.trainingCount = " + (JSON.stringify($scope.trainingCount)) + " \n $scope.updatedDate = new Date(\"" + (new Date()) + "\")\n";
      return fileExport(data, "rating_save_" + (new Date()), "txt");
    };
    $scope.color = function(rank) {
      if (rank <= 2) {
        return "gold";
      }
      if (rank <= 5) {
        return "silver";
      }
      if (rank <= 8) {
        return "brown";
      }
      return "white";
    };
    return update();
  });

}).call(this);

//# sourceMappingURL=app.js.map
