# aw-watcher-web

[![Chrome Web Store](https://img.shields.io/chrome-web-store/v/nglaklhklhcoonedhgnpgddginnjdadi.svg)][chrome]
[![Mozilla Add-on](https://img.shields.io/amo/v/aw-watcher-web.svg)][firefox]

A cross-browser WebExtension that serves as a web browser watcher for [ActivityWatch][activitywatch].


## Usage

[activitywatch]: https://github.com/ActivityWatch/activitywatch
[chrome]: https://chrome.google.com/webstore/detail/nglaklhklhcoonedhgnpgddginnjdadi/
[build-source-cmt]: https://github.com/ActivityWatch/aw-watcher-web/issues/94#issuecomment-1315773537
[last-xpi]: https://github.com/ActivityWatch/aw-watcher-web/releases/download/v0.4.3/aw-watcher-web-v0.4.3.xpi
[818]: https://github.com/orgs/ActivityWatch/discussions/818#discussioncomment-4017528


## Building

First, clone the repo with:

```sh
git pull --recurse-submodules https://github.com/kalpa-com/kalpa-watcher-web.git
# or, normal `git pull` and then:
git submodule update --init
```

Then build with:

```
make build
```

The resulting `aw-watcher-web.zip` can then be loaded into your browser in development mode. (for Firefox, loading unsigned extensions is only possible in Firefox Nightly and Developer Edition).

For further build instructions, refer to the `Makefile`.
