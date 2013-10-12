class Quiz
	constructor:(@id)->
		@header = ko.observable "New Quiz"
		@text = ko.observable "Hello"
		@editTitle = ko.observable false
	enableEdit: (state) -> => 
		@editTitle state
		console.log("editTitle now is #{@editTitle()}")

class QuizViewModel
	constructor:->
		@quizes = ko.observableArray()
		@quiz = 
			id:0
			add: =>	@quizes.push new Quiz @quiz.id++
			remove: (quiz)=> @quizes.remove quiz
$ -> 
	ko.applyBindings new QuizViewModel
