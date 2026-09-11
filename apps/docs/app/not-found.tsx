import Link from 'next/link';
import { DocsBody, DocsDescription, DocsPage, DocsTitle } from 'fumadocs-ui/layouts/docs/page';
import { SearchButton } from '@/components/search-button';

export default function NotFound() {
  return <DocsPage>
    <header className="concepta-docs-page-header">
      <DocsTitle>Page not found</DocsTitle>
      <DocsDescription>We couldn’t find a documentation page at this address.</DocsDescription>
    </header>
    <DocsBody>
      <p>Search for a component or guide, or start with one of these pages.</p>
      <SearchButton />
      <ul>
        <li><Link href="/">Remix introduction</Link></li>
        <li><Link href="/getting-started">Install Remix and render your first button</Link></li>
        <li><Link href="/fortal/catalog">Browse the Fortal catalog</Link></li>
      </ul>
    </DocsBody>
  </DocsPage>;
}
