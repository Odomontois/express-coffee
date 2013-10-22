#= require lib/koTick
#= require lib/koCanvasSize

class Point
	constructor: (x,y)->
		@x = ko.observable x
		@y = ko.observable y
	_addComp: (a,b)->
		a parseFloat(a()) + parseFloat(b())
	add: (point)-> 
		@_addComp @x, point.x
		@_addComp @y, point.y
	toString: -> "(#{@x()},#{@y()})"
	plain: -> 
		x: @x()
		y: @y()
Point.make = (point)-> new Point point.x, point.y

class ButtonState
	constructor:(@text, @className,@running,@board,@next)->
	css: -> "btn #{@className}"
	toggle: -> 
		next = @next.apply @board.buttonStates
		@board.buttonState next
		@board.running next.running

class DrawBoard
	constructor: (@id,@size,@bgColor,@penColor) ->
	context: -> 
		unless @_ctx?
			@_ctx = ($ "##{@id}")[0].getContext("2d")
		@_ctx
	clear: -> 
		@context().fillStyle = @bgColor
		@context().fillRect(0,0,@size().x(), @size().y())
	circle: (pos,radius)-> 
		@context().fillStyle = @penColor
		@context().beginPath()
		@context().arc(pos().x(), pos().y(), radius(), 0, Math.PI*2 )
		@context().fill()

class TennisBoard
	constructor: (@id,board)->
		unless board?
			@size     = ko.observable new Point 600, 400
			@pos      = ko.observable new Point 40,40 
			@move     = ko.observable new Point 1,1
			@interval = ko.observable 1000
			@running  = ko.observable false
			@radius   = ko.observable 20
		else
			@size     = ko.observable Point.make board.size
			@pos      = ko.observable Point.make board.pos
			@move     = ko.observable Point.make board.move
			@interval = ko.observable board.interval
			@running  = ko.observable true
			@radius   = ko.observable board.radius

		@buttonStates =
			stopped: new ButtonState "Run" , "btn-warning", false, this, ->@running
			running: new ButtonState "Stop", "btn-info"   , true , this, ->@stopped
		@buttonState = ko.observable @buttonStates.stopped

		@stepDraw = =>
			@draw.clear()
			@draw.circle(@pos,@radius) 
			@pos().add @move()
			@toggleDim("x")
			@toggleDim("y")
			
		@draw = new DrawBoard @canvasId(), @size, "black", "orange"
		
	canvasId: -> "canvas-#{@id}"
	dimOf: (comp, dim)-> parseFloat(comp()[dim]())
	toggleDim: (dim)-> 
		move = @dimOf @move, dim
		pos  = @dimOf @pos, dim
		size = @dimOf @size, dim
		radius = parseFloat(@radius())
		if  ((move < 0) and (pos <= radius) ) or
			((move > 0) and ((pos + radius) >= size))
				@move()[dim]( - move)
	plain: ->
		pos: @pos().plain()
		move: @move().plain()
		size: @size().plain()
		interval: @interval()
		radius: @radius()

class TennisViewModel
	constructor: (tennis)->
		@link = ko.observable()
		if tennis? 
			@boards = (new TennisBoard i,board for board,i in tennis.boards) 
			@link @getLink tennis._id
		else @boards = (new TennisBoard i for i in [1,2])
	dump: -> 
		data = boards: (board.plain() for board in @boards)
		$.post '/tennis/dump', data, ((id)=> @link @getLink id), "json"
	getLink: (id)-> "#{location.protocol}//#{location.host}/tennis/view/#{id}"



$ ->
	if tennisDbId? then $.get "/tennis/load/#{tennisDbId}",(tennis) -> ko.applyBindings new TennisViewModel tennis
	else ko.applyBindings new TennisViewModel()




