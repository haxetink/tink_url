package ;

import tink.Url;

@:asserts
class TestUrl extends Base {
  
  #if (cpp && (haxe_ver >= 4))
    // https://github.com/HaxeFoundation/haxe/issues/7536
  #else
  public function testResolve() {
    var url:Url = 'http://example.com/foo/bar';
    asserts.assert(url.resolve('baz') == 'http://example.com/foo/baz');
    asserts.assert(url.resolve('/baz') == 'http://example.com/baz');
    asserts.assert(url.resolve('#baz') == 'http://example.com/foo/bar#baz');
    asserts.assert(url.resolve('?baz') == 'http://example.com/foo/bar?baz');
    asserts.assert(url.resolve('//baz') == 'http://baz');
    asserts.assert(url.resolve('https://baz') == 'https://baz');
    return asserts.done();
  }
  #end
  
  public function testMailto() {
    var mailto:Url = 'mailto:back2dos@gmail?body=Hello,+world';
    asserts.assert(mailto.path == 'back2dos@gmail');
    asserts.assert(mailto.query == 'body=Hello,+world');
    return asserts.done();
  }

  public function testChromeExtension() {
    var ce : Url = 'chrome-extension://test/test.js';
    asserts.assert('chrome-extension' == ce.scheme);
    asserts.assert('My-wild-scheme243' == ('My-wild-scheme243:blublub' : Url).scheme);
    return asserts.done();
  }
  
  public function testTrailingSlash() {
      // trailing slash + query and hash
      var url:Url = 'http://www.google.com/?key=value#hash';
      asserts.assert(url.scheme == 'http');
      asserts.assert(url.path == '/');
      asserts.assert(url.host == 'www.google.com');
      asserts.assert(url.query == 'key=value');
      asserts.assert(url.hash == 'hash');
      
      // no trailing slash + query and hash
      var url:Url = 'http://www.google.com?key=value#hash';
      asserts.assert(url.scheme == 'http');
      asserts.assert(url.path == '/');
      asserts.assert(url.host == 'www.google.com');
      asserts.assert(url.query == 'key=value');
      asserts.assert(url.hash == 'hash');
      
      // trailing slash + query
      var url:Url = 'http://www.google.com/?key=value';
      asserts.assert(url.scheme == 'http');
      asserts.assert(url.path == '/');
      asserts.assert(url.host == 'www.google.com');
      asserts.assert(url.query == 'key=value');
      
      // no trailing slash + query
      var url:Url = 'http://www.google.com?key=value';
      asserts.assert(url.scheme == 'http');
      asserts.assert(url.path == '/');
      asserts.assert(url.host == 'www.google.com');
      asserts.assert(url.query == 'key=value');
      
      // trailing slash + hash
      var url:Url = 'http://www.google.com/#hash';
      asserts.assert(url.scheme == 'http');
      asserts.assert(url.path == '/');
      asserts.assert(url.host == 'www.google.com');
      asserts.assert(url.hash == 'hash');
      
      // no trailing slash + hash
      var url:Url = 'http://www.google.com#hash';
      asserts.assert(url.scheme == 'http');
      asserts.assert(url.path == '/');
      asserts.assert(url.host == 'www.google.com');
      asserts.assert(url.hash == 'hash');
      return asserts.done();
  }
  
  #if (cpp && (haxe_ver >= 4))
    // https://github.com/HaxeFoundation/haxe/issues/7536
  #else
  public function testLazyPathTranscoding() {
    var url : tink.Url = "http://test.com/foo+bar";
    var same = url.resolve("");
    asserts.assert(Std.string(same)  ==  Std.string(url) );    
    return asserts.done();
  }
  #end
}