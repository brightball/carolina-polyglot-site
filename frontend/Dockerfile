FROM elixir:alpine

WORKDIR /app
EXPOSE 4000

COPY mix.exs mix.lock ./
COPY lib lib
RUN mix deps.get

CMD mix
