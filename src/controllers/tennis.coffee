Tennis = require "../models/tennis"

module.exports =
	index:(req,res)-> res.render 'tennis', dbId:null
	dump: (req,res)-> 
		tennis = new Tennis req.body
		tennis.save (err, tennis)->
			if not err
				res.send tennis._id
				res.statusCode = 201
			else
				res.send err
				res.statusCode = 500
	load:(req,res)->
		tennis = Tennis.findById req.params.id, (err, tennis) ->
			if not err
				console.log tennis
				res.send tennis
			else
				res.send err
				res.statusCode = 500
	view:(req,res)-> res.render 'tennis', dbId:req.params.id