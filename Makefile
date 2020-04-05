# Constants
OUT=target

define PREFIX
#!/bin/sh
SELF=`which "$0" 2>/dev/null`
[ $? -gt 0 -a -f "$0" ] && SELF="./$0"
exec java -jar "$SELF" "$@"
exit 1
endef

export PREFIX

# Files
SRC=$(shell find src -type f)
RES=$(shell find resources -type f)

# Tasks
all: $(OUT)/into
.PHONY: all

clean:
	rm -rf $(OUT)

$(OUT)/into: $(OUT)/into.jar
	echo "$$PREFIX" > $(OUT)/into
	cat $(OUT)/into.jar >> $(OUT)/into
	chmod +x $(OUT)/into

$(OUT)/into.jar: project.clj $(SRC) $(RES)
	lein uberjar
