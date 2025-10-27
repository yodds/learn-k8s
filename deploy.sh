docker build -t yodds/complex-client:latest -t yodds/complex-client:$SHA -f ./client/Dockerfile ./client
docker build -t yodds/complex-server:latest -t yodds/complex-server:$SHA -f ./server/Dockerfile ./server
docker build -t yodds/complex-worker:latest -t yodds/complex-worker:$SHA -f ./worker/Dockerfile ./worker
docker push yodds/complex-client:latest
docker push yodds/complex-server:latest
docker push yodds/complex-worker:latest
docker push yodds/complex-client:$SHA
docker push yodds/complex-server:$SHA
docker push yodds/complex-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=yodds/complex-server:$SHA
kubectl set image deployments/worker-deployment worker=yodds/complex-worker:$SHA
kubectl set image deployments/client-deployment client=yodds/complex-client:$SHA