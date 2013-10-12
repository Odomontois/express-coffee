request = require 'supertest'

Quiz = require process.cwd() + '/.app/models/quiz'
app = require process.cwd() + '/.app'


INITIAL_DATA = {
  "header":"Some Data"
  "text": """Some Text
            line
            another Line"""
}

UPDATED_DATA = {
  "header":"Another data"
}

cleanDB = (done) ->
  Quiz.remove {}, ->
    done()

describe 'Quiz', ->
  before cleanDB
  
  quiz_id = null
      
  it "should be created", (done) ->
    request(app)
      .post("/quizs/create")
      .send(INITIAL_DATA)
      .expect 201, (err, res) ->
        res.body.should.include(INITIAL_DATA)
        res.body.should.have.property "_id"
        res.body["_id"].should.be.ok
        quiz_id = res.body["_id"]
        done()
        
  it "should be accessible by id", (done) ->
    request(app)
      .get("/quizs/get/#{quiz_id}")
      .expect 200, (err, res) ->
        res.body.should.include(INITIAL_DATA)
        res.body.should.have.property "_id"
        res.body["_id"].should.be.eql quiz_id
        done()
        
  it "should be listed in list", (done) ->
    request(app)
      .get("/quizs")
      .expect 200, (err, res) ->
        res.body.should.be.an.instanceof Array
        res.body.should.have.length 1
        res.body[0].should.include(INITIAL_DATA)
        done()
    
  it "should be updated", (done) ->
    request(app)
      .post("/quizs/update/#{quiz_id}")
      .send(UPDATED_DATA)
      .expect 200, (err, res) ->
        res.body.should.include(UPDATED_DATA)
        done()
        
  it "should be persisted after update", (done) ->
    request(app)
      .get("/quizs/get/#{quiz_id}")
      .expect 200, (err, res) ->
        res.body.should.include(UPDATED_DATA)
        res.body.should.have.property "_id"
        res.body["_id"].should.be.eql quiz_id
        done()
  
  it "should be removed", (done) ->
    request(app)
      .del("/quizs/delete/#{quiz_id}")
      .expect 200, (err, res) ->
        done()
    
  it "should not be listed after remove", (done) ->
    request(app)
      .get("/quizs")
      .expect 200, (err, res) ->
        res.body.should.be.an.instanceof Array
        res.body.should.have.length 0
        done()
        
  after cleanDB
      