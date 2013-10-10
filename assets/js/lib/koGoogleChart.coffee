ko.bindingHandlers.googleChart = 
	init: (element,accessor,allBindingsAccessor) ->
		bindings = allBindingsAccessor()
		@options = title: bindings.title || ''
		@chart = new google.visualization.LineChart element
		@itemFormat = (items)->	
			format = bindings.format
			names = [title for own id,title of format]
			names.concat((item[id] for own id of format) for item in items)

	update: (element,accessor)->
		list = ko.unwrap accessor()
		data = google.visualization.arrayToDataTable @itemFormat list
		@chart.draw data, @options