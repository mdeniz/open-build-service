worker_processes 4
listen 3000

after_fork do |server, _|
  listener = server.listener_opts.first[0]
  port = Integer(listener.split(':')[1])
  ActiveXML::api.port = port
  CONFIG['frontend_port'] = port
  # Needed by Vanity http://vanity.labnotes.org/rails.html
  ActiveRecord::Base.establish_connection
  Vanity.playground.establish_connection
end
