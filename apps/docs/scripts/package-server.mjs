import { access, cp } from 'node:fs/promises';

// Next traces server dependencies; public files and client chunks are separate.
const root = new URL('../', import.meta.url);
const output = new URL('.next/standalone/', root);
await access(new URL('server.js', output));
await cp(new URL('public/', root), new URL('public/', output), { recursive: true });
await cp(new URL('.next/static/', root), new URL('.next/static/', output), { recursive: true });
console.log('Deployment ready in apps/docs/.next/standalone; run node server.js with Node 24.14+.');
