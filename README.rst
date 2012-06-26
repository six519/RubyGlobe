HOW TO INSTALL
--------------
To install run ``gem install PyGlobe``


EXAMPLE CODE
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
