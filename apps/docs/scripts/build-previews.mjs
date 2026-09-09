import { execFileSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';

const demo = fileURLToPath(new URL('../../demo/', import.meta.url));
const output = fileURLToPath(new URL('../public/previews/', import.meta.url));
const command = process.env.CI ? 'flutter' : 'fvm';
const args = ['build', 'web', '--release', '--base-href', '/previews/', '--output', output];
execFileSync(command, process.env.CI ? args : ['flutter', ...args], { cwd: demo, stdio: 'inherit' });
