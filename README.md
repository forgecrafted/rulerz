# rulerz

##### By the guys at [Forge Software](http://www.forgecrafted.com/)

A simple Atom [package](https://atom.io/packages/rulerz) to mark each of your cursors with a vertical ruler. Inspired by the Sublime Text plugin [CursorRuler](https://github.com/icylace/CursorRuler).

[![screencast gif](https://cloud.githubusercontent.com/assets/281467/5994471/d3648c72-aa42-11e4-8916-bdd4705ed55c.gif)](http://www.forgecrafted.com)

## Styles

You can change the appearance of the rulers by adding a rule to [your stylesheet](https://atom.io/docs/latest/using-atom-basic-customization#style-tweaks). For example:

```less
atom-text-editor.is-focused::shadow {
  ruler-view.rulerz {
    border-left: 1px solid black;
  }
}
```

The default color is taken from the variable `@text-color-subtle`. By continuing to base your ruler color on this value (modified with LESS functions), your ruler will match whatever syntax theme you have active:

```less
atom-text-editor.is-focused::shadow {
  ruler-view.rulerz {
    border-left: 1px dotted fade(mix(@text-color-subtle, limegreen), 5%);
  }
}
```

## Contributing

Please [report any issues on Github](https://github.com/forgecrafted/rulerz/issues).

Patches welcome and encouraged.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

[![forge software](http://www.forgecrafted.com/logo.png)](http://www.forgecrafted.com)

rulerz is maintained and funded by [Forge Software (forgecrafted.com)](http://www.forgecrafted.com).

If you like our code, please give us a hollar if your company needs outside pro's who can write good code AND run servers at the same time!

## License

MIT, of course! Rulerz is Copyright Forge Software, LLC. It is free software, and may be redistributed under the terms specified in the [LICENSE](LICENSE.md) file.
