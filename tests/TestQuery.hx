package;
import tink.url.Query;

@:asserts
class TestQuery extends Base {
  public function testParse() {
    var q = ('foo=bar&bar=1=1':Query).toMap();
    asserts.assert(q['foo'] == 'bar');
    asserts.assert(q['bar'] == '1=1');
    return asserts.done();
  }
  
  public function testBuilder() {
      var q = new QueryStringBuilder();
      q.add('key1', 'value1').add('key2', 'value2');
      asserts.assert(q.toString() == 'key1=value1&key2=value2');
      return asserts.done();
  }
  
  public function testWith() {
    var q:Query = 'a=1&b=2';
    q = q.with(['a' => '3']);
    var map = q.toMap();
    asserts.assert(map['a'] == '3');
    asserts.assert(map['b'] == '2');
    
    q = q.with(['c' => '4']);
    var map = q.toMap();
    asserts.assert(map['a'] == '3');
    asserts.assert(map['b'] == '2');
    asserts.assert(map['c'] == '4');
    
    q = q.with(['a' => '1', 'c' => '1']);
    var map = q.toMap();
    asserts.assert(map['a'] == '1');
    asserts.assert(map['b'] == '2');
    asserts.assert(map['c'] == '1');
    return asserts.done();
  }
}