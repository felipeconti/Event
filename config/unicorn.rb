APP_PATH = "/var/www/Event/"

worker_processes 4

working_directory APP_PATH

listen "/tmp/unicorn.trip.sock", :backlog => 64
#listen 8080, :tcp_nopush => true

timeout 60

preload_app true

pid APP_PATH+"/tmp/pids/unicorn.pid"

stderr_path APP_PATH+"/log/unicorn.stderr.log"
stdout_path APP_PATH+"/log/unicorn.stdout.log"

#check_client_connection false

before_fork do |server, worker|
# Disconnect since the database connection will not carry over
if defined? ActiveRecord::Base
	ActiveRecord::Base.connection.disconnect!
end

# Quit the old unicorn process
old_pid = "#{server.config[:pid]}.oldbin"
if File.exists?(old_pid) && server.pid != old_pid
begin
	Process.kill("QUIT", File.read(old_pid).to_i)
		rescue Errno::ENOENT, Errno::ESRCH
		# someone else did our job for us
		end
	end
end

after_fork do |server, worker|
	# Start up the database connection again in the worker
	if defined?(ActiveRecord::Base)
		ActiveRecord::Base.establish_connection
	end
end

before_exec do |server|
	ENV['BUNDLE_GEMFILE'] = APP_PATH+"/Gemfile"
end
