package ;

import tink.Url;

class TestUrl extends Base {
  function testResolve() {
    var url:Url = 'http://example.com/foo/bar';
    assertEquals('http://example.com/foo/baz', url.resolve('baz'));
    assertEquals('http://example.com/baz', url.resolve('/baz'));
    assertEquals('http://example.com/foo/bar#baz', url.resolve('#baz'));
    assertEquals('http://example.com/foo/bar?baz', url.resolve('?baz'));
    assertEquals('http://baz', url.resolve('//baz'));
    assertEquals('https://baz', url.resolve('https://baz'));
  }
  
  function testMailto() {
    var mailto:Url = 'mailto:back2dos@gmail?body=Hello,+world';
    assertEquals('back2dos@gmail', mailto.path);
    assertEquals('body=Hello,+world', mailto.query);
  }

  function testChromeExtension() {
    var ce : Url = 'chrome-extension://test/test.js';
    assertEquals(ce.scheme, 'chrome-extension');
    assertEquals(('My-wild-scheme243:blublub' : Url).scheme, 'My-wild-scheme243');
  }
  
  function testTrailingSlash() {
      // trailing slash + query and hash
      var url:Url = 'http://www.google.com/?key=value#hash';
      assertEquals('http', url.scheme);
      assertEquals('/', url.path);
      assertEquals('www.google.com', url.host);
      assertEquals('key=value', url.query);
      assertEquals('hash', url.hash);
      
      // no trailing slash + query and hash
      var url:Url = 'http://www.google.com?key=value#hash';
      assertEquals('http', url.scheme);
      assertEquals('/', url.path);
      assertEquals('www.google.com', url.host);
      assertEquals('key=value', url.query);
      assertEquals('hash', url.hash);
      
      // trailing slash + query
      var url:Url = 'http://www.google.com/?key=value';
      assertEquals('http', url.scheme);
      assertEquals('/', url.path);
      assertEquals('www.google.com', url.host);
      assertEquals('key=value', url.query);
      
      // no trailing slash + query
      var url:Url = 'http://www.google.com?key=value';
      assertEquals('http', url.scheme);
      assertEquals('/', url.path);
      assertEquals('www.google.com', url.host);
      assertEquals('key=value', url.query);
      
      // trailing slash + hash
      var url:Url = 'http://www.google.com/#hash';
      assertEquals('http', url.scheme);
      assertEquals('/', url.path);
      assertEquals('www.google.com', url.host);
      assertEquals('hash', url.hash);
      
      // no trailing slash + hash
      var url:Url = 'http://www.google.com#hash';
      assertEquals('http', url.scheme);
      assertEquals('/', url.path);
      assertEquals('www.google.com', url.host);
      assertEquals('hash', url.hash);
  }
}