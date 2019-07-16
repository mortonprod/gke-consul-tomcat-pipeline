apply: init plan
	terraform apply --auto-approve
	echo "$(terraform output kubeconfig)" > ./.kube/eksconfig
plan: init
	terraform plan 
destroy: init
	terraform destroy --auto-approve
refresh: init
	terraform refresh
init: 
	terraform init
	touch init