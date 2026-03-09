# Convex Kubernetes deployment

Helm chart for [Self Hosted Convex Backend](https://github.com/get-convex/convex-backend/blob/main/self-hosted/README.md)

## Setup

First deploy the secrets needed for the cluster. Copy .env.example to .env in the `chart/files/envs/` folder. `INSTANCE_NAME` is just a short string for your deployment while `INSTANCE_SECRET` is a 32 byte hex string. To make this you can run `openssl rand -hex 32`.

The run the following:

```sh
cd chart/files/scripts
./create-secret.sh
```

Then make sure that all of the following values are defined, either via updating values.yaml, making your own overriding the default values file, or via `--set` in the CLI.

- ingress.backend.host: hostname for ingress routing for Convex backend (port 3210)
- ingress.site.host: hostname for ingress routing for Convex proxy (port 3211)
- ingress.dashboard.host: hostname for ingress routing for Convex dashboard (port 6791)
- ingress.backend.origin: (optional) full FQDN used in env vars if different from host — useful for Tailscale where the ingress host is a short name (e.g. `convex-backend`) but the actual reachable domain is the full MagicDNS name (e.g. `convex-backend.my-tailnet.ts.net`). Defaults to the value of `host` if not set. Same optional field exists for `ingress.site.origin` and `ingress.dashboard.origin`.
- hostBasePath: path on your system of the root of the helm chart (for the hostPath volume mount given I am deploying to a single node cluster)

Then deploy via `helm install / helm upgrade`.

Next, run `kubectl exec <convex_backend_pod> -- ./generate_admin_key.sh` and save the string provided. This is the admin key you can use to both login to the dashboard & in the convex cli with the `CONVEX_SELF_HOSTED_ADMIN_KEY` env variable
