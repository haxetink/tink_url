import tink.Url;

@:asserts
class TestAuth extends Base {
  public function testAuth() {
    var raw = [
      'https://user:pass@/foo',
      'https://user:pass@host/foo',
      'https://host/foo',
    ];

    var auth = ['user:pass@', 'user:pass@', ''];
    for (r in raw) {
      var u:Url = r;
      asserts.assert(u == r);
      asserts.assert(u.auth == auth[raw.indexOf(r)]);
    }
    return asserts.done();
  }

}