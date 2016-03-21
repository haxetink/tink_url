package;
import tink.url.Query;

class TestQuery extends Base {
  function testParse() {
    var q:Map<String, String> = ('foo=bar&bar=1=1':Query);
    assertEquals('foo', q['bar']);
    assertEquals('bar', q['1=1']);
  }
}