import { createSiteMetadata, createBaseLayoutOptions } from '@conceptadev/docs-theme';
import { DocsLayout } from 'fumadocs-ui/layouts/docs';
import { RootProvider } from 'fumadocs-ui/provider/next';
import type { ReactNode } from 'react';
import { docsConfig } from '@/docs.config';
import { source } from '@/lib/source';
import './global.css';

export const metadata = {
  ...createSiteMetadata(docsConfig),
  icons: { icon: '/assets/favicon.png' },
};
export default function RootLayout({ children }: { children: ReactNode }) {
  return <html lang="en" className="concepta-docs remix-docs" suppressHydrationWarning><body className="flex min-h-screen flex-col">
    <RootProvider>
      <DocsLayout tree={source.getPageTree()} {...createBaseLayoutOptions(docsConfig)}
        sidebar={{ banner: <span className="remix-docs-label">Documentation</span> }}
      >{children}</DocsLayout>
    </RootProvider>
  </body></html>;
}
