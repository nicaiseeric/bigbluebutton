package org.bigbluebutton.lib.common.services {
	
	import flash.net.NetConnection;
	
	import org.osflash.signals.ISignal;
	
	public interface IBaseConnection {
		function get connection():NetConnection;
		function connect(uri:String, ... parameters):void;
		function disconnect(onUserCommand:Boolean):void;
		function sendMessage(service:String, onSuccess:Function, onFailure:Function, message:Object = null):void;
		function init(callback:IDefaultConnectionCallback):void;
		function get connectionFailureSignal():ISignal;
		function get successConnected():ISignal;
	}
}
