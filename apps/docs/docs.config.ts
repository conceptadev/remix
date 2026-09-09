import { defineDocsConfig } from '@conceptadev/docs-theme';

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
    repository: { url: 'https://github.com/conceptadev/remix', branch: 'main', contentPath: 'docs' },
  },
});
