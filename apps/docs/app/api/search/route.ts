import { createFromSource, initSimpleSearch } from 'fumadocs-core/search/server';
import { source } from '@/lib/source';

// Page discovery comes before section matches, so a long guide cannot bury
// the component whose name the reader entered. Keep deep links underneath.
const pages = initSimpleSearch({
  indexes: source.getPages().map(page => ({
    title: page.data.title,
    keywords: page.data.keywords.join(' '),
    content: '',
    url: page.url,
  })),
  search: { boost: { title: 8, keywords: 2 }, tolerance: 0 },
});
const sections = createFromSource(source, {
  search: { groupBy: { properties: ['page_id'], maxResult: 3 } },
});

export async function GET(request: Request) {
  const params = new URL(request.url).searchParams;
  const query = params.get('query')?.trim();
  if (!query) return Response.json([]);
  const requestedLimit = Number(params.get('limit') ?? 20);
  const limit = Number.isInteger(requestedLimit)
    ? Math.max(0, Math.min(requestedLimit, 60)) : 20;
  const [pageResults, sectionResults] = await Promise.all([
    pages.search(query, { limit }),
    sections.search(query, { limit: 60 }),
  ]);
  const promoted = new Set(pageResults.map(result => result.url));
  const ordered = pageResults.flatMap(page => [
    page,
    ...sectionResults.filter(result => result.type !== 'page' && result.url.split('#')[0] === page.url),
  ]);
  ordered.push(...sectionResults.filter(result => !promoted.has(result.url.split('#')[0])));
  const seen = new Set<string>();
  return Response.json(ordered.filter(result => {
    if (seen.has(result.url)) return false;
    seen.add(result.url);
    return true;
  }).slice(0, limit));
}
