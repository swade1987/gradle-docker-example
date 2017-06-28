APP_NAME=simple-gradle

# Note: The ARTIFACTORY_PASSWORD should be passed in as a pipeline environment variable
ARTIFACTORY_USERNAME=swade1987
ARTIFACTORY_PASSWORD?="unknown"
ARTIFACTORY_URL=www.artifactory.com
ARTIFACTORY_REPO=repo-name

GO_PIPELINE_COUNTER?="unknown"

# Construct the image tag.
VERSION=1.1.$(GO_PIPELINE_COUNTER)

# Construct docker image name.
IMAGE = $(ARTIFACTORY_URL)/$(ARTIFACTORY_REPO)/$(APP_NAME)

build: build-app build-image

push: docker-login push-image

build-app:
	docker build -t build-img -f Dockerfile.build .
	docker run --name build-image-$(VERSION) --rm -v ${PWD}:/usr/bin/app:rw build-img clean jar

build-image:
	docker build \
    --build-arg git_repository=`git config --get remote.origin.url` \
    --build-arg git_branch=`git rev-parse --abbrev-ref HEAD` \
    --build-arg git_commit=`git rev-parse HEAD` \
    --build-arg built_on=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
    -t $(IMAGE):$(VERSION) .

docker-login:
	docker login -u $(ARTIFACTORY_USERNAME) -p $(ARTIFACTORY_PASSWORD) $(ARTIFACTORY_URL)

# Push the image to our container registry and remove the image from the agent.
push-image:
	docker push $(IMAGE):$(VERSION)
	docker rmi $(IMAGE):$(VERSION)