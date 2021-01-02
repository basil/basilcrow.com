.POSIX:
DESTDIR=public
DOMAIN=basilcrow.com

.PHONY: all build test serve clean

all: serve

build:
	hugo -d $(DESTDIR) --gc
	find $(DESTDIR) -name '*.html' -print0 | xargs -0 tidy -config tidy.conf -m -q || true

test:
	docker run --rm -it \
		-v $(PWD)/$(DESTDIR):/src \
		klakegg/html-proofer \
		--check-html \
		--disable-external

serve:
	hugo -d $(DESTDIR) --gc server

clean:
	rm -rf $(DESTDIR)/
	rm -rf resources/_gen/
