# Convex Kubernetes deployment

Helm chart for [Self Hosted Convex Backend](https://github.com/get-convex/convex-backend/blob/main/self-hosted/README.md)

## Setup

First deploy the secrets needed for the cluster. Copy .env.example to .env in the `chart/files/envs/` folder. `INSTANCE_NAME` is just a short string for your deployment while `INSTANCE_SECRET` is a 32 byte hex string. To make this you can run `openssl rand -hex 32`.

The run the following:

```sh
cd chart/files/scripts
./create-secret.sh
```

I use Tailscale for ingress so I have a explicit required `--set` for the tailnet name. Similar for the convex data volume mount which I am using hostPath as I am deploying to a single node cluster.

```sh
cd chart
helm install --set tailnet=<your_tailnet> --set hostBasePath=$(pwd) <release_name> .
```

Next, run `kubectl exec <convex_backend_pod> -- ./generate_admin_key.sh` and save the string provided. This is the admin key you can use to both login to the dashboard & use in your apps via the `CONVEX_SELF_HOSTED_ADMIN_KEY` env variable
