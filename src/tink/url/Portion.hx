package tink.url;

using tink.CoreApi;
using StringTools;

abstract Portion(String) {
  
  public var raw(get, never):String;
    inline function get_raw()
      return this;
      
  public inline function new(v:String)
    this = v;
    
  @:to function stringly():tink.Stringly
    return toString();
      
  @:to public function toString()
    return 
      if (this == null) null;
      else this.urlDecode();
    
  @:from static function ofString(s:String)
    return new Portion(if (s == null) '' else s.urlEncode());
    
  #if macro
  @:to public function toExpr()
    return macro new tink.url.Portion($v{this});
  #end
}