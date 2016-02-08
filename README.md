# Iron Crawler

A generic web crawler.

## Features

From a starting URL, it will crawl all links on that URL and print a list of URLs visited.

- Follow href attributes contained in tags from the same domain
- Ignores href attributes contained in tags from other domains (even subdomains)
- Captures script src and link href tags for script and link tags respectively
- Outputs a list of visited URLs

## Getting Started

It's easy to get started!

### Install

```
gem install iron-crawler
```

### Run

```
iron-crawler <url>
```

The above command will crawl any site for you.


