import { rmSync } from 'node:fs';
import { execFileSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';

// Remove the previous disposable output before Next copies public assets.
rmSync(new URL('../public/previews/', import.meta.url), { recursive: true, force: true });

const demo = fileURLToPath(new URL('../../demo/', import.meta.url));
const output = fileURLToPath(new URL('../public/catalog/', import.meta.url));
const command = process.env.CI ? 'flutter' : 'fvm';
const basePath = process.env.NEXT_PUBLIC_BASE_PATH ?? '/remix';
const args = ['build', 'web', '--release', '--base-href', `${basePath}/catalog/`, '--output', output];
execFileSync(command, process.env.CI ? args : ['flutter', ...args], { cwd: demo, stdio: 'inherit' });
