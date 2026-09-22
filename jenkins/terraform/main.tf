terraform {
  required_version = ">= 1.0.0"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.20"
    }
  }
}

provider "kubernetes" {
  config_path = var.kubeconfig_path != "" ? var.kubeconfig_path : null
}

resource "kubernetes_namespace_v1" "go_ns" {
  metadata {
    name = var.namespace
    labels = {
      name       = var.namespace
      managed-by = "terraform"
    }
  }
}

resource "kubernetes_deployment_v1" "go_deploy" {
  metadata {
    name      = "go-deployment"
    namespace = kubernetes_namespace_v1.go_ns.metadata[0].name
    labels = {
      app        = "go-backend-app"
      managed-by = "terraform"
    }
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = "go-backend-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "go-backend-app"
        }
      }

      spec {
        container {
          name              = "go-container"
          image             = var.app_image
          image_pull_policy = "Always"

          port {
            name           = "http"
            container_port = 3000
          }

          resources {
            limits = {
              cpu    = "200m"
              memory = "256Mi"
            }
            requests = {
              cpu    = "50m"
              memory = "64Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/api/status"
              port = 3000
            }
            initial_delay_seconds = 5
            period_seconds        = 10
          }

          readiness_probe {
            http_get {
              path = "/api/status"
              port = 3000
            }
            initial_delay_seconds = 2
            period_seconds        = 5
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "go_service" {
  metadata {
    name      = "go-service"
    namespace = kubernetes_namespace_v1.go_ns.metadata[0].name
    labels = {
      app        = "go-backend-app"
      managed-by = "terraform"
    }
  }

  spec {
    selector = {
      app = "go-backend-app"
    }

    port {
      name        = "http"
      port        = 3000
      target_port = 3000
      node_port   = var.node_port
    }

    type = "NodePort"
  }
}
