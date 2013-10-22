passport = require 'passport'
LinkedInStrategy = (require 'passport-linkedin').OAuth2Strategy

LINKEDIN_API_KEY = 


module.exports = (app) -> 
	passport.use ( new LinkedInStrategy
		consumerKey: LINKEDIN_API_KEY
		consumerSecret: LINKEDIN_SECRET_KEY
		callbackUrl: "/auth/linkedin/callback")	,
		



