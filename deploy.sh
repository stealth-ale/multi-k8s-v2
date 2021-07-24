docker build -t alehti/multi-client:latest -t alehti/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t alehti/multi-server:latest -t alehti/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alehti/multi-worker:latest -t alehti/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push alehti/multi-client:latest
docker push alehti/multi-server:latest
docker push alehti/multi-worker:latest

docker push alehti/multi-client:$SHA
docker push alehti/multi-server:$SHA
docker push alehti/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=alehti/multi-server:$SHA
kubectl set image deployments/client-deployment server=alehti/multi-client:$SHA
kubectl set image deployments/worker-deployment server=alehti/multi-worker:$SHA
