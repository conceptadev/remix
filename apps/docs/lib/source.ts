import { loader } from 'fumadocs-core/source';
import { applyMdxPreset } from 'fumadocs-mdx/config';
import { defineDocs } from 'fumadocs-mdx/macro';

const docs = defineDocs({
  dir: '.generated/content',
  docs: {
    postprocess: { includeProcessedMarkdown: true },
    // GitHub's legacy Shiki themes were tuned for GitHub's own surfaces. On
    // Concepta's card the dark comment token only reaches 3.15:1; the Primer
    // defaults clear AA for every token on both payloads.
    mdxOptions: applyMdxPreset({
      rehypeCodeOptions: {
        themes: { light: 'github-light-default', dark: 'github-dark-default' },
      },
    }),
  },
});

export const source = loader({ baseUrl: '/', source: docs.toFumadocsSource() });
