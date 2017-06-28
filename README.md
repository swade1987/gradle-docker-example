# gradle-docker-example

A repo for creating docker images with Gradle

## Usage

### Local

Set the 'GO_PIPELINE_COUNTER' environment variable by running the following command:

```
$ export GO_PIPELINE_COUNTER=123
```

To build the container execute the following command:

```
$ make build
```

To few the results of the build execute:

```
$ docker images
```

The following should be displayed:

```
$  docker images
REPOSITORY                                    TAG
www.artifactory.com/repo-name/simple-gradle   1.1.123
```

You can also inspect the image to make sure the labels have been set correctly.

Execute the following command:

```
$ docker inspect www.artifactory.com/repo-name/simple-gradle:1.1.123
```

The following should be displayed at the bottom of the output:

```
"Labels": {
            "build-date": "2016-06-02",
            "build.dockerfile": "/Dockerfile",
            "build.on": "2017-06-28T10:12:27Z",
            "git.branch": "master",
            "git.commit": "c2973d6c51a09671a9c4d2ff688d4e3899f6c23e",
            "git.repository": "https://github.com/swade1987/gradle-docker-example",
}
```