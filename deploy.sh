docker build -t bereketdeb1/multi-client:latest -t bereketdeb1/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t bereketdeb1/multi-server:latest -t bereketdeb1/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bereketdeb1/multi-worker:latest -t bereketdeb1/multi-worker:$SHA -f ./worker/Dockerfile ./worker 
docker push bereketdeb1/multi-client:latest
docker push bereketdeb1/multi-server:latest
docker push bereketdeb1/multi-worker:latest
docker push bereketdeb1/multi-client:$SHA
docker push bereketdeb1/multi-server:$SHA
docker push bereketdeb1/multi-worker:$SHA

kubectl apply -f k8
kubectl set image deployments/server-deployment server=bereketdeb1/multi-server:$SHA
kubectl set image deployments/client-deployment client=bereketdeb1/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bereketdeb1/multi-worker:$SHA