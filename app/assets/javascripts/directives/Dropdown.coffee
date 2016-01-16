Dropdown = (@$q, @$http) ->
  {
    restrict: 'E',
    require: '^ngModel',
    scope:{
      ngModel: '=',
      tableName: '=tableName',
      columnNames: '=columnName',
      condition: '=sqlCondition'
      onChange: '&',
      values: '=values'
      items: '=',
      displayField: '=',
      valueField: '='
    },
    link: (scope, element, attrs) ->
      console.log "constructing dropdown"
      element.on('click', (event) ->
        event.preventDefault()
      )

      #根据表名和字段名
      columnNameArr = scope.columnNames.split(',')
      parameter = {columnNames: columnNameArr, condition: scope.condition, tableName: scope.tableName, values: ["1%"]}
      deferred = @$q.defer()
      @$http(
        {
          url: 'http://localhost:8008/rest/db/directive',
          method: "POST",
          data: parameter
          headers: {
            'Content-Type': 'application/json; charset=utf-8'
          }
        }
      )
      .success((data, status, headers) =>
        console.log("Successfully get report items - status #{status}")
        scope.items = data
        deferred.resolve(data)
      )
      .error((data, status, headers) =>
        console.error("Failed to get report items - status #{status}")
        deferred.reject(data)
      )
      deferred.promise

      scope.default = '请选择'
      if !scope.displayField
        scope.displayField = columnNameArr[0]
      if !scope.valueField
        scope.valueField = columnNameArr[1]
      #scope.isButton = 'isButton' in attrs
      scope.select = (item) ->
        scope.ngModel = item
        if scope.onChange
          scope.onChange({item: item, valueField: scope.valueField})
    ,templateUrl: '/assets/directive/dropdown-template.html'
  }

directivesModule.directive('dropdown', Dropdown)