package
{
	public class Dialog
	{
		public static var LANGUAGE:int = 1;
		
		public var id:String;
		
		public var textEnglish:String;
		public var textSpanish:String;
		
		public function Dialog(id:String, textSpanish:String, textEnglish:String)
		{
			this.id = id;
			
			this.textEnglish = textEnglish;
			this.textSpanish = textSpanish;
		}
		
		public function getText():String
		{
			switch(LANGUAGE)
			{
				case 1:
				{
					return textEnglish;
					break;
				}
					
				default:
				{
					return textSpanish;
					break;
				}
			}
		}
	}
}