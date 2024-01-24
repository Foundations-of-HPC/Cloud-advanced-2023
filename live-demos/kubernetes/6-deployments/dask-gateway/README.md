# What is Dask?

Dask is an open-source Python library for parallel computing. 

Dask scales Python code from multi-core local machines to large distributed clusters in the cloud. 

Dask provides a familiar user interface by mirroring the APIs of other libraries in the PyData ecosystem including: Pandas, scikit-learn and NumPy.

It also exposes low-level APIs that help programmers run custom algorithms in parallel.

# How Does Dask Work?

From https://www.dask.org/ and https://www.nvidia.com/en-us/glossary/data-science/dask/

* Dask is composed of two parts*: 

- A collections API for parallel lists, arrays, and DataFrames for natively scaling Numpy, NumPy, Pandas, and scikit-learn to run in larger-than-memory or distributed environments. Dask collections are parallel collections from the underlying library (eg. a Dask array consists of Numpy arrays) and run on top of the task scheduler.

- A task scheduler for building task graphs and coordinating, scheduling, and monitoring tasks optimized for interactive workloads across CPU cores and machines.

Dask’s three parallel collections—called DataFrames, Bags, and Arrays—can each automatically use data partitioned between RAM and disk as well, distributed across multiple nodes in a cluster, depending on resource availability. 

For problems that are parallelizable but don’t fit well in high-level abstractions like Dask Arrays or DataFrames, there's a "delayed" function that uses Python decorators to modify functions so that they operate lazily. That means that execution is delayed, and the function and its arguments placed into a task graph.

Dask's task scheduler can scale to thousand-node clusters and its algorithms have been tested on some of the world’s largest supercomputers. 

Its task scheduling interface can also be customized for specific jobs. 

Dask delivers the low-overhead, low-latency, and minimal serialization necessary for speed.

In a distributed scenario, one scheduler coordinates many workers and moves computation to the correct worker maintaining a continuous, non-blocking conversation. 
Several users may share the same system. 

This approach works with the Hadoop HDFS file system, as well as cloud object stores such as Amazon’s S3 storage.

The single-machine scheduler is optimized for larger-than-memory use and divides tasks across multiple threads and processors.

It uses a low-overhead approach that consumes roughly 50 microseconds per task.

## Dask Gateway

From https://gateway.dask.org/index.html

Dask Gateway provides a secure, multi-tenant server for managing Dask clusters. 

It allows users to launch and use Dask clusters in a shared, centrally managed cluster environment, without requiring users to have direct access to the underlying cluster backend.

Dask Gateway is one of many options for deploying Dask clusters, see Deploying Dask in the Dask documentation for an overview of additional options.
Highlights

- **Centrally Managed**: Administrators do the heavy lifting of configuring the Gateway, users simply connect to the Gateway to get a new cluster. Eases deployment, and allows enforcing consistent configuration across all users.

- **Secure by Default**: Cluster communication is automatically encrypted with TLS. All operations are authenticated with a configurable protocol, allowing you to use what makes sense for your organization.

- **Flexible**: The gateway is designed to support multiple backends, and runs equally well in the cloud as on-premise. Natively supports Kubernetes, Hadoop/YARN, and HPC Job Queueing systems.

- **Robust to Failure**: The gateway can be restarted or experience failover without losing existing clusters. Allows for seamless upgrades and restarts without disrupting users.

### Architecture Overview

Dask Gateway is divided into three separate components:

- Multiple active Dask Clusters (potentially more than one per user)

- A Proxy for proxying both the connection between the user’s client and their respective scheduler, and the Dask Web UI for each cluster

- A central Gateway that manages authentication and cluster startup/shutdown
