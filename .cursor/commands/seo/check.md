# /seo:check - SEO & GEO Validation Check

## Description

Run comprehensive SEO and GEO (Generative Engine Optimization) validation checks on project pages. Unlike `/seo:audit` which analyzes the codebase, this command validates live pages against SEO and AI Discovery standards.

## Usage

```
/seo:check [url] [options]
```

**Arguments:**
- `url` (required): URL to check (localhost or production)

**Options:**
- `--seo` - Traditional SEO checks only
- `--geo` - GEO/AI Discovery checks only
- `--full` - Both SEO and GEO checks (default)
- `--json` - Output results as JSON

## Execution Steps

### 1. SEO Checks

#### Meta Tags Validation
```
✓ Title exists and is 50-60 characters
✓ Meta description exists and is 150-160 characters
✓ Canonical URL present
✓ Open Graph tags complete (og:title, og:description, og:image, og:url)
✓ Twitter Card tags present (twitter:card, twitter:title, twitter:image)
✓ Viewport meta tag set
✓ Language attribute on <html>
```

#### Structured Data Validation
```
✓ JSON-LD schema present
✓ Schema syntax valid
✓ Required properties exist
✓ Google Rich Results eligible
  → Test: https://search.google.com/test/rich-results?url={URL}
```

#### Technical SEO
```
✓ HTTPS enabled
✓ Canonical URL matches current URL
✓ No duplicate meta tags
✓ robots meta allows indexing
✓ hreflang tags (if multi-language)
```

#### Content Structure
```
✓ Single H1 tag
✓ Heading hierarchy correct (H1→H2→H3)
✓ Images have alt text
✓ Links have descriptive text (no "click here")
```

### 2. GEO Checks (Generative Engine Optimization)

#### Content Structure for AI
```
✓ Direct answer in first 1-2 sentences
✓ Key takeaways section present
✓ FAQ section with Q&A format
✓ Semantic HTML structure (<article>, <section>, <aside>)
✓ Table of contents for long content
```

#### Citation & Credibility
```
✓ Author information visible
✓ Author credentials/bio present
✓ Publish date displayed
✓ Last updated date displayed
✓ Sources/references section
✓ External links to authoritative sources
```

#### Entity Recognition
```
✓ Clear entity definitions
✓ Specific data (numbers, dates, statistics)
✓ Comparison tables where relevant
✓ Step-by-step instructions (if how-to)
```

#### AI Crawler Accessibility
```
✓ robots.txt allows AI crawlers (or blocks intentionally)
✓ Content not hidden behind JavaScript
✓ Clean, parseable HTML structure
✓ Schema.org markup for entities
```

## Check Results Format

```
╔═══════════════════════════════════════════════════════════════╗
║                    SEO/GEO CHECK RESULTS                       ║
╠═══════════════════════════════════════════════════════════════╣
║  URL: https://example.com/blog/article                         ║
║  Checked: 2026-01-15 10:30:00                                  ║
╠═══════════════════════════════════════════════════════════════╣
║                                                                 ║
║  SEO SCORE: 85/100                                             ║
║  ├─ Meta Tags:        ████████░░ 80%                           ║
║  ├─ Structured Data:  ██████████ 100%                          ║
║  ├─ Technical SEO:    ████████░░ 80%                           ║
║  └─ Content:          ████████░░ 80%                           ║
║                                                                 ║
║  GEO SCORE: 70/100                                             ║
║  ├─ AI Structure:     ████████░░ 80%                           ║
║  ├─ Citations:        ██████░░░░ 60%                           ║
║  ├─ Entity Recognition: ██████░░░░ 60%                         ║
║  └─ Crawlability:     ████████░░ 80%                           ║
║                                                                 ║
╠═══════════════════════════════════════════════════════════════╣
║  ISSUES FOUND: 5                                               ║
║                                                                 ║
║  ❌ CRITICAL (1)                                               ║
║     • Missing author information                                ║
║                                                                 ║
║  ⚠️  WARNING (3)                                                ║
║     • Meta description is 180 chars (recommended: 150-160)     ║
║     • No "Last updated" date visible                           ║
║     • Missing FAQ section for AI extraction                    ║
║                                                                 ║
║  ℹ️  INFO (1)                                                   ║
║     • Consider adding comparison table                         ║
║                                                                 ║
╠═══════════════════════════════════════════════════════════════╣
║  VALIDATION LINKS:                                             ║
║  • Rich Results: https://search.google.com/test/rich-results   ║
║  • Schema: https://validator.schema.org/                       ║
║  • PageSpeed: https://pagespeed.web.dev/                       ║
╚═══════════════════════════════════════════════════════════════╝
```

## Implementation with Playwright MCP

```typescript
// Automated SEO/GEO check using Playwright
async function runSEOGEOCheck(url: string) {
  // Navigate to page
  await browser_navigate({ url });

  // Get page snapshot for analysis
  const snapshot = await browser_snapshot({});

  // Extract and validate meta tags
  const metaCheck = await browser_evaluate({
    function: `() => {
      const title = document.title;
      const description = document.querySelector('meta[name="description"]')?.content;
      const canonical = document.querySelector('link[rel="canonical"]')?.href;
      const ogTitle = document.querySelector('meta[property="og:title"]')?.content;
      const h1Count = document.querySelectorAll('h1').length;
      const jsonLd = document.querySelectorAll('script[type="application/ld+json"]');

      return {
        title: { value: title, length: title?.length },
        description: { value: description, length: description?.length },
        canonical,
        ogTitle,
        h1Count,
        hasJsonLd: jsonLd.length > 0,
        jsonLdCount: jsonLd.length
      };
    }`
  });

  // Check GEO elements
  const geoCheck = await browser_evaluate({
    function: `() => {
      const article = document.querySelector('article');
      const faq = document.querySelector('[itemtype*="FAQPage"]') ||
                  document.querySelector('.faq') ||
                  document.querySelector('#faq');
      const author = document.querySelector('[rel="author"]') ||
                     document.querySelector('.author') ||
                     document.querySelector('[itemtype*="Person"]');
      const pubDate = document.querySelector('time[datetime]');
      const sources = document.querySelector('.sources') ||
                      document.querySelector('.references') ||
                      document.querySelector('#sources');

      return {
        hasArticleTag: !!article,
        hasFAQ: !!faq,
        hasAuthor: !!author,
        hasPubDate: !!pubDate,
        hasSources: !!sources
      };
    }`
  });

  return { metaCheck, geoCheck };
}
```

## Examples

```bash
# Full SEO + GEO check
/seo:check https://mysite.com/blog/article

# SEO only
/seo:check https://mysite.com --seo

# GEO only (AI Discovery)
/seo:check https://mysite.com --geo

# Check localhost
/seo:check http://localhost:3000/products/item

# Output as JSON
/seo:check https://mysite.com --json
```

## Quick Check Workflow

```bash
# 1. Start local dev server
npm run dev

# 2. Run check on local page
/seo:check http://localhost:3000/blog/my-article

# 3. Fix reported issues

# 4. Re-run check to verify fixes
/seo:check http://localhost:3000/blog/my-article

# 5. Deploy and check production
/seo:check https://mysite.com/blog/my-article
```

## Comparison: /seo:check vs /seo:audit vs /seo:test

| Command | Purpose | Input | Output |
|---------|---------|-------|--------|
| `/seo:check` | Validate live page SEO/GEO | URL | Score + issues |
| `/seo:audit` | Analyze codebase | Files | Recommendations |
| `/seo:test` | External tool validation | URL | Tool results |

## Output

- Console: Formatted check results with scores
- File: `.cursor/logs/seo/check-{timestamp}.md`
- JSON: `.cursor/logs/seo/check-{timestamp}.json` (with `--json`)

## References

- **SEO Standards:** `.cursor/rules/core/seo-standards.mdc`
- **SEO Expert:** `.cursor/rules/skills/experts/seo-expert.mdc`
- **AI Discovery:** `.cursor/rules/skills/reference/ai-discovery.mdc`
- **Google Rich Results:** https://search.google.com/test/rich-results
- **Schema Validator:** https://validator.schema.org/

## Notes

- Run on both localhost and production URLs
- GEO checks focus on AI search engine optimization
- Scores are guidelines, not absolute requirements
- Some checks require Playwright MCP for automation

---

**Command ID:** seo:check
**Version:** 1.11.0
**Status:** Active
