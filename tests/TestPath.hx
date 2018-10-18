package;
import tink.url.Path;

@:asserts
class TestPath extends Base {

  public function testJoin() {
        
    asserts.assert(('foo/bar/' : Path).join('') == 'foo/bar/');
    asserts.assert(('foo/bar' : Path).join('') == 'foo/bar');
    
    asserts.assert(('foo/bar/' : Path).join('new') == 'foo/bar/new');
    asserts.assert(('foo/bar/ignored' : Path).join('new') == 'foo/bar/new');
        
    asserts.assert(('foo/bar/' : Path).join('new/nested') == 'foo/bar/new/nested');
    asserts.assert(('foo/bar/ignored' : Path).join('new/nested') == 'foo/bar/new/nested');

    asserts.assert(('' : Path).join('new/nested') == 'new/nested');
    asserts.assert(('ignored' : Path).join('new/nested') == 'new/nested');
    
    asserts.assert(('foo/bar/' : Path).join('.') == 'foo/bar/');
    asserts.assert(('foo/bar/' : Path).join('../') == 'foo/');
    return asserts.done();
  }
  
  public function testNormalize() {
    asserts.assert(Path.normalize('') == '');
    asserts.assert(Path.normalize('/') == '/');
    asserts.assert(Path.normalize('/.') == '/');
    asserts.assert(Path.normalize('/.././../../.') == '/');
    asserts.assert(Path.normalize('/../remove/../../') == '/');
    asserts.assert(Path.normalize('/../remove/../../add') == '/add');
    asserts.assert(Path.normalize('/../remove/../../add/') == '/add/');
    asserts.assert(Path.normalize('../remove/../../add') == '../../add');
    asserts.assert(Path.normalize('../remove/../../alsoremove/..') == '../../');
    asserts.assert(Path.normalize('../remove/../../alsoremove/../') == '../../');
    return asserts.done();
  }
    
}