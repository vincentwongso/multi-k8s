docker build -t vincentwong/multi-client:latest -t vincentwong/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vincentwong/multi-server:latest -t vincentwong/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vincentwong/multi-worker:latest -t vincentwong/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vincentwong/multi-client:latest
docker push vincentwong/multi-server:latest
docker push vincentwong/multi-worker:latest

docker push vincentwong/multi-client:$SHA
docker push vincentwong/multi-server:$SHA
docker push vincentwong/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vincentwong/multi-server:$SHA
kubectl set image deployments/client-deployment client=vincentwong/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vincentwong/multi-worker:$SHA