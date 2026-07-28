/// Local seed data. Swap `items` for a fetch against your own /v1 API — the
/// widgets only depend on the Item shape, not on where it came from.
class Item {
  const Item(this.id, this.title, this.tag, this.blurb, this.body);
  final String id, title, tag, blurb, body;
}

const items = <Item>[
  Item('widgets', 'Everything is a widget', 'framework',
      'Layout, gesture, animation and theme are all the same primitive.',
      'A Flutter UI is a tree of immutable widget descriptions that the framework diffs into a mutable element tree, then into a render tree. You describe the frame you want; the framework works out the minimum it has to repaint.'),
  Item('skia', 'Pixels are ours, not the platform\'s', 'impeller',
      'Impeller draws every pixel, so iOS and Android look identical.',
      'Because Flutter ships its own renderer instead of wrapping UIKit, a design lands byte-for-byte on both platforms. The cost is that platform widgets are imitated rather than used — the Cupertino library exists for when you want the iOS look.'),
  Item('hot', 'Sub-second hot reload', 'tooling',
      'State survives the reload, so you iterate inside the screen you are on.',
      'The Dart VM patches classes in place and rebuilds the widget tree without restarting the app. Deep in a five-step form, you change a padding and see it without re-entering the form.'),
  Item('aot', 'AOT-compiled for release', 'dart',
      'Debug builds JIT; release builds compile to native ARM.',
      'flutter build ipa produces machine code, not a bytecode interpreter. That is also why a release build needs the platform toolchain — for iOS, Xcode on macOS. See the README.'),
];

Item? byId(String id) => items.where((i) => i.id == id).firstOrNull;

extension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
