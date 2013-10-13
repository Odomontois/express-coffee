mongoose = require 'mongoose'

# Quiz model
Quiz = new mongoose.Schema(
  title: String
  text: String
  questions: [
  	text: String
  	answers: [
  		text: String
  		points: [
  			dim: String
  			value: Number
  		]
  	]
  ]
  dimensions:[String]
  results:[
  	title: String
  	areas:[
  		dim:String
  		low:Number
  		high:Number
  	]
  ]
)

module.exports = mongoose.model 'Quiz', Quiz