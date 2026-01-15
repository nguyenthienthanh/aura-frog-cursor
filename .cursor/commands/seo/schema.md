# /seo:schema - Generate Structured Data

## Description

Generate JSON-LD structured data schemas for pages based on content type.

## Usage

```
/seo:schema <type> [options]
```

**Arguments:**
- `type` (required): Schema type to generate
  - `article` - Blog post/news article
  - `product` - E-commerce product
  - `organization` - Company/organization
  - `faq` - FAQ page
  - `howto` - Tutorial/how-to guide
  - `breadcrumb` - Breadcrumb navigation
  - `website` - Website schema
  - `person` - Author/person profile
  - `event` - Event listing
  - `review` - Review/rating
  - `recipe` - Recipe content
  - `video` - Video content
  - `local-business` - Local business

## Execution Steps

1. **Analyze Context**
   - Identify current page/file
   - Detect existing schemas
   - Determine content structure

2. **Generate Schema Component**
   ```tsx
   // components/schemas/{Type}Schema.tsx
   export function ArticleSchema({ article }: Props) {
     const schema = {
       '@context': 'https://schema.org',
       '@type': 'Article',
       // ... fields based on type
     };

     return (
       <script
         type="application/ld+json"
         dangerouslySetInnerHTML={{ __html: JSON.stringify(schema) }}
       />
     );
   }
   ```

3. **Add to Page**
   - Import schema component
   - Integrate with page layout
   - Pass required props

4. **Validate**
   - Check JSON-LD syntax
   - Verify required fields
   - Test with Google Rich Results Test URL

## Examples

```bash
# Generate article schema for blog posts
/seo:schema article

# Generate product schema for e-commerce
/seo:schema product

# Generate FAQ schema
/seo:schema faq

# Generate organization schema for homepage
/seo:schema organization
```

## Schema Templates

### Article Schema Fields
- headline (required)
- datePublished (required)
- dateModified
- author (required)
- publisher (required)
- image
- description

### Product Schema Fields
- name (required)
- description
- image
- sku
- brand
- offers (price, availability)
- aggregateRating

### FAQ Schema Fields
- mainEntity (array of Question/Answer pairs)

## Output

Creates files:
- `components/schemas/{Type}Schema.tsx` - Reusable schema component
- Updates page file with schema import

## References

- Schema.org: https://schema.org
- Google Structured Data: https://developers.google.com/search/docs/appearance/structured-data
- Rich Results Test: https://search.google.com/test/rich-results

## Notes

- Always validate generated schemas with Google Rich Results Test
- One schema per content type per page
- Keep schema data synchronized with visible page content
