# Minetest Game LSP API (WIP)

The [LSP API] not only makes development much more pleasant but also helps to
detect serious bugs, so I hope that when everything is ready, it will become the
standard for Minetest devs and modders.

## Goals

- [ ] Transfer here all the docs from [Minetest] in [LSP format]
- [ ] Fork [Minetest Game] and solve all problems found using this API
- [ ] Fork [MineClone2] and do the same
- [ ] Ask Minetest and MineClone2 devs about PR

## Notes and rules

In my opinion, in its current form, the documentation is very awkward and
chaotic. The same thing is quite often described in three to ten different
places, scattered throughout the file, the length of 10k+ lines.

For this reason, I decided to keep this rule: every time I encounter a new
definition, I search for it throughout the file and move all mentions of it up,
closer to where it was first announced. This way I get rid of the various "see
here, see there" which are completely irrelevant in LSP.

Also, I try to start all sentences in all comments with a capital letter and end
with a period.

[lsp api]: https://github.com/sumneko/lua-language-server
[lsp format]: https://github.com/sumneko/lua-language-server/wiki/Annotations
[minetest]: https://github.com/minetest/minetest/tree/master/doc
[minetest game]: https://github.com/minetest/minetest_game
[mineclone2]: https://github.com/MineClone2/MineClone2
