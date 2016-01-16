
dependencies = [
    'ngRoute',
    'ui.bootstrap',
    'myApp.filters',
    'myApp.services',
    'myApp.controllers',
    'myApp.directives',
    'myApp.common',
    'myApp.routeConfig'
]

app = angular.module('myApp', dependencies)

angular.module('myApp.routeConfig', ['ngRoute'])
    .config ($sceDelegateProvider) ->
        $sceDelegateProvider.resourceUrlWhitelist(['self', 'http://localhost:8008/**'])
    .config ($routeProvider) ->
        $routeProvider
            .when('/', {
                templateUrl: '/assets/partials/view.html'
            })
    .config ($locationProvider) ->
        $locationProvider.html5Mode({
            enabled: true,
            requireBase: false
        })

datepickerPopup = () ->
  {
  restrict: 'EAC',
  require: 'ngModel',
  link: (scope, element, attr, controller) ->
    controller.$formatters.shift();
  }



app.directive('datepickerPopup', datepickerPopup)

parseDate = (dateFilter, $parse) ->
  {
    restrict:'EAC',
    require:'?ngModel',
    link:(scope,element,attrs,ngModel,ctrl) ->
      ngModel.$parsers.push((viewValue) ->
        dateFilter(viewValue,'yyyyMMdd')
      )
  }

app.directive('parseDate', parseDate)

@commonModule = angular.module('myApp.common', [])
@controllersModule = angular.module('myApp.controllers', [])
@servicesModule = angular.module('myApp.services', [])
@modelsModule = angular.module('myApp.models', [])
@directivesModule = angular.module('myApp.directives', [])
@filtersModule = angular.module('myApp.filters', [])