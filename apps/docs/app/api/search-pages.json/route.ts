import { pages } from '@/lib/search-index';
export const dynamic = 'force-static';
export async function GET() { return Response.json(await pages.export()); }
