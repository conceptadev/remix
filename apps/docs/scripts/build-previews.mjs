import { execFileSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';

const demo = fileURLToPath(new URL('../../demo/', import.meta.url));
const output = fileURLToPath(new URL('../public/previews/', import.meta.url));
execFileSync('fvm', ['flutter', 'build', 'web', '--release', '--base-href', '/previews/', '--output', output], { cwd: demo, stdio: 'inherit' });
