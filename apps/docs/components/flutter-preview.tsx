'use client';

import { useTheme } from 'fumadocs-ui/provider/base';
import { useEffect, useId, useRef, useState, type ComponentProps } from 'react';

// Native selection retains keyboard navigation and the mobile system picker.
function PreviewSelect({ label, ...props }: ComponentProps<'select'> & { label: string }) {
  return <div className="remix-preview-field">
    <label htmlFor={props.id}>{label}</label>
    <div className="remix-preview-select">
      <select {...props} />
      <svg aria-hidden="true" focusable="false" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
        <path d="m6 9 6 6 6-6" />
      </svg>
    </div>
  </div>;
}

export function FlutterPreview({ title, cases }: {
  title: string;
  cases: { name: string; path: string }[];
}) {
  const id = useId();
  const frame = useRef<HTMLIFrameElement>(null);
  const { resolvedTheme } = useTheme();
  const [path, setPath] = useState(cases[0].path);
  // The example follows the site theme until the reader picks one to compare.
  const [chosenMode, setChosenMode] = useState<string | null>(null);
  const [mounted, setMounted] = useState(false);
  const [attempt, setAttempt] = useState(0);
  const [loadState, setLoadState] = useState<{ url: string; status: 'ready' | 'slow' } | null>(null);
  const mode = chosenMode ?? (resolvedTheme === 'dark' ? 'dark' : 'light');
  const query = new URLSearchParams({ path, theme: `{name:${mode}}` });
  const catalogUrl = `/previews/#/?${query}`;
  const previewUrl = `${catalogUrl}&preview&attempt=${attempt}`;
  const status = loadState?.url === previewUrl ? loadState.status : 'loading';
  const compact = ['Button', 'IconButton', 'Badge', 'Switch', 'Checkbox', 'Radio', 'Spinner', 'Progress'].includes(title);

  // The resolved theme is only known on the client; render one correct frame.
  useEffect(() => setMounted(true), []);

  useEffect(() => {
    setLoadState(null);
    const timeout = window.setTimeout(() => setLoadState({ url: previewUrl, status: 'slow' }), 25000);
    const onMessage = (event: MessageEvent) => {
      if (event.origin !== window.location.origin || event.source !== frame.current?.contentWindow || event.data?.type !== 'remix-preview-ready') return;
      window.clearTimeout(timeout);
      setLoadState({ url: previewUrl, status: 'ready' });
    };
    window.addEventListener('message', onMessage);
    return () => { window.clearTimeout(timeout); window.removeEventListener('message', onMessage); };
  }, [previewUrl]);

  return <div className="not-prose remix-preview">
    <div className="remix-preview-toolbar">
      <PreviewSelect label="Example" id={`${id}-case`} value={path} onChange={event => setPath(event.target.value)}>
        {cases.map(item => <option key={item.path} value={item.path}>{item.name}</option>)}
      </PreviewSelect>
      <PreviewSelect label="Theme" aria-label="Example theme" id={`${id}-theme`} value={mode} onChange={event => setChosenMode(event.target.value)}>
        <option value="light">Light</option><option value="dark">Dark</option>
      </PreviewSelect>
      <div className="remix-preview-actions">
        <button type="button" className="remix-preview-reset" onClick={() => {
          setPath(cases[0].path);
          setChosenMode(null);
          setAttempt(value => value + 1);
        }}>Reset example</button>
        <a href={catalogUrl} target="_blank" rel="noreferrer">Open catalog</a>
      </div>
    </div>
    <div className={`remix-preview-stage${['Dialog', 'Data Table'].includes(title) ? ' remix-preview-stage-large' : compact ? ' remix-preview-stage-compact' : ''}`} data-status={status} aria-busy={status === 'loading'}>
      {mounted && <iframe key={previewUrl} ref={frame} src={previewUrl} title={`${title} interactive Flutter example`} loading="lazy" />}
      {status !== 'ready' && <div className="remix-preview-status" role="status">
        <span>{status === 'loading' ? 'Starting Flutter example…' : 'The example is taking longer to start. Retry or open the catalog.'}</span>
        {status === 'slow' && <button type="button" onClick={() => setAttempt(value => value + 1)}>Retry example</button>}
      </div>}
    </div>
    <div className="remix-preview-caption">Live Flutter from this checkout’s component catalog. Examples include Fortal styling; the source tab shows the catalog code, not a standalone application.</div>
  </div>;
}
