VERSION = 0.1

all: base hadoop spark tachyon

base: base-image 

base-image:
	@docker build -t dcapwell/base:$(VERSION) base

hadoop: base hadoop-base-image

hadoop-base-image:
	@docker build -t dcapwell/hadoop-base:$(VERSION) hadoop2x/base

hadoop-base-run:
	@docker run -t -i dcapwell/hadoop-base:$(VERSION) bash

spark: base hadoop spark-base-image

spark-base-image:
	@docker build -t dcapwell/spark-base:$(VERSION) spark/base

spark-base-run:
	@docker run -t -i dcapwell/spark-base:$(VERSION) bash
