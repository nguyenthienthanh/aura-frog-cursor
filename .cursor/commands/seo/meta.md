# /seo:meta - Generate Meta Tags

## Description

Generate comprehensive meta tags for a page including Open Graph, Twitter Cards, and SEO metadata.

## Usage

```
/seo:meta [path] [options]
```

**Arguments:**
- `path` (optional): Target page file. Defaults to current file.

**Options:**
- `--og` - Open Graph tags only
- `--twitter` - Twitter Card tags only
- `--full` - All meta tags (default)

## Execution Steps

1. **Analyze Page**
   - Detect page type (static, dynamic, layout)
   - Identify content for meta generation
   - Check existing metadata

2. **Generate Static Metadata**
   ```tsx
   // For static pages
   import { Metadata } from 'next';

   export const metadata: Metadata = {
     title: 'Page Title | Site Name',
     description: 'Compelling description under 160 characters',
     keywords: ['keyword1', 'keyword2'],
     authors: [{ name: 'Author Name' }],

     openGraph: {
       title: 'Page Title',
       description: 'OG description for social sharing',
       url: 'https://example.com/page',
       siteName: 'Site Name',
       images: [
         {
           url: 'https://example.com/og-image.jpg',
           width: 1200,
           height: 630,
           alt: 'Descriptive alt text',
         },
       ],
       locale: 'en_US',
       type: 'website',
     },

     twitter: {
       card: 'summary_large_image',
       title: 'Page Title',
       description: 'Twitter card description',
       images: ['https://example.com/twitter-image.jpg'],
       creator: '@handle',
     },

     alternates: {
       canonical: 'https://example.com/page',
     },

     robots: {
       index: true,
       follow: true,
     },
   };
   ```

3. **Generate Dynamic Metadata**
   ```tsx
   // For dynamic pages [slug]
   import { Metadata, ResolvingMetadata } from 'next';

   type Props = {
     params: Promise<{ slug: string }>;
   };

   export async function generateMetadata(
     { params }: Props,
     parent: ResolvingMetadata
   ): Promise<Metadata> {
     const { slug } = await params;
     const data = await fetchData(slug);

     return {
       title: data.title,
       description: data.excerpt,
       openGraph: {
         title: data.title,
         description: data.excerpt,
         images: [data.image],
       },
       alternates: {
         canonical: `https://example.com/${slug}`,
       },
     };
   }
   ```

## Meta Tag Guidelines

### Title Tag
- Length: 50-60 characters
- Format: `Primary Keyword - Secondary Info | Brand`
- Unique per page

### Meta Description
- Length: 150-160 characters
- Include call-to-action
- Unique per page

### Open Graph Image
- Size: 1200 x 630 pixels
- Format: JPG or PNG
- Include text overlay for context

### Twitter Card
- Use `summary_large_image` for articles
- Use `summary` for profiles/products

## Examples

```bash
# Generate meta for current page
/seo:meta

# Generate for specific page
/seo:meta app/about/page.tsx

# Open Graph only
/seo:meta --og

# Twitter Card only
/seo:meta --twitter
```

## Output

- Updated page file with metadata export
- Console output with generated tags

## Validation

After generation:
1. Preview with social media debuggers:
   - Facebook: https://developers.facebook.com/tools/debug/
   - Twitter: https://cards-dev.twitter.com/validator
   - LinkedIn: https://www.linkedin.com/post-inspector/

2. Check with browser extensions:
   - SEO META in 1 CLICK
   - META SEO Inspector

## References

- Next.js Metadata: https://nextjs.org/docs/app/api-reference/functions/generate-metadata
- Open Graph Protocol: https://ogp.me/
- Twitter Cards: https://developer.twitter.com/en/docs/twitter-for-websites/cards

## Notes

- Always test social sharing before publishing
- Keep meta descriptions actionable
- Use unique images for important pages
