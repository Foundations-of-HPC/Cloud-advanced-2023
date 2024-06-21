# Exercise  for the course Cloud Computing Advanced.

This is the exercise for Prof. Taffoni and Ruggero of the 2023/2024 Cloud Computing Advanced course. Both exercises must be done.

Version `1.1`: This document can be modified several times in the next few days to improve the clarity of the information and provide a better understanding of what we are asking.

## Rules

- Exercise should be done individually: no group, please!
- Materials (code/scripts/pictures and final report) should be prepared on a GitHub repository, starting with this one and sharing it with the teachers.
- A report should be sent by e-mail to the teachers at least five days in advance: the name of the file should `YOURSURNAME_report.pdf`
- Results and numbers of the exercises should be presented (also with the help of slides** in a maximum 10-minute presentation: this will be part of the exam). A few more questions on the topic of the courses will be asked at the end of the presentation.

***deadlines***

You should send us the e-mail at least one week before the exam. For the first two  scheduled "appelli" this means:

 - exam scheduled at 1.02.2024  **deadline 28.01.2023 at midnight**
 - exam scheduled at 23.02.2024  **deadline 20.02.2023 at midnight**
 - Summer session UPCOMING

The report should clearly explain which software stack we should use to deploy the developed infrastructure and run all the programs you used in your exercises. Providing well-done Makefiles/Dockerfiles/scripts to automatize the work is highly appreciated.


## Exercise 1: Cloud-Based File Storage System in Kubernetes

### Introduction

This exercise assesses your comprehension of the Kubernetes environment and its primary resources, evaluates your capability to apply this knowledge in the real-world scenario of deploying a straightforward service, and validates your proficiency with Kubernetes. The exercise consists of a replication of the deployment of the service done in exercise one. This deployment must be achieved using either a HELM chart with appropriate values or by writing custom manifests. 

### Requirements

- the cluster must run `k8s`; one node is sufficient,
- the pods must have all the probes necessary to handle miss-behaviors,
- the volumes must survive a pod crash and accidental deletion, local pv are sufficient,
- the service must be accessible from the user via IP or FQDN,
- eventual databases or third-party services necessary for the deployed software must run in their pod.


### Submission detail

Documentation:

- Extend the report of exercise one, including all the declining arguments for the case of the Kubernetes platform.
- Discuss the limits of the back-end storage choice, which steps should be taken to overcome such limitations,
- Discuss all the steps that should be taken to have the service in high availability.
- Discuss the advantages and disadvantages of this deployment concerning the docker solution. 

Code:

- publish all the value files used in your helm charts, the developed manifests, and any code eventually developed/modified  
necessary to deploy your cloud-based file storage system in a vanilla clean cluster.
- Include a README file with instructions on how to deploy and use your system.

Presentation:

- Extend the presentation for exercise one, summarizing your design, implementation, and any **interesting** challenges you faced. (no more than seven extra slides)
- Be ready to answer questions about your design choices and on the topics discussed during the Cloud Course Lectures
  

### Evaluation Criteria:

- Design Clarity: Is the system design well-documented and clear?
- Functionality: Does the system meet the specified requirements?
- Resilience: Is the system implementing basic HA correctly?
- Security: Are any security measures implemented or discussed?

## Exercise 2: mpi service in Kubernetes

### Introduction

The exercise addresses the task of porting simple HPC workflows into Kubernetes by testing your proficiency not only in Kubernetes but also with Docker and HPC workflows.

You are supposed to run the [OSU benchmark](https://mvapich.cse.ohio-state.edu/benchmarks/) inside two containers distributed in different nodes in the Kubernetes cluster.

### Requirements

- the cluster must run `k8s`; two nodes are necessary,
- the nodes must talk via either `flannel` or `calico`,
- the [mpi operator](https://github.com/kubeflow/mpi-operator) must be installed,
- Create a container with the OSU benchmark on this page: https://mvapich.cse.ohio-state.edu/benchmarks/. More detailed instructions about compilation can be found [here](https://mvapich.cse.ohio-state.edu/static/media/mvapich/README-OMB.txt). This container must have a behavior as expected by the operator. Specialized containers must be created to compile and run the code. For example, follow the [mpi-operator doc](https://github.com/kubeflow/mpi-operator/tree/master/build/base) 
- use the code to estimate the latency between the two nodes (by placing one worker per node) and at least one between collective operations. Compare these results with those when both pods are on the same node.

### Submission detail

Documentation:

- Not required

Code:

- publish all the value files used in your helm charts, the developed manifests and Dockerfiles, and any code eventually developed/modified necessary to deploy your cloud-based file storage system in a vanilla clean cluster.
- Include a README file with instructions on how to deploy and use your system.

Presentation:

- Extend the presentation for exercises one and two, summarizing any **interesting** challenges you faced and the results you obtained (no more than five extra slides)
- Be ready to answer questions about the topics discussed during the Cloud Course Lectures
  
### Evaluation Criteria:

- Design Clarity: Is the system design well-documented and clear?
- Functionality: Does the system meet the specified requirements?
