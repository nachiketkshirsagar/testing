require 'rubygems' 
require 'net/ssh'
require 'net/scp'

HOST = '54.255.170.191'
USER = 'ubuntu' 
key = '~/.ssh/MerchantEcoTest.pem'

Net::SCP.start( HOST, USER, :keys => key ) do|scp| 
  scp.download!('/var/log/mlex/mlex_stdout.log','/Users/nachiket/Desktop/first_log.txt')
end 
