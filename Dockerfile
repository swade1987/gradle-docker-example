FROM fabric8/java-jboss-openjdk8-jdk:1.0.13

MAINTAINER Steve Wade <steven@stevenwade.co.uk>

ARG git_repository="Unknown"
ARG git_commit="Unknown"
ARG git_branch="Unknown"
ARG built_on="Unknown"

LABEL git.repository=$git_repository
LABEL git.commit=$git_commit
LABEL git.branch=$git_branch
LABEL build.dockerfile=/Dockerfile
LABEL build.on=$built_on

COPY ./Dockerfile /Dockerfile

# App specific section below

ENV JAVA_APP_JAR app.jar
ENV AB_OFF true

EXPOSE 8080

ADD build/libs/app.jar /app/