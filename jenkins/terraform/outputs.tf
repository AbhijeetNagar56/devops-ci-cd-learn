output "namespace" {
  description = "Kubernetes namespace"
  value       = kubernetes_namespace_v1.go_ns.metadata[0].name
}

output "deployment_name" {
  description = "Deployment name"
  value       = kubernetes_deployment_v1.go_deploy.metadata[0].name
}

output "service_name" {
  description = "Service name"
  value       = kubernetes_service_v1.go_service.metadata[0].name
}

output "service_node_port" {
  description = "NodePort of the service"
  value       = try(kubernetes_service_v1.go_service.spec[0].port[0].node_port, null)
}
