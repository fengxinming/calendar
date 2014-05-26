calendar
========

日历控件

定义angular指令
	module.directive('calendar', function() {
		return {
			require: '?ngModel',
			link: function(scope, element, attr, ngModel) {
				if (!ngModel) return;
				ngModel.$render = function() {
					element.val(ngModel.$viewValue || ''); 
				};

				ngModel.$parsers.push(function(date) {
					return $.calendarpicker.parseDate(date);
				});
				
				ngModel.$formatters.push(function(date) {
					return $.calendarpicker.formatDate(date);
				});

				element.calendarpicker({
					onSelect: function(date) {
						scope.$apply(function() {
							ngModel.$setViewValue(date);
							ngModel.$render();
						});
					}
				});
			}
		};
	});

在html中使用
	<input calendar ng-model='date' readonly />

在Controller中使用
	$scope.date = new Date();
