variable "kubeconfig_path" {
  description = "Path to kubeconfig file (leave empty to use in-cluster config when running on Kubernetes/Jenkins agent)"
  type        = string
  default     = ""
}

variable "app_image" {
  description = "Docker image repository and tag for Go application"
  type        = string
  default     = "abhijeetnagar56/go-basic-server:latest"
}

variable "namespace" {
  description = "Kubernetes namespace for the application"
  type        = string
  default     = "go-backend-app"
}

variable "replicas" {
  description = "Number of deployment replicas"
  type        = number
  default     = 2
}

variable "node_port" {
  description = "NodePort exposed on Kubernetes nodes (leave null for auto-assigned)"
  type        = number
  default     = null
}
