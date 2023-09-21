# Introduction

From [Wikipedia](https://en.wikipedia.org/wiki/Kubernetes), the free encyclopedia:

  > [Kubernetes](https://kubernetes.io/) (commonly abbreviated K8s) is an
  > open-source container orchestration system for automating software
  > deployment, scaling, and management. Originally designed by Google, the
  > project is now maintained by the [Cloud Native Computing
  > Foundation](https://www.cncf.io).

You may think of Kubernetes as an orchestrator for a cluster of container-handling machines.

The orchestrator is in charge of switching on the containers as needed,
irrespective of the machine where the containers are. It takes care of keeping
the desired availabilty according to the costraints set by the administrator.

## Glossary

- An *image* is a read-only set of files used as the base data for a container.
- A *container* is a running image. It has a read-write layer on top of the
  read-only image, a virtual network interface with its own IP address and it
  has its own [cgroup](https://en.wikipedia.org/wiki/Cgroups) for handling
  child processes, cpu, memory and network constrains.
- A *pod* is a set of related containers, which Kubernetes manages as a single unit.

## k3s

From [k3s](https://docs.k3s.io) official documentation:

 >  K3s is a fully compliant Kubernetes distribution with the following enhancements:
 >
 >  - Packaged as a single binary.
 >  - Lightweight storage backend based on sqlite3 as the default storage
 >    mechanism. etcd3, MySQL, Postgres are also available.
 >  - Wrapped in simple launcher that handles a lot of the complexity of TLS and options.
 >  - Secure by default with reasonable defaults for lightweight environments.
 >  - Simple but powerful "batteries-included" features have been added, such as:
 >      - local storage provider
 >      - service load balancer
 >      - Helm controller
 >      - Traefik ingress controller.
 >  - Operation of all Kubernetes control plane components is encapsulated in a
 >    single binary and process. This allows K3s to automate and manage complex
 >    cluster operations like distributing certificates.
 >  - External dependencies have been minimized (just a modern kernel and
 >    cgroup mounts needed). K3s packages the required dependencies, including:
 >      - containerd
 >      - Flannel (CNI)
 >      - CoreDNS
 >      - Traefik (Ingress)
 >      - Klipper-lb (Service LB)
 >      - Embedded network policy controller
 >      - Embedded local-path-provisioner
 >      - Host utilities (iptables, socat, etc)

### Installing k3s

**Important!**

  > Unless stated otherwise we will assume that each node has been prepared
  > with a clean install of a distribution that has a reasonably new Linux
  > kernel (version 5+) and `systemd`.

#### Single node

While a single node cluster it's not a cluster, k3s can be set up as such. The
typical use case is quick testing before deploying in production.

1. (Optional - only if enabled) Disable `SELinux`:
   ```shell
   sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
   reboot
   ```
2. (Optional - only if enabled) Disable `firewalld`:
   ```shell
   systemctl stop firewalld
   systemctl disable firewalld
   ```
3. Download the latest binary from GitHub: https://github.com/k3s-io/k3s/releases/latest
4. Copy the `k3s` binary in `/usr/local/bin` and set the execution bit:
   ```shell
   install -m 755 k3s /usr/local/bin/k3s
   ```
5. Create the systemd unit file `/etc/systemd/system/k3s.service`:
   ```
   [Unit]
   Description=Lightweight Kubernetes
   Documentation=https://k3s.io
   Wants=network-online.target
   After=network-online.target

   [Install]
   WantedBy=multi-user.target

   [Service]
   Type=notify
   EnvironmentFile=-/etc/default/%N
   EnvironmentFile=-/etc/sysconfig/%N
   KillMode=process
   Delegate=yes
   # Having non-zero Limit*s causes performance problems due to accounting overhead
   # in the kernel. We recommend using cgroups to do container-local accounting.
   LimitNOFILE=1048576
   LimitNPROC=infinity
   LimitCORE=infinity
   TasksMax=infinity
   TimeoutStartSec=0
   Restart=always
   RestartSec=5s
   ExecStartPre=/bin/sh -xc '! /usr/bin/systemctl is-enabled --quiet nm-cloud-setup.service'
   ExecStartPre=-/sbin/modprobe br_netfilter
   ExecStartPre=-/sbin/modprobe overlay
   ExecStart=/usr/local/bin/k3s server
   ```
6. Enable and start the k3s service:
   ```shell
   systemctl enable --now k3s.service
   ```
7. Wait a few minutes for k3s to download the infrastructure images and set up
   the control plane.
8. Create a symlink to `k3s` called `kubectl`:
   ```shell
   ln -s /usr/local/bin/k3s /usr/local/bin/kubectl
   ```
9. Test if the cluster is up and running:
   ```shell
   kubectl get nodes
   kubectl get pods -A
   ```

#### Single server with agent(s)

As stated before a single node is not a cluster.

In this section we will see how to add agents (runners) to the cluster.

First you have to generate a bootstrap token on the server:

```shell
k3s token create
```

**Important!**

  > Take note of the generated token.

**Warning:**

  > The following instructions **must be performed on a different host**.
  >
  > **DO NOT RUN THESE COMMANDS ON THE SERVER!**

1. (Optional - only if enabled) Disable `SELinux`:
   ```shell
   sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
   reboot
   ```
2. (Optional - only if enabled) Disable `firewalld`:
   ```shell
   systemctl stop firewalld
   systemctl disable firewalld
   ```
3. Download the latest binary from GitHub: https://github.com/k3s-io/k3s/releases/latest
4. Copy the `k3s` binary in `/usr/local/bin` and set the execution bit:
   ```shell
   install -m 755 k3s /usr/local/bin/k3s
   ```
5. Create the env file `/etc/systemd/system/k3s.env`:
   ```
   K3S_URL='https://${SERVER_IP}:6443'
   K3S_TOKEN='${TOKEN}'
   ```
   **BEWARE**: substitute `${SERVER_IP}` with the IP address of your server node and `${TOKEN}` with the token you have generated.
6. Create the systemd unit file `/etc/systemd/system/k3s.service` (*be careful*, the contents are different from the server):
   ```
   [Unit]
   Description=Lightweight Kubernetes
   Documentation=https://k3s.io
   Wants=network-online.target
   After=network-online.target

   [Install]
   WantedBy=multi-user.target

   [Service]
   Type=notify
   EnvironmentFile=-/etc/default/%N
   EnvironmentFile=-/etc/sysconfig/%N
   EnvironmentFile=-/etc/systemd/system/k3s.env
   KillMode=process
   Delegate=yes
   # Having non-zero Limit*s causes performance problems due to accounting overhead
   # in the kernel. We recommend using cgroups to do container-local accounting.
   LimitNOFILE=1048576
   LimitNPROC=infinity
   LimitCORE=infinity
   TasksMax=infinity
   TimeoutStartSec=0
   Restart=always
   RestartSec=5s
   ExecStartPre=/bin/sh -xc '! /usr/bin/systemctl is-enabled --quiet nm-cloud-setup.service'
   ExecStartPre=-/sbin/modprobe br_netfilter
   ExecStartPre=-/sbin/modprobe overlay
   ExecStart=/usr/local/bin/k3s agent
   ```
7. Enable and start the k3s service:
   ```shell
   systemctl enable --now k3s.service
   ```
8. Repeat the previous steps for each agent node.
