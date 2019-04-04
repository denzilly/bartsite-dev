---
layout:       project
date:         05 Aug 2017
title:        Hyde
caption:      A new take on salad.
description:  >
  One-dish meal salad containing chicken, lentils, beans, sweet potato, and more.
image:        /assets/img/projects/hyde.jpg
screenshot:
  src:        /assets/img/projects/hyde.jpg
  srcset:   
    1920w:    /assets/img/projects/hyde.jpg
    960w:     /assets/img/projects/hyde@0,5x.jpg
    480w:     /assets/img/projects/hyde@0,25x.jpg

featured:     true
accent_color: '#268bd2'
accent_image:
  background: '#202020'
  overlay:    false
---

![Typeface](../assets/img/hyde-1.jpg){:.lead}

## Usage
To use this flavor, make the following changes to following files:

### `_config.yml`

~~~yml
google_fonts: Abril+Fatface:400|PT+Sans:400,400i,700,700i
font:         "'PT Sans', Helvetica, Arial, sans-serif"
font_heading: "'PT Sans', Helvetica, Arial, sans-serif"
accent_color: '#268bd2'
accent_image:
  background: '#202020'
  overlay:    false
~~~

### `_sass/my-inline.scss`
