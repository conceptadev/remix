import { getConceptaMDXComponents } from '@concepta/docs-theme/mdx';
import { Callout } from 'fumadocs-ui/components/callout';
import type { ReactNode } from 'react';
import type { MDXComponents } from 'mdx/types';
import { FlutterPreview } from './flutter-preview';
import { CatalogSearch } from './catalog-search';

// Existing content uses these names. Fumadocs still owns the code blocks,
// highlighting, copy controls, and callout presentation.
function CodeGroup({ title, children }: { title?: string; defaultLanguage?: string; children: ReactNode }) {
  return <section aria-label={title}>{title ? <p className="font-medium">{title}</p> : null}{children}</section>;
}

export function getMDXComponents(overrides?: MDXComponents) {
  return getConceptaMDXComponents({
    CodeGroup,
    FlutterPreview,
    CatalogSearch,
    Info: ({ children }: { children: ReactNode }) => <Callout type="info">{children}</Callout>,
    Note: ({ children }: { children: ReactNode }) => <Callout type="info">{children}</Callout>,
    Warning: ({ children }: { children: ReactNode }) => <Callout type="warn">{children}</Callout>,
    ...overrides,
  });
}
export const useMDXComponents = getMDXComponents;
declare global { type MDXProvidedComponents = ReturnType<typeof getMDXComponents>; }
