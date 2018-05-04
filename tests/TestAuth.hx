import tink.Url;

class TestAuth extends haxe.unit.TestCase {
  function testAuth() {
    var raw = [
      'https://user:pass@/foo',
      'https://user:pass@host/foo',
      'https://host/foo',
    ];

    var auth = ['user:pass@', 'user:pass@', ''];
    for (r in raw) {
      var u:Url = r;
      assertEquals(r, u);
      assertEquals(auth[raw.indexOf(r)], u.auth);
    }
  }

}