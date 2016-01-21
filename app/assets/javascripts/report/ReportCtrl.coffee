class ReportCtrl

  constructor: (@$scope, @$log,@$location, @ReportService,@$route) ->
    @$scope.items = []
    @hideObject = {hideBase: false, hideColumnChart: true, hidePieChart: true}
    @queryCondition = {startDate: '', endDate: ''}
    #These variables MUST be set as a minimum for the calendar to work
    @event = {
      format: 'yyyyMMdd'
    }

  onChange: (item) ->
    @$log.debug 'User selected ' + angular.toJson(item);


  toggle: ($event, field, event) ->
      $event.preventDefault()
      $event.stopPropagation()
      event[field] = !event[field]


  fetch: () ->
    @ReportService.fetch(@queryCondition, 'http://localhost:8008/rest/report/report-demo')
    .then(
      (data) =>
        @$scope.items = data
    ,
      (error) =>
        @$log.error "Unable to fetch items"
    )

  click: (elementId) ->
    if elementId == "base-report"
      @hideObject.hideBase = false
      @hideObject.hideColumnChart = true
      @hideObject.hidePieChart = true
    else if elementId == "chart-test"
      @hideObject.hideBase = true
      @hideObject.hideColumnChart = false
      @hideObject.hidePieChart = true
    else if elementId == "pie-chart"
      @hideObject.hideBase = true
      @hideObject.hideColumnChart = true
      @hideObject.hidePieChart = false


fullyDone = ()->
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
      link: link,
      restrict: 'EA'

constructPieChart = (collection, containerId) ->
    dataBox = []
    for item in collection
      do(item) ->
        temp = {}
        temp.name = item.name
        temp.y = parseInt(item.bqfsejf, 10)
        dataBox.push temp
    pieChart = {
      chart: {
        plotBackgroundColor: null,
        plotBorderWidth: null,
        plotShadow: false,
        renderTo: containerId,
        type: 'pie'
      },
      title: {
        text: '昌吉农商行放款额报表'
      },
      tooltip: {
        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
      },
      plotOptions: {
        pie: {
          allowPointSelect: true,
          cursor: 'pointer',
          dataLabels: {
            enabled: true,
            format: '<b>{point.name}</b>: {point.percentage:.1f} %',
            style: {
              color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
            }
          }
        }
      },
      series: [{
        name: '放款金额',
        colorByPoint: true,
        data: dataBox
      }]
    }
    new Highcharts.Chart(pieChart)

constructColumnChart = (title, categoriesData, progressData, containerId) ->
    chart = {
      chart: {type: 'column', renderTo: containerId},
      title: {text: title},
      xAxis: {categories: categoriesData},
      yAxis: {allowDecimals: false,  min: 0, minRange: 60 * 1000, title: { text: '金额(元)' }},
      credits: {enabled:false},
      series: [{ name: '放款金额', data: progressData}]
      tooltip: {
        formatter: ->
          '<b>' + this.x + '</b><br/>' + this.series.name + ': ' + this.y + '<br/>'
      }
    }
    new Highcharts.Chart(chart)



controllersModule
  .controller('ReportCtrl', ReportCtrl)
  .directive("fullyDone",fullyDone)