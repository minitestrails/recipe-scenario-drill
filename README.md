# Recipe scenario drill

Reference Rails app for [Minitest Rails](https://github.com/minitestrails/minitest-rails) Chapter 4 practice drills. Clone this repo and run it **locally** (Ruby on the host) or in **Docker** (no local Ruby required).

## Requirements

- **Ruby 4.0.x** (see `.ruby-version`)
- **Rails 8.x**
- SQLite (default)
- For Docker: [Docker Desktop](https://www.docker.com/products/docker-desktop/) or a compatible engine

## Local setup (Ruby on the host)

```bash
git clone https://github.com/minitestrails/recipe-scenario-drill.git
cd recipe-scenario-drill
bin/setup
```

`bin/setup` installs gems, prepares the database, and runs seeds. To start the app:

```bash
bin/dev
```

Open [http://localhost:3000](http://localhost:3000). Console: `bin/rails console`.

### Share email (local)

In development, outgoing mail uses **letter_opener** — submitting “Share recipe” opens a browser tab with the message. Recipe title appears in the subject/body.

## Docker setup (no local Ruby)

1. Install Docker Desktop (or compatible).
2. After clone, run once:

   ```bash
   bin/docker-setup
   ```

3. Daily development:

   ```bash
   bin/docker-dev
   ```

   Open [http://localhost:3000](http://localhost:3000).

4. Console inside the container:

   ```bash
   docker compose -f .devcontainer/compose.yaml exec rails-app bin/rails console
   ```

### Share email (Docker)

Auto-opening a letter_opener tab on the host is unreliable in Docker. Use **mailer previews** at [http://localhost:3000/rails/mailers](http://localhost:3000/rails/mailers) instead, or run the share flow locally with letter_opener.

## Seed users

After `bin/setup` or `bin/docker-setup`, two accounts exist for authorization drills:

| User | Email | Password |
| --- | --- | --- |
| Alice (User A) | `alice@example.com` | `password123` |
| Bob (User B) | `bob@example.com` | `password123` |

Sign in at `/session/new`. Sign out via `DELETE` on the session route (link in the app header when signed in).

## Guide

Walk through Chapter 4 drills in the Minitest Rails guide: [How to approach testing](https://minitestrails.com/guide/how-to-approach-testing/).

## Tests

Minitest folders are present for later guide chapters. A green full suite is not required for the initial reference app release.
