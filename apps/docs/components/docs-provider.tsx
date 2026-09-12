'use client';

import type { ReactNode } from 'react';
import { RootProvider } from 'fumadocs-ui/provider/next';
import type { SharedProps } from 'fumadocs-ui/contexts/search';
import { useDocsSearch } from 'fumadocs-core/search/client';
import { SearchDialog, SearchDialogClose, SearchDialogContent, SearchDialogHeader, SearchDialogIcon, SearchDialogInput, SearchDialogList, SearchDialogOverlay } from 'fumadocs-ui/components/dialog/search';
import { searchClient } from '@/lib/search-client';

function StaticSearchDialog(props: SharedProps) {
  const { search, setSearch, query } = useDocsSearch({ client: searchClient });
  return <SearchDialog {...props} search={search} onSearchChange={setSearch} isLoading={query.isLoading}>
    <SearchDialogOverlay />
    <SearchDialogContent>
      <SearchDialogHeader><SearchDialogIcon /><SearchDialogInput /><SearchDialogClose /></SearchDialogHeader>
      {query.error && <p role="alert" className="p-4 text-sm">Search could not load. Reload the page to try again.</p>}
      <SearchDialogList items={query.data === 'empty' ? null : query.data} />
    </SearchDialogContent>
  </SearchDialog>;
}
export function DocsProvider({ children }: { children: ReactNode }) {
  return <RootProvider search={{ SearchDialog: StaticSearchDialog }}>{children}</RootProvider>;
}
