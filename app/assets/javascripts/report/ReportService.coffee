class ReportService
  constructor: (@$log, @$http, @$q) ->
    @$log.debug "constructing ReportService"

  fetch: (parameter)->
      @$log.debug "find report items #{parameter}"
      deferred = @$q.defer()

      @$http(
        {
          url: 'http://localhost:8008/rest/db/report-demo',
          method: "POST",
          data: parameter
          headers: {
            'Content-Type': 'application/json; charset=utf-8'
          }
        }
      )
      .success((data, status, headers) =>
        @$log.info("Successfully get report items - status #{status}")
        deferred.resolve(data)
      )
      .error((data, status, headers) =>
        @$log.error("Failed to get report items - status #{status}")
        deferred.reject(data)
      )
      deferred.promise

servicesModule.service('ReportService', ReportService)