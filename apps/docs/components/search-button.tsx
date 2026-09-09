'use client';

import { useSearchContext } from 'fumadocs-ui/contexts/search';

export function SearchButton() {
  const { setOpenSearch } = useSearchContext();
  return <button type="button" className="remix-search-button" onClick={() => setOpenSearch(true)}>
    Search documentation
  </button>;
}
