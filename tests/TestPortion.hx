package ;

import tink.Url;
import tink.url.Portion;
using StringTools;

class TestPortion extends Base {
  
  function testNumbers() {
    assertEquals('5', (5 : Portion).raw);
    assertEquals('5.1', (5.1 : Portion).raw);
    
    var portion = new Portion('%205%30+');
    
    assertEquals(50, portion);
    assertEquals(' 50 ', portion);
    assertEquals(50.0, portion);
    
    var portion = new Portion('%205%30.7e%2B85');
    
    assertEquals(50.7e85, portion);
    assertEquals(Std.string(5.7e85), (5.7e85 : Portion).raw.urlDecode());
  }
  
}