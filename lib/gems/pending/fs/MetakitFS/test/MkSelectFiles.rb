require 'log4r'
require 'fs/MiqFsUtil'
require 'fs/MiqFS/MiqFS'
require 'fs/MetakitFS/MetakitFS'
require 'fs/MiqFS/modules/LocalFS'


#
# Formatter to output log messages to the console.
#
$stderr.sync = true
class ConsoleFormatter < Log4r::Formatter
	def format(event)
		t = Time.now
		"#{t.hour}:#{t.min}:#{t.sec}: " + (event.data.kind_of?(String) ? event.data : event.data.inspect) + "\n"
	end
end
$log = Log4r::Logger.new 'toplog'
Log4r::StderrOutputter.new('err_console', :level=>Log4r::DEBUG, :formatter=>ConsoleFormatter)
$log.add 'err_console'

dobj = OpenStruct.new
dobj.mkfile = ARGV[1]
dobj.create = true

toFs	= MiqFS.new(MetakitFS, dobj)
fromFs	= MiqFS.new(LocalFS, nil)

cf = MiqFsUtil.new(fromFs, toFs, ARGV[0])
cf.verbose = true
cf.update
