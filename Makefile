DEPS = $(go list -f '{{range .TestImports}}{{.}} {{end}}' ./...)
WEBSITE="https://criticalstack.com"
DESCRIPTION="CSOS API server and user interface."
NAME="csos-server"
GULP="node_modules/gulp/bin/gulp.js"

BUILDVERSION=$(shell cat VERSION)

# Get the git commit
SHA=$(git rev-parse --short HEAD)

client: clientDeps
	@echo "Building client..."
	@${GULP} prod

build: server client
	@echo "Done"

clientDeps:
	@echo "Fetching client dependencies..."
	@npm install

jslint:
	@${GULP} lint-dev

watch:
	@${GULP} dev

watch-fast:
	@${GULP} dev-fast

clean:
	@rm -rf build/

clean-all:
	@rm -rf node_modules/
	@rm -rf doc/
	@rm -rf package/
	@rm -rf build/
	@rm -rf VERSION

.PHONY: server serverDeps test
