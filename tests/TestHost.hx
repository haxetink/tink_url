package ;

import tink.Url;

@:asserts
class TestHost extends Base {
  public function testIpv4() {
    var url:Url = 'http://example.com/foo/bar';
    asserts.assert(url.host == 'example.com');
    
    var url:Url = 'http://example.com:80/foo/bar';
    asserts.assert(url.host == 'example.com:80');
    asserts.assert(url.host.name == 'example.com');
    asserts.assert(url.host.port == 80);
    return asserts.done();
  }

  public function testInvalid() {
    var url:Url = 'http://example.com:invalid/foo/bar';    
    asserts.assert(url.host == 'example.com');
    var url:Url = 'file:///foo/bar';    
    asserts.assert(url.scheme == 'file');
    asserts.assert(url.host == '');
    var url:Url = '/foo/bar';
    asserts.assert(url.host == null);
    return asserts.done();
  }
  
  public function testIpv6() {
    var url:Url = 'http://[::1]/foo/bar';
    asserts.assert(url.host == '[::1]');
    
    var url:Url = 'http://[::1]:80/foo/bar';
    asserts.assert(url.host == '[::1]:80');
    asserts.assert(url.host.name == '[::1]');
    asserts.assert(url.host.port == 80);
    return asserts.done();
  }
  
  public function testMultiIpv4() {
    var url:Url = 'http://example.com,foo.com/foo/bar';
    asserts.assert(url.host == 'example.com');
    asserts.assert(getHost(url.hosts, 0) == 'example.com');
    asserts.assert(getHost(url.hosts, 1) == 'foo.com');
    
    var url:Url = 'http://example.com:80,foo.com:81/foo/bar';
    asserts.assert(url.host == 'example.com:80');
    asserts.assert(getHost(url.hosts, 0) == 'example.com:80');
    asserts.assert(getHost(url.hosts, 1) == 'foo.com:81');
    return asserts.done();
  }
  
  public function testMultiIpv6() {
    var url:Url = 'http://[::1],[::2]/foo/bar';
    asserts.assert(url.host == '[::1]');
    asserts.assert(getHost(url.hosts, 0) == '[::1]');
    asserts.assert(getHost(url.hosts, 1) == '[::2]');
    
    var url:Url = 'http://[::1]:80,[::2]:81/foo/bar';
    asserts.assert(url.host == '[::1]:80');
    asserts.assert(getHost(url.hosts, 0) == '[::1]:80');
    asserts.assert(getHost(url.hosts, 1) == '[::2]:81');
    return asserts.done();
  }
  
  public function testMixed() {
    var url:Url = 'http://example.com,[::2]/foo/bar';
    asserts.assert(url.host == 'example.com');
    asserts.assert(getHost(url.hosts, 0) == 'example.com');
    asserts.assert(getHost(url.hosts, 1) == '[::2]');
    
    var url:Url = 'http://example.com:80,[::2]:81/foo/bar';
    asserts.assert(url.host == 'example.com:80');
    asserts.assert(getHost(url.hosts, 0) == 'example.com:80');
    asserts.assert(getHost(url.hosts, 1) == '[::2]:81');
    return asserts.done();
  }
  
  function getHost(hosts:Iterable<String>, i) {
    var c = 0;
    for(host in hosts) if(c++ == i) return host;
    return null;
  }
}