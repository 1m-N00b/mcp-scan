# If the first argument is "run"...
ifeq (run,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif

run:
	uv run -m src.mcp_scan.cli ${RUN_ARGS}

clean:
	rm -rf ./dist
	rm -rf ./mcp_scan/mcp_scan.egg-info

build: clean
	uv build --no-sources

publish: build
	uv publish --token ${PYPI_TOKEN}