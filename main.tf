
data "local_file" "kubeconfig_file" {
    filename = "${path.module}/kubeconfig.yaml"
}



module "rancher-server-268" {
  source = "github.com/belgaied2/tf-module-rancher-server"
  rancher_hostname = "rancher-mbh.ps.rancher.space"
  rancher_k8s = {
    host = yamldecode(data.local_file.kubeconfig_file.content).clusters[0].cluster.server
    client_certificate = base64decode(yamldecode(data.local_file.kubeconfig_file.content).users[0].user.client-certificate-data)
    client_key = base64decode(yamldecode(data.local_file.kubeconfig_file.content).users[0].user.client-key-data)
    cluster_ca_certificate = base64decode(yamldecode(data.local_file.kubeconfig_file.content).clusters[0].cluster.certificate-authority-data)
  }
  cert_manager = {
    ns = "cert-manager"
    version = "v1.7.1"
    crd_url = ""
    chart_set = [
      installCRDs=true
    ]
  }
  rancher_server = {
    ns = "cattle-system"
    version = "v2.6.8"
    branch = "stable"
    chart_set = []
  }
}