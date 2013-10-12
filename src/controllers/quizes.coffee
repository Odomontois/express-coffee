Quiz = require '../models/quiz'

# Quiz model's CRUD controller.
module.exports = 

  # Lists all quizs
  index: (req, res) ->
    Quiz.find {}, (err, quizs) ->
      res.send quizs
      
  # Creates new quiz with data from `req.body`
  create: (req, res) ->
    quiz = new Quiz req.body
    quiz.save (err, quiz) ->
      if not err
        res.send quiz
        res.statusCode = 201
      else
        res.send err
        res.statusCode = 500
        
  # Gets quiz by id
  get: (req, res) ->
    Quiz.findById req.params.id, (err, quiz) ->
      if not err
        res.send quiz
      else
        res.send err
        res.statusCode = 500
             
  # Updates quiz with data from `req.body`
  update: (req, res) ->
    Quiz.findByIdAndUpdate req.params.id, {"$set":req.body}, (err, quiz) ->
      if not err
        res.send quiz
      else
        res.send err
        res.statusCode = 500
    
  # Deletes quiz by id
  delete: (req, res) ->
    Quiz.findByIdAndRemove req.params.id, (err) ->
      if not err
        res.send {}
      else
        res.send err
        res.statusCode = 500
      
  