NAME ?= StormBreaker

DATE := $(shell date "+%Y%m%d-%H%M")

DEVICE :=

KERNELVERSION := $(shell cd .. && make kernelversion | cut -c 1-3)

VERSION :=

ZIP := $(NAME)-$(KERNELVERSION)-$(DEVICE)-$(DATE)-$(VERSION).zip

EXCLUDE := Makefile *.git* *.jar* *placeholder* *.md*

normal: $(ZIP)

$(ZIP):
	@echo "Creating ZIP: $(ZIP)"
	@zip -r9 "$@" . -x $(EXCLUDE)
	@echo "Generating SHA1..."
	@sha1sum "$@" > "$@.sha1"
	@cat "$@.sha1"
	@echo "Done."


clean:
	@rm -vf dtbo.img
	@rm -vf *.zip*
	@rm -vf zImage
	@rm -vf Image*
	@echo "Cleaned Up."
