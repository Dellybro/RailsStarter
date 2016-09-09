class ApplicationMailer < ActionMailer::Base
	include SendGrid 
  	default from: "do_not_reply@start.io"
  	layout 'mailer'
end