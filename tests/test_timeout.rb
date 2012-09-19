#!/usr/bin/env ruby

require 'timeout'

@destination_ip = '199.47.218.150'
TRACEROUTE=`which traceroute`.chomp


def execute_with_timeout!(command, timeout)
  begin
    pipe = IO.popen(command, 'r')
  rescue Exception => e
    raise "Execution of command #{command} unsuccessful"
  end

  output = ""
  begin
    status = Timeout::timeout(timeout) {
      #Process.waitpid2(pipe.pid)
      output = pipe.gets(nil)
    }
  rescue Timeout::Error
    Process.kill('KILL', pipe.pid)
  end
  pipe.close
  output
end


puts execute_with_timeout!("#{TRACEROUTE} -n #{@destination_ip} & sleep 5 ; if ps aux | awk '{print $2 }' | grep $! > /dev/null; then kill -9 $!; fi", 10)

