import { createSiteMetadata, createBaseLayoutOptions } from '@concepta/docs-theme';
import { DocsLayout } from 'fumadocs-ui/layouts/docs';
import type { ReactNode } from 'react';
import { docsConfig } from '@/docs.config';
import { source } from '@/lib/source';
import './global.css';
import { sitePath } from '@/lib/paths';
import { LegacyCatalogRedirect } from '@/components/legacy-catalog-redirect';
import { DocsProvider } from '@/components/docs-provider';

export const metadata = {
  ...createSiteMetadata(docsConfig),
  icons: { icon: sitePath('/assets/favicon.png') },
};
const layoutOptions = createBaseLayoutOptions(docsConfig);
// The catalog is a separate Flutter app, even when served on the docs origin.
layoutOptions.links = layoutOptions.links?.map(link =>
  'url' in link && link.url === sitePath('/catalog/') ? { ...link, external: true } : link,
);
export default function RootLayout({ children }: { children: ReactNode }) {
  return <html lang="en" className="concepta-docs remix-docs" suppressHydrationWarning><body className="flex min-h-screen flex-col">
    <DocsProvider>
      <LegacyCatalogRedirect />
      {/* No sidebar banner: the wordmark sits directly above it, and a
          "Documentation" label there reads as a heading for the quick links
          below it, which it does not head. */}
      <DocsLayout tree={source.getPageTree()} {...layoutOptions}>
        {children}
      </DocsLayout>
    </DocsProvider>
  </body></html>;
}
