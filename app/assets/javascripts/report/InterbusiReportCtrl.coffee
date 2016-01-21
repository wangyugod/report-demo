class InterbusiReportCtrl
  constructor: (@$scope, @$log,@$location, @ReportService,@$route) ->
    @$scope.item = {}
    @hideObject = {hideBase: false, hideColumnChart: true, hidePieChart: true}
    @queryCondition = {startDate: '', endDate: ''}
    #These variables MUST be set as a minimum for the calendar to work
    @event = {
      format: 'yyyyMMdd'
    }

  toggle: ($event, field, event) ->
      $event.preventDefault()
      $event.stopPropagation()
      event[field] = !event[field]

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

  fetch: () ->
    @ReportService.fetch(@queryCondition, 'http://localhost:8008/rest/report/interbusistat')
    .then(
      (data) =>
        @$scope.item = data
    ,
      (error) =>
        @$log.error "Unable to fetch items"
    )

  onChange: (item) ->
    @$log.debug 'User selected ' + angular.toJson(item)
    @queryCondition.dept = item.fs_agent



controllersModule.controller('InterbusiReportCtrl', InterbusiReportCtrl)