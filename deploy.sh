#build
docker build -t aspetter/gk8s-client:latest -t aspetter/gk8s-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t aspetter/gk8s-server:latest -t aspetter/gk8s-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t aspetter/gk8s-worker:latest -t aspetter/gk8s-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push aspetter/gk8s-client:latest
docker push aspetter/gk8s-client:$GIT_SHA
docker push aspetter/gk8s-server:latest
docker push aspetter/gk8s-server:$GIT_SHA
docker push aspetter/gk8s-worker:latest
docker push aspetter/gk8s-worker:$GIT_SHA
# deploy to kubernetes
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aspetter/gk8s-server:$GIT_SHA
kubectl set image deployments/client-deployment client=aspetter/gk8s-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=aspetter/gk8s-worker:$GIT_SHA