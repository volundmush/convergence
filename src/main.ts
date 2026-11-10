// Main entry point for convergence
// getConfig from @ursamu/mush (same core as mu). Do not import
// getConfig from @ursamu/core separately — dual core can return
// undefined for game.layout and wipe boot templates.
import {
  mu,
  applyLayoutFromConfig,
  getConfig,
} from "@ursamu/mush";

const game = await mu(undefined, undefined, {
  pluginsDir: "",
});

// Load game.layout.* (header / divider / footer) from config.
// mu() applies this at boot; re-apply so dual-package hosts still
// honor config on the instance this process imported.
applyLayoutFromConfig(
  getConfig<{
    header?: string;
    divider?: string;
    footer?: string;
  }>("game.layout"),
);

console.log(`${game.config.get("game.name")} main server is running!`);
