import assert from 'node:assert/strict';
import { readFile, readdir, stat } from 'node:fs/promises';
import { resolve, join } from 'node:path';
import { fileURLToPath } from 'node:url';

const root = resolve(process.env.DOCS_OUTPUT ?? fileURLToPath(new URL('../../../build/pages/', import.meta.url)));
const base = process.env.NEXT_PUBLIC_BASE_PATH ?? '/remix';
const origin = process.env.NEXT_PUBLIC_SITE_URL ?? 'https://conceptadev.github.io';
const docsOnly = process.argv.includes('--docs-only');
async function exists(path) { return stat(path).then(() => true, () => false); }
async function* files(path) {
  for (const entry of await readdir(path, { withFileTypes: true })) {
    const full = join(path, entry.name);
    if (entry.isDirectory()) {
      if (!['_next', 'catalog', 'dashboard', 'assets', 'previews'].includes(entry.name)) yield* files(full);
    } else if (entry.name.endsWith('.html')) yield full;
  }
}
let checked = 0;
for await (const file of files(root)) {
  const html = await readFile(file, 'utf8');
  // Resource hints may target the origin rather than an exported file.
  const linkedHtml = html.replace(/<link[^>]+rel="(?:preconnect|dns-prefetch)"[^>]*>/g, '');
  for (const [, raw] of linkedHtml.matchAll(/(?:href|src)="([^"]+)"/g)) {
    const url = new URL(raw.replaceAll('&amp;', '&'), origin + base + '/');
    if (url.origin !== origin || !raw.startsWith('/')) continue;
    assert.ok(url.pathname.startsWith(base + '/'), `${file}: missing prefix: ${raw}`);
    assert.ok(!url.pathname.startsWith(base + base + '/'), `${file}: double prefix: ${raw}`);
    let target = join(root, decodeURIComponent(url.pathname.slice(base.length)));
    if (await exists(target) && (await stat(target)).isDirectory()) target = join(target, 'index.html');
    assert.ok(await exists(target), `${file}: missing target ${raw}`);
    checked++;
  }
}
for (const route of ['', 'getting-started', 'components/button', 'tutorials/settings-screen', 'open-code']) {
  const html = await readFile(join(root, route, 'index.html'), 'utf8');
  const canonical = html.match(/<link rel="canonical" href="([^"]+)"/);
  assert.ok(canonical, `Missing canonical on ${route}`);
  assert.equal(canonical[1].replace(/\/$/, ''), `${origin}${base}${route ? '/' + route : ''}`);
}
for (const app of docsOnly ? ['catalog'] : ['catalog', 'dashboard']) {
  const html = await readFile(join(root, app, 'index.html'), 'utf8');
  assert.ok(html.includes(`<base href="${base}/${app}/">`));
  for (const asset of ['flutter_bootstrap.js', 'main.dart.js', 'assets/AssetManifest.bin']) assert.ok(await exists(join(root, app, asset)), `${app}/${asset}`);
}
for (const index of ['search', 'search-pages']) {
  const data = JSON.parse(await readFile(join(root, 'api', index + '.json'), 'utf8'));
  assert.ok(data.type, `Missing ${index} database`);
}
assert.ok(await exists(join(root, '404.html')));
if (!docsOnly) {
  assert.ok(await exists(join(root, '.nojekyll')));
  for (const [from, to] of Object.entries({ 'previews/index.html': '/catalog/', 'remix-cli-guide.html': '/open-code/', 'remix-cli-tutorial.html': '/tutorials/settings-screen/' })) {
    const html = await readFile(join(root, from), 'utf8');
    assert.ok(html.includes(`location.replace("${base}${to}"+location.search+location.hash)`));
  }
}
console.log(`Verified static routes, metadata, search indexes, Flutter builds, and ${checked} local links/assets.`);
