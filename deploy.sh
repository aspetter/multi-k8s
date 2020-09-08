docker build -t aspetter/gk8s-client:latest -f ./client/Dockerfile ./client
docker build -t aspetter/gk8s-server:latest -f ./server/Dockerfile ./server
docker build -t aspetter/gk8s-worker:latest -f ./worker/Dockerfile ./worker
docker push aspetter/gk8s-client
docker push aspetter/gk8s-server
docker push aspetter/gk8s-worker
kubectl apply -f k8s
kubectl set image deployments/client-deployment server=aspetter/gk8s-client
kubectl set image deployments/server-deployment server=aspetter/gk8s-server
kubectl set image deployments/worker-deployment server=aspetter/gk8s-worker