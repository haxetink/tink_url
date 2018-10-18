package ;

import tink.Url;
import tink.url.Portion;
using StringTools;

@:asserts
class TestPortion extends Base {
  
  public function testNumbers() {
    
    var portion = new Portion('%205%30.7e%2B85');
    asserts.assert(Std.parseFloat(portion) == 50.7e85);
    return asserts.done();
  }
  
}