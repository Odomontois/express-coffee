mongoose = require 'mongoose'

Tennis = new mongoose.Schema(
	boards: [
		pos:
			x: Number
			y: Number
		move:
			x: Number
			y: Number
		size:
			x: Number
			y: Number
		interval: Number
		radius: Number
	]
)
module.exports = mongoose.model 'Tennis', Tennis
