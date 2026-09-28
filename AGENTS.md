# AGENTS.md

## Project Overview

Personal CV

**Type**: General-purpose project
**Package Manager**: None specified

## Project-specific notes

This is a Typst-based CV. The main source files are:

- `resume.typ` — the CV content
- `lib.typ` — shared Typst helpers and styling

The Nix dev shell provides `typst` for compiling the CV locally.

## Development Environment

A Nix flake is present for local dev. If using direnv, it loads automatically:

```bash
direnv allow
```

Otherwise:

```bash
nix develop
```

## CI Pipeline

GitHub Actions runs `nix flake check` on PRs/pushes to `main`/`develop`.

## Dependency Automation

This project uses **Renovate** for dependency updates. Renovate opens a single monthly PR grouping all GitHub Actions updates, plus a monthly lock-file maintenance PR that refreshes any lock files (e.g. `flake.lock`, `pnpm-lock.yaml`).

## License

This project is proprietary and copyrighted. Do not add or distribute a public license.
