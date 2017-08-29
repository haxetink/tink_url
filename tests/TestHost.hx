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
    assertEquals('example.com', getHost(url.hosts, 0));
    assertEquals('foo.com', getHost(url.hosts, 1));
    
    var url:Url = 'http://example.com:80,foo.com:81/foo/bar';
    assertEquals('example.com:80', url.host);
    assertEquals('example.com:80', getHost(url.hosts, 0));
    assertEquals('foo.com:81', getHost(url.hosts, 1));
  }
  
  function testMultiIpv6() {
    var url:Url = 'http://[::1],[::2]/foo/bar';
    assertEquals('[::1]', url.host);
    assertEquals('[::1]', getHost(url.hosts, 0));
    assertEquals('[::2]', getHost(url.hosts, 1));
    
    var url:Url = 'http://[::1]:80,[::2]:81/foo/bar';
    assertEquals('[::1]:80', url.host);
    assertEquals('[::1]:80', getHost(url.hosts, 0));
    assertEquals('[::2]:81', getHost(url.hosts, 1));
  }
  
  function testMixed() {
    var url:Url = 'http://example.com,[::2]/foo/bar';
    assertEquals('example.com', url.host);
    assertEquals('example.com', getHost(url.hosts, 0));
    assertEquals('[::2]', getHost(url.hosts, 1));
    
    var url:Url = 'http://example.com:80,[::2]:81/foo/bar';
    assertEquals('example.com:80', url.host);
    assertEquals('example.com:80', getHost(url.hosts, 0));
    assertEquals('[::2]:81', getHost(url.hosts, 1));
  }
  
  function getHost(hosts:Iterable<String>, i) {
    var c = 0;
    for(host in hosts) if(c++ == i) return host;
    return null;
  }
}