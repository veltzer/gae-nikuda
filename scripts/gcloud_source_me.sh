source ~/.locations
# google cloud stuff
# project_name
export GCLOUD_PROJECT_NAME=`basename $PWD`
# The next line updates PATH for the Google Cloud SDK.
source $LOCATION_GAE/path.bash.inc
# The next line enables bash completion for gcloud.
source $LOCATION_GAE/completion.bash.inc
# this is left out by google's path.bash.inc
export PATH=$LOCATION_GAE/platform/google_appengine:$PATH
# this is for our own project
gcloud config configurations activate $GCLOUD_PROJECT_NAME
