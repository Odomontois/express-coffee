class Quiz
	constructor:(@model, @id,@new,header = "New Quiz",text = "Hello", edit = false)->
		@header = ko.observable header
		@text = ko.observable text
		@edit = ko.observable edit
	enableEdit: (edit) -> => 
		@edit edit
		@save() if not edit 

	save: ->
		data = 
			header: @header()
			text: @text()
		if @new
			$.post "/quizes/create", data, (quiz)->
				@new = false
				@id = quiz._id
		else
			$.post "/quizes/update/#{@id}",data
	remove: =>
		if @new 
			@model.quizes.remove this
		else
			$.post "/quizes/delete/#{@id}",{}, => @model.quizes.remove this



class QuizViewModel
	constructor:->
		@quizes = ko.observableArray()
		@quiz = 
			id:0
			add: =>	@quizes.push new Quiz  this, @quiz.id++,true
		$.get '/quizes/index',(quizes) =>
			@quizes (new Quiz(this, quiz._id, false, quiz.header, quiz.text) for quiz in quizes)

$ -> 
	ko.applyBindings new QuizViewModel
