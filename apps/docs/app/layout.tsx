import { createSiteMetadata, createBaseLayoutOptions } from '@conceptadev/docs-theme';
import { DocsLayout } from 'fumadocs-ui/layouts/docs';
import { RootProvider } from 'fumadocs-ui/provider/next';
import type { ReactNode } from 'react';
import { docsConfig } from '@/docs.config';
import { source } from '@/lib/source';
import './global.css';

export const metadata = createSiteMetadata(docsConfig);
export default function RootLayout({ children }: { children: ReactNode }) {
  return <html lang="en" suppressHydrationWarning><body>
    <RootProvider>
      <DocsLayout tree={source.getPageTree()} {...createBaseLayoutOptions(docsConfig)}>{children}</DocsLayout>
    </RootProvider>
  </body></html>;
}
