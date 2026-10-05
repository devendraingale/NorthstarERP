# Northstar ERP

A responsive, installable web ERP for invoices, sales, purchases, inventory, and customers. It uses a shared SQLite database and Python's standard-library HTTP server; no external Python packages are required.

## Run locally

1. Install Python 3.9 or newer.
2. From the project root, start the app with `python3 backend/server.py`.
3. Open `http://localhost:8000`.
4. Create an account and workspace. The first account is the workspace admin.
5. Teammates register at the same URL; an admin opens **Team** and adds their registered email. Members share the workspace records. Changes refresh automatically about every 15 seconds.

The persistent database is `data/northstar.sqlite3`. Back up that file regularly. Set `NORTHSTAR_DB` to move the database file, or `PORT` to change the listening port.

For internet deployment, run behind an HTTPS reverse proxy and keep the SQLite file on persistent storage. This setup is intended for a single app server. For larger multi-server deployments, migrate the database layer to PostgreSQL.

## Files

- `frontend/` — responsive ERP interface, registration/sign-in, CSV export, and PWA assets
- `backend/server.py` — JSON API, password hashing, sessions, workspace permissions, and SQLite schema
- `data/` — persistent SQLite database directory (database files are ignored by Git)
- `Dockerfile`, `docker-compose.yml` — container build and run setup

## Run with Docker

Install Docker Desktop or Docker Engine with the Compose plugin, then run this folder:

```sh
docker compose up -d --build
```

Open `http://localhost:8000` (or the host port set with `APP_PORT`). View logs with `docker compose logs -f`; stop the app with `docker compose down`. The named Docker volume `northstar_data` keeps the SQLite database through restarts and rebuilds. Do not run `docker compose down -v` unless you intend to delete that volume and its data.
