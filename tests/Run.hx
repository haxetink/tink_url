package ;

import haxe.unit.TestCase;
import haxe.unit.TestRunner;
import tink.Url;

class Run {
	static var tests:Array<TestCase> = [
		new TestPath(),
		new TestQuery(),
		//new TestFile(),
		new TestUrl()
	];
	static function main() {
		
		var runner = new TestRunner();
		for (test in tests)
			runner.add(test);
		runner.run();
	}
}