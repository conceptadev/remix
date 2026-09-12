import { sitePath } from '@/lib/paths';
import { defineDocsConfig } from '@concepta/docs-theme';

export const docsConfig = defineDocsConfig({
  organization: { name: 'Concepta', homeUrl: 'https://concepta.dev' },
  site: {
    title: 'Remix Documentation',
    description: 'Flutter components, application-owned recipes, and working examples.',
    url: process.env.NEXT_PUBLIC_SITE_URL ?? 'https://conceptadev.github.io',
    docsPath: '/',
  },
  project: {
    id: 'remix', name: 'Remix', docsUrl: '/',
    logo: { light: sitePath('/assets/logo_light.png'), dark: sitePath('/assets/logo_dark.png'), width: 108, height: 30 },
    repository: { url: 'https://github.com/conceptadev/remix', branch: process.env.DOCS_SOURCE_REF ?? 'main', contentPath: 'docs' },
  },
  socialLinks: [
    { label: 'Component catalog', url: sitePath('/catalog/'), placement: 'menu' },
    { label: 'GitHub', url: 'https://github.com/conceptadev/remix', placement: 'menu' },
    { label: 'Concepta', url: 'https://concepta.dev', placement: 'menu' },
  ],
});
