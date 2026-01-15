# /seo:sitemap - Generate Dynamic Sitemap

## Description

Generate a dynamic sitemap configuration for the project based on the routing structure.

## Usage

```
/seo:sitemap [options]
```

**Options:**
- `--static` - Include static pages only
- `--dynamic` - Include dynamic routes with data fetching
- `--index` - Generate sitemap index for large sites (>50,000 URLs)

## Execution Steps

1. **Analyze Routes**
   - Scan `app/` or `pages/` directory
   - Identify static pages
   - Identify dynamic routes ([slug], [id])
   - Find data sources for dynamic content

2. **Generate Sitemap File**
   ```tsx
   // app/sitemap.ts
   import { MetadataRoute } from 'next';

   export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
     const baseUrl = process.env.NEXT_PUBLIC_SITE_URL || 'https://example.com';

     // Static pages
     const staticPages = [
       { url: baseUrl, lastModified: new Date(), priority: 1.0 },
       { url: `${baseUrl}/about`, lastModified: new Date(), priority: 0.8 },
       // ... discovered static pages
     ];

     // Dynamic pages (fetched from data source)
     const posts = await getAllPosts();
     const postPages = posts.map(post => ({
       url: `${baseUrl}/blog/${post.slug}`,
       lastModified: new Date(post.updatedAt),
       changeFrequency: 'weekly' as const,
       priority: 0.7,
     }));

     return [...staticPages, ...postPages];
   }
   ```

3. **For Large Sites (>50,000 URLs)**
   ```tsx
   // app/sitemap/[id]/route.ts
   // Generate sitemap index with pagination
   ```

4. **Update robots.txt**
   - Ensure sitemap URL is referenced
   - Verify no sitemap-related conflicts

## Sitemap Configuration

### Priority Guidelines
| Page Type | Priority | Change Frequency |
|-----------|----------|------------------|
| Homepage | 1.0 | daily |
| Main sections | 0.9 | weekly |
| Product pages | 0.8-0.9 | daily |
| Blog posts | 0.6-0.7 | weekly |
| Static pages | 0.5 | monthly |
| Legal pages | 0.3 | yearly |

## Examples

```bash
# Generate basic sitemap
/seo:sitemap

# Static pages only
/seo:sitemap --static

# With dynamic routes
/seo:sitemap --dynamic

# Sitemap index for large sites
/seo:sitemap --index
```

## Output

Creates files:
- `app/sitemap.ts` - Main sitemap generator
- `app/sitemap/[id]/route.ts` - For sitemap index (if --index)

## Post-Generation

1. Build project to verify sitemap generation
2. Visit `/sitemap.xml` to verify output
3. Submit to Google Search Console
4. Submit to Bing Webmaster Tools

## References

- Next.js Sitemap: https://nextjs.org/docs/app/api-reference/file-conventions/metadata/sitemap
- Google Sitemap Guidelines: https://developers.google.com/search/docs/crawling-indexing/sitemaps/overview

## Notes

- Sitemap limit: 50,000 URLs or 50MB per file
- Use sitemap index for larger sites
- Update lastModified when content changes
