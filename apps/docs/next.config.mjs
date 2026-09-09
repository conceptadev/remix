import { createMDX } from 'fumadocs-mdx/next';
import { execFileSync } from 'node:child_process';

const sourceRef = process.env.DOCS_SOURCE_REF ?? execFileSync('git', ['rev-parse', 'HEAD'], { encoding: 'utf8' }).trim();

export default createMDX()({
  reactStrictMode: true,
  env: { DOCS_SOURCE_REF: sourceRef },
  transpilePackages: ['@conceptadev/docs-theme'],
  async rewrites() {
    return [{ source: '/previews', destination: '/previews/index.html' }];
  },
  async redirects() {
    return [
      { source: '/remix-cli-tutorial.html', destination: '/tutorials/settings-screen', permanent: true },
      { source: '/remix-cli-guide.html', destination: '/open-code', permanent: true },
    ];
  },
});
