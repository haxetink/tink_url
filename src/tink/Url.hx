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
  
  public var pathWithQuery(get, never):String;
    inline function get_pathWithQuery()
      return if(this.query == null) this.path else this.path + '?' + this.query;
  
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
    
    var payload = '';
            
    switch parts {
      case { host: null, auth: null }:
      case { auth: null, host: host }:
        payload += '//$host';
      case { auth: auth, host: null }:
        payload += '//$auth';
      case { auth: auth, host: host } :
        payload += '//$auth$host'; 
    }
    
    payload += parts.path;
    
    switch parts.query {
      case null:
      case v: payload += '?$v';
    }
    
    switch parts.hash {
      case null:
      case v: payload += '#$v';
    }
    
    @:privateAccess parts.payload = payload.toString();
  }
  
  @:to public function toString()
    return switch this.scheme {
      case null: this.payload;
      default: '${this.scheme}:${this.payload}';
    }
  
  @:from static function fromString(s:String):Url return parse(s);
  static function noop(_) {}
  static public function parse(s:String, ?onError:String->Void):Url {
    
    if (s == null) 
      return parse('');

    if (onError == null)
      onError = noop;

    s = s.trim();
    
    if (s.startsWith('data:')) //this is kind of a fast-path
      return new Url( { scheme: 'data', payload: s.substr(5) } );
    
    var FORMAT = ~/^(([a-zA-Z][a-zA-Z0-9\-+.]*):)?((\/\/(([^@\/]+)@)?([^\/?#]*))?([^?#]*)(\?([^#]*))?(#(.*))?)$/;
    var HOST = ~/^(\[(.*)\]|([^:]*))(:(.*))?$/;  
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
                  case _: 
                    onError('invalid host $host'); 
                    null;
              }
              var port = switch HOST.matched(5) {
                  case null: null;
                  case v: 
                      switch Std.parseInt(v) {
                          case null: 
                            onError('invalid port $v'); 
                            null;
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

  static public function make(parts:UrlArgs):Url {
    var parts:UrlParts = {
      payload: '',
      path: parts.path,
      query: parts.query,
      host: parts.host,
      hosts: parts.hosts,
      auth: parts.auth,
      scheme: parts.scheme,
      hash: parts.hash,
    };
    makePayload(parts);
    return new Url(parts);
  }
  
  #if tink_json
  @:from public static function fromRepresentation(v:tink.json.Representation<String>)
    return Url.parse(v.get());
  @:to public function toRepresentation():tink.json.Representation<String>
    return new tink.json.Representation(toString());
  #end
}

private typedef UrlParts = {>UrlArgs,
  var payload(default, null):String;
}

private typedef UrlArgs = {
  @:optional var path(default, null):Path;
  @:optional var query(default, null):Query;
  @:optional var host(default, null):Host;
  @:optional var hosts(default, null):Iterable<Host>;
  @:optional var auth(default, null):Auth;
  @:optional var scheme(default, null):String;
  @:optional var hash(default, null):String;
}
