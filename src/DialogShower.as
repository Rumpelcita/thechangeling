package
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	public class DialogShower extends Sprite
	{
		
		public static var END_DIALOG:String = "END_DIALOG";
		
		private var dialogs:Array;
		private var onUse:Boolean;
		private var currentText:String;
		private var currentSentence:uint;
		private var text:TextDisplay;
		
		public function DialogShower()
		{
			super();
			text= new TextDisplay();
			text.x = 400;
			text.y = 500;
			text.text.multiline = true;
			text.text.wordWrap = true;
			addChild(text);
			
			dialogs = new Array();
			dialogs.push(new Dialog("dialogFoodRats", "Comida por las ratas, ew", "Eaten by rats, ew"));
			dialogs.push(new Dialog("dialogFoodOld", "No comió nada", "She didn't eat anything"));
			dialogs.push(new Dialog("dialogBookFind", "Parece ser un libro viejo...; sus dibujos muestran un terror que solo una mente enferma podría concebir...; quisiera poder leerlo, tal vez tenga información útil...; Tal vez el anciano pueda ayudarme", "It seems to be a old book...; these drawings show terrors that only a sick mind can imagine...; I wish I could read it. It might be useful...; Maybe the old man can help me"));
			dialogs.push(new Dialog("dialogDollFind", "La muñeca de mi hija", "My daughter's doll"));
			dialogs.push(new Dialog("dialogKnifeFind", "¡Que extraño cuchillo! ¿Por qué lo ocultarían aquí?", "An strange knife! Why would anybody hide it here? "));
			
			dialogs.push(new Dialog("dialogReadBook", "Cuando la luna se alce, en la hora más oscura;Te quitaremos lo que más amas;Y el alma del viajero será llevada a un mundo lejano;Cuando la noche llore y tu corazón sangre;Si quieres recuperarlo;ven a jugar con nosotros, en el otro lado", "When the moon rises on the darkest hour;we shall take what you value most;And the traveler’s soul shall be taken; to the world beyond; When the night cries and your heart bleeds;If you want it back, come to play with us,;in the other side..."));dialogs.push(new Dialog("dialogDollWatch1", "Mi hija...; sigue perdida...; tengo que encontrarla...; no puedo dejarla...; no puedo dejarla", "My daughter...; she is still missing...; I must find her...; I can’t leave her...; I can’t"));
			dialogs.push(new Dialog("dialogDollWatch1", "¿Dónde estás? Tengo que encontrarte...", "Where are you Lily? I must find you!"));
			dialogs.push(new Dialog("dialogDollWatch2", "Ya no soporto más... ya no puedo...", "I can’t take this... I can’t take this anymore..."));
			dialogs.push(new Dialog("dialogDollWatch3", "Ya no puedo seguir viendo esta muñeca del infierno!", "I can't see this infernal doll anymore!"));
			dialogs.push(new Dialog("dialogFinal1", 
				"Vos: ¡Tú no eres mi hija!; Si lo soy. ¿No me ves?;Vos:¡¿Dónde está mi hija?!; Aquí estoy… Yo salí y ella se quedara allí…; y yo viviré en su lugar. Viviré contigo, para siempre…; Vos: ¡¿Dónde está mi hija?!; Ella nunca va a volver; Vos:  ¡AAAAAAAHHHHHHHHHHHHHH!",
				"You: You are not my daughter!; Yes, I am. Can't you see me?; You: Where is my daughter?!; I’m here. I’m out and she will be trapped there …; and will live in her place. I will live with you, for ever…; You: Where is my daughter?!; She will never come back; You: AAAAAAAAAAAAHHHHHHHHHHHH!"));
			dialogs.push(new Dialog("dialogFinal2", "Lily: ¿Estamos juntas?; Sí; Vos: Estamos juntas para siempre; Lily: Sí… para siempre…", 
			"Lily: Are we together now?; You: Yes; We will be together forever; Lily: Yes... forever"));
			dialogs.push(new Dialog("dialogFinal3", "Vos: ¿Quién eres? ¿Qué le hiciste a mi hija?; Lily: Ella ya no está. Yo salí y ella se quedara allí…; Lily: yo viviré en su lugar.; Lily: Viviré contigo, para siempre…; Vos: ¡¿Dónde está mi hija?!; Cuando la noche llore y tu corazón sangre; Si quieres recuperarla; ven a jugar con nosotros, en el otro lado; ...; Si quieres recuperarla; ven a jugar con nosotros, en el otro lado; Lily: Nunca vas a recuperarla.; Lily: Yo salí y ella se quedara allí…; Lily: y yo viviré en su lugar…; Lily: para siempre; Vos: Voy a recuperar a mi hija, engendro del infierno!; Lily: Puedes intentarlo…", 
			"You: Who are you? What did you do with my daughter?; Lily: She is not here. She is there.; Lily: I’m out and she will be trapped there; Lily: …; Lily: and I will live in her place.; Lily: I will live with you, for ever…; You: Where is my  daughter?!; When the night cries and your heart bleeds; If you want it back, come to play with us; on the other side; When the night cries and your heart bleeds; If you want it back, come to play with us; on the other side; Lily: You never will find her. Lily: I’m out and she will be trapped there; Lily: … and I will live in her place.; Lily: I will live with you, for ever…; You: I will find my daughter; You: and I will take her back here,; You: you hell spawn!; Lily: You can try…"));
			dialogs.push(new Dialog("dialogOldMan", "Vos: ¿Hola?; Viejo: Buenas noches; Vos: ¿Quién eres?; Viejo: Sven, El Ermitaño; Vos: ¿Vives en el bosque?; Sven: Así es…; Sven: prefiero vivir en donde las bestias tenga rostro; Vos: Estoy buscando a mi hija. Es una niña de cabello castaño y un vestido verde; Sven: No la he visto; Vos: Estoy desesperada; Sven: Nadie en esa aldea es de fiar.; Sven: No confío en ellos y tampoco tu deberias; Vos: Tengo que encontrar a mi hija.; Sven: No puedo ayudarte.; Sven: Quisiera, pero mis viejos huesos no soportarían; Sven: una noche en el frío lejos de mi hogar.; Sven: Puedo ofrecerte comida y un lugar donde dormir,; Sven: cerca de mi chimenea, en la biblioteca.; Vos: ¿Biblioteca? ¿Sabes leer?; Sven: Si. Mis libros son mi única compañía.; Sven: Ellos nunca mienten, nunca me han abandonado.; Vos: Lily…; tengo que encontrarla...;", 
			"You: Hello?; Old Man: Good Night; You: Who are you?; Old Man: Sven, the hermit; You: You live in this forest?; Sven: Right you are.; Sven: I prefer to live where the beasts have a real face, at least.; You: I’m looking for my daughter.; You: It's a girl with brown hair and a green dress.; You: Did you see her?; Sven: I didn’t; You: I'm desperate; Sven: You can’t trust in anybody of the village.; Sven: I don't trust them and neither should you.; You: I have to find my daughter; Sven: I can’t help you.; Sven: I wish I could but my old bones can’t take a night; Sven: outside in the cold away from my home. Sven: I can give you food and shelter,; Sven: next to the fire,; Sven: in the library.; You: Library? Can you read?; Sven: Yes. My books are my only company.; Sven: They never lie.; Sven: They never let me down.; You: Lily…; I must find her...; "));
			dialogs.push(new Dialog("dialogNoBook", "Sven no puede ayudarme por el momento...", "Sven can't help right now"));
			dialogs.push(new Dialog("dialogBook", "Vos: ¿Puedes leer esto por mi?; Vos: Yo no sé leer, solo soy una campesina.; Vos: Estaba en una de las casas de la aldea.; Vos: Quizás tenga algo tenga algo útil.; Sven: Dejame ver… hmmm…; Sven: es un libro muy antiguo…; Sven: ¡Oh, por Dios!; Sven: ¡Estos dibujos!; Sven: ¿Qué es esto?; Vos: ¿Qué dice?; Sven: Changeling, el usurpador de cuerpos.; Sven: El ladrón de rostros...; Vos: ¿De qué habla?; Sven: Solo es un poema; Vos: ¿Y qué es lo que dice?; Sven: Cuando la luna se alce, en la hora más oscura; Te quitaremos lo que más amas; Y el alma del viajero; será llevada a un mundo lejano; Cuando la noche llore y tu corazón sangre; Si quieres recuperarlo; ven a jugar con nosotros; en el otro lado; Vos: Lily…; tengo que encontrarla...;", 
			"You: Can you read this to me?; You: I can’t read, I’m just a poor peasant.; You: I found this book in a house in the village.; You: Maybe it says something useful.; Sven: Let me see… hmm…; Sven: It’s a very old book…; Sven: Oh, God! This drawings!; You: What is it?; You: What does it say?; Sven: Changeling, the usurper of bodies.; Sven: The thief of faces ...; You: And what does it say about that!?; Sven: It's just a poem; You: What does it say!?; Sven: When the moon rises on the darkest hour; we shall take what you value most; And the traveler’s soul shall be taken; to the world beyond; When the night cries; and your heart bleeds; If you want it back,; come to play with us,; on the other side…; You: Lily…; I must find her..."));
			
			var credits:String = "The Changeling; -Game Designers-; Pablo Rubio; Leonardo Pereyra; -Art-; Nicolas Moreno; -Programmers-; Florencia 'Rumpel' Rodriguez; Marco Paolantonio";
			
			dialogs.push(new Dialog("credits", credits, credits));
		}
		
		public function setText(id:String):void
		{
			if(onUse)
				return;
			
			currentSentence = 0;
			
			onUse = true;
			for each(var d:Dialog in dialogs)
			{
				if(d.id == id)
				{
					currentText = d.getText();
					text.text.text = currentText.split(";")[0];
					break;
				}
			}
			
			TweenLite.to(this, 0.25, {alpha:1});
			setTimeout(hide, 2000);
		}
		
		private function hide():void
		{
			if(currentSentence < currentText.split(";").length-1)
			{
				currentSentence++;
				text.text.text = currentText.split(";")[currentSentence];
				setTimeout(hide, 2000);
			}
			else
			{
				TweenLite.to(this, 0.25, {alpha:0});
				onUse = false;
				dispatchEvent(new Event(END_DIALOG));
			}
		}
	}
}