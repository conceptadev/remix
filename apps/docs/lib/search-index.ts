import { createFromSource, initSimpleSearch } from 'fumadocs-core/search/server';
import { source } from '@/lib/source';

// Page discovery comes before section matches, so a long guide cannot bury
// the component whose name the reader entered. Keep deep links underneath.
export const pages = initSimpleSearch({
  indexes: source.getPages().map(page => ({
    title: page.data.title,
    keywords: page.data.keywords.join(' '),
    content: '',
    url: page.url,
  })),
  search: { boost: { title: 8, keywords: 2 }, tolerance: 0 },
});
export const sections = createFromSource(source, {
  search: { groupBy: { properties: ['page_id'], maxResult: 3 } },
});

