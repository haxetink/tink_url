package ;

import tink.Url;

class TestHost extends Base {
  function testIpv4() {
    var url:Url = 'http://example.com/foo/bar';
    assertEquals('example.com', url.host);
    
    var url:Url = 'http://example.com:80/foo/bar';
    assertEquals('example.com:80', url.host);
    assertEquals('example.com', url.host.name);
    assertEquals(80, url.host.port);
  }
  
  function testIpv6() {
    var url:Url = 'http://[::1]/foo/bar';
    assertEquals('[::1]', url.host);
    
    var url:Url = 'http://[::1]:80/foo/bar';
    assertEquals('[::1]:80', url.host);
    assertEquals('[::1]', url.host.name);
    assertEquals(80, url.host.port);
  }
  
  function testMultiIpv4() {
    var url:Url = 'http://example.com,foo.com/foo/bar';
    assertEquals('example.com', url.host);
    assertEquals('example.com', url.hosts[0]);
    assertEquals('foo.com', url.hosts[1]);
    
    var url:Url = 'http://example.com:80,foo.com:81/foo/bar';
    assertEquals('example.com:80', url.host);
    assertEquals('example.com:80', url.hosts[0]);
    assertEquals('foo.com:81', url.hosts[1]);
  }
  
  function testMultiIpv6() {
    var url:Url = 'http://[::1],[::2]/foo/bar';
    assertEquals('[::1]', url.host);
    assertEquals('[::1]', url.hosts[0]);
    assertEquals('[::2]', url.hosts[1]);
    
    var url:Url = 'http://[::1]:80,[::2]:81/foo/bar';
    assertEquals('[::1]:80', url.host);
    assertEquals('[::1]:80', url.hosts[0]);
    assertEquals('[::2]:81', url.hosts[1]);
  }
  
  function testMixed() {
    var url:Url = 'http://example.com,[::2]/foo/bar';
    assertEquals('example.com', url.host);
    assertEquals('example.com', url.hosts[0]);
    assertEquals('[::2]', url.hosts[1]);
    
    var url:Url = 'http://example.com:80,[::2]:81/foo/bar';
    assertEquals('example.com:80', url.host);
    assertEquals('example.com:80', url.hosts[0]);
    assertEquals('[::2]:81', url.hosts[1]);
  }
}