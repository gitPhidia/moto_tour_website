const esbuild = require("esbuild");
const { sassPlugin } = require("esbuild-sass-plugin");
const postcss = require("postcss");
const autoprefixer = require("autoprefixer");
const postcssPresetEnv = require("postcss-preset-env");

const args = process.argv.slice(2);
const watch = args.includes("--watch");
const deploy = args.includes("--deploy");

const loader = {
  ".ttf": "file",
  ".otf": "file",
  ".svg": "file",
  ".eot": "file",
  ".woff": "file",
  ".woff2": "file",
};

const plugins = [
  sassPlugin({
    async transform(source, resolveDir) {
      const { css } = await postcss([
        autoprefixer,
        postcssPresetEnv({ stage: 0 }),
      ]).process(source);
      return css;
    },
  }),
];

let opts = {
  entryPoints: ["js/app.js"],
  bundle: true,
  target: "es2016",
  outdir: "../priv/static/assets",
  logLevel: "info",
  loader,
  plugins: plugins,
};

if (deploy) {
  opts = {
    ...opts,
    minify: true,
  };
}

if (watch) {
  opts = {
    ...opts,
    sourcemap: "inline",
  };

  // Use esbuild.context for watching
  esbuild
    .context(opts)
    .then((ctx) => {
      ctx.watch();
    })
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
} else {
  // Build once
  esbuild.build(opts).catch((error) => {
    console.error(error);
    process.exit(1);
  });
}
