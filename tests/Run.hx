package;

import tink.testrunner.*;
import tink.unit.*;

class Run {
  static function main() {
    Runner.run(TestBatch.make([
      new TestPath(),
      new TestQuery(),
      new TestUrl(),
      new TestHost(),
      new TestPortion(),
      new TestAuth(),
    ])).handle(Runner.exit);
  }
}