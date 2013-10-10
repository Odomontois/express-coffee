#= require lib/jquery
#= require lib/knockout
#= require lib/koGoogleChart

class CalcViewModel
	constructor:  ->
		@dice = ko.observable 6 
		@count = ko.observable 6
		@list = ko.computed => 
			count = parseInt @count()
			dice = parseInt @dice()
			{points: count+i, value: x} for x,i  in @power (@initialDice dice), count

	initialDice: (d)-> (1.0/ d) for i in [1..d]

	power: (dice,count) -> if count == 1 then dice else @convolution(dice,@power(dice,count-1))

	convolution: (a,b)-> 
		r = (0 for i in [0..(a.length + b.length - 2)])
		r[i+j]+=x*y for x,i in a for y,j in b
		# console.log a,b,r
		r
	chart:
		format: 
			points: "Points"
			value: "Probability"
		title: "Dice Probability"


$ -> ko.applyBindings new CalcViewModel()

google.load "visualization", "1",  packages:["corechart"]


