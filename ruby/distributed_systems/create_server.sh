cp -r distributed_system distributed_system_$1

rm -r distributed_system_$1/tmp/

rm distributed_system_$1/config/initializers/remote_control.rb
ln distributed_system//config/initializers/remote_control.rb distributed_system_$1/config/initializers/remote_control.rb

rm distributed_system_$1/lib/middlewares/remote_control.rb
ln distributed_system/lib/middlewares/remote_control.rb distributed_system_$1/lib/middlewares/
