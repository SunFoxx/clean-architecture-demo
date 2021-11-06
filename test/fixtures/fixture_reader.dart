import 'dart:io';

String readFixture(Fixture fixture) =>
    File('./test/fixtures/${fixture.getPath()}').readAsStringSync();

enum Fixture {
  manufacturersPage1,
  makes_for_id987,
}

extension FixturePath on Fixture {
  String getPath() {
    switch (this) {
      case Fixture.manufacturersPage1:
        return 'manufacturers/manufacturers_page1.json';
      case Fixture.makes_for_id987:
        return 'makes/makes_987.json';
    }
  }
}
