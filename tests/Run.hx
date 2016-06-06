package ;

import haxe.unit.TestCase;
import haxe.unit.TestRunner;
import tink.Url;

#if flash
typedef Sys = flash.system.System;
#end

class Run {
  static var tests:Array<TestCase> = [
    new TestPath(),
    new TestQuery(),
    //new TestFile(),
    new TestUrl(),
    new TestHost(),
  ];
  static function main() {
    
    var runner = new TestRunner();
    for (test in tests)
      runner.add(test);
      
    Sys.exit(
      if (runner.run()) 0
      else 500
    );
  }
}