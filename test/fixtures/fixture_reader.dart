import 'dart:io';

String readFixture(Fixture fixture) =>
    File('./test/fixtures/${fixture.getPath()}').readAsStringSync();

enum Fixture {
  manufacturersPage1,
}

extension FixturePath on Fixture {
  String getPath() {
    switch (this) {
      case Fixture.manufacturersPage1:
        return 'manufacturers/manufacturers_page1.json';
    }
  }
}
