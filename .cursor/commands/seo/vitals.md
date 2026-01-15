# /seo:vitals - Core Web Vitals Analysis

## Description

Analyze and optimize Core Web Vitals (LCP, INP, CLS) for better search rankings and user experience.

## Usage

```
/seo:vitals [options]
```

**Options:**
- `--analyze` - Analyze current implementation (default)
- `--fix` - Apply automatic optimizations
- `--report` - Generate detailed report

## Execution Steps

1. **Analyze Current State**
   - Scan for image components
   - Check font loading configuration
   - Review script loading strategies
   - Identify layout shift sources

2. **LCP (Largest Contentful Paint) Check**
   ```
   Target: ≤ 2.5 seconds

   Common Issues:
   - Large unoptimized images
   - Slow server response
   - Render-blocking resources
   - Client-side rendering delays
   ```

   **Fixes:**
   - Use `next/image` with priority for hero images
   - Implement blur placeholders
   - Optimize server response time
   - Preload critical resources

3. **INP (Interaction to Next Paint) Check**
   ```
   Target: ≤ 200 milliseconds

   Common Issues:
   - Heavy JavaScript execution
   - Long tasks blocking main thread
   - Unoptimized event handlers
   ```

   **Fixes:**
   - Break up long tasks
   - Use Web Workers for heavy computation
   - Debounce/throttle event handlers
   - Lazy load non-critical JavaScript

4. **CLS (Cumulative Layout Shift) Check**
   ```
   Target: ≤ 0.1

   Common Issues:
   - Images without dimensions
   - Dynamic content insertion
   - Font loading shifts
   - Ad/embed loading
   ```

   **Fixes:**
   - Always specify image width/height
   - Use `aspect-ratio` CSS
   - Use `font-display: swap` with fallback
   - Reserve space for dynamic content

## Optimization Patterns

### Image Optimization
```tsx
// Before
<img src="/hero.jpg" />

// After - Optimized
import Image from 'next/image';

<Image
  src="/hero.jpg"
  alt="Hero image"
  width={1200}
  height={630}
  priority
  placeholder="blur"
  blurDataURL="data:image/..."
/>
```

### Font Optimization
```tsx
// app/layout.tsx
import { Inter } from 'next/font/google';

const inter = Inter({
  subsets: ['latin'],
  display: 'swap',
  preload: true,
});
```

### Script Optimization
```tsx
import Script from 'next/script';

// Analytics - load after interactive
<Script
  src="https://analytics.js"
  strategy="afterInteractive"
/>

// Non-critical - load when idle
<Script
  src="https://widget.js"
  strategy="lazyOnload"
/>
```

## Examples

```bash
# Analyze current vitals
/seo:vitals --analyze

# Apply automatic fixes
/seo:vitals --fix

# Generate detailed report
/seo:vitals --report
```

## Output

**Analysis Mode:**
- Console output with findings
- Recommendations for each metric

**Fix Mode:**
- Automatic code modifications
- Summary of changes made

**Report Mode:**
- `.cursor/logs/seo/vitals-{timestamp}.md`
- Detailed breakdown with code examples

## Testing Tools

After optimization, test with:
1. **PageSpeed Insights**: https://pagespeed.web.dev
2. **Lighthouse**: Chrome DevTools
3. **Web Vitals Extension**: Chrome extension
4. **Search Console**: Core Web Vitals report

## References

- Core Web Vitals: https://web.dev/vitals/
- Next.js Performance: https://nextjs.org/docs/app/building-your-application/optimizing
- Web Vitals Library: https://github.com/GoogleChrome/web-vitals

## Notes

- Test on real devices, not just localhost
- Consider mobile performance (often worse than desktop)
- Monitor vitals over time in Search Console
