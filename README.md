# Kubernetes: Big Lab

Deploy application on Kubernetes with the following requirements: 
- [x] Deploy 3 pods to run Front-End services (e.g. ReactJS, VueJS, Angular, etc.). 
    - https://jasonwatmore.com/net-7-dapper-postgresql-crud-api-tutorial-in-aspnet-core#data-context-cs:~:text=Connect%20a%20React%20App%20with%20the%20.NET%20CRUD%20API
- [x] Deploy 3 pods to run Back-End services (e.g. C#, Java, Golang, Python, etc.). 
    - https://jasonwatmore.com/net-7-dapper-postgresql-crud-api-tutorial-in-aspnet-core#data-context-cs:~:text=Run%20the%20.NET%207.0%20CRUD%20Example%20API%20Locally
- [x] The images for Front-End and Back-End must be built from Dockerfile and pushed to Dockerhub (default images from the Docker registry should not be used) 
- [x] The pods should be auto-scaled based on CPU usage. 
- [x] Deploy a database (e.g. MySQL, MongoDB, etc.) with the option to implement a High Availability (HA) model using Helm or StatefulSet (bonus points will be awarded).
    - https://dev.to/dm8ry/how-to-deploy-a-high-availability-ha-postgres-cluster-in-kubernetes-79
    - https://devopscube.com/deploy-postgresql-statefulset / https://weng-albert.medium.com/mastering-high-availability-postgresql-meets-kubernetes-929846f6cc88
- [x] Configure the Front-End services to call the Back-End services, and the Back-End services to call the database.
- [ ] Store relevant credential settings in Secrets.
- [ ] (Optional) Use DaemonSet to deploy ElasticSearch (using the fluentd-elasticsearch image) or complete EFK stack or any kind of logging and monitoring stacks.
- [ ] Deploy an Ingress to allow access to the Front-End service from the internet using a DNS. Configuring HTTPS is a bonus point. If a domain name is not available, use LoadBalancer service type (maximum points will not be awarded). 