import { mkdir, writeFile } from 'node:fs/promises';
const output = new URL('../out/', import.meta.url);
await writeFile(new URL('.nojekyll', output), '');
// Static aliases replace the old server redirects and preview rewrite.
for (const [from, to] of Object.entries({
  'remix-cli-tutorial.html': '/remix/tutorials/settings-screen/',
  'remix-cli-guide.html': '/remix/open-code/',
  'previews/index.html': '/remix/catalog/',
})) {
  const target = new URL(from, output);
  await mkdir(new URL('.', target), { recursive: true });
  await writeFile(target, `<!doctype html><meta charset="utf-8"><meta http-equiv="refresh" content="0;url=${to}"><link rel="canonical" href="${to}"><a href="${to}">Continue</a><script>location.replace(${JSON.stringify(to)}+location.search+location.hash)</script>`);
}
