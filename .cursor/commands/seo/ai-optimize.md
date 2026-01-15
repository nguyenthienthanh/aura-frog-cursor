# /seo:ai-optimize - AI Discovery Optimization

## Description

Optimize content for AI-powered search engines and answer engines (Perplexity, ChatGPT Search, Gemini, etc.).

## Usage

```
/seo:ai-optimize [path] [options]
```

**Arguments:**
- `path` (optional): Specific file or directory to optimize

**Options:**
- `--content` - Optimize content structure only
- `--schema` - Add AI-friendly structured data
- `--freshness` - Add freshness indicators
- `--full` - Apply all optimizations (default)

## Execution Steps

1. **Analyze Content Structure**
   - Check heading hierarchy
   - Identify main topics/entities
   - Evaluate answer-readiness
   - Review citation patterns

2. **Content Optimization**
   - Restructure for direct answers
   - Add TL;DR/summary sections
   - Create key takeaways
   - Add FAQ sections

3. **Semantic Structure**
   ```tsx
   // Transform content to AI-friendly structure
   <article itemScope itemType="https://schema.org/Article">
     <header>
       <h1 itemProp="headline">{title}</h1>
       <p className="summary" itemProp="description">
         {/* Direct answer in first 1-2 sentences */}
       </p>
     </header>

     <aside className="key-takeaways">
       <h2>Key Takeaways</h2>
       <ul>
         {keyPoints.map(point => <li key={point}>{point}</li>)}
       </ul>
     </aside>

     <div itemProp="articleBody">
       {/* Main content with clear sections */}
     </div>

     <footer>
       <section className="sources">
         <h2>Sources</h2>
         {/* Cited references */}
       </section>
     </footer>
   </article>
   ```

4. **Add Freshness Signals**
   ```tsx
   <time dateTime={publishedAt} itemProp="datePublished">
     Published: {formatDate(publishedAt)}
   </time>
   <time dateTime={updatedAt} itemProp="dateModified">
     Updated: {formatDate(updatedAt)}
   </time>
   ```

5. **Enhanced Schema**
   - Add speakable specification
   - Include citation metadata
   - Add author credentials

## AI-Optimized Content Pattern

### Before
```markdown
# About Our Product

We've been making great products for years...
[Long introduction before getting to the point]
```

### After
```markdown
# What is [Product Name]?

**[Product Name] is [direct definition in one sentence].**
It helps [target audience] achieve [specific outcome].

## Key Facts
- Feature 1: [specific detail]
- Feature 2: [specific detail]
- Price: $X/month

## How [Product Name] Works
1. Step one
2. Step two
3. Step three

## Comparison: [Product] vs Alternatives
| Feature | [Product] | Competitor A | Competitor B |
...

## Frequently Asked Questions

### What is [Product Name] used for?
[Direct answer]

### How much does [Product Name] cost?
[Direct answer with pricing]

## Sources
- [Official Documentation](url)
- [Industry Report](url)
```

## Examples

```bash
# Optimize entire content directory
/seo:ai-optimize content/

# Optimize specific blog post
/seo:ai-optimize app/blog/my-post/page.tsx

# Content structure only
/seo:ai-optimize --content

# Add AI-friendly schemas
/seo:ai-optimize --schema
```

## Output

- Modified content files with improved structure
- New/updated schema components
- Console report of changes made

## AI Discovery Checklist

After optimization, verify:
- [ ] Direct answer in first 1-2 sentences
- [ ] Clear heading hierarchy (H1 > H2 > H3)
- [ ] Key takeaways section
- [ ] FAQ section with common questions
- [ ] Publish date visible
- [ ] Update date visible
- [ ] Author info with credentials
- [ ] Sources cited and linked
- [ ] Semantic HTML structure
- [ ] Schema.org structured data

## References

- AI Discovery Skill: `.cursor/rules/skills/reference/ai-discovery.mdc`
- SEO Standards: `.cursor/rules/core/seo-standards.mdc`
- Web SEO Agent: `.cursor/rules/agents/web-seo.mdc`

## Notes

- AI systems prefer content that directly answers questions
- Freshness matters - keep content updated
- Citations add credibility for AI extraction
- Test by asking AI assistants questions about your content
