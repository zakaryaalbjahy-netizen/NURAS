# NURAS Deployment Guide

## GitHub
Upload the project to a private repository. Never commit `.env`, passwords, API keys, or tokens.

## Render
Build command: `npm install`
Start command: `npm start`

Environment variables:
- `NODE_ENV=production`
- `DATABASE_URL` configured privately in Render

## Database
Run `schema.sql` against PostgreSQL.

## Health checks
- `/`
- `/api/health`
