sudo apt-get -yq update
sudo apt -yq install virtualbox
sudo apt -yq install vagrant
git clone https://github.com/mortonprod/gke-consul-tomcat-pipeline
git --git-dir=/home/ubuntu/gke-consul-tomcat-pipeline/.git checkout -b feature/deployment-dev origin/feature/deployment-dev