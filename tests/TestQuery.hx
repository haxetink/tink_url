package;
import tink.url.Query;

class TestQuery extends Base {
  function testParse() {
    var q = ('foo=bar&bar=1=1':Query).toMap();
    assertEquals('bar', q['foo']);
    assertEquals('1=1', q['bar']);
  }
  
  function testBuilder() {
      var q = new QueryStringBuilder();
      q.add('key1', 'value1').add('key2', 'value2');
      assertEquals('key1=value1&key2=value2', q.toString());
  }
  
  function testUpsert() {
    var q:Query = 'a=1&b=2';
    q = q.upsert('a', '3');
    var map = q.toMap();
    assertEquals('3', map['a']);
    assertEquals('2', map['b']);
    
    q = q.upsert('c', '4');
    var map = q.toMap();
    assertEquals('3', map['a']);
    assertEquals('2', map['b']);
    assertEquals('4', map['c']);
  }
}