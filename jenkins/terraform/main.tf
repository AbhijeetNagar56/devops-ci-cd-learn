provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "go_ns" {
  metadata {
    name = "go-backend-app"
  }
}

resource "kubernetes_deployment" "go_deploy" {
  metadata {
    name      = "go-deployment"
    namespace = kubernetes_namespace.go_ns.metadata[0].name
  }

  spec {
    replicas = 1

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
          name  = "go-container"
          image = "abhijeetnagar56/go-basic-server:latest"

          port {
            container_port = 3000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "go_service" {
  metadata {
    name      = "go-service"
    namespace = kubernetes_namespace.go_ns.metadata[0].name
  }

  spec {
    selector = {
      app = "go-backend-app"
    }

    port {
      port        = 3000
      target_port = 3000
    }

    type = "NodePort"
  }
}