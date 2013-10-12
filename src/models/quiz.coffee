mongoose = require 'mongoose'

# Quiz model
Quiz = new mongoose.Schema(
  header: String
  text: String
)

module.exports = mongoose.model 'Quiz', Quiz