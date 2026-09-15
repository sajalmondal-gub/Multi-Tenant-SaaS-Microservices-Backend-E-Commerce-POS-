# Backend Microservices Setup

This project uses a microservice architecture built with Node.js, Express, PostgreSQL, and Redis. All microservices and databases are containerized using Docker and managed via `docker-compose`.

## 🏗 Architecture Overview

The backend consists of **7 Microservices**, a centralized **Redis** cache, and a **PostgreSQL** database:

1. `api-gateway` (Port: 3000)
2. `order-service` (Port: 3001)
3. `product-service` (Port: 3002)
4. `purchase-service` (Port: 3003)
5. `stock-management-service` (Port: 3004)
6. `tenant-service` (Port: 3005)
7. `theme-service` (Port: 3006)

### 🗄️ Database Strategy
To conserve local resources during development, we use a **Single PostgreSQL Container** (Port: 5432). However, upon initialization, it automatically creates 6 isolated databases (`order_db`, `product_db`, `purchase_db`, `stock_db`, `tenant_db`, `theme_db`). Each microservice securely connects only to its respective database.

### 📦 NPM Workspaces
The project utilizes **NPM Workspaces** (`apps/*` and `packages/*`) to manage dependencies centrally at the root level. Running `npm install` at the root folder sets up the environment for all microservices.

---

## 🚀 Getting Started (A to Z)

### Prerequisites
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) (must be running)
- Node.js (Optional: only if you want to run `npm install` locally outside of docker)

### Step 1: Start the Services
Open your terminal in the `backend` folder and run the following command:

```bash
docker compose up -d --build
```
*This will download the required images, install dependencies, build the containers, and start everything in the background.*

### Step 2: Verify the Setup
Check if all containers (7 apps, 1 postgres, 1 redis) are running properly:

```bash
docker compose ps
```

### Step 3: Accessing the Databases
You can connect to your local PostgreSQL instance using tools like **pgAdmin**, **DBeaver**, or **DataGrip**:
- **Host**: `localhost`
- **Port**: `5432`
- **Username**: `postgres`
- **Password**: `password`
- **Databases Available**: `order_db`, `product_db`, `purchase_db`, `stock_db`, `tenant_db`, `theme_db`

---

## 🛠 Local Development

The `docker-compose.yml` file is optimized for **Local Development**. 

- **Volume Mapping:** Your local `./apps` and `./packages` directories are mounted directly into the Docker containers.
- **Hot Reloading:** The microservices run using `nodemon` (`npm run dev`). 
- **Workflow:** Whenever you edit or save a `.js` or `.ts` file locally in your IDE, the changes will immediately reflect in the running container without requiring you to rebuild the Docker image!

### Installing New Packages
If you need to install a new NPM package for a specific microservice:
```bash
# Example: Installing a package for api-gateway
npm install <package-name> --workspace=apps/api-gateway
```
*Note: If you modify `package.json`, you must rebuild the docker containers using `docker compose up -d --build` so the changes take effect inside the image.*

---

## 🛑 Stopping the Services

To stop all running microservices and databases without deleting your data:
```bash
docker compose stop
```

To completely remove the containers and the network:
```bash
docker compose down
```
*(Note: To also wipe the database data completely, you can use `docker compose down -v`)*
