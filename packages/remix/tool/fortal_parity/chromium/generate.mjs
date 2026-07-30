import { execFileSync, spawn } from 'node:child_process';
import {
  existsSync,
  mkdtempSync,
  readFileSync,
  rmSync,
  statSync,
  writeFileSync,
} from 'node:fs';
import { tmpdir } from 'node:os';
import { dirname, join } from 'node:path';
import { fileURLToPath, pathToFileURL } from 'node:url';

const toolDirectory = dirname(fileURLToPath(import.meta.url));
const fixture = join(toolDirectory, 'fixture.html');
const outputDirectory = join(
  toolDirectory,
  '..',
  '..',
  '..',
  'reference',
  'radix_themes_3_3_0',
  'chromium',
);
const packageMetadata = JSON.parse(
  readFileSync(join(toolDirectory, 'node_modules', '@radix-ui', 'themes', 'package.json')),
);
const lockfile = JSON.parse(readFileSync(join(toolDirectory, 'package-lock.json')));
const lockedPackage = lockfile.packages['node_modules/@radix-ui/themes'];

const chromium =
  process.env.FORTAL_CHROMIUM_BIN ??
  [
    '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome',
    '/Applications/Chromium.app/Contents/MacOS/Chromium',
    '/usr/bin/google-chrome',
    '/usr/bin/chromium',
  ].find(existsSync);

if (chromium === undefined) {
  throw new Error(
    'Chromium was not found. Set FORTAL_CHROMIUM_BIN to a Chromium-compatible executable.',
  );
}
if (packageMetadata.version !== '3.3.0' || lockedPackage.version !== '3.3.0') {
  throw new Error('The browser fixture must use @radix-ui/themes 3.3.0 exactly.');
}

const commonArguments = [
  '--headless=new',
  '--disable-gpu',
  '--disable-extensions',
  '--disable-background-networking',
  '--disable-default-apps',
  '--disable-sync',
  '--hide-scrollbars',
  '--no-first-run',
  '--allow-file-access-from-files',
  '--force-color-profile=srgb',
  '--font-render-hinting=none',
  '--run-all-compositor-stages-before-draw',
  '--virtual-time-budget=2000',
];

const chromiumVersion = execFileSync(chromium, ['--version'], { encoding: 'utf8' }).trim();
const dumpedDocument = await runChromium(
  ['--dump-dom', pathToFileURL(fixture).href],
  ({ stdout }) => stdout.includes('</html>'),
);
const match = dumpedDocument.match(
  /<script id="computed-style-result" type="application\/json">([\s\S]*?)<\/script>/,
);
if (match === null) {
  throw new Error('Chromium did not serialize the computed-style result.');
}

const result = JSON.parse(
  match[1]
    .replaceAll('&quot;', '"')
    .replaceAll('&lt;', '<')
    .replaceAll('&gt;', '>')
    .replaceAll('&amp;', '&'),
);
const reference = {
  source: {
    package: '@radix-ui/themes',
    version: packageMetadata.version,
    integrity: lockedPackage.integrity,
    tarball: lockedPackage.resolved,
  },
  generator: {
    chromium: chromiumVersion,
    viewport: { width: 1440, height: 1280, deviceScaleFactor: 1 },
    colorProfile: 'srgb',
    fontRenderHinting: 'none',
  },
  ...result,
};
writeFileSync(
  join(outputDirectory, 'computed-styles.json'),
  `${JSON.stringify(reference, null, 2)}\n`,
);

const screenshot = join(outputDirectory, 'families-light.png');
await runChromium(
  [
    '--window-size=1440,1280',
    `--screenshot=${screenshot}`,
    pathToFileURL(fixture).href,
  ],
  () => existsSync(screenshot) && statSync(screenshot).size > 1024,
);

async function runChromium(arguments_, isComplete) {
  const profile = mkdtempSync(join(tmpdir(), 'fortal-radix-reference-'));
  try {
    return await new Promise((resolve, reject) => {
      const child = spawn(
        chromium,
        [...commonArguments, `--user-data-dir=${profile}`, ...arguments_],
        { stdio: ['ignore', 'pipe', 'pipe'] },
      );
      let stdout = '';
      let stderr = '';
      let complete = false;
      let timedOut = false;
      child.stdout.setEncoding('utf8');
      child.stderr.setEncoding('utf8');
      child.stdout.on('data', (value) => {
        stdout += value;
      });
      child.stderr.on('data', (value) => {
        stderr += value;
      });

      const poll = setInterval(() => {
        if (isComplete({ stdout, stderr })) {
          complete = true;
          child.kill('SIGTERM');
        }
      }, 100);
      const timeout = setTimeout(() => {
        timedOut = true;
        child.kill('SIGTERM');
      }, 15000);

      child.on('error', reject);
      child.on('close', (code, signal) => {
        clearInterval(poll);
        clearTimeout(timeout);
        if (complete || (code === 0 && isComplete({ stdout, stderr }))) {
          resolve(stdout);
          return;
        }
        reject(
          new Error(
            `Chromium capture ${timedOut ? 'timed out' : 'failed'} ` +
              `(code ${code}, signal ${signal}).\n${stderr}`,
          ),
        );
      });
    });
  } finally {
    rmSync(profile, { recursive: true, force: true });
  }
}
