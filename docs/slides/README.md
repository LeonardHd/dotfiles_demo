# Marp (presentations)

This repo uses **Marp** (Markdown → slides).

## Quick start (Docker, no Node required)

From the repo root:

- Build HTML:
  ```bash
  mkdir -p docs/dist && chmod -R a+rwx docs/dist
  docker run --rm \
    -v "$PWD/docs:/home/marp/app" \
    -w /home/marp/app \
    marpteam/marp-cli:latest \
    slides/presentation.md \
    --html --allow-local-files \
    -o dist/presentation.html
  ```

- Build PDF:
  ```bash
  mkdir -p docs/dist && chmod -R a+rwx docs/dist
  docker run --rm \
    -v "$PWD/docs:/home/marp/app" \
    -w /home/marp/app \
    marpteam/marp-cli:latest \
    slides/presentation.md \
    --pdf --allow-local-files \
    -o dist/presentation.pdf
  ```

Outputs go to `docs/dist/`.

## Convenience (Make)

If you have `make` available:

```bash
cd docs
make html
make pdf
```

## Editing

Slides live in `docs/slides/`. Start with:
- `docs/slides/presentation.md`
