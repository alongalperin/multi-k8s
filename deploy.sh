docker build -t alongal/multi-client:latest -t alongal/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alongal/multi-server:latest -t alongal/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alongal/multi-worker:latest -t alongal/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push alongal/multi-client:latest
docker push alongal/multi-server:latest
docker push alongal/multi-worker:latest

docker push alongal/multi-client:$SHA
docker push alongal/multi-server:$SHA
docker push alongal/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment server=alongal/multi-client:$SHA
kubectl set image deployments/server-deployment server=alongal/multi-server:$SHA
kubectl set image deployments/worker-deployment server=alongal/multi-worker:$SHA