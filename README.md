# convergence

A modern MU* game built with the [UrsaMU](https://github.com/ursamu/ursamu) engine.

## Architecture

- **Main Server** (`src/main.ts`) — game engine, database, WebSocket, HTTP API
- **Telnet Server** (`src/telnet.ts`) — classic MU* connections, runs as a separate process

### Ports

| Protocol | Port |
|----------|------|
| Telnet   | `server.telnet` (default 4201) |
| WebSocket | `server.ws` / `wsPort` (default 4202) |
| HTTP     | `server.http` / `apiPort` (default 4203) |

## Getting Started

```bash
deno task start
```

This starts both servers with watch mode enabled.

## Connecting

- Telnet: `telnet localhost 4201`
- WebSocket: `ws://localhost:4202`
- HTTP API: `http://localhost:4203/api/...`

## Project Structure

```
convergence/
├── config/             Configuration files
├── data/               Database files
├── help/               In-game help files
├── scripts/            Utility scripts (run.sh, etc.)
├── src/
│   ├── main.ts         Main server entry point
│   ├── telnet.ts       Telnet server entry point
│   └── plugins/        Custom plugins
├── system/scripts/     Engine system scripts (editable)
├── text/
│   └── default_connect.txt  Welcome screen
├── wiki/               Game wiki and documentation
└── deno.json           Tasks and import map
```

## Extending

Add plugins to `src/plugins/`:

```bash
deno run -A jsr:@ursamu/cli create plugin my-feature
```

## Documentation

- [UrsaMU Docs](https://ursamu.github.io/ursamu/)
- [GitHub](https://github.com/ursamu/ursamu)

## License

MIT
