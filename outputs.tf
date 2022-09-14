output "kubeconfig_decoded" {
  value = yamldecode(data.local_file.kubeconfig_file.content)
}