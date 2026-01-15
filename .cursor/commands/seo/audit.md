# /seo:audit - Comprehensive SEO Audit

## Description

Perform a comprehensive SEO audit of the project, identifying issues and providing recommendations for improvement.

## Usage

```
/seo:audit [path]
```

**Arguments:**
- `path` (optional): Specific file or directory to audit. Defaults to entire project.

## Execution Steps

1. **Scan Project Structure**
   - Identify all page files (pages/, app/)
   - Find layout files
   - Locate existing SEO configuration

2. **Check Meta Tags**
   - Verify title on each page (50-60 chars)
   - Verify description on each page (150-160 chars)
   - Check for duplicate titles/descriptions
   - Validate Open Graph tags
   - Validate Twitter Card tags

3. **Audit Structured Data**
   - Find existing JSON-LD schemas
   - Validate schema syntax
   - Check for missing required schemas
   - Recommend additional schemas

4. **Review Technical SEO**
   - Check sitemap.xml/sitemap.ts exists
   - Validate robots.txt configuration
   - Verify canonical URLs
   - Check for proper heading hierarchy
   - Audit image alt texts

5. **Analyze Performance Factors**
   - Check image optimization setup
   - Review font loading strategy
   - Identify render-blocking resources
   - Check for lazy loading

6. **AI Discovery Assessment**
   - Evaluate content structure
   - Check for answer-optimized content
   - Review citation patterns
   - Assess freshness signals

7. **Validate with Google Rich Results Test**
   - Open https://search.google.com/test/rich-results with project URL
   - Verify all structured data is valid
   - Check for rich result eligibility
   - Document any errors or warnings
   - Take screenshot of results for audit report

   ```bash
   # Test with Rich Results Tool
   open "https://search.google.com/test/rich-results?url=${PROJECT_URL}"
   ```

8. **Generate Report**
   ```markdown
   # SEO Audit Report

   ## Summary
   - Pages Audited: X
   - Issues Found: X
   - Critical: X | Warning: X | Info: X

   ## Critical Issues
   ...

   ## Warnings
   ...

   ## Recommendations
   ...
   ```

## Output

Creates audit report at:
- Console output (summary)
- `.cursor/logs/seo/audit-{timestamp}.md` (full report)

## Examples

```bash
# Audit entire project
/seo:audit

# Audit specific directory
/seo:audit app/blog

# Audit single page
/seo:audit app/products/[slug]/page.tsx
```

## References

- SEO Expert: `.cursor/rules/skills/experts/seo-expert.mdc`
- AI Discovery: `.cursor/rules/skills/reference/ai-discovery.mdc`
- SEO Standards: `.cursor/rules/core/seo-standards.mdc`

## Notes

- Run before major releases
- Compare with previous audits in `.cursor/logs/seo/`
- Use findings to prioritize SEO improvements
