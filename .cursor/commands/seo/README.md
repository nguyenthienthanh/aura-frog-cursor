# SEO Commands

Commands for Search Engine Optimization and AI Discovery optimization.

## Available Commands

| Command | Description |
|---------|-------------|
| `/seo:audit` | Comprehensive SEO audit of the codebase |
| `/seo:check` | Validate live page SEO & GEO scores |
| `/seo:test` | Test with Google Rich Results Test |
| `/seo:schema` | Generate structured data (JSON-LD) |
| `/seo:sitemap` | Generate dynamic sitemap |
| `/seo:vitals` | Core Web Vitals analysis and optimization |
| `/seo:ai-optimize` | AI Discovery optimization (Perplexity, ChatGPT, Gemini) |
| `/seo:meta` | Generate meta tags (OG, Twitter Cards) |
| `/seo:i18n` | International SEO setup (hreflang) |

## Quick Reference

### SEO Audit
```bash
/seo:audit              # Audit entire project
/seo:audit app/blog     # Audit specific directory
```

### SEO/GEO Check (Validation)
```bash
/seo:check https://mysite.com          # Full SEO + GEO check
/seo:check https://mysite.com --seo    # SEO only
/seo:check https://mysite.com --geo    # GEO/AI Discovery only
/seo:check http://localhost:3000       # Check local dev server
```

**What it validates:**
- SEO: Meta tags, structured data, headings, technical SEO
- GEO: AI content structure, citations, author info, entity recognition

### SEO Test (External Tools)
```bash
/seo:test https://mysite.com           # Test production URL
/seo:test http://localhost:3000        # Test local dev server
/seo:test https://mysite.com --all     # Run all validation tests
```

**Testing Tools:**
- Google Rich Results Test: https://search.google.com/test/rich-results
- Schema.org Validator: https://validator.schema.org/
- Facebook Debugger: https://developers.facebook.com/tools/debug/

### Structured Data
```bash
/seo:schema article     # Blog post schema
/seo:schema product     # E-commerce product
/seo:schema faq         # FAQ page
/seo:schema organization # Company schema
```

### Sitemap
```bash
/seo:sitemap            # Basic sitemap
/seo:sitemap --dynamic  # With dynamic routes
/seo:sitemap --index    # Sitemap index for large sites
```

### Core Web Vitals
```bash
/seo:vitals --analyze   # Analyze current state
/seo:vitals --fix       # Apply automatic fixes
/seo:vitals --report    # Generate detailed report
```

### AI Discovery
```bash
/seo:ai-optimize                # Full optimization
/seo:ai-optimize --content      # Content structure only
/seo:ai-optimize --schema       # AI-friendly schemas
/seo:ai-optimize --freshness    # Freshness signals
```

### Meta Tags
```bash
/seo:meta               # Generate for current page
/seo:meta --og          # Open Graph only
/seo:meta --twitter     # Twitter Cards only
```

### International SEO
```bash
/seo:i18n --setup       # Initial setup
/seo:i18n --add-locale vi-VN  # Add locale
/seo:i18n --audit       # Audit existing i18n
```

## Related Resources

- **Agent:** `.cursor/rules/agents/web-seo.mdc`
- **Skills:**
  - `.cursor/rules/skills/experts/seo-expert.mdc`
  - `.cursor/rules/skills/reference/ai-discovery.mdc`
- **Rule:** `.cursor/rules/core/seo-standards.mdc`

---

**Version:** 1.10.0
**Last Updated:** 2026-01-15
