cp -r distributed_system distributed_system_$1

rm -r distributed_system_$1/tmp/

rm distributed_system_$1/config/initializers/remote_control.rb
ln distributed_system//config/initializers/remote_control.rb distributed_system_$1/config/initializers/remote_control.rb

rm -rf distributed_system_$1/lib/*
ln -rs distributed_system/lib/* distributed_system_$1/lib/

rm distributed_system_$1/config/routes.rb
ln distributed_system/config/routes.rb distributed_system_$1/config/routes.rb

rm -rf distributed_system_$1/app/*
ln -rs distributed_system/app/* distributed_system_$1/app/

rm distributed_system_$1/Gemfile*
ln  distributed_system/Gemfile* distributed_system_$1/
