.PHONY: build install clean

# This is what Google and Mozilla wants us to upload when we release a new version to the Addon "store"
build: install
	npm run build
	make build.zip

install:
	npm ci
	(cd kalpa-client-js; npm ci; npm run compile)

update:
	npm run build

clean:
	rm -rf node_modules build
	(cd kalpa-client-js; rm -rf node_modules)

build.zip: out/app.js
	rm -f $@
	zip -r -FS $@ manifest.json static/ out/ kalpa-watcher-media/logo/logo-128.png kalpa-watcher-media/banners/banner.png

# To build a source archive, wanted by Mozilla reviewers. Include media subdir.
srczip:
	rm -rfv build
	mkdir -p build
	# archive the main repo
	git archive --prefix=aw-watcher-web/ -o build/build.zip HEAD
	# archive the kalpa-watcher-media subrepo
	(cd kalpa-watcher-media/ && git archive --prefix=kalpa-watcher-web/kalpa-watcher-media/ -o ../build/kalpa-watcher-media.zip HEAD)
	(cd kalpa-client-js/ && git archive --prefix=aw-watcher-web/kalpa-client-js/ -o ../build/kalpa-client-js.zip HEAD)
	# extract the archives into a single directory
	(cd build && unzip -q build.zip)
	(cd build && unzip -q kalpa-client-js.zip)
	(cd build && unzip -q kalpa-watcher-media.zip)
	# zip the whole thing
	(cd build && zip -r build.zip build)
	# clean up
	(cd build && rm kalpa-watcher-media.zip)

# Tests reproducibility of the build from srczip
test-build-srczip: srczip build
	(cd build/aw-watcher-web && make build)
	@# check that build.zip have the same size
	@wc -c build.zip build/aw-watcher-web/build.zip | \
		sort -n | \
		cut -d' ' -f2 | \
		uniq -c | \
		grep -q ' 2 ' \
	|| (echo "build artifacts not the same size" && exit 1)
