FROM 84codes/crystal as build
WORKDIR "/src"
COPY shard.* app.cr .
RUN shards install
RUN crystal build --release --static app.cr

FROM alpine
WORKDIR "/app"
COPY --from=build /src/app .
EXPOSE 80
CMD /app/app -p 80
