# SERVER_SIDE

# First initiate a new git repo on home
mkdir app_deploy && cd app_deploy
git init --bare
# Edit your hook files
wget file_path
# Add execution permission on them
sudo chmod +x hooks/post-receive

# CLIENT_SIDE

# Create ssh config
wget file_path
# Add a new remote to project
git remote add production ec2:app_deploy
# Push changes to new remote
git push production master
