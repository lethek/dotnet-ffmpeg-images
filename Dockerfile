FROM ubuntu:22.10 as ubuntu-base
RUN apt-get update

FROM ubuntu-base as ffmpeg-base
ARG FFMPEG_VERSION=5.1.1-1ubuntu2.1
ENV FFMPEG_VERSION=${FFMPEG_VERSION}
RUN apt-get install -y ffmpeg=7:${FFMPEG_VERSION}

FROM ffmpeg-base as aspnet-base
ARG DOTNET_VERSION=7.0
ENV DOTNET_VERSION=${DOTNET_VERSION}
ENV ASPNET_VERSION=${DOTNET_VERSION}
RUN apt-get install -y --no-install-recommends aspnetcore-runtime-${DOTNET_VERSION} ca-certificates libc6 libgcc1 libgcc-s1 libgssapi-krb5-2 libicu71 liblttng-ust1 libssl3 libstdc++6 libunwind8 zlib1g
RUN rm -rf /var/lib/apt/lists/*
ARG HTTP_PORT=80
ENV ASPNETCORE_URLS=http://+:${HTTP_PORT} DOTNET_RUNNING_IN_CONTAINER=true

FROM aspnet-base as final
