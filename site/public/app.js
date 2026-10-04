/* Bocha Switcher — bochaswitcher.com
   The layout-fix demo in the hero, the name easter egg, scroll reveals and the
   release data on the download page. No dependencies, no tracking. */

const reduced = matchMedia('(prefers-reduced-motion: reduce)').matches;

/* ---------- sticky nav ---------- */
const nav = document.querySelector('.nav');
if (nav) {
  const onScroll = () => nav.classList.toggle('is-stuck', window.scrollY > 8);
  onScroll();
  addEventListener('scroll', onScroll, { passive: true });
}

/* ---------- reveal on scroll ---------- */
const revealables = document.querySelectorAll('.reveal');
if (revealables.length && !reduced && 'IntersectionObserver' in window) {
  const io = new IntersectionObserver((entries) => {
    for (const entry of entries) {
      if (!entry.isIntersecting) continue;
      entry.target.classList.add('in');
      io.unobserve(entry.target);
    }
  }, { rootMargin: '0px 0px -12% 0px' });
  revealables.forEach((el) => io.observe(el));
} else {
  revealables.forEach((el) => el.classList.add('in'));
}

/* Runs `start` while `el` is on screen and `stop` when it scrolls away. */
const whileVisible = (el, start, stop) => {
  if (!('IntersectionObserver' in window)) { start(); return; }
  new IntersectionObserver((entries) => {
    for (const entry of entries) entry.isIntersecting ? start() : stop();
  }, { threshold: .15 }).observe(el);
};

/* Small timer set that can be cancelled as a whole. */
const timeline = () => {
  let timers = [];
  return {
    later(fn, ms) { timers.push(setTimeout(fn, ms)); },
    clear() { timers.forEach(clearTimeout); timers = []; },
    get idle() { return timers.length === 0; },
  };
};

/* Types `text` into `el` one character at a time, then calls `done`. */
const typeInto = (t, el, text, done, base = 70) => {
  let i = 0;
  const step = () => {
    el.textContent = text.slice(0, i);
    if (i++ < text.length) t.later(step, base + Math.random() * 60);
    else done();
  };
  step();
};

/* ---------- hero demo: wrong layout → one tap ---------- */
const demo = document.querySelector('[data-demo]');
if (demo) {
  const copy = JSON.parse(demo.dataset.demo);
  const recorder = demo.querySelector('.recorder');
  const label = demo.querySelector('[data-label]');
  const typed = demo.querySelector('[data-typed]');
  const tail = demo.querySelector('[data-tail]');
  const caret = demo.querySelector('.caret');
  const badge = demo.querySelector('.layout-badge');
  const replay = demo.querySelector('.replay');
  const t = timeline();

  const setStatus = (text, done) => {
    label.textContent = text;
    label.parentElement.classList.toggle('is-done', !!done);
  };

  const finalState = () => {
    typed.textContent = copy.right;
    typed.className = 'typed';
    tail.textContent = copy.tail;
    caret.style.display = 'none';
    badge.textContent = copy.to;
    setStatus(copy.fixed, true);
  };

  const cycle = () => {
    t.clear();
    typed.textContent = '';
    typed.className = 'typed';
    tail.textContent = '';
    caret.style.display = '';
    badge.textContent = copy.from;
    demo.classList.remove('is-fixed');
    recorder.classList.remove('is-held');
    setStatus(copy.idle, false);

    t.later(() => {
      setStatus(copy.typing, false);
      typeInto(t, typed, copy.wrong, () => {
        typed.classList.add('is-wrong');
        setStatus(copy.noticed, false);

        t.later(() => {
          recorder.classList.add('is-held');
          setStatus(copy.tap, false);
        }, 1100);

        t.later(() => {
          recorder.classList.remove('is-held');
          typed.textContent = copy.right;
          typed.classList.remove('is-wrong');
          typed.classList.add('is-fixed');
          badge.textContent = copy.to;
          demo.classList.add('is-fixed');
          setStatus(copy.fixed, true);
        }, 1450);

        t.later(() => {
          typed.classList.remove('is-fixed');
          typeInto(t, tail, copy.tail, () => {
            caret.style.display = 'none';
            t.later(cycle, 3600);
          });
        }, 2700);
      });
    }, 900);
  };

  if (reduced) finalState();
  else whileVisible(demo, () => { if (t.idle) cycle(); }, () => t.clear());

  replay?.addEventListener('click', () => { if (!reduced) cycle(); });
}

/* ---------- the name, typed in the wrong layout ---------- */
document.querySelectorAll('[data-flip]').forEach((el) => {
  const [wrong, right] = JSON.parse(el.dataset.flip);
  const out = el.querySelector('[data-flip-out]');
  const t = timeline();

  const cycle = () => {
    t.clear();
    out.textContent = '';
    out.classList.remove('is-wrong');
    typeInto(t, out, wrong, () => {
      out.classList.add('is-wrong');
      t.later(() => {
        out.classList.remove('is-wrong');
        out.textContent = right;
        t.later(cycle, 3200);
      }, 1500);
    }, 110);
  };

  if (reduced) out.textContent = right;
  else whileVisible(el, () => { if (t.idle) cycle(); }, () => t.clear());
});

/* ---------- copy the checksum ---------- */
document.querySelectorAll('[data-copy]').forEach((button) => {
  button.addEventListener('click', async () => {
    const value = document.querySelector(button.dataset.copy)?.textContent.trim();
    if (!value) return;
    try {
      await navigator.clipboard.writeText(value);
      const before = button.textContent;
      button.textContent = button.dataset.copied || 'Copied';
      setTimeout(() => { button.textContent = before; }, 1800);
    } catch { /* clipboard blocked — the text is selectable anyway */ }
  });
});

/* ---------- release data on the download page ---------- */
const release = document.querySelector('[data-release]');
if (release) {
  const strings = JSON.parse(release.dataset.release);
  fetch('/release.json', { cache: 'no-store' })
    .then((r) => (r.ok ? r.json() : null))
    .then((data) => {
      if (!data || !data.version) return;
      const meta = release.querySelector('[data-meta]');
      const checksum = document.querySelector('[data-checksum]');
      const box = document.querySelector('.checksum');
      if (meta) meta.textContent = strings.version.replace('%s', data.version);
      if (checksum && data.sha256) { checksum.textContent = data.sha256; box?.removeAttribute('hidden'); }
    })
    .catch(() => { /* the button works without it */ });
}
