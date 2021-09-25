docker build -t harisankarg909/multi_client:latest -t harisankarg909/multi_client:$SHA -f ./client/Dockerfile ./client
docker build -t harisankarg909/multi_server:latest  -t harisankarg909/multi_server:$SHA -f ./server/Dockerfile ./server
docker build -t harisankarg909/multi_worker:latest  -t harisankarg909/multi_worker:$SHA -f ./worker/Dockerfile ./worker

docker push harisankarg909/multi_client:latest
docker push harisankarg909/multi_server:latest
docker push harisankarg909/multi_worker:latest

docker push harisankarg909/multi_client:$SHA
docker push harisankarg909/multi_server:$SHA
docker push harisankarg909/multi_worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=harisankarg909/multi_client:$SHA;
kubectl set image deployments/server-deployment server=harisankarg909/multi_server:$SHA;
kubectl set image deployments/worker-deployment worker=harisankarg909/multi_worker:$SHA;