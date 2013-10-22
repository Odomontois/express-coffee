ko.bindingHandlers.tick =
	update: (element, accessor, allBindingsAccessor) ->
		bindings = allBindingsAccessor()
		interval = ko.unwrap bindings.interval
		func = ko.unwrap accessor()
		running = ko.unwrap bindings.running
		if element._intObj?
			clearInterval(element._intObj)
			element._intObj = null
		if running 
			element._intObj= setInterval func,interval||1000
