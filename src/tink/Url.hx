package tink;

import tink.url.*;

using StringTools;

@:forward
abstract Url(UrlParts) {
  
  static inline var SCHEME = 2;
  static inline var PAYLOAD = 3;
  static inline var AUTH = 6;
  static inline var HOSTNAMES = 7;
  static inline var PATH = 8;
  static inline var QUERY = 10;
  static inline var HASH = 12;
  
  inline function new(parts)
    this = parts;
    
  public function resolve(that:Url):Url
    return
      if (that.scheme != null) that;
      else if (that.host != null)
        if (that.scheme != null) that;
        else {
          var copy = Reflect.copy(that);
          @:privateAccess copy.scheme = this.scheme;
          return copy;
        }
      else {
        var parts:UrlParts = {
          path: this.path.join(that.path),
          payload: '',
          scheme: this.scheme,
          query: that.query,
          auth: this.auth,
          host: this.host,
          hash: that.hash
        }
        
        makePayload(parts);
        
        return new Url(parts);
      }
      
  static function makePayload(parts:UrlParts) {
    
    var payload = new StringBuf();
            
    switch parts {
      case { host: null, auth: null }:
      case { auth: null, host: host }:
        payload.add('//$host');
      case { auth: auth, host: null }:
        payload.add('//$auth@');
      case { auth: auth, host: host } :
        payload.add('//$auth@$host'); 
    }
    
    payload.add((parts.path : String).split('/').join('/'));
    
    switch parts.query {
      case null:
      case v: payload.add('?$v');
    }
    
    switch parts.hash {
      case null:
      case v: payload.add('#$v');
    }
    
    @:privateAccess parts.payload = payload.toString();
  }
  
  @:to public function toString()
    return switch this.scheme {
      case null: this.payload;
      default: '${this.scheme}:${this.payload}';
    }
  
  @:from static public function parse(s:String):Url {
    if (s == null) 
      return parse('');
    s = s.trim();
    
    if (s.startsWith('data:')) //this is kind of a fast-path
      return new Url( { scheme: 'data', payload: s.substr(5) } );
    
    var FORMAT = ~/^(([a-zA-Z][a-zA-Z0-9\-]*):)?((\/\/(([^@\/]+)@)?([^\/?#]*))?([^?#]*)(\?([^#]*))?(#(.*))?)$/;
    var HOST = ~/^(\[(.*)\]|([^:]*))(:(\d*))?$/;  
    //Ideally the above would be a constant. Unfortunately that would compromise thread safety.
    
    FORMAT.match(s);
    
    var hosts = switch FORMAT.matched(HOSTNAMES) {
        case null: [];
        case v:
            [for(host in v.split(',')) {
              HOST.match(host);
              var host = switch [HOST.matched(3), HOST.matched(2)] {
                  case [ipv4, null]: ipv4;
                  case [null, ipv6]: '[$ipv6]';
                  case _: throw 'assert';
              }
              var port = switch HOST.matched(5) {
                  case null: null;
                  case v: 
                      switch Std.parseInt(v) {
                          case null: throw 'Invalid port';
                          case p: p;
                      }
              }
              new Host(host, port);
            }];
    }
    var path = FORMAT.matched(PATH);
    
    if (hosts.length > 0 && path.charAt(0) != '/')
      path = '/$path';
      
    return new Url({
      scheme: FORMAT.matched(SCHEME),
      payload: FORMAT.matched(PAYLOAD),
      host: hosts[0],
      hosts: hosts,
      auth: cast FORMAT.matched(AUTH),
      path: path,
      query: FORMAT.matched(QUERY),
      hash: FORMAT.matched(HASH)
    });    
  }
}

private typedef UrlParts = {
  @:optional var path(default, null):Path;
  var payload(default, null):String;
  
  @:optional var query(default, null):Query;
  @:optional var host(default, null):Host;
  @:optional var hosts(default, null):Array<Host>;
  @:optional var auth(default, null):Auth;
  @:optional var scheme(default, null):String;
  @:optional var hash(default, null):String;
}