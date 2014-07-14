VERSION = 0.1

all: base hadoop

base: base-image 

base-image:
	@docker build -t dcapwell/base:$(VERSION) base

hadoop: base hadoop-base-image

hadoop-base-image:
	@docker build -t dcapwell/hadoop-base:$(VERSION) hadoop2x/base
