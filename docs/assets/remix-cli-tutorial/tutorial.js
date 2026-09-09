/* Keep the tutorial usable when opened directly from a local folder. */
if (window.Prism) Prism.highlightAll();

const copyStatus = document.querySelector('#copy-status');
document.querySelectorAll('.copy').forEach((button) => {
  button.addEventListener('click', async () => {
    const code = button.closest('figure').querySelector('code');
    const label = button.getAttribute('aria-label').replace(/^Copy /, '');
    let copied = false;
    try {
      await navigator.clipboard.writeText(code.textContent);
      copied = true;
    } catch {
      const selection = window.getSelection();
      const range = document.createRange();
      range.selectNodeContents(code);
      selection.removeAllRanges();
      selection.addRange(range);
      try { copied = document.execCommand('copy'); } catch { /* Keep the text selected. */ }
      if (copied) selection.removeAllRanges();
    }
    button.textContent = copied ? 'Copied' : 'Selected';
    copyStatus.textContent = copied
      ? `${label} copied.`
      : 'Code selected. Press Control+C or Command+C to copy.';
    setTimeout(() => { button.textContent = 'Copy'; }, 1800);
  });
});

document.querySelector('#wrap-code').addEventListener('change', (event) => {
  document.body.classList.toggle('wrap-code', event.target.checked);
});

const contents = document.querySelector('.contents');
const narrowScreen = window.matchMedia('(max-width: 1060px)');
const setContents = () => { contents.open = !narrowScreen.matches; };
setContents();
narrowScreen.addEventListener('change', setContents);

const links = [...document.querySelectorAll('.contents nav a')];
const sections = links.map((link) => document.querySelector(link.getAttribute('href')));
const locationLabel = document.querySelector('#current-location');
let scheduled = false;
function updateLocation() {
  let current = 0;
  sections.forEach((section, index) => {
    if (section.getBoundingClientRect().top <= Math.max(160, window.innerHeight * 0.35)) current = index;
  });
  links.forEach((link, index) => {
    if (index === current) link.setAttribute('aria-current', 'location');
    else link.removeAttribute('aria-current');
  });
  locationLabel.textContent = links[current].dataset.label;
  scheduled = false;
}
function scheduleLocation() {
  if (!scheduled) {
    scheduled = true;
    requestAnimationFrame(updateLocation);
  }
}
window.addEventListener('scroll', scheduleLocation, { passive: true });
window.addEventListener('resize', scheduleLocation);
window.addEventListener('hashchange', scheduleLocation);
document.querySelectorAll('details').forEach((details) => {
  details.addEventListener('toggle', scheduleLocation);
});
links.forEach((link) => {
  link.addEventListener('click', () => {
    if (narrowScreen.matches) contents.open = false;
  });
});
updateLocation();
