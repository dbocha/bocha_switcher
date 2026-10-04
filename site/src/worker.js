// Bocha Switcher — bochaswitcher.com
// Static site from ./public, plus three small routes:
//   www.*          → 301 to the bare domain
//   /get           → 302 to the latest DMG on GitHub Releases
//   /release.json  → version and SHA-256 of the latest release (from its update feed)

const REPO = "dbocha/bocha_switcher";
const LATEST = `https://github.com/${REPO}/releases/latest/download`;

export default {
  async fetch(request, env) {
    const url = new URL(request.url);

    if (url.hostname.startsWith("www.")) {
      url.hostname = url.hostname.slice(4);
      return Response.redirect(url.toString(), 301);
    }

    if (url.pathname === "/get" || url.pathname === "/get/") {
      return Response.redirect(`${LATEST}/BochaSwitcher.dmg`, 302);
    }

    if (url.pathname === "/release.json") {
      return releaseInfo();
    }

    return env.ASSETS.fetch(request);
  },
};

async function releaseInfo() {
  const headers = { "content-type": "application/json; charset=utf-8", "cache-control": "public, max-age=300" };
  try {
    const res = await fetch(`${LATEST}/version.json`, { cf: { cacheTtl: 300, cacheEverything: true } });
    if (!res.ok) throw new Error(`feed ${res.status}`);
    const feed = await res.json();
    const body = { version: feed.version, sha256: feed.sha256, notes: feed.notes, url: feed.url };
    return new Response(JSON.stringify(body), { headers });
  } catch {
    return new Response(JSON.stringify({ version: null }), { status: 502, headers });
  }
}
