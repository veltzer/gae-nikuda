# google cloud stuff
export GAE=~/shared_archive/install/google-cloud-sdk
# The next line updates PATH for the Google Cloud SDK.
source $GAE/path.bash.inc
# The next line enables bash completion for gcloud.
source $GAE/completion.bash.inc
# this is left out by google's path.bash.inc
export PATH=$GAE/platform/google_appengine:$PATH
# this is for our own project
gcloud config configurations activate `basename $PWD`
