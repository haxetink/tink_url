package;
import tink.url.Query;

class TestQuery extends Base {
  function testParse() {
    var q:Map<String, String> = ('foo=bar&bar=1=1':Query);
    assertEquals('bar', q['foo']);
    assertEquals('1=1', q['bar']);
  }
}