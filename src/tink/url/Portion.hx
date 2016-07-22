package tink.url;

using tink.CoreApi;
using StringTools;

abstract Portion(String) {
  
  public var raw(get, never):String;
    inline function get_raw()
      return this;
      
  public inline function new(v:String)
    this = v;
    
  static inline function isDigit(c:Int)
    return c > 47 && c < 58;
      
  static inline function isWhite(c:Int)
    return c < 33;
   
  static function isNumber(s:String, allowFloat:Bool) {
    var pos = 0,
        max = s.length;
              
    inline function skip(cond)
      while (pos < max && cond(s.fastCodeAt(pos))) pos++;
    
    inline function allow(code)
      return 
        if (pos < max && s.fastCodeAt(pos) == code) pos++ > -1;//always true ... not pretty, but generates much simpler code
        else false;
      
    
    allow('-'.code);
    skip(isDigit);
    if (allowFloat && pos < max) {
      if (allow('.'.code))
        skip(isDigit);
        
      if (allow('e'.code) || allow('E'.code)) {
        allow('+'.code) || allow('-'.code);
        skip(isDigit);
      }
    }
    
    return pos == max;
  }
  
  @:to public function toString()
    return this.urlDecode();
  
  public function toBool()
    return switch this.urlDecode().trim().toLowerCase() {
      case 'false', '0', 'no': false;
      default: true;
    }
    
  @:to public function parseFloat()
    return switch this.urlDecode().trim() {
      case v if (isNumber(v, true)):
        Success((Std.parseFloat(v) : Float));
      case v:
        Failure(new Error(UnprocessableEntity, '$v (encoded as $this) is not a valid float'));
    }
  
  @:to function toFloat()
    return parseFloat().sure();
    
  @:to public function parseInt()
    return switch this.urlDecode().trim() {
      case v if (isNumber(v, false)):
        Success((Std.parseInt(v) : Int));
      case v:
        Failure(new Error(UnprocessableEntity, '$v (encoded as $this) is not a valid integer'));
    }
        
  @:to function toInt()
    return parseInt().sure();
      
  @:from static inline function ofFloat(f:Float)
    return new Portion(Std.string(f).urlEncode());
    
  @:from static inline function ofInt(i:Int)
    return new Portion(Std.string(i));
    
  @:from static function ofString(s:String)
    return new Portion(if (s == null) '' else s.urlEncode());
}