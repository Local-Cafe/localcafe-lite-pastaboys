#   /priv/home.md
#
#   This file repersents the site's configration and the home page's content
#
#   site_name - This will show in the title tag in all pages
#
#   title - The prefix of the title on the home page
#
#   description - This will show in the header's description meta tag, used for SEO
#
#   image - The preivew image seen in the header's meta tags used by social networks and SEO
#
#   logo - This is the companies branding seen in the top navigation bar.
#   Warning. It's advised to use a 100x100 png
#
#   hero - A list of strings that are using on the landing section of the home page.
#   Each element in the list is a line.
#
#   hero_image - a list of images relative to the domain for use in the slide show on the home page
#
#   domain - the site's main url.
#
#   social_links - A list of social media profiles to display as icons in the footer.
#   Available icons: bluesky, doordash, facebook, github, instagram, tiktok, ubereats, x, yelp
#   Format: [platform: "url", ...]


%{
  site_name: "Pasta Boy's Lil Cafe",
  title: "Home",
  description: "Home made pasta like your ma' used to make it",
  image: "/images/pasta.jpg",
  logo: "/images/logo.png",
  hero: ["Fresh, delicious pasta made with love.", "Discover our selection of carefully crafted dishes."],
  hero_image: ["/images/hero_1.jpg", "/images/hero_2.jpg", "/images/hero_3.jpg"],
  domain: "https://lite.localcafe.org/",
  social_links: [
    bluesky: "https://bsky.app/profile/localcafe.org",
    github: "https://github.com/Local-Cafe"
  ]
}
---

## Disclaimer

This is not a real restaurant,

## About US

Pasta boy's started in ma's kitchen after a plate of ma's spaggite in old town meatball. 20 years later they are still slerping noddles.

## Orders to GO

We do orders to go, call us and place an order for pick up

## This was an example of using localcafe lite

You can use localcafe lite for free and also host static restaurant menu sites for free using github pages.

Learn more about this project at [https://github.com/Local-Cafe/localcafe-lite](https://github.com/Local-Cafe/localcafe-lite)

### Free / No Monthly Fees
- This project is open source and free
- This project can host for free on GitHub Pages, Netlify, or Cloudflare Pages

### Static Website
- Fast page loads - everything pre-generated
- No database or server required

### Online Menu
- Display your full menu with photos, descriptions, and prices
- Single prices or multiple options (small/large, hot/iced, etc.)
- Customers filter by tags (vegetarian, gluten-free, breakfast, lunch)
- Update by editing simple text files

### Location & Maps
- Show one location or multiple locations
- Each location has its own hours, phone, email and optional image. 

### Photo Slideshow
- Homepage displays rotating photos with smooth transitions
- Supports single image or multiple images
- Photos fade between each other automatically

### Mobile Responsive
- Works on all phones and tablets
- Menu and navigation adapt to screen size
- No pinching or zooming required

### Social Sharing
- Links shared on Facebook, Twitter, Instagram show rich previews
- Displays your photo and description automatically


** Images in example provided by https://pixabay.com/ **
