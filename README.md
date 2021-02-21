
## How to add a new person

```
hugo new people/ilana-kelsey.md
```

Then, you can edit the file at `content/people/ilana-kelsey.md`.

## Adding a new publication

Run 

```
hugo new publications/name-of-the-publication.md
```

Then, edit the file created in the `content/publications` directory. You'll want to
create a "thumbnail" image too (but you don't have to---a generic paper image will
appear if you don't make a custom thumbnail). To make the thumbnail, download a 
PDF of the paper and then, if you're on a mac, you can do something like

```
sips -s format png eaar2971.full.pdf --out 30467144.png --resampleWidth 97
```

In that case `eaar2971.full.pdf` was the name of the PDF that I downloaded
and `30467144` is the pmid of the manuscript. Then, move that file into
the `static/img` directory.

## Previewing your changes

Run

```
hugo server -D --disableFastRender
```

To preview your changes.

## Deploying your changes

To deploy your changes, make sure you add all your new content and your changes
to version control. Run `git status` to see what is either changed or
untracked, then `git add` as appropriate. Then, `git commit` and finally, `git
push origin main` after you made your commits. The "CI/CD" pipeline on GitHub
will take care of deploying the site when you push to the main branch.

## Helpful links about Hugo

* [Creating a theme from scratch](https://retrolog.io/blog/creating-a-hugo-theme-from-scratch/)

## Random notes

* Most of the pngs were compressed with zopflipng
* Most of the jpegs were compressed with mozjpeg
