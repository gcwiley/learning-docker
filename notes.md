#### How to containerize a Node.js application using Docker

1. Containerize your app
    - containerize a Node.js application

2. Develop your app
    - adding a local database and persisting data
    - configuring your container to run a development environment
    - debugging your containerized application

3. Run your tests

4. Configure CI/CD

5. Test your deployment

### Multi-Stage Benefits

- Smaller Production Image: the `prod` stage only contains production-ready code and dependences. Development tools and unnecessary files aren't included

- Security: Running as a non-root user (node) improves security.

- Caching: BuildKit's `--mount` system greatly improves caching, making build faster, especially during development

- Readability: the usage of stages makes it easier to read the steps that occur during the creation of the container.

### How to User

1. Development: `docker compose up --build` will use the `dev` stage and install development dependencies. the npm command will be run.

2. Production

    - `docker build --target prod -t my-app:prod` will build the production image

    
