FROM alpine:latest

# Tools required by the official Deno installer
RUN apk add --no-cache curl unzip ca-certificates \
  && update-ca-certificates

# Install Deno 2.3.1 via the official install script
ENV DENO_INSTALL="/root/.deno"
ENV PATH="${DENO_INSTALL}/bin:${PATH}"
RUN curl -fsSL https://deno.land/install.sh | sh -s v2.3.1

WORKDIR /app

# Copy dependency manifests first for layer caching
COPY deno.json deps.ts import_map.json ./
# Workspace packages needed so deno cache can resolve the monorepo entry
COPY packages/ ./packages/

# Pre-cache dependencies (may be partial until full tree is present)
RUN deno cache --unstable-kv packages/mush/src/main.ts || true

# Copy remaining source files
COPY . .

# Cache with full source available
# Entry: packages/mush/src/main.ts (replaces legacy src/main.ts)
RUN deno cache --unstable-kv packages/mush/src/main.ts

# Expose ports: 4201 (Telnet), 4202 (WebSocket), 4203 (HTTP API)
EXPOSE 4201
EXPOSE 4202
EXPOSE 4203

CMD ["deno", "run", "--allow-all", "--unstable-detect-cjs", "--unstable-kv", "./packages/mush/src/main.ts"]
