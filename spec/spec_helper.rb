ENV['PATH'] = "#{File.expand_path(File.dirname(__FILE__) + '/../../bin')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"
LIB_DIR = File.expand_path(File.join(File.expand_path(File.dirname(__FILE__)),'..','..','lib'))

require "location_grabber/lib_location_grabber"