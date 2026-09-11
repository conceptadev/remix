import { defineDocsConfig } from '@concepta/docs-theme';

export const docsConfig = defineDocsConfig({
  organization: { name: 'Concepta', homeUrl: 'https://concepta.dev' },
  site: {
    title: 'Remix Documentation',
    description: 'Flutter components, application-owned recipes, and working examples.',
    url: process.env.NEXT_PUBLIC_SITE_URL ?? 'http://localhost:3000',
    docsPath: '/',
  },
  project: {
    id: 'remix', name: 'Remix', docsUrl: '/',
    logo: { light: '/assets/logo_light.png', dark: '/assets/logo_dark.png', width: 108, height: 30 },
    repository: { url: 'https://github.com/conceptadev/remix', branch: process.env.DOCS_SOURCE_REF ?? 'main', contentPath: 'docs' },
  },
  socialLinks: [
    { label: 'Component catalog', url: '/previews/', placement: 'menu' },
    { label: 'GitHub', url: 'https://github.com/conceptadev/remix', placement: 'menu' },
    { label: 'Concepta', url: 'https://concepta.dev', placement: 'menu' },
  ],
});
