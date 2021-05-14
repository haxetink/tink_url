package ;

import tink.Url;

@:asserts
class TestJson extends Base {
  public function test() {
    var url:Url = 'https://www.google.com';
    asserts.assert(tink.Json.stringify(url) == haxe.Json.stringify('https://www.google.com'));
    return asserts.done();
  }
}