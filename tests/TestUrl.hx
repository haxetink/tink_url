package ;

import tink.Url;

class TestUrl extends Base {
  function testResolve() {
    var url:Url = 'http://example.com/foo/bar';
    assertEquals('http://example.com/foo/baz', url.resolve('baz'));
    assertEquals('http://example.com/baz', url.resolve('/baz'));
    assertEquals('http://example.com/foo/bar#baz', url.resolve('#baz'));
    assertEquals('http://example.com/foo/bar?baz', url.resolve('?baz'));
    assertEquals('//baz', url.resolve('//baz'));
  }
  
  function testMailto() {
    var mailto:Url = 'mailto:back2dos@gmail?body=Hello,+world';
    assertEquals('back2dos@gmail', mailto.path);
    assertEquals('body=Hello,+world', mailto.query);
  }
}