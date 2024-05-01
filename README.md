# Kubernetes: Big Lab

Deploy application on Kubernetes with the following requirements: 
- [x] Deploy 3 pods to run Front-End services (e.g. ReactJS, VueJS, Angular, etc.).
- [x] Deploy 3 pods to run Back-End services (e.g. C#, Java, Golang, Python, etc.).
- [x] The images for Front-End and Back-End must be built from Dockerfile and pushed to Dockerhub (default images from the Docker registry should not be used)
- [x] The pods should be auto-scaled based on CPU usage.
- [x] Deploy a database (e.g. MySQL, MongoDB, etc.) with the option to implement a High Availability (HA) model using Helm or StatefulSet (bonus points will be awarded).
- [x] Configure the Front-End services to call the Back-End services, and the Back-End services to call the database.
- [x] Store relevant credential settings in Secrets.
- [ ] (Optional) Use DaemonSet to deploy ElasticSearch (using the fluentd-elasticsearch image) or complete EFK stack or any kind of logging and monitoring stacks.
- [x] Deploy an Ingress to allow access to the Front-End service from the internet using a DNS. Configuring HTTPS is a bonus point. If a domain name is not available, use LoadBalancer service type (maximum points will not be awarded).

