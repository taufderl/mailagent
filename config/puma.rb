# Change to match your CPU core count
workers 2

# Min and Max threads per worker
threads 1, 6

app_dir = '/home/kkb/mailagent'
directory app_dir

environment "production"

bind "tcp://0.0.0.0:1337"
bind "unix://#{app_dir}/tmp/sockets/mailagent.sock"

# Logging
stdout_redirect "#{app_dir}/log/puma.stdout.log", "#{app_dir}/log/puma.stderr.log", true
