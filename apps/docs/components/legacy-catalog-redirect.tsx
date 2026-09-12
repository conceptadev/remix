'use client';

import { useEffect } from 'react';
import { sitePath } from '@/lib/paths';

export function LegacyCatalogRedirect() {
  useEffect(() => {
    if (location.pathname.replace(/\/$/, '') === sitePath('') && location.hash.startsWith('#/?')) {
      location.replace(sitePath('/catalog/') + location.search + location.hash);
    }
  }, []);
  return null;
}
