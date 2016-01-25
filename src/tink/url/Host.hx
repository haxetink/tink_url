package tink.url;

/**
 * Represents a host, i.e. a hostname and an additional port.
 * May be accessed when null.
 */
abstract Host(String) to String {
	public var name(get, never):Null<String>;
	public var port(get, never):Null<Int>;
	
	public inline function new(name:String, ?port:Int)
		this = 
			if (port == null) name;
			else '$name:$port';
			
	inline function get_name()
		return
			if (this == null) null;
			else this.split(':')[0];
			
	inline function get_port()
		return
			if (this == null) null;
			else 
				switch this.split(':')[1] {
					case null: null;
					case v: Std.parseInt(v);
				}
}