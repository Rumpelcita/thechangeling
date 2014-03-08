package   
{
	public function get Key():Input
	{
		return Input.getInstance();
	}
}

//-----------------------------------------------------------------------------------------------------

import flash.display.Stage;
import flash.events.KeyboardEvent;	
import flash.ui.Keyboard;
import flash.utils.Proxy;
import flash.utils.flash_proxy;
	
class Input extends Proxy
{
	// Some common key codes that aren't
	// a part of flash.ui.Keyboard
	public const W:int 	= 87;
	public const A:int 	= 65;
	public const S:int 	= 83;
	public const D:int 	= 68;
		
	private var m_keys:Object
	private var m_downOnce:Object;
	
	private static var m_instance:Input;
	private static var m_allowCreation:Boolean;
	
	//-------------------------------------------------------------------------------------------------
		
	public function Input():void
	{	
		if(!m_allowCreation)
		{
			throw new Error("Call getInstance() instead!");
			return;
		}
		resetKeys();
	}

	//-------------------------------------------------------------------------------------------------
	
	public static function getInstance():Input
	{
		if(!m_instance)
		{
			m_allowCreation = true;
			m_instance = new Input;
			m_allowCreation = false;
		}
		return m_instance;
	}
	
	//-------------------------------------------------------------------------------------------------
		
	public function resetKeys():void
	{
		m_keys = new Object;
		m_downOnce = new Object;
	}
	
	//-------------------------------------------------------------------------------------------------
	
	public function addListeners(stage:Stage):void
	{
		stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
		stage.addEventListener(KeyboardEvent.KEY_UP, keyReleased);
	}
	
	//-------------------------------------------------------------------------------------------------
	
	private function keyPressed(e:KeyboardEvent):void
	{ 
		//trace(code);	// uncomment this to trace the key code.
		m_keys[e.keyCode] = true;	
	}
	
	//-------------------------------------------------------------------------------------------------
	
	private function keyReleased(e:KeyboardEvent):void
	{	
		delete m_keys[e.keyCode];
		delete m_downOnce[e.keyCode];
	}
		
	//-------------------------------------------------------------------------------------------------
		
	public function isDown(code:int):Boolean
	{
		return code in m_keys;
	}		
	
	//-------------------------------------------------------------------------------------------------
	
	public function isDownOnce(code:int):Boolean
	{			
		if(code in m_keys && !(code in m_downOnce))
		{
			m_downOnce[code] = true;
			return true;
		}
		return false;
	}
	
	//-------------------------------------------------------------------------------------------------
	
	flash_proxy override function getProperty(name:*):*
	{
		return (name in Keyboard) ? Keyboard[name] : null;
	}
	
	//-------------------------------------------------------------------------------------------------
}
