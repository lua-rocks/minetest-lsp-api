# Minetest Game LSP API (WIP)

The [LSP API] not only makes development much more pleasant but also helps to
detect serious bugs, so I hope that when everything is ready, it will become the
standard for Minetest devs and modders.

## Usage

Move API definitions from this repository to your minetest game project and
enjoy smart tooltips in a text editor [that supports the LSP]. I personally use
[VSCodium].

## Goals

- [ ] Transfer here all the docs from [Minetest] in [LSP format]
- [ ] Fork [Minetest Game] and solve all problems found using this API
- [ ] Fork [MineClone2] and do the same
- [ ] Ask Minetest and MineClone2 devs about PR

## Contribution

PR's are highly appreciated, but before making edits, be sure to read the rules
at [NOTES.md].

[lsp api]: https://github.com/sumneko/lua-language-server
[lsp format]: https://github.com/sumneko/lua-language-server/wiki/Annotations
[minetest]: https://github.com/minetest/minetest/tree/master/doc
[minetest game]: https://github.com/minetest/minetest_game
[mineclone2]: https://github.com/MineClone2/MineClone2
[that supports the lsp]:
  https://microsoft.github.io/language-server-protocol/implementors/tools
[vscodium]: https://github.com/VSCodium/vscodium
[notes.md]: NOTES.md
