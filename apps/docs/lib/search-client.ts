import { staticClient } from 'fumadocs-core/search/client/orama-static';
import { sitePath } from './paths';

const pages = staticClient({ from: sitePath('/api/search-pages.json'), search: { boost: { title: 8, keywords: 2 }, tolerance: 0, limit: 20 } });
const sections = staticClient({ from: sitePath('/api/search.json'), search: { groupBy: { properties: ['page_id'], maxResult: 3 }, limit: 60 } });
export const searchClient = {
  deps: [],
  async search(query: string) {
    if (!query.trim()) return [];
    const [pageResults, sectionResults] = await Promise.all([pages.search(query), sections.search(query)]);
    const promoted = new Set(pageResults.map(result => result.url));
    const ordered = pageResults.flatMap(page => [page,
      ...sectionResults.filter(result => result.type !== 'page' && result.url.split('#')[0] === page.url),
    ]);
    ordered.push(...sectionResults.filter(result => !promoted.has(result.url.split('#')[0])));
    const seen = new Set<string>();
    return ordered.filter(result => {
      if (seen.has(result.url)) return false;
      seen.add(result.url);
      return true;
    }).slice(0, 20);
  },
};
