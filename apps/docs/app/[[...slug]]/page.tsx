import { createPageMetadata, createSourceUrl } from '@conceptadev/docs-theme';
import { DocsBody, DocsDescription, DocsPage, DocsTitle } from 'fumadocs-ui/layouts/docs/page';
import { createRelativeLink } from 'fumadocs-ui/mdx';
import { notFound } from 'next/navigation';
import { getMDXComponents } from '@/components/mdx';
import { docsConfig } from '@/docs.config';
import { source } from '@/lib/source';

export default async function Page({ params }: PageProps<'/[[...slug]]'>) {
  const page = source.getPage((await params).slug);
  if (!page) notFound();
  const MDX = page.data.body;
  return <DocsPage toc={page.data.toc.filter(item => item.depth <= 3)} full={page.data.full}>
    <header className="concepta-docs-page-header">
      <DocsTitle>{page.data.title}</DocsTitle>
      <DocsDescription>{page.data.description}</DocsDescription>
    </header>
    <DocsBody><MDX components={getMDXComponents({ a: createRelativeLink(source, page) })} /></DocsBody>
    <a href={createSourceUrl(docsConfig, page.path)} className="concepta-docs-source-link">View page source on GitHub</a>
  </DocsPage>;
}
export function generateStaticParams() { return source.generateParams(); }
export async function generateMetadata({ params }: PageProps<'/[[...slug]]'>) {
  const page = source.getPage((await params).slug);
  if (!page) notFound();
  return createPageMetadata(docsConfig, { title: page.data.title, description: page.data.description, path: page.url });
}
