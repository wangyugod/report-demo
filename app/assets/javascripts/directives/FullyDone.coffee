FullyDone = ()->
  link = (scope, element, attrs)->
    scope.$watch("items",(value)->
      val = value || null
      if(val)
        yAxis = []
        xAxis = []
        for item in value
          do (item) ->
            xAxis.push item.name
            yAxis.push parseInt(item.bqfsejf, 10)

        scope.hideBase = scope.hideBase
        scope.hideColumnChart = scope.hideColumnChart
        scope.hidePieChart = scope.hidePieChart
        constructColumnChart('统计', xAxis, yAxis, 'chart-test')
        constructPieChart(value, 'pie-chart')
    )
  # ... #
  directive =
    {
      scope:{

      }
      link: link,
      restrict: 'EA'
    }

directivesModule.directive('fullyDone', FullyDone)