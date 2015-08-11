# SERVER_SIDE

# First initiate a new git repo on home
mkdir app_deploy && cd app_deploy
git init --bare
# Edit your hook files
wget -O hooks/post-receive https://raw.githubusercontent.com/eduardoschneiders/learning/master/bash/deploy/app_deploy/hooks/post-receive
# Add execution permission on them
sudo chmod +x hooks/post-receive

# CLIENT_SIDE

# Create ssh config
wget https://raw.githubusercontent.com/eduardoschneiders/learning/master/bash/deploy/config
# Add a new remote to project
git remote add production ec2:app_deploy
# Push changes to new remote
git push production master
