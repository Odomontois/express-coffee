class Quiz
	constructor:(@model, @id,@new, edit = false ,data)->
		@edit = ko.observable edit
		@title = ko.observable data.title || 'New Quiz'
		@text = ko.observable data.text || 'Test Text'
		@dimensions  = ko.observableArray(data.dimensions || [])
	enableEdit: (edit) -> => 
		@edit edit
		@save() if not edit 

	save: ->
		data = 
			title: @title()
			text: @text()
		if @new
			$.post "/quizes/create", data, (quiz)=>
				@new = false
				@id = quiz._id
			,"json"
		else
			$.post "/quizes/update/#{@id}",data,null,"json"
	remove: =>
		if @new 
			@model.quizes.remove this
		else
			$.post "/quizes/delete/#{@id}",{}, (=> @model.quizes.remove this),"json"



class QuizViewModel
	constructor:->
		@quizes = ko.observableArray()
		@quiz = 
			id:0
			add: =>	@quizes.push new Quiz  this, @quiz.id++,true,true,{}
		$.get '/quizes/index',(quizes) =>
			@quizes (new Quiz(this, quiz._id, false, false, quiz) for quiz in quizes)

$ -> 
	ko.applyBindings new QuizViewModel
