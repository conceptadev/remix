'use client';

import { useId, useState } from 'react';

export function CatalogSearch({ items }: { items: string[] }) {
  const id = useId();
  const [query, setQuery] = useState('');
  const matches = items.filter(item => item.toLowerCase().includes(query.trim().toLowerCase()));
  return <section className="remix-catalog-search not-prose" aria-label="Find a Fortal widget">
    <label htmlFor={id}>Find a widget</label>
    <input id={id} type="search" placeholder="Button, dialog, text…" value={query} onChange={event => setQuery(event.target.value)} aria-describedby={`${id}-status`} />
    <p id={`${id}-status`} role="status">{query.trim()
      ? matches.length
        ? `${matches.length} ${matches.length === 1 ? 'widget' : 'widgets'} found. Choose a result to jump to its API.`
        : 'No widgets match. Try a shorter name or clear your search.'
      : 'Search by name, or browse the categories below.'}</p>
    {query.trim() && (matches.length ? <ul>
      {matches.map(item => <li key={item}><a href={`#${item.toLowerCase()}`}>{item}</a></li>)}
    </ul> : <button type="button" onClick={() => setQuery('')}>Clear search</button>)}
  </section>;
}
