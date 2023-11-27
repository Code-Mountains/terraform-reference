## $ [cloud_user@ip-10-0-1-220 section2-hol1]$ cat ~/.kube/config
```
apiVersion: v1
clusters:
- cluster:
    certificate-authority: /home/cloud_user/.minikube/ca.crt
    server: https://172.17.0.3:8443
  name: minikube
contexts:
- context:
    cluster: minikube
    user: minikube
  name: minikube
current-context: minikube
kind: Config
preferences: {}
users:
- name: minikube
  user:
    client-certificate: /home/cloud_user/.minikube/profiles/minikube/client.crt
    client-key: /home/cloud_user/.minikube/profiles/minikube/client.key
```

## $ [cloud_user@ip-10-0-1-220 section2-hol1]$ kubectl get all -A --show-labels
```
NAMESPACE     NAME                                   READY   STATUS             RESTARTS   AGE   LABELS
kube-system   pod/coredns-f9fd979d6-7887l            0/1     Running            0          26m   k8s-app=kube-dns,pod-template-hash=f9fd979d6
kube-system   pod/etcd-minikube                      1/1     Running            0          26m   component=etcd,tier=control-plane
kube-system   pod/kube-apiserver-minikube            1/1     Running            0          26m   component=kube-apiserver,tier=control-plane
kube-system   pod/kube-controller-manager-minikube   1/1     Running            0          26m   component=kube-controller-manager,tier=control-plane
kube-system   pod/kube-proxy-z6wdm                   0/1     CrashLoopBackOff   10         26m   controller-revision-hash=ff45b7d7d,k8s-app=kube-proxy,pod-template-generation=1
kube-system   pod/kube-scheduler-minikube            1/1     Running            0          26m   component=kube-scheduler,tier=control-plane
kube-system   pod/storage-provisioner                1/1     Running            9          26m   addonmanager.kubernetes.io/mode=Reconcile,integration-test=storage-provisioner

NAMESPACE     NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                  AGE   LABELS
default       service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP                  26m   component=apiserver,provider=kubernetes
kube-system   service/kube-dns     ClusterIP   10.96.0.10   <none>        53/UDP,53/TCP,9153/TCP   26m   k8s-app=kube-dns,kubernetes.io/cluster-service=true,kubernetes.io/name=KubeDNS

NAMESPACE     NAME                        DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE   LABELS
kube-system   daemonset.apps/kube-proxy   1         1         0       1            0           kubernetes.io/os=linux   26m   k8s-app=kube-proxy

NAMESPACE     NAME                      READY   UP-TO-DATE   AVAILABLE   AGE   LABELS
kube-system   deployment.apps/coredns   0/1     1            0           26m   k8s-app=kube-dns

NAMESPACE     NAME                                DESIRED   CURRENT   READY   AGE   LABELS
kube-system   replicaset.apps/coredns-f9fd979d6   1         1         0       26m   k8s-app=kube-dns,pod-template-hash=f9fd979d6
```

## $ [cloud_user@ip-10-0-1-220 section2-hol1] $ terraform init
```
Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/kubernetes...
- Installing hashicorp/kubernetes v2.18.1...
- Installed hashicorp/kubernetes v2.18.1 (self-signed, key ID 34365D9472D7468F)

Partner and community providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://www.terraform.io/docs/plugins/signing.html

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, we recommend adding version constraints in a required_providers block
in your configuration, with the constraint strings suggested below.

* hashicorp/kubernetes: version = "~> 2.18.1"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

## [cloud_user@ip-10-0-1-220 section2-hol1]$ terraform plan
```
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # kubernetes_deployment.tf-k8s-deployment will be created
  + resource "kubernetes_deployment" "tf-k8s-deployment" {
      + id               = (known after apply)
      + wait_for_rollout = true

      + metadata {
          + generation       = (known after apply)
          + labels           = {
              + "name" = "terraform-k8s-deployment"
            }
          + name             = "tf-k8s-deploy"
          + namespace        = "default"
          + resource_version = (known after apply)
          + uid              = (known after apply)
        }

      + spec {
          + min_ready_seconds         = 0
          + paused                    = false
          + progress_deadline_seconds = 600
          + replicas                  = "2"
          + revision_history_limit    = 10

          + selector {
              + match_labels = {
                  + "name" = "terraform-k8s-deployment"
                }
            }

          + strategy {
              + type = (known after apply)

              + rolling_update {
                  + max_surge       = (known after apply)
                  + max_unavailable = (known after apply)
                }
            }

          + template {
              + metadata {
                  + generation       = (known after apply)
                  + labels           = {
                      + "name" = "terraform-k8s-deployment"
                    }
                  + name             = (known after apply)
                  + resource_version = (known after apply)
                  + uid              = (known after apply)
                }

              + spec {
                  + automount_service_account_token  = true
                  + dns_policy                       = "ClusterFirst"
                  + enable_service_links             = true
                  + host_ipc                         = false
                  + host_network                     = false
                  + host_pid                         = false
                  + hostname                         = (known after apply)
                  + node_name                        = (known after apply)
                  + restart_policy                   = "Always"
                  + service_account_name             = (known after apply)
                  + share_process_namespace          = false
                  + termination_grace_period_seconds = 30

                  + container {
                      + image                      = "nginx"
                      + image_pull_policy          = (known after apply)
                      + name                       = "nginx"
                      + stdin                      = false
                      + stdin_once                 = false
                      + termination_message_path   = "/dev/termination-log"
                      + termination_message_policy = (known after apply)
                      + tty                        = false

                      + resources {
                          + limits   = (known after apply)
                          + requests = (known after apply)
                        }
                    }

                  + image_pull_secrets {
                      + name = (known after apply)
                    }

                  + readiness_gate {
                      + condition_type = (known after apply)
                    }

                  + volume {
                      + name = (known after apply)

                      + aws_elastic_block_store {
                          + fs_type   = (known after apply)
                          + partition = (known after apply)
                          + read_only = (known after apply)
                          + volume_id = (known after apply)
                        }

                      + azure_disk {
                          + caching_mode  = (known after apply)
                          + data_disk_uri = (known after apply)
                          + disk_name     = (known after apply)
                          + fs_type       = (known after apply)
                          + kind          = (known after apply)
                          + read_only     = (known after apply)
                        }

                      + azure_file {
                          + read_only        = (known after apply)
                          + secret_name      = (known after apply)
                          + secret_namespace = (known after apply)
                          + share_name       = (known after apply)
                        }

                      + ceph_fs {
                          + monitors    = (known after apply)
                          + path        = (known after apply)
                          + read_only   = (known after apply)
                          + secret_file = (known after apply)
                          + user        = (known after apply)

                          + secret_ref {
                              + name      = (known after apply)
                              + namespace = (known after apply)
                            }
                        }

                      + cinder {
                          + fs_type   = (known after apply)
                          + read_only = (known after apply)
                          + volume_id = (known after apply)
                        }

                      + config_map {
                          + default_mode = (known after apply)
                          + name         = (known after apply)
                          + optional     = (known after apply)

                          + items {
                              + key  = (known after apply)
                              + mode = (known after apply)
                              + path = (known after apply)
                            }
                        }

                      + csi {
                          + driver            = (known after apply)
                          + fs_type           = (known after apply)
                          + read_only         = (known after apply)
                          + volume_attributes = (known after apply)

                          + node_publish_secret_ref {
                              + name = (known after apply)
                            }
                        }

                      + downward_api {
                          + default_mode = (known after apply)

                          + items {
                              + mode = (known after apply)
                              + path = (known after apply)

                              + field_ref {
                                  + api_version = (known after apply)
                                  + field_path  = (known after apply)
                                }

                              + resource_field_ref {
                                  + container_name = (known after apply)
                                  + divisor        = (known after apply)
                                  + resource       = (known after apply)
                                }
                            }
                        }

                      + empty_dir {
                          + medium     = (known after apply)
                          + size_limit = (known after apply)
                        }

                      + fc {
                          + fs_type      = (known after apply)
                          + lun          = (known after apply)
                          + read_only    = (known after apply)
                          + target_ww_ns = (known after apply)
                        }

                      + flex_volume {
                          + driver    = (known after apply)
                          + fs_type   = (known after apply)
                          + options   = (known after apply)
                          + read_only = (known after apply)

                          + secret_ref {
                              + name      = (known after apply)
                              + namespace = (known after apply)
                            }
                        }

                      + flocker {
                          + dataset_name = (known after apply)
                          + dataset_uuid = (known after apply)
                        }

                      + gce_persistent_disk {
                          + fs_type   = (known after apply)
                          + partition = (known after apply)
                          + pd_name   = (known after apply)
                          + read_only = (known after apply)
                        }

                      + git_repo {
                          + directory  = (known after apply)
                          + repository = (known after apply)
                          + revision   = (known after apply)
                        }

                      + glusterfs {
                          + endpoints_name = (known after apply)
                          + path           = (known after apply)
                          + read_only      = (known after apply)
                        }

                      + host_path {
                          + path = (known after apply)
                          + type = (known after apply)
                        }

                      + iscsi {
                          + fs_type         = (known after apply)
                          + iqn             = (known after apply)
                          + iscsi_interface = (known after apply)
                          + lun             = (known after apply)
                          + read_only       = (known after apply)
                          + target_portal   = (known after apply)
                        }

                      + local {
                          + path = (known after apply)
                        }

                      + nfs {
                          + path      = (known after apply)
                          + read_only = (known after apply)
                          + server    = (known after apply)
                        }

                      + persistent_volume_claim {
                          + claim_name = (known after apply)
                          + read_only  = (known after apply)
                        }

                      + photon_persistent_disk {
                          + fs_type = (known after apply)
                          + pd_id   = (known after apply)
                        }

                      + projected {
                          + default_mode = (known after apply)

                          + sources {
                              + config_map {
                                  + name     = (known after apply)
                                  + optional = (known after apply)

                                  + items {
                                      + key  = (known after apply)
                                      + mode = (known after apply)
                                      + path = (known after apply)
                                    }
                                }

                              + downward_api {
                                  + items {
                                      + mode = (known after apply)
                                      + path = (known after apply)

                                      + field_ref {
                                          + api_version = (known after apply)
                                          + field_path  = (known after apply)
                                        }

                                      + resource_field_ref {
                                          + container_name = (known after apply)
                                          + divisor        = (known after apply)
                                          + resource       = (known after apply)
                                        }
                                    }
                                }

                              + secret {
                                  + name     = (known after apply)
                                  + optional = (known after apply)

                                  + items {
                                      + key  = (known after apply)
                                      + mode = (known after apply)
                                      + path = (known after apply)
                                    }
                                }

                              + service_account_token {
                                  + audience           = (known after apply)
                                  + expiration_seconds = (known after apply)
                                  + path               = (known after apply)
                                }
                            }
                        }

                      + quobyte {
                          + group     = (known after apply)
                          + read_only = (known after apply)
                          + registry  = (known after apply)
                          + user      = (known after apply)
                          + volume    = (known after apply)
                        }

                      + rbd {
                          + ceph_monitors = (known after apply)
                          + fs_type       = (known after apply)
                          + keyring       = (known after apply)
                          + rados_user    = (known after apply)
                          + rbd_image     = (known after apply)
                          + rbd_pool      = (known after apply)
                          + read_only     = (known after apply)

                          + secret_ref {
                              + name      = (known after apply)
                              + namespace = (known after apply)
                            }
                        }

                      + secret {
                          + default_mode = (known after apply)
                          + optional     = (known after apply)
                          + secret_name  = (known after apply)

                          + items {
                              + key  = (known after apply)
                              + mode = (known after apply)
                              + path = (known after apply)
                            }
                        }

                      + vsphere_volume {
                          + fs_type     = (known after apply)
                          + volume_path = (known after apply)
                        }
                    }
                }
            }
        }
    }

  # kubernetes_service.tf-k8s-service will be created
  + resource "kubernetes_service" "tf-k8s-service" {
      + id                     = (known after apply)
      + status                 = (known after apply)
      + wait_for_load_balancer = true

      + metadata {
          + generation       = (known after apply)
          + labels           = {
              + "name" = "tf-k8s-deploy"
            }
          + name             = "terraform-k8s-service"
          + namespace        = "default"
          + resource_version = (known after apply)
          + uid              = (known after apply)
        }

      + spec {
          + allocate_load_balancer_node_ports = true
          + cluster_ip                        = (known after apply)
          + cluster_ips                       = (known after apply)
          + external_traffic_policy           = (known after apply)
          + health_check_node_port            = (known after apply)
          + internal_traffic_policy           = (known after apply)
          + ip_families                       = (known after apply)
          + ip_family_policy                  = (known after apply)
          + publish_not_ready_addresses       = false
          + session_affinity                  = "None"
          + type                              = "NodePort"

          + port {
              + node_port   = 30080
              + port        = 80
              + protocol    = "TCP"
              + target_port = "80"
            }

          + session_affinity_config {
              + client_ip {
                  + timeout_seconds = (known after apply)
                }
            }
        }
    }

Plan: 2 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```

## [cloud_user@ip-10-0-1-220 section2-hol1]$ terraform apply --auto-approve
```
kubernetes_service.tf-k8s-service: Creating...
kubernetes_service.tf-k8s-service: Creation complete after 0s [id=default/terraform-k8s-service]
kubernetes_deployment.tf-k8s-deployment: Creating...
kubernetes_deployment.tf-k8s-deployment: Creation complete after 5s [id=default/tf-k8s-deploy]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
```
## $ [cloud_user@ip-10-0-1-220 section2-hol1]$ terraform state list
```
kubernetes_deployment.tf-k8s-deployment
kubernetes_service.tf-k8s-service
```

## cloud_user@ip-10-0-1-220 section2-hol1]$ kubectl get pods -o wide
```
NAME                            READY   STATUS    RESTARTS   AGE     IP           NODE       NOMINATED NODE   READINESS GATES
tf-k8s-deploy-9c7b8d989-ccxrg   1/1     Running   0          4m18s   172.18.0.3   minikube   <none>           <none>
tf-k8s-deploy-9c7b8d989-dg2x8   1/1     Running   0          4m18s   172.18.0.4   minikube   <none>           <none>
```

## cloud_user@ip-10-0-1-220 section2-hol1]$ kubectl get all -A -o wide --show-labels
```
NAMESPACE     NAME                                   READY   STATUS             RESTARTS   AGE   IP           NODE       NOMINATED NODE   READINESS GATES   LABELS
default       pod/tf-k8s-deploy-9c7b8d989-ccxrg      1/1     Running            0          27s   172.18.0.3   minikube   <none>           <none>            name=terraform-k8s-deployment,pod-template-hash=9c7b8d989
default       pod/tf-k8s-deploy-9c7b8d989-dg2x8      1/1     Running            0          27s   172.18.0.4   minikube   <none>           <none>            name=terraform-k8s-deployment,pod-template-hash=9c7b8d989
kube-system   pod/coredns-f9fd979d6-7887l            0/1     Running            0          34m   172.18.0.2   minikube   <none>           <none>            k8s-app=kube-dns,pod-template-hash=f9fd979d6
kube-system   pod/etcd-minikube                      1/1     Running            0          34m   172.17.0.3   minikube   <none>           <none>            component=etcd,tier=control-plane
kube-system   pod/kube-apiserver-minikube            1/1     Running            0          34m   172.17.0.3   minikube   <none>           <none>            component=kube-apiserver,tier=control-plane
kube-system   pod/kube-controller-manager-minikube   1/1     Running            0          34m   172.17.0.3   minikube   <none>           <none>            component=kube-controller-manager,tier=control-plane
kube-system   pod/kube-proxy-z6wdm                   0/1     CrashLoopBackOff   11         34m   172.17.0.3   minikube   <none>           <none>            controller-revision-hash=ff45b7d7d,k8s-app=kube-proxy,pod-template-generation=1
kube-system   pod/kube-scheduler-minikube            1/1     Running            0          34m   172.17.0.3   minikube   <none>           <none>            component=kube-scheduler,tier=control-plane
kube-system   pod/storage-provisioner                0/1     CrashLoopBackOff   10         34m   172.17.0.3   minikube   <none>           <none>            addonmanager.kubernetes.io/mode=Reconcile,integration-test=storage-provisioner

NAMESPACE     NAME                            TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                  AGE   SELECTOR           LABELS
default       service/kubernetes              ClusterIP   10.96.0.1    <none>        443/TCP                  34m   <none>             component=apiserver,provider=kubernetes
default       service/terraform-k8s-service   NodePort    10.107.4.7   <none>        80:30080/TCP             28s   <none>             name=tf-k8s-deploy
kube-system   service/kube-dns                ClusterIP   10.96.0.10   <none>        53/UDP,53/TCP,9153/TCP   34m   k8s-app=kube-dns   k8s-app=kube-dns,kubernetes.io/cluster-service=true,kubernetes.io/name=KubeDNS

NAMESPACE     NAME                        DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE   CONTAINERS   IMAGES                          SELECTOR             LABELS
kube-system   daemonset.apps/kube-proxy   1         1         0       1            0           kubernetes.io/os=linux   34m   kube-proxy   k8s.gcr.io/kube-proxy:v1.19.0   k8s-app=kube-proxy   k8s-app=kube-proxy

NAMESPACE     NAME                            READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS   IMAGES                     SELECTOR                        LABELS
default       deployment.apps/tf-k8s-deploy   2/2     2            2           27s   nginx        nginx                      name=terraform-k8s-deployment   name=terraform-k8s-deployment
kube-system   deployment.apps/coredns         0/1     1            0           34m   coredns      k8s.gcr.io/coredns:1.7.0   k8s-app=kube-dns                k8s-app=kube-dns

NAMESPACE     NAME                                      DESIRED   CURRENT   READY   AGE   CONTAINERS   IMAGES                     SELECTOR                                                    LABELS
default       replicaset.apps/tf-k8s-deploy-9c7b8d989   2         2         2       27s   nginx        nginx                      name=terraform-k8s-deployment,pod-template-hash=9c7b8d989   name=terraform-k8s-deployment,pod-template-hash=9c7b8d989
kube-system   replicaset.apps/coredns-f9fd979d6         1         1         0       34m   coredns      k8s.gcr.io/coredns:1.7.0   k8s-app=kube-dns,pod-template-hash=f9fd979d6                k8s-app=kube-dns,pod-template-hash=f9fd979d6
[cloud_user@ip-10-0-1-220 section2-hol1]$ kubectl get all -A -o wide --show-labels
NAMESPACE     NAME                                   READY   STATUS             RESTARTS   AGE   IP           NODE       NOMINATED NODE   READINESS GATES   LABELS
default       pod/tf-k8s-deploy-9c7b8d989-ccxrg      1/1     Running            0          67s   172.18.0.3   minikube   <none>           <none>            name=terraform-k8s-deployment,pod-template-hash=9c7b8d989
default       pod/tf-k8s-deploy-9c7b8d989-dg2x8      1/1     Running            0          67s   172.18.0.4   minikube   <none>           <none>            name=terraform-k8s-deployment,pod-template-hash=9c7b8d989
kube-system   pod/coredns-f9fd979d6-7887l            0/1     Running            0          35m   172.18.0.2   minikube   <none>           <none>            k8s-app=kube-dns,pod-template-hash=f9fd979d6
kube-system   pod/etcd-minikube                      1/1     Running            0          35m   172.17.0.3   minikube   <none>           <none>            component=etcd,tier=control-plane
kube-system   pod/kube-apiserver-minikube            1/1     Running            0          35m   172.17.0.3   minikube   <none>           <none>            component=kube-apiserver,tier=control-plane
kube-system   pod/kube-controller-manager-minikube   1/1     Running            0          35m   172.17.0.3   minikube   <none>           <none>            component=kube-controller-manager,tier=control-plane
kube-system   pod/kube-proxy-z6wdm                   0/1     CrashLoopBackOff   11         35m   172.17.0.3   minikube   <none>           <none>            controller-revision-hash=ff45b7d7d,k8s-app=kube-proxy,pod-template-generation=1
kube-system   pod/kube-scheduler-minikube            1/1     Running            0          35m   172.17.0.3   minikube   <none>           <none>            component=kube-scheduler,tier=control-plane
kube-system   pod/storage-provisioner                0/1     CrashLoopBackOff   10         35m   172.17.0.3   minikube   <none>           <none>            addonmanager.kubernetes.io/mode=Reconcile,integration-test=storage-provisioner

NAMESPACE     NAME                            TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                  AGE   SELECTOR           LABELS
default       service/kubernetes              ClusterIP   10.96.0.1    <none>        443/TCP                  35m   <none>             component=apiserver,provider=kubernetes
default       service/terraform-k8s-service   NodePort    10.107.4.7   <none>        80:30080/TCP             68s   <none>             name=tf-k8s-deploy
kube-system   service/kube-dns                ClusterIP   10.96.0.10   <none>        53/UDP,53/TCP,9153/TCP   35m   k8s-app=kube-dns   k8s-app=kube-dns,kubernetes.io/cluster-service=true,kubernetes.io/name=KubeDNS

NAMESPACE     NAME                        DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE   CONTAINERS   IMAGES                          SELECTOR             LABELS
kube-system   daemonset.apps/kube-proxy   1         1         0       1            0           kubernetes.io/os=linux   35m   kube-proxy   k8s.gcr.io/kube-proxy:v1.19.0   k8s-app=kube-proxy   k8s-app=kube-proxy

NAMESPACE     NAME                            READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS   IMAGES                     SELECTOR                        LABELS
default       deployment.apps/tf-k8s-deploy   2/2     2            2           67s   nginx        nginx                      name=terraform-k8s-deployment   name=terraform-k8s-deployment
kube-system   deployment.apps/coredns         0/1     1            0           35m   coredns      k8s.gcr.io/coredns:1.7.0   k8s-app=kube-dns                k8s-app=kube-dns

NAMESPACE     NAME                                      DESIRED   CURRENT   READY   AGE   CONTAINERS   IMAGES                     SELECTOR                                                    LABELS
default       replicaset.apps/tf-k8s-deploy-9c7b8d989   2         2         2       67s   nginx        nginx                      name=terraform-k8s-deployment,pod-template-hash=9c7b8d989   name=terraform-k8s-deployment,pod-template-hash=9c7b8d989
kube-system   replicaset.apps/coredns-f9fd979d6         1         1         0       35m   coredns      k8s.gcr.io/coredns:1.7.0   k8s-app=kube-dns,pod-template-hash=f9fd979d6                k8s-app=kube-dns,pod-template-hash=f9fd979d6
```

## [cloud_user@ip-10-0-1-220 section2-hol1]$ terraform state show kubernetes_service.tf-k8s-service
```
# kubernetes_service.tf-k8s-service:
resource "kubernetes_service" "tf-k8s-service" {
    id                     = "default/terraform-k8s-service"
    status                 = [
        {
            load_balancer = [
                {
                    ingress = []
                },
            ]
        },
    ]
    wait_for_load_balancer = true

    metadata {
        generation       = 0
        labels           = {
            "name" = "tf-k8s-deploy"
        }
        name             = "terraform-k8s-service"
        namespace        = "default"
        resource_version = "1034"
        uid              = "cda95039-f3bf-4464-85ed-45e8da7ccf28"
    }

    spec {
        allocate_load_balancer_node_ports = true
        cluster_ip                        = "10.107.4.7"
        cluster_ips                       = []
        external_traffic_policy           = "Cluster"
        health_check_node_port            = 0
        ip_families                       = []
        publish_not_ready_addresses       = false
        session_affinity                  = "None"
        type                              = "NodePort"

        port {
            node_port   = 30080
            port        = 80
            protocol    = "TCP"
            target_port = "80"
        }
    }
}
```

## [cloud_user@ip-10-0-1-220 section2-hol1]$ terraform state show kubernetes_deployment.tf-k8s-deployment
```
# kubernetes_deployment.tf-k8s-deployment:
resource "kubernetes_deployment" "tf-k8s-deployment" {
    id               = "default/tf-k8s-deploy"
    wait_for_rollout = true

    metadata {
        generation       = 1
        labels           = {
            "name" = "terraform-k8s-deployment"
        }
        name             = "tf-k8s-deploy"
        namespace        = "default"
        resource_version = "1066"
        uid              = "97bfdf09-bea5-432f-91f1-0aa6af6e56ea"
    }

    spec {
        min_ready_seconds         = 0
        paused                    = false
        progress_deadline_seconds = 600
        replicas                  = "2"
        revision_history_limit    = 10

        selector {
            match_labels = {
                "name" = "terraform-k8s-deployment"
            }
        }

        strategy {
            type = "RollingUpdate"

            rolling_update {
                max_surge       = "25%"
                max_unavailable = "25%"
            }
        }

        template {
            metadata {
                generation = 0
                labels     = {
                    "name" = "terraform-k8s-deployment"
                }
            }

            spec {
                active_deadline_seconds          = 0
                automount_service_account_token  = true
                dns_policy                       = "ClusterFirst"
                enable_service_links             = true
                host_ipc                         = false
                host_network                     = false
                host_pid                         = false
                restart_policy                   = "Always"
                share_process_namespace          = false
                termination_grace_period_seconds = 30

                container {
                    image                      = "nginx"
                    image_pull_policy          = "Always"
                    name                       = "nginx"
                    stdin                      = false
                    stdin_once                 = false
                    termination_message_path   = "/dev/termination-log"
                    termination_message_policy = "File"
                    tty                        = false

                    resources {
                        limits   = {}
                        requests = {}
                    }
                }
            }
        }
    }
}
```
## cloud_user@ip-10-0-1-220 section2-hol1]$ vim main.tf
replicas = 3

## [cloud_user@ip-10-0-1-220 section2-hol1]$ terraform apply --auto-approve
```
kubernetes_service.tf-k8s-service: Refreshing state... [id=default/terraform-k8s-service]
kubernetes_deployment.tf-k8s-deployment: Refreshing state... [id=default/tf-k8s-deploy]
kubernetes_deployment.tf-k8s-deployment: Modifying... [id=default/tf-k8s-deploy]
kubernetes_deployment.tf-k8s-deployment: Modifications complete after 5s [id=default/tf-k8s-deploy]

Apply complete! Resources: 0 added, 1 changed, 0 destroyed.
```

## cloud_user@ip-10-0-1-220 section2-hol1]$ terraform state show kubernetes_deployment.tf-k8s-deployment | grep replicas
```
        replicas                  = "3"
```

[cloud_user@ip-10-0-1-220 section2-hol1]$ kubectl get pods -o wide
```
NAME                            READY   STATUS    RESTARTS   AGE    IP           NODE       NOMINATED NODE   READINESS GATES
tf-k8s-deploy-9c7b8d989-8ctc8   1/1     Running   0          36s    172.18.0.5   minikube   <none>           <none>
tf-k8s-deploy-9c7b8d989-ccxrg   1/1     Running   0          9m2s   172.18.0.3   minikube   <none>           <none>
tf-k8s-deploy-9c7b8d989-dg2x8   1/1     Running   0          9m2s   172.18.0.4   minikube   <none>           <none>
```

## cloud_user@ip-10-0-1-220 section2-hol1]$ terraform destroy --auto-approve
```
kubernetes_service.tf-k8s-service: Refreshing state... [id=default/terraform-k8s-service]
kubernetes_deployment.tf-k8s-deployment: Refreshing state... [id=default/tf-k8s-deploy]
kubernetes_service.tf-k8s-service: Destroying... [id=default/terraform-k8s-service]
kubernetes_service.tf-k8s-service: Destruction complete after 0s
kubernetes_deployment.tf-k8s-deployment: Destroying... [id=default/tf-k8s-deploy]
kubernetes_deployment.tf-k8s-deployment: Destruction complete after 0s

Destroy complete! Resources: 2 destroyed.
```

## [cloud_user@ip-10-0-1-220 section2-hol1]$ kubectl get pods -o wide
```
No resources found in default namespace.
```
