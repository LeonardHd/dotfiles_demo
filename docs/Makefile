SHELL := /bin/bash

MARPC_IMAGE ?= marpteam/marp-cli:latest
SLIDES ?= slides/presentation.md
DIST ?= dist

.PHONY: html pdf clean

html:
	mkdir -p "$(DIST)"
	chmod -R a+rwx "$(DIST)"
	docker run --rm \
		-v "$$(pwd):/home/marp/app" \
		-w /home/marp/app \
		$(MARPC_IMAGE) \
		"$(SLIDES)" --html --allow-local-files \
		-o "$(DIST)/presentation.html"

pdf:
	mkdir -p "$(DIST)"
	chmod -R a+rwx "$(DIST)"
	docker run --rm \
		-v "$$(pwd):/home/marp/app" \
		-w /home/marp/app \
		$(MARPC_IMAGE) \
		"$(SLIDES)" --pdf --allow-local-files \
		-o "$(DIST)/presentation.pdf"

clean:
	rm -rf "$(DIST)"
