import { createMDX } from 'fumadocs-mdx/next';
import { execFileSync } from 'node:child_process';

const sourceRef = process.env.DOCS_SOURCE_REF ?? execFileSync('git', ['rev-parse', 'HEAD'], { encoding: 'utf8' }).trim();

const basePath = process.env.NEXT_PUBLIC_BASE_PATH ?? '/remix';
export default createMDX()({
  reactStrictMode: true,
  output: 'export',
  basePath,
  trailingSlash: true,
  images: { unoptimized: true },
  env: { DOCS_SOURCE_REF: sourceRef, NEXT_PUBLIC_BASE_PATH: basePath },
  transpilePackages: ['@concepta/docs-theme'],
});
