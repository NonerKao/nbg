---
title: "Recording Terminal"
date: 2021-01-17T15:13:23+08:00
draft: false
---

## Recording

When being executed, [ttyrec](https://github.com/mjording/ttyrec) launches a new tty, not obvious though, and then the user performs any commands they wants to record. The user can then press `Ctrl+D` to terminate the session, and obtain the record (named `ttyrecord` by default).

## Appendix: Disable Prompt

I have a multi-line bash prompt (environment variable `PS1`), which looks redundant in a tty record. Since the record session by nature runs in a different tty, we can get the **Shell Level** from the environment variable `SHLVL`.  The value is always 1 if one uses shell which is a direct child of the terminal simulator they uses, but launching a new shell in the shell increases `SHLVL` by 1.  So I end up with the following logic in my `.bashrc`:
```
if [ $SHLVL -gt 1 ]; then
        clear
        export PS1=''
else
        export PS1=...
```

## Rendering

It is straightforward to use [ttyrec2gif](https://github.com/sugyan/ttyrec2gif).

## Appendix: When `base_url` is not Empty

My current theme, forked from hugo-theme-console, doesn't deal with `base_url` well. At first I try

```
![](gif/about.gif)
```
and hugo renders it as
```
<p><img src="http://localhost:1313/gif/about.gif">...
```

This is OK if the `base_url` is set to root of the domain, but I need to preserve the multi-host setting and need a `/blog` as my prefix. I end up with a dedicated shortcode in `layouts/shortcodes/ttyrec.html`:
```
<img src={{ .Site.BaseURL }}{{ .Get "url" }} alt={{ .Get "alt" }}>
```
and use the following in the markdown 
```
{{\< ttyrec url="gif/about.gif" alt="???">}}
```

