// Next Link handles basePath itself; native assets and Flutter apps need it explicitly.
export const basePath = process.env.NEXT_PUBLIC_BASE_PATH ?? '/remix';
export const sitePath = (path: string) => `${basePath}${path}`;
