import { loader } from 'fumadocs-core/source';
import { defineDocs } from 'fumadocs-mdx/macro';

const docs = defineDocs({
  dir: '.generated/content',
  docs: { postprocess: { includeProcessedMarkdown: true } },
});

export const source = loader({ baseUrl: '/', source: docs.toFumadocsSource() });
