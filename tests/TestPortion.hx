package ;

import tink.Url;
import tink.url.Portion;
using StringTools;

class TestPortion extends Base {
  
  function testNumbers() {
    
    var portion = new Portion('%205%30.7e%2B85');
    assertEquals(50.7e85, Std.parseFloat(portion));
  }
  
}