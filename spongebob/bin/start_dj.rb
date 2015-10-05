#!/usr/bin/env ruby
def main
  unless ARGV.empty?
    threads = []
    queues = []
    ARGV.each_with_index do |arg, i|
      if i%2 == 0
        queues << arg
      else
        threads << arg
      end
    end
    if threads.size == queues.size
    n = 0
      (0..(threads.size-1)).each do |i|
        threads[i].to_i.times do 
          puts `#{dj_script_path} -m --queues #{queues[i]} -p #{queues[i]} -i #{n} start`
          n = n + 1
        end
      end
    else
      run_delayed_job_with_default_config
    end
  else
    run_delayed_job_with_default_config
  end
end

def run_delayed_job_with_default_config
  if ENV['RAILS_ENV'] == 'test'
    puts `#{dj_script_path} --queues=* -n 3 start`
  else
    puts `#{dj_script_path} --queues=* start`
  end
end

def dj_script_path
  File.join(File.expand_path(File.dirname(__FILE__)), 'delayed_job')
end

main