docker build -t aspetter/gk8s-client -f ./client/Dockerfile ./client
docker build -t aspetter/gk8s-server -f ./server/Dockerfile ./server
docker build -t aspetter/gk8s-worker -f ./worker/Dockerfile ./worker
docker push aspetter/gk8s-client
docker push aspetter/gk8s-server
docker push aspetter/gk8s-worker
kubectl apply -f k8s