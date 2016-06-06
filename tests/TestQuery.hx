package;
import tink.url.Query;

class TestQuery extends Base {
  function testParse() {
    var q:Map<String, String> = ('foo=bar&bar=1=1':Query);
    assertEquals('bar', q['foo']);
    assertEquals('1=1', q['bar']);
  }
  
  function testBuilder() {
      var q = new QueryStringBuilder();
      q.add('key1', 'value1').add('key2', 'value2');
      assertEquals('key1=value1&key2=value2', q.toString());
  }
}