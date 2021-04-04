docker build -t ilonaosv/multi-client:latest -t ilonaosv/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ilonaosv/multi-server:latest -t ilonaosv/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ilonaosv/multi-worker:latest -t ilonaosv/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ilonaosv/multi-client:latest
docker push ilonaosv/multi-server:latest
docker push ilonaosv/multi-worker:latest

docker push ilonaosv/multi-client:$SHA
docker push ilonaosv/multi-server:$SHA
docker push ilonaosv/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ilonaosv/multi-server:$SHA
kubectl set image deployments/client-deployment client=ilonaosv/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ilonaosv/multi-worker:$SHA