# Miller-Jensen lab website

This is the code that generates the website for our lab at
[https://www.miller-jensen.org](https://www.miller-jensen.org).

## About this website

The website is
generated using [Hugo](https://gohugo.io/), which is a [static site
generator](https://www.netlify.com/blog/2020/04/14/what-is-a-static-site-generator-and-3-ways-to-find-the-best-one/).
That means it takes some files and then turns those files into HTML, CSS,
images and everything else for your website. In our case, the source files are
kept in this repository and the build files, the output, is kept in
[miller-jensen-lab/miller-jensen-lab.github.io](miller-jensen-lab/miller-jensen-lab.github.io).

There are three kinds of content on this website: people, publications, and
news.  You can see a directory for each of these in the
[content](https://github.com/miller-jensen-lab/miller-jensen-website/tree/main/content)
directory. Each of those directories has files inside that are in
[Markdown](https://en.wikipedia.org/wiki/Markdown) format. (Markdown is less of
a pain than HTML to write.) They also have so-called
"[front-matter](https://gohugo.io/content-management/front-matter/)": a little
bit of data about the particular item. E.g. take a look at the
`[content/news/elise-awarded-peb-training-grant.md](https://raw.githubusercontent.com/miller-jensen-lab/miller-jensen-website/main/content/news/elise-awarded-peb-training-grant.md)`
file. That looks something like as follows:

```
---
title: Elise is awarded a PEB Training grant
date: 2017-06-08T15:10:06-05:00
draft: false
---

Elise Bullock was awarded a slot on Yale's NIH T32 Training grant supporting
the Integrated Graduate Program in Physical and Engineering Biology.
```

All the stuff between the two `---` blocks is the front-matter in
[YAML](https://en.wikipedia.org/wiki/YAML) format. The stuff below is the
content and the content is in Markdown format, which mostly just looks like
regular text 😉.

The people and publication files looks similar. E.g. take a look at 
[content/publications/2018-myofibroblast-proliferation.md](https://raw.githubusercontent.com/miller-jensen-lab/miller-jensen-website/main/content/publications/2018-myofibroblast-proliferation.md). That looks like this

```
---
authors: |
  Shook BA, Wasko RR, Rivera-Gonzalez GC, Salazar-Gatzimas E,
  López-Giráldez F, Dash BC, Muñoz-Rojas AR, Aultman KD, Zwick
  RK, Lei V, Arbiser JL, Miller-Jensen K, Clark DA, Hsia HC, Horsley V.
doi: 10.1126/science.aar2971
journal: Science
pmid: 30467144
title: |
  Myofibroblast proliferation and heterogeneity are supported by macrophages 
  during skin repair
volume: 362
number: 6417
year: 2018
---

No need for content here
```

In the case of publications, it's pretty much all data and no content 😜.
Anyway, you get the trend: every piece of content on the website is either
news, people, or publications. Each piece is in its own file. Those files have
some data and then some content. The data are in YAML format and the content
is in Markdown format. Easy peasy.

## Making changes to the website

In order to make changes to the website you can do one of two things. You can
either edit this content directly on GitHub (weak, but understandable for quick
changes!) or clone the repo to your computer where you can edit it properly. To
clone the repo, you'll need to know how to use [git](https://git-scm.com/), the
version control system upon which GitHub is based. That's beyond the scope of
these instructions 😜. But, I wrote a brief guide below.

### Making simple changes on GitHub

How can you add new content? Well, it's easy! If you want to create a new news
item, just copy an old news item to a new file and change it's content. You'll
want to keep the same fields, like `title`, `date` and such. You'd follow a
similar process for people and for publications: just copy an old one.

OK, specifically, how do you do that? If  you want to create a new news item,
go to
[https://github.com/miller-jensen-lab/miller-jensen-website/tree/main/content/news](https://github.com/miller-jensen-lab/miller-jensen-website/tree/main/content/news)
and then click the "add file" button. Give your file a name that looks like the
other files, something like "kathryn-wins-nobel-prize.md". (The ".md" part is
important.) Then, put some content in there that you copied from the other
files. (In order to view the other files, you'll want to click on "view raw",
so that GitHub doesn't show you the rendered Markdown.) Then you'd put in your
content like

```
---
title: Nobel?! Congrats, Kathryn!
date: 2018-03-23T15:14:16-05:00
draft: false
---

We didn't expect this! 🥳🍕
```

Then "commit" your file. After you commit, if everything was well-formatted,
the website should be automatically updated to reflect your changes. (See
"deployment" info, below.)

### Making and previewing changes on your computer

First, clone the repo in your terminal/shell

```
git clone git@github.com:miller-jensen-lab/miller-jensen-website.git
```

Or, if you haven't set up your ssh keys (lame 😦)

```
git clone https://github.com/miller-jensen-lab/miller-jensen-website.git
```

Then, you'll need to [install Hugo](https://gohugo.io/getting-started/quick-start/)
on your computer. You can do that on any OS. Once you have Hugo installed, `cd`
to the repo directory

```
cd miller-jensen-website
```

and run

```
hugo server -D --disableFastRender
```

Then, you can preview the website at [http://localhost:1313](http://localhost:1313).
Also, as you make changes, those changes will be automatically reflected in your
browser. Nice!

When you're done with your changes run something like

```
git commit -am "Update the website"
git push origin main
```

to push your changes up to GitHub.

### Static content

You'll notice that some content has images. E.g. people have pictures
and publications have thumbnails. You can find those in the `static/img/people`
directory and the `static/img/publications` directory. When you add a person,
you'll want to create a picture for them and add it to that `people` directory.
Look at the other pictures and make it roughly the same size and aspect ratio.
(Obviously, you'll need to `git add` and `git commit` this file unless you're
uploading straight through GitHub's website.)

You can do the same for publications, but I also wrote a script that you
can run to create the thumbnail automatically using a PDF downloaded from
[Sci-Hub](https://sci-hub.se/). You can run this like

```
./scripts/mac-get-paper-thumbnail.sh 30704857
```

on a *Mac* and it will create a thumbnail for the publication with Pubmed ID 30704857.
Then you can `git add`, `git commit`, etc.

## Getting help

When in doubt, write to [Kyle](https://som.yale.edu/faculty/kyle-jensen). It's easy 
for me to help 👍👍👍.

## Deployment

The website is deployed automatically using GitHub Actions using a method
similar to that described in [this person's blog
post](https://medium.com/@asishrs/automate-your-github-pages-deployment-using-hugo-and-actions-518b959a51f9).
When you push to the `main` branch of this repo on GitHub, the action will run, it will
build the website with Hugo, and then push the resulting files to the
[miller-jensen-lab.github.io](miller-jensen-lab/miller-jensen-lab.github.io)
repo. From there, they're served by GitHub using [GitHub Pages](https://pages.github.com/)
(see [GitHub Pages Documentation](https://docs.github.com/en/github/working-with-github-pages).)

## Helpful links about Hugo 

* [Creating a theme from scratch](https://retrolog.io/blog/creating-a-hugo-theme-from-scratch/)
* [GitHub Pages Documentation](https://docs.github.com/en/github/working-with-github-pages)
* Feel free to add links here!

## Random notes

* Most of the pngs were compressed with zopflipng
* Most of the jpegs were compressed with mozjpeg
