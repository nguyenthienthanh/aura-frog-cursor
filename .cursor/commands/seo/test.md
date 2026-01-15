# /seo:test - Test SEO & Structured Data

## Description

Test SEO implementation using Google Rich Results Test and other validation tools.

## Usage

```
/seo:test [url] [options]
```

**Arguments:**
- `url` (optional): URL to test. Defaults to localhost or production URL from env.

**Options:**
- `--rich-results` - Test structured data with Google Rich Results Test (default)
- `--schema` - Validate Schema.org markup
- `--og` - Test Open Graph tags
- `--all` - Run all tests

## Execution Steps

### 1. Google Rich Results Test (Primary)

**Tool URL:** https://search.google.com/test/rich-results

```bash
# Open Rich Results Test with URL
open "https://search.google.com/test/rich-results?url=${ENCODED_URL}"
```

**What It Tests:**
- JSON-LD structured data validity
- Schema.org compliance
- Rich result eligibility (FAQ, Article, Product, etc.)
- Mobile usability issues
- Page indexability

**Expected Results:**
- ✅ All structured data items valid
- ✅ Eligible for rich results
- ✅ No critical errors

### 2. Automated Testing Flow

```
┌─────────────────────────────────────────────────────────────┐
│                    SEO TEST WORKFLOW                         │
├─────────────────────────────────────────────────────────────┤
│  1. BUILD ──────► Build production version                   │
│       │                                                      │
│       ▼                                                      │
│  2. SERVE ──────► Start local server (or use staging URL)    │
│       │                                                      │
│       ▼                                                      │
│  3. EXTRACT ────► Get JSON-LD from page                      │
│       │                                                      │
│       ▼                                                      │
│  4. VALIDATE ───► Google Rich Results Test                   │
│       │           Schema.org Validator                       │
│       │           OG Tag Debugger                            │
│       ▼                                                      │
│  5. REPORT ─────► Generate test results                      │
└─────────────────────────────────────────────────────────────┘
```

### 3. Test with Playwright MCP

```typescript
// Use Playwright MCP to automate testing
async function testRichResults(url: string) {
  // Navigate to Rich Results Test
  await browser_navigate({
    url: `https://search.google.com/test/rich-results?url=${encodeURIComponent(url)}`
  });

  // Wait for results
  await browser_wait_for({ text: 'Page is eligible' });
  // or
  await browser_wait_for({ text: 'items detected' });

  // Take screenshot of results
  await browser_take_screenshot({
    filename: `.cursor/logs/seo/rich-results-${Date.now()}.png`
  });
}
```

## Testing Tools

### Primary Tools
| Tool | URL | Purpose |
|------|-----|---------|
| **Google Rich Results Test** | https://search.google.com/test/rich-results | Structured data validation |
| **Schema.org Validator** | https://validator.schema.org/ | Schema markup validation |
| **Google Search Console** | https://search.google.com/search-console | Indexing & performance |

### Social Media Debuggers
| Tool | URL | Purpose |
|------|-----|---------|
| **Facebook Sharing Debugger** | https://developers.facebook.com/tools/debug/ | Open Graph tags |
| **Twitter Card Validator** | https://cards-dev.twitter.com/validator | Twitter Cards |
| **LinkedIn Post Inspector** | https://www.linkedin.com/post-inspector/ | LinkedIn sharing |

### Performance Tools
| Tool | URL | Purpose |
|------|-----|---------|
| **PageSpeed Insights** | https://pagespeed.web.dev/ | Core Web Vitals |
| **Lighthouse** | Chrome DevTools | Full SEO audit |
| **GTmetrix** | https://gtmetrix.com/ | Performance analysis |

## Examples

```bash
# Test current project URL
/seo:test https://mysite.com

# Test localhost (start dev server first)
/seo:test http://localhost:3000

# Test specific page
/seo:test https://mysite.com/blog/my-article

# Run all tests
/seo:test https://mysite.com --all

# Test structured data only
/seo:test --rich-results
```

## Local Testing Workflow

```bash
# 1. Build production version
npm run build

# 2. Start production server locally
npm run start
# or use ngrok for public URL
npx ngrok http 3000

# 3. Run SEO test with public URL
/seo:test https://abc123.ngrok.io

# 4. Or test directly with Rich Results Test
open "https://search.google.com/test/rich-results?url=https://abc123.ngrok.io"
```

## Output

- Console output with test results
- Screenshots saved to `.cursor/logs/seo/`
- Structured report in `.cursor/logs/seo/test-{timestamp}.md`

## Checklist After Testing

### Rich Results Test
- [ ] All structured data items valid
- [ ] No errors (warnings acceptable)
- [ ] Eligible for rich results
- [ ] Mobile-friendly

### Schema.org Validation
- [ ] JSON-LD syntax valid
- [ ] Required properties present
- [ ] Property types correct

### Social Media
- [ ] OG image displays correctly
- [ ] Title and description show
- [ ] Twitter card renders properly

### Performance
- [ ] LCP < 2.5s
- [ ] CLS < 0.1
- [ ] INP < 200ms

## References

- **Google Rich Results Test:** https://search.google.com/test/rich-results
- **Schema.org Validator:** https://validator.schema.org/
- **SEO Expert Skill:** `.cursor/rules/skills/experts/seo-expert.mdc`
- **SEO Standards Rule:** `.cursor/rules/core/seo-standards.mdc`

## Notes

- Google Rich Results Test requires a publicly accessible URL
- Use ngrok or deploy to staging for local testing
- Test after every structured data change
- Keep screenshots as documentation

---

**Command ID:** seo:test
**Version:** 1.10.0
**Status:** Active
