import tink.Url;

class TestAuth extends haxe.unit.TestCase {
  function testAuth() {
    var raw = [
      'https://user:pass@/foo',
      'https://user:pass@host/foo',
      'https://host/foo',
    ];
    for (r in raw) {
      var u:Url = r;
      assertEquals(r, u);
    }
  }

}