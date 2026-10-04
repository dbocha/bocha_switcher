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

/* ---------- hero: mistyped words falling into a black hole ----------
   Each word is typed in the wrong layout. It spirals in on a tilted disc,
   speeding up as it falls; halfway down it turns into what was meant, then
   stretches along its orbit and disappears behind the event horizon. */
const vortex = document.querySelector('.vortex');
if (vortex) {
  const hero = vortex.parentElement;
  const anchor = hero.querySelector('h1');
  const ctx = vortex.getContext('2d');
  const WORDS = [
    ['ghbdtn', 'привет'], ['rfr ltkf', 'как дела'], ['cgfcb,j', 'спасибо'], ['ntrcn', 'текст'],
    ['hfcrkflrf', 'раскладка'], ['pfdnhf', 'завтра'], ['jrtq', 'окей'], ['ytn', 'нет'], ['rjl', 'код'],
    ['vbh', 'мир'], ['lfdfq', 'давай'], ['[jhjij', 'хорошо'], ['cjpdjy', 'созвон'], ['gjrf', 'пока'],
    ['kflyj', 'ладно'], ['dcnhtxf', 'встреча'], ['ehf', 'ура'], ['ищсрф', 'bocha'], ['руддщ', 'hello'],
    ['цщкв', 'word'], ['ыцшеср', 'switch'], ['дфнщге', 'layout'], ['ьфс', 'mac'], ['ерфтлы', 'thanks'],
    ['мщшсу', 'voice'], ['зкщьзе', 'prompt'], ['ыршз', 'ship'], ['вуздщн', 'deploy'], ['сщаауу', 'coffee'],
    ['дфеук', 'later'], ['ьууештп', 'meeting'], ['нуы', 'yes'],
  ];
  const TILT = .42;                    // disc seen from slightly above
  const FONT = '-apple-system, BlinkMacSystemFont, "SF Pro Text", "Segoe UI", Inter, system-ui, sans-serif';
  let W = 0, H = 0, cx = 0, cy = 0, R = 0, horizon = 0, dpr = 1;
  let words = [], quiet = [], raf = 0, last = 0, running = false;

  const rand = (a, b) => a + Math.random() * (b - a);
  const clamp01 = (x) => Math.max(0, Math.min(1, x));

  const spawn = (outer) => {
    const [wrong, right] = WORDS[Math.floor(Math.random() * WORDS.length)];
    return {
      wrong, right,
      a: rand(0, Math.PI * 2),
      r: outer ? R * rand(1, 1.25) : rand(horizon * 1.6, R * 1.1),
      size: rand(15, 25),
      flip: rand(.3, .46),            // fraction of R where the word gets fixed
    };
  };

  const layout = () => {
    const box = hero.getBoundingClientRect();
    const h1 = anchor.getBoundingClientRect();
    dpr = Math.min(devicePixelRatio || 1, 2);
    W = box.width; H = box.height;
    vortex.width = Math.round(W * dpr);
    vortex.height = Math.round(H * dpr);
    cx = W / 2;
    cy = h1.top - box.top + h1.height / 2;
    R = Math.max(W * .62, 420);
    horizon = Math.max(46, Math.min(W, 1200) * .06);
    // text blocks where words should stay faint so the copy remains readable
    quiet = [...hero.querySelectorAll('.hero-copy .flag, .hero-copy .lead, .hero-copy .actions, .hero-copy .note')]
      .map((el) => el.getBoundingClientRect())
      .map((r) => ({ x0: r.left - box.left - 12, x1: r.right - box.left + 12, y0: r.top - box.top - 10, y1: r.bottom - box.top + 10 }));
    const count = W < 640 ? 22 : 44;
    words = Array.from({ length: count }, () => spawn(false));
  };

  const step = (w, dt) => {
    const k = R / Math.max(w.r, 1);
    w.r -= 16 * Math.pow(k, .75) * dt;                 // falls faster near the centre
    w.a += Math.min(.18 * Math.pow(k, 1.15), 3.2) * dt; // and spins faster too
    if (w.r < horizon * .9) Object.assign(w, spawn(true));
  };

  const drawWord = (w) => {
    const x = cx + Math.cos(w.a) * w.r;
    const y = cy + Math.sin(w.a) * w.r * TILT;
    const t = w.r / R;
    const fixed = t < w.flip;
    // fade in at the rim, fade out at the horizon
    let alpha = clamp01((1.18 - t) / .3) * clamp01((w.r - horizon) / (horizon * 1.3)) * .42;
    if (quiet.some((q) => x > q.x0 && x < q.x1 && y > q.y0 && y < q.y1)) alpha *= .28;
    if (alpha <= .01) return;
    // behind the hole (upper half of the disc) words are dimmer
    const depth = Math.sin(w.a) < 0 ? .7 : 1;
    const size = w.size * (.35 + .65 * Math.sqrt(clamp01(t)));
    // tangent of the ellipse, kept upright so the word stays readable
    let rot = Math.atan2(TILT * Math.cos(w.a), -Math.sin(w.a));
    if (rot > Math.PI / 2) rot -= Math.PI; else if (rot < -Math.PI / 2) rot += Math.PI;
    // spaghettification just before the horizon
    const s = clamp01((horizon * 2.6 - w.r) / (horizon * 1.6));
    ctx.save();
    ctx.translate(x, y);
    ctx.rotate(rot * (.4 + .6 * (1 - t)));
    ctx.scale(1 + s * 1.4, 1 - s * .6);
    ctx.globalAlpha = alpha * depth;
    ctx.fillStyle = fixed ? '#f4f1ea' : '#ffb071';
    ctx.font = `${fixed ? 600 : 500} ${size.toFixed(1)}px ${FONT}`;
    ctx.textAlign = 'center';
    ctx.textBaseline = 'middle';
    ctx.fillText(fixed ? w.right : w.wrong, 0, 0);
    ctx.restore();
  };

  const drawHole = (time) => {
    // faint accretion rings on the disc
    ctx.save();
    ctx.translate(cx, cy);
    ctx.scale(1, TILT);
    for (const [m, a] of [[1.7, .16], [2.6, .09], [3.8, .05]]) {
      ctx.beginPath();
      ctx.arc(0, 0, horizon * m, 0, Math.PI * 2);
      ctx.strokeStyle = `rgba(255, 138, 61, ${a})`;
      ctx.lineWidth = 1;
      ctx.stroke();
    }
    ctx.restore();
    // glow and the photon ring
    const pulse = 1 + Math.sin(time / 1400) * .04;
    const glow = ctx.createRadialGradient(cx, cy, horizon * .8, cx, cy, horizon * 2.6 * pulse);
    glow.addColorStop(0, 'rgba(255, 138, 61, .34)');
    glow.addColorStop(.35, 'rgba(255, 138, 61, .1)');
    glow.addColorStop(1, 'rgba(255, 138, 61, 0)');
    ctx.fillStyle = glow;
    ctx.beginPath();
    ctx.arc(cx, cy, horizon * 2.6 * pulse, 0, Math.PI * 2);
    ctx.fill();
    // the event horizon itself
    const core = ctx.createRadialGradient(cx, cy, 0, cx, cy, horizon * 1.08);
    core.addColorStop(0, '#000');
    core.addColorStop(.86, '#020304');
    core.addColorStop(1, 'rgba(2, 3, 4, 0)');
    ctx.fillStyle = core;
    ctx.beginPath();
    ctx.arc(cx, cy, horizon * 1.08, 0, Math.PI * 2);
    ctx.fill();
    ctx.beginPath();
    ctx.arc(cx, cy, horizon * 1.01, 0, Math.PI * 2);
    ctx.strokeStyle = 'rgba(255, 176, 113, .55)';
    ctx.lineWidth = 1.2;
    ctx.shadowColor = 'rgba(255, 138, 61, .9)';
    ctx.shadowBlur = 18;
    ctx.stroke();
    ctx.shadowBlur = 0;
  };

  const frame = (time) => {
    const dt = Math.min((time - (last || time)) / 1000, .05);
    last = time;
    ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
    ctx.clearRect(0, 0, W, H);
    // words behind the hole first, then the hole, then words in front of it
    for (const w of words) step(w, dt);
    for (const w of words) if (Math.sin(w.a) < 0) drawWord(w);
    drawHole(time);
    for (const w of words) if (Math.sin(w.a) >= 0) drawWord(w);
    if (running) raf = requestAnimationFrame(frame);
  };

  const start = () => { if (running || reduced) return; running = true; last = 0; raf = requestAnimationFrame(frame); };
  const stop = () => { running = false; cancelAnimationFrame(raf); };

  layout();
  if (reduced) frame(0);
  new ResizeObserver(() => { layout(); if (!running) frame(performance.now()); }).observe(hero);
  whileVisible(hero, start, stop);
  document.addEventListener('visibilitychange', () => (document.hidden ? stop() : start()));
}
