'use client';

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
  const [path, setPath] = useState(cases[0].path);
  const [mode, setMode] = useState('light');
  const [attempt, setAttempt] = useState(0);
  const [status, setStatus] = useState<'loading' | 'ready' | 'slow'>('loading');
  const query = new URLSearchParams({ path, theme: `{name:${mode}}` });
  const catalogUrl = `/previews/#/?${query}`;
  const previewUrl = `${catalogUrl}&preview&attempt=${attempt}`;

  useEffect(() => {
    setStatus('loading');
    const timeout = window.setTimeout(() => setStatus('slow'), 25000);
    const onMessage = (event: MessageEvent) => {
      if (event.origin !== window.location.origin || event.source !== frame.current?.contentWindow || event.data?.type !== 'remix-preview-ready') return;
      window.clearTimeout(timeout);
      setStatus('ready');
    };
    window.addEventListener('message', onMessage);
    return () => { window.clearTimeout(timeout); window.removeEventListener('message', onMessage); };
  }, [previewUrl]);

  return <div className="not-prose remix-preview">
    <div className="remix-preview-toolbar">
      <PreviewSelect label="Example" id={`${id}-case`} value={path} onChange={event => setPath(event.target.value)}>
        {cases.map(item => <option key={item.path} value={item.path}>{item.name}</option>)}
      </PreviewSelect>
      <PreviewSelect label="Theme" aria-label="Example theme" id={`${id}-theme`} value={mode} onChange={event => setMode(event.target.value)}>
        <option value="light">Light</option><option value="dark">Dark</option>
      </PreviewSelect>
      <a href={catalogUrl} target="_blank" rel="noreferrer">Open catalog</a>
    </div>
    <div className="remix-preview-stage" aria-busy={status === 'loading'}>
      <iframe key={previewUrl} ref={frame} src={previewUrl} title={`${title} interactive Flutter example`} loading="lazy" />
      {status !== 'ready' && <div className="remix-preview-status" role="status">
        <span>{status === 'loading' ? 'Starting Flutter example…' : 'The example is taking longer to start. Retry or open the catalog.'}</span>
        {status === 'slow' && <button type="button" onClick={() => setAttempt(value => value + 1)}>Retry example</button>}
      </div>}
    </div>
    <div className="remix-preview-caption">Live Flutter from this checkout’s component catalog. Examples include Fortal styling; the source tab shows the catalog code, not a standalone application.</div>
  </div>;
}
