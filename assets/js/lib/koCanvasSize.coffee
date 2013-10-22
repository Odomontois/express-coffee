ko.bindingHandlers.canvasSize = 
	update: (element,accessor) ->
		size = ko.unwrap accessor()
		element.width = ko.unwrap size.x
		element.height = ko.unwrap size.y

