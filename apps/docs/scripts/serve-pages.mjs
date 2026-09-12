import { createServer } from 'node:http';
import { readFile, stat } from 'node:fs/promises';
import { resolve, extname, sep } from 'node:path';
import { fileURLToPath } from 'node:url';

const root = resolve(process.env.DOCS_OUTPUT ?? fileURLToPath(new URL('../../../build/pages/', import.meta.url)));
const base = process.env.NEXT_PUBLIC_BASE_PATH ?? '/remix';
const types = { '.html': 'text/html', '.js': 'text/javascript', '.css': 'text/css', '.json': 'application/json', '.wasm': 'application/wasm', '.png': 'image/png', '.svg': 'image/svg+xml', '.woff2': 'font/woff2', '.txt': 'text/plain' };
export function servePages(directory = root) {
  return createServer(async (req, res) => {
    try {
      const url = new URL(req.url, 'http://localhost');
      if (url.pathname === base) { res.writeHead(301, { Location: base + '/' + url.search }); res.end(); return; }
      if (!url.pathname.startsWith(base + '/')) throw new Error('Outside mount');
      let path = resolve(directory, '.' + decodeURIComponent(url.pathname.slice(base.length)));
      if (path !== directory && !path.startsWith(directory + sep)) throw new Error('Outside root');
      if ((await stat(path)).isDirectory()) {
        if (!url.pathname.endsWith('/')) { res.writeHead(301, { Location: url.pathname + '/' + url.search }); res.end(); return; }
        path = resolve(path, 'index.html');
      }
      res.writeHead(200, { 'Content-Type': types[extname(path)] ?? 'application/octet-stream' });
      res.end(await readFile(path));
    } catch {
      res.writeHead(404, { 'Content-Type': 'text/html' });
      res.end(await readFile(resolve(directory, '404.html')).catch(() => 'Not found'));
    }
  });
}
if (process.argv[1] === fileURLToPath(import.meta.url)) {
  const port = Number(process.env.PORT ?? 3000);
  servePages().listen(port, '127.0.0.1', () => console.log(`Static Pages preview: http://localhost:${port}${base}/`));
}
