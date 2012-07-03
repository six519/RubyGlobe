HOW TO INSTALL
--------------
To install run ``gem install RubyGlobe``


SENDING SMS
------------
::

	require 'rubygems'
	require 'rubyglobe'

	begin
		service = RubyGlobe.new '<globe API uname>','<globe API pin>','<11 digit mobile number>'
		service.sendSMS 'Message through Globe Labs API'
	rescue RubyGlobeInvalidServiceException, RubyGlobeInvalidURLException, RubyGlobeServerFaultException => e
		puts "An error occurred: " << e
	end
	
SENDING MMS
------------
::

	require 'rubygems'
	require 'rubyglobe'

	#Valid SMIL (Synchronized Multimedia Integration Language)
	smil = "<smil><head><layout><root-layout height='96' width='122' /><region height='67%' fit='meet' id='Image' width='100%' left='0%' top='0%' /><region height='33%' fit='scroll' id='Text' width='100%' left='0%' top='67%' /></layout></head><body><par dur='8000ms'><img src='https://www.globelabs.com.ph/Style%20Library/en-us/Core%20Styles/MasterPageStyles/images/globe_logo_NOtag_155x60px.png' region='Image' /><text src='http://ferdinandsilva.com/hello.txt' region='Text' /></par></body></smil>"

	begin
		service = RubyGlobe.new '<globe API uname>','<globe API pin>','<11 digit mobile number>'
		service.sendMMS '<subject>', smil
	rescue RubyGlobeInvalidServiceException, RubyGlobeInvalidURLException, RubyGlobeServerFaultException => e
		puts "An error occurred: " << e
	end
