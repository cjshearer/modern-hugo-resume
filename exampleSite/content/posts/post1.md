+++
title = "Markdown Guide"
date = 2025-10-16
+++

This example markdown was adapted from [here](https://gist.github.com/cuonggt/9b7d08a597b167299f0d), which was probably sourced from [here](https://cjshearer.dev/changelog/markdown/), and now edited by me to fit my preferences and Hugo's feature set.

<!--more-->

## Basic Markdown Formatting

### Headings

```md
# This is an <h1> tag
## This is an <h2> tag
### This is an <h3> tag
#### This is an <h4> tag
##### This is an <h5> tag
###### This is an <h6> tag
```

### Emphasis

```md
*This text will be italic*
_This will also be italic_

**This text will be bold**
__This will also be bold__

_You **can** combine them_
```

Result:

*This text will be italic*

_This will also be italic_

**This text will be bold**

__This will also be bold__

_You **can** combine them_

### Lists

**Unordered:**

```md
* Milk
* Bread
    * Wholegrain
* Butter
```

Result:

* Milk
* Bread
    * Wholegrain
* Butter

**Ordered:**

```md
1. Tidy the kitchen
2. Prepare ingredients
3. Cook delicious things
```

Result:

1. Tidy the kitchen
2. Prepare ingredients
3. Cook delicious things

### Images

```md
![O RLY](https://raw.githubusercontent.com/denitdao/o-rly-collection/refs/heads/main/public/book_covers/resume-driven-dev.jpg)
{style="max-width: 200px;"}
```

Result:

![O RLY](https://raw.githubusercontent.com/denitdao/o-rly-collection/refs/heads/main/public/book_covers/resume-driven-dev.jpg)
{style="max-width: 200px;"}

### Links

```md
[link](http://example.com)
```

Result:

[link](http://example.com)

### Blockquotes

```md
As Kanye West said:

> We're living the future so
> the present is our past.
```

Result:

As Kanye West said:
> We're living the future so
> the present is our past.

### Horizontal Rules

```md
---
```

Result:

---

### Code Snippets

    ```css
    .my-link {
        text-decoration: underline;
    }
    ```

Result:

```css
.my-link {
    text-decoration: underline;
}
```

### Escaping

```md
\*literally\*
```

Result:

\*literally\*

### Embedding HTML

```html
<button 
  style="font-size:2em; padding:1em 2em;"
>
  Big Button
</button>
```

Result:

<button 
  style="font-size:2em; padding:1em 2em;"
>
  Big Button
</button>

## Advanced Markdown

Note: Some syntax which is not standard to native Markdown. They're extensions of the language.
### Strike-throughs

```md
~~deleted words~~
```

Result:

~~deleted words~~

### Automatic Links

```md
https://cjshearer.dev
```

Result:

https://cjshearer.dev

### Markdown Footnotes

```md
The quick brown fox[^1] jumped over the lazy dog[^2].

[^1]: Foxes are red
[^2]: Dogs are usually not red
```

Result:

The quick brown fox[^1] jumped over the lazy dog[^2].

[^1]: Foxes are red
[^2]: Dogs are usually not red

## GitHub Flavored Markdown

### Syntax Highlighting

    ```js
    function fancyAlert(arg) {
      if(arg) {
        $.facebox({div:'#foo'})
      }
    }
    ```

Result:

```js
function fancyAlert(arg) {
  if(arg) {
    $.facebox({div:'#foo'})
  }
}
```

### Task Lists

```md
- [x] @mentions, #refs, [links](), **formatting**, and <del>tags</del> supported
- [x] list syntax required (any unordered or ordered list supported)
- [x] this is a complete item
- [ ] this is an incomplete item
```

Result:

- [x] @mentions, #refs, [links](), **formatting**, and <del>tags</del> supported
- [x] list syntax required (any unordered or ordered list supported)
- [x] this is a complete item
- [ ] this is an incomplete item

### Tables

You can create tables by assembling a list of words and dividing them with hyphens `-` (for the first row), and then separating each column with a pipe `|`:

First Header | Second Header
------------ | -------------
Content from cell 1 | Content from cell 2
Content in the first column | Content in the second column

### Diagrams

See [here](https://github.com/blampe/goat) for more info.

    ```goat
         .               .                .               .--- 1          .-- 1     / 1
        / \              |                |           .---+            .-+         +
       /   \         .---+---.         .--+--.        |   '--- 2      |   '-- 2   / \ 2
      +     +        |       |        |       |    ---+            ---+          +
     / \   / \     .-+-.   .-+-.     .+.     .+.      |   .--- 3      |   .-- 3   \ / 3
    /   \ /   \    |   |   |   |    |   |   |   |     '---+            '-+         +
    1   2 3   4    1   2   3   4    1   2   3   4         '--- 4          '-- 4     \ 4
    ```

```goat
     .               .                .               .--- 1          .-- 1     / 1
    / \              |                |           .---+            .-+         +
   /   \         .---+---.         .--+--.        |   '--- 2      |   '-- 2   / \ 2
  +     +        |       |        |       |    ---+            ---+          +
 / \   / \     .-+-.   .-+-.     .+.     .+.      |   .--- 3      |   .-- 3   \ / 3
/   \ /   \    |   |   |   |    |   |   |   |     '---+            '-+         +
1   2 3   4    1   2   3   4    1   2   3   4         '--- 4          '-- 4     \ 4
```

## References

* http://blog.ghost.org/markdown/
* https://guides.github.com/features/mastering-markdown/