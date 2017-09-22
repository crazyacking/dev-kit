#!/usr/bin/env bash

# author:crazyacking
#
# Steps:
#
#  1. Download corresponding html file for some README.md:
#       curl -s $1
#
#  2. Discard rows where no substring 'user-content-' (github's markup):
#       awk '/user-content-/ { ...
#
#  3.1 Get last number in each row like ' ... </span></a>sitemap.js</h1'.
#      It's a level of the current header:
#       substr($0, length($0), 1)
#
#  3.2 Get level from 3.1 and insert corresponding number of spaces before '*':
#       sprintf("%*s", substr($0, length($0), 1)*3, " ")
#
#  4. Find head's text and insert it inside "* [ ... ]":
#       substr($0, match($0, /a>.*<\/h/)+2, RLENGTH-5)
#
#  5. Find anchor and insert it inside "(...)":
#       substr($0, match($0, "href=\"[^\"]+?\" ")+6, RLENGTH-8)
#

gh_toc_version="0.4.8"

gh_user_agent="gh-md-toc v$gh_toc_version"

#
# Download rendered into html README.md by its url.
#
#
gh_toc_load() {
    local gh_url=$1

    if type curl &>/dev/null; then
        curl --user-agent "$gh_user_agent" -s "$gh_url"
    elif type wget &>/dev/null; then
        wget --user-agent="$gh_user_agent" -qO- "$gh_url"
    else
        echo "Please, install 'curl' or 'wget' and try again."
        exit 1
    fi
}

#
# Converts local md file into html by GitHub
#
# ➥ curl -X POST --data '{"text": "Hello world github/linguist#1 **cool**, and #1!"}' https://api.github.com/markdown
# <p>Hello world github/linguist#1 <strong>cool</strong>, and #1!</p>'"
gh_toc_md2html() {
    local gh_file_md=$1
    curl -s --user-agent "$gh_user_agent" \
        --data-binary @"$gh_file_md" -H "Content-Type:text/plain" \
        https://api.github.com/markdown/raw
}
