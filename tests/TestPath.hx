package;
import tink.url.Path;

class TestPath extends Base {

  function testJoin() {
        
    assertEquals('foo/bar/', ('foo/bar/' : Path).join(''));
    assertEquals('foo/bar', ('foo/bar' : Path).join(''));
    
    assertEquals('foo/bar/new', ('foo/bar/' : Path).join('new'));
    assertEquals('foo/bar/new', ('foo/bar/ignored' : Path).join('new'));
        
    assertEquals('foo/bar/new/nested', ('foo/bar/' : Path).join('new/nested'));
    assertEquals('foo/bar/new/nested', ('foo/bar/ignored' : Path).join('new/nested'));

    assertEquals('new/nested', ('' : Path).join('new/nested'));
    assertEquals('new/nested', ('ignored' : Path).join('new/nested'));
    
    assertEquals('foo/bar/', ('foo/bar/' : Path).join('.'));
    assertEquals('foo/', ('foo/bar/' : Path).join('../'));
    
  }
  
  function testNormalize() {
    assertEquals('', Path.normalize(''));
    assertEquals('/', Path.normalize('/'));
    assertEquals('/', Path.normalize('/.'));
    assertEquals('/', Path.normalize('/.././../../.'));
    assertEquals('/', Path.normalize('/../remove/../../'));
    assertEquals('/add', Path.normalize('/../remove/../../add'));
    assertEquals('/add/', Path.normalize('/../remove/../../add/'));
    assertEquals('../../add', Path.normalize('../remove/../../add'));
    assertEquals('../../', Path.normalize('../remove/../../alsoremove/..'));
    assertEquals('../../', Path.normalize('../remove/../../alsoremove/../'));
  }
    
}