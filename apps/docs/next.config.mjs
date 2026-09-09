import { createMDX } from 'fumadocs-mdx/next';

export default createMDX()({
  reactStrictMode: true,
  transpilePackages: ['@conceptadev/docs-theme'],
  async redirects() {
    return [
      { source: '/remix-cli-tutorial.html', destination: '/tutorials/settings-screen', permanent: true },
      { source: '/remix-cli-guide.html', destination: '/open-code', permanent: true },
    ];
  },
});
