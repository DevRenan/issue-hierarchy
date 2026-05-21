# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Using production Postgres and Cloudflare R2 locally

If you want your local development to point to the same Postgres instance and Cloudflare R2 bucket used in production (useful for testing), follow these steps:

1. Copy the example env file:

```bash
cp .env.local.example .env
```

2. Edit `.env` and fill your real `R2_ACCESS_KEY_ID`, `R2_SECRET_ACCESS_KEY`, `R2_BUCKET`, and `R2_ENDPOINT` values.

3. Install Ruby gems and (optionally) Python deps for PDF parsing:

```bash
bundle install
# optional for python script
python3 -m venv venv
source venv/bin/activate
pip install pymupdf
```

4. Start the Rails server:

```bash
bin/dev
```

Notes:

- Using production DB/bucket can be risky (data modification). Use read-only workflows when possible and backup before mass changes.
- Make sure your network allows connections to the Render Postgres endpoint.


