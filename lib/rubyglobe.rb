=begin
***********************************************
* @author: Ferdinand E. Silva
* @email: ferdinandsilva@ferdinandsilva.com
* @title: PyGlobe
* @description: Ruby interface for Globe Labs API
***********************************************
=end

require 'soap/wsdlDriver'

WSDL_URL = 'http://iplaypen.globelabs.com.ph:1881/axis2/services/Platform?wsdl'

class RubyGlobeInvalidURLException < Exception
end

class RubyGlobeInvalidServiceException < Exception
end

class RubyGlobeServerFaultException < Exception
end

class RubyGlobeDisplay

	@@SEND_DIRECTLY_TO_DISPLAY = "0"
	@@SEND_TO_PHONE = "1"
	@@SEND_TO_SIM = "2"
	
	def self.SEND_DIRECTLY_TO_DISPLAY
		@@SEND_DIRECTLY_TO_DISPLAY
	end
	
	def self.SEND_TO_PHONE
		@@SEND_TO_PHONE
	end
	
	def self.SEND_TO_SIM
		@@SEND_TO_SIM
	end

end

class RubyGlobeMWI

	@@NONE = ""
	@@VOICE_MAIL_ICON_ACTIVATE = "0"
	@@FAX_ICON_ACTIVATE = "1"
	@@EMAIL_ICON_ACTIVATE = "2"
	@@OTHER_ACTIVATION = "3"
	@@DEACTIVATE_VOICE_MAIL_ICON = "4"
	@@DEACTIVATE_FAX_ICON = "5"
	@@DEACTIVATE_EMAIL_ICON = "6"
	@@DEACTIVATE_OTHER_ICON = "7"
	
	def self.NONE
		@@NONE
	end
	
	def self.VOICE_MAIL_ICON_ACTIVATE
		@@VOICE_MAIL_ICON_ACTIVATE
	end
	
	def self.FAX_ICON_ACTIVATE
		@@FAX_ICON_ACTIVATE
	end
	
	def self.EMAIL_ICON_ACTIVATE
		@@EMAIL_ICON_ACTIVATE
	end
	
	def self.OTHER_ACTIVATION
		@@OTHER_ACTIVATION
	end
	
	def self.DEACTIVATE_VOICE_MAIL_ICON
		@@DEACTIVATE_VOICE_MAIL_ICON
	end
	
	def self.DEACTIVATE_FAX_ICON
		@@DEACTIVATE_FAX_ICON
	end
	
	def self.DEACTIVATE_EMAIL_ICON
		@@DEACTIVATE_EMAIL_ICON
	end
	
	def self.DEACTIVATE_OTHER_ICON
		@@DEACTIVATE_OTHER_ICON
	end

end

class RubyGlobeCoding

	@@BIT_7 = "0"
	@@BIT_8 = "1"
	@@USC_2 = "2"
	
	def self.BIT_7
		@@BIT_7
	end
	
	def self.BIT_8
		@@BIT_8
	end
	
	def self.USC_2
		@@USC_2
	end

end

class RubyGlobeReturnCode

	@@NOT_ALLOWED = "301"
	@@EXCEEDED_DAILY_CAP = "302"
	@@INVALID_MESSAGE_LENGTH = "303"
	@@MAX_NUMBER_CONNECTION = "304"
	@@INVALID_LOGIN_CREDENTIALS = "305"
	@@SMS_SENDING_FAILED = "401"
	@@MMS_SENDING_FAILED = "402"
	@@INVALID_TARGET = "501"
	@@INVALID_DISPLAY = "502"
	@@INVALID_MWI = "503"
	@@BAD_XML = "506"
	@@INVALID_CODING = "504"
	@@EMPTY_VALUE = "505"
	@@ARGUMENT_TOO_LARGE = "507"
	@@SMS_ACCEPTED = "201"
	@@MMS_ACCEPTED = "202"
	
	def self.NOT_ALLOWED
		@@NOT_ALLOWED
	end
	
	def self.EXCEEDED_DAILY_CAP
		@@EXCEEDED_DAILY_CAP
	end
	
	def self.INVALID_MESSAGE_LENGTH
		@@INVALID_MESSAGE_LENGTH
	end
	
	def self.MAX_NUMBER_CONNECTION
		@@MAX_NUMBER_CONNECTION
	end
	
	def self.INVALID_LOGIN_CREDENTIALS
		@@INVALID_LOGIN_CREDENTIALS
	end
	
	def self.SMS_SENDING_FAILED
		@@SMS_SENDING_FAILED
	end
	
	def self.MMS_SENDING_FAILED
		@@MMS_SENDING_FAILED
	end
	
	def self.INVALID_TARGET
		@@INVALID_TARGET
	end
	
	def self.INVALID_DISPLAY
		@@INVALID_DISPLAY
	end
	
	def self.INVALID_MWI
		@@INVALID_MWI
	end
	
	def self.BAD_XML
		@@BAD_XML
	end
	
	def self.INVALID_CODING
		@@INVALID_CODING
	end
	
	def self.EMPTY_VALUE
		@@EMPTY_VALUE
	end
	
	def self.ARGUMENT_TOO_LARGE
		@@ARGUMENT_TOO_LARGE
	end
	
	def self.SMS_ACCEPTED
		@@SMS_ACCEPTED
	end
	
	def self.MMS_ACCEPTED
		@@MMS_ACCEPTED
	end

end

class RubyGlobe

		@@__VERSION__ = "1.2"
		@@__AUTHOR__ = "Ferdinand E. Silva"
		
	def self.__VERSION__
		@@__VERSION__
	end
	
	def self.__AUTHOR__
		@@__AUTHOR__
	end

	def initialize(uname, pin, msisdn, wsdl = WSDL_URL, display = RubyGlobeDisplay.SEND_TO_PHONE, udh = "", mwi = RubyGlobeMWI.NONE, coding = RubyGlobeCoding.BIT_7)
	
		@wsdl = wsdl
		@uname = uname
		@pin = pin
		@msisdn = msisdn
		@display = display
		@udh = udh
		@mwi = mwi
		@coding = coding
		@service = nil
		
		begin
			@service = SOAP::WSDLDriverFactory.new(@wsdl).create_rpc_driver	
		rescue RuntimeError
			raise RubyGlobeInvalidURLException, "Invalid URL"
		rescue SocketError
			raise RubyGlobeInvalidServiceException, "Service Unknown"
		end
	
	end
	
	def translateMsg(ret)
	
		if ret == RubyGlobeReturnCode.SMS_ACCEPTED || ret == RubyGlobeReturnCode.MMS_ACCEPTED
			return true
		elsif ret == RubyGlobeReturnCode.NOT_ALLOWED
			raise RubyGlobeServerFaultException, "User is not allowed to access this service"
		elsif ret == RubyGlobeReturnCode.EXCEEDED_DAILY_CAP
			raise RubyGlobeServerFaultException, "User exceeded daily cap"
		elsif ret == RubyGlobeReturnCode.INVALID_MESSAGE_LENGTH
			raise RubyGlobeServerFaultException, "Invalid message length"
		elsif ret == RubyGlobeReturnCode.MAX_NUMBER_CONNECTION
			raise RubyGlobeServerFaultException, "Maximum Number of simultaneous connections reached"
		elsif ret == RubyGlobeReturnCode.INVALID_LOGIN_CREDENTIALS
			raise RubyGlobeServerFaultException, "Invalid login credentials"
		elsif ret == RubyGlobeReturnCode.SMS_SENDING_FAILED
			raise RubyGlobeServerFaultException, "SMS sending failed"
		elsif ret == RubyGlobeReturnCode.INVALID_TARGET
				raise RubyGlobeServerFaultException, "Invalid target MSISDN"
		elsif ret == RubyGlobeReturnCode.INVALID_DISPLAY
				raise RubyGlobeServerFaultException, "Invalid display type"
		elsif ret == RubyGlobeReturnCode.INVALID_MWI
				raise RubyGlobeServerFaultException, "Invalid MWI"
		elsif ret == RubyGlobeReturnCode.BAD_XML
				raise RubyGlobeServerFaultException, "Badly formed XML in SOAP request"
		elsif ret == RubyGlobeReturnCode.INVALID_CODING
				raise RubyGlobeServerFaultException, "Invalid Coding"
		elsif ret == RubyGlobeReturnCode.EMPTY_VALUE
				raise RubyGlobeServerFaultException, "Empty value given in required argument"
		elsif ret == RubyGlobeReturnCode.ARGUMENT_TOO_LARGE
			raise RubyGlobeServerFaultException, "Argument given too large"
		end
	
	end
	
	def sendSMS(message)
		
		begin
			ret = @service.sendSMS(:uName => @uname, :uPin => @pin, :MSISDN => @msisdn, :messageString => message, :Display => @display, :udh => @udh, :mwi => @mwi, :coding => @coding).return.to_s
			
			return translateMsg ret
			
		rescue SocketError
			raise RubyGlobeInvalidServiceException, "Service Unknown"
		end
		
	end
	
	def sendMMS(subject, smil)
		
		begin
			ret = @service.sendMMS(:uName => @uname, :uPin => @pin, :MSISDN => @msisdn, :subject => subject, :smil => smil).return.to_s
			
			return translateMsg ret
			
		rescue SocketError
			raise RubyGlobeInvalidServiceException, "Service Unknown"
		end
		
	end

end
