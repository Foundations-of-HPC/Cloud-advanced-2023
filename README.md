# Cloud-advanced-2023
Slides, exercises and resources for the 2023-2024 3 credit course on "Cloud-Computing Module 2" under the "Scientific and Data-Intensive Computing" Master Program at University of Trieste


## Teachers

**Stefano Cozzini**, Area Science Park, Trieste

**Ruggero Lot**, Area Science Park, Trieste

## Tutor:

**Marco Celoria**  Area Science Park

**Niccolo' Tosato**  PhD student UNITS

**Gianfranco Gallizia** Area Science Park

Computational resource to be used: ORFEO cluster see https://orfeo-doc.areasciencepark.it/

## Prerequisites

  - decent knowledge of linux command line interface
  - first part of Cloud course completed
  - HPC course completed
  - decent knowledge of scripting language  ( python is fine but bash awk perl are also welcome}

# Calendar&Topic

We plan to provide a few hours as frontal lectures ( max 8) and the rest as tutorials and labs.
A couple of hours as specialised seminars.
Here below the preliminary schedule of the course:

| Theoretical date | date    | time | Lecture                                                       | Kind | Chapters     |
|:-----------------|:--------|:-----|:--------------------------------------------------------------|------|:-------------|
| Mon, Nov 20      | Nov 27  | 1h   | Introduction to Kubernetes                                    | L    | 1            |
| Mon, Nov 27      | Dec 01  | 1h   | Docker + Runtimes;                                            | L    | 2            |
|                  |         |      | Bonus Namespaces and Networking                               |      |              |
| Fri, Dec 01      | Dec 04  | 2h   | Deploying a kubernetes cluster + common kubebctl commands     | L    | 3,4          |
|                  | Delayed | 2h   | [Installing kubernetes](Intro/readme.md)                      | T    |              |
| Mon, Dec 04      | Dec 05  | 1h   | Pods, lables and annotations;                                 | L    | 5,6          |
|                  |         |      | Bonus: Networking + resource management                       |      |              |
| Tue, Dec 05      | Dec 05  | 2h   | Service discovery, cloud integration, ingress and node ports, | L    | 7,8          |
| Thu, Dec 07      |         | 2h   | loadbalancing Replica sets, Deployments, Deamon sets          | L    | 9,10, 11, 13 |
|                  |         |      | configmap and secrets                                         |      |              |
| Mon, Dec 11      |         | 1h   | A case study of complex kubernetes deployment                 | S    |              |
| Tue, Dec 12      |         | 2h   | Deploying a service pt 1                                      | T    |              |
| Thu, Dec 14      |         | 2h   | Deploying a service pt 2                                      | T    |              |
| Fri, Dec 15      |         | 2h   | Integrated storage solution and kubernetes                    | L    | 16           |
|                  |         |      | Deploying a real world application in theory                  |      |              |
|                  |         | 2h   |                                                               | T    |              |
| Mon, Dec 18      |         | 1h   | Genomic workflow on containers                                | S    |              |
| Tue, Dec 19      |         | 2h   | Advanced topics overview                                      |      |              |

Legend:
- L lecture
- T tutorial
- S Seminar

## Tutorial

### Turorial 1

- [Tutorial 1: installing    kubernetes ](Intro/readme.md)
- [Tutorial 2: using/managing kubernetes ](Intro/readme.md)
<<<<<<< ours

# Resources

Starting point and the one to refer for this course: https://kubernetes.io/docs/home/

Introduction will follow in particular this section: https://kubernetes.io/docs/concepts/
