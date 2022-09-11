package  {
	import flash.display.MovieClip;
	
	public class Pet extends MovieClip {
		//*********************
		//**** DATA MEMBERS****
		//*********************
		
		// CURRENT PET STATE
		private var myState: int;
		
		// POSSIBLE PET STATES
		private const isPLAYING: int = 1;
		private const isLOOKING_FOR_FOOD: int = 2;
		private const isEATING: int = 3;
		private const isDied: int = 4;
		
		// STOMACH ATTRIBUTES
		private var stomachCapacity: int;
		private var currentStomachLevel: int;
		private const EMPTY: int = 0;
		
		// SPEED ATTRIBUTES
		private var easingVelocity: int;

		// CONSTRUCTOR
		public function Pet() {
			// TASK 1: A PET ARRIVE WITH A FULL STOMACH, READY TO PLAY
			myState = isPLAYING;
			stomachCapacity = Math.random() * 100 + 150;
			currentStomachLevel = stomachCapacity;
			
			// TASK 2: ATTRIBUTES ARE RANDOMLY ASSIGNED: SIZE, SPEED ABILITY, LOCATION
			this.width = Math.random() * 45 + 45;
			this.height = this.width + 20;
			easingVelocity = Math.random() * 45 + 15;
			this.x = Math.random() * 600 + 200;
			this.y = Math.random() * 200 + 200;
		}
	
		public function move(toy: Toy, food: Food): void {
			// task: evaluate finit states
			switch(myState) {
				//*****************************************
				//****			isPLAYING			   ****
				//*****************************************
				case isPLAYING:
					// TASK 1: BURN CALORIES
					currentStomachLevel--;
					// TASK 2: LOCATE THE TOY TO PLAY WITH
					locateTarget(toy.x, toy.y);
					// TASK 3:
					if (currentStomachLevel < 10) {
						myState = isLOOKING_FOR_FOOD;
					}
					break;
		
				//*****************************************
				//****		  isLOOKING_FOR_FOOD  	   ****
				//*****************************************
				case isLOOKING_FOR_FOOD:
					// TASK 1: CHECK IF THERE IS ANY FOOD AND SEEK IT OUT
					locateTarget(food.x, food.y);
					// TASK 2: CHECK IF PET HAS REACHED THE FOOD: CHANNGE THE STAT TO IS EATTING
					if (food.hitTestPoint(this.x, this.y, true)) {
						myState = isEATING;
						currentStomachLevel = stomachCapacity;
						removeChild(food);
						food.shift();
						//food.splice(i, 1);
					/*} else {
						myState = isDied; */
					}
					break;
			
				//*****************************************
				//****			isEATING			  	   ****
				//*****************************************
				case isEATING:
					// TASK: 1 CONSUME FOOD - INCREASE CURRENT STOMACH LEVEL
					currentStomachLevel++;
					// TASK 2: WHEN FOOD IN BELLY FULL, PET PLAYS
					if (currentStomachLevel >= stomachCapacity) {
						myState = isPLAYING;
						removeChild(food);
						food.shift();
						//food.splice(i, 1);
					}
					break;
				/*
				case isDied:
					if (currentStomachLevel <= 0) {
						removeChild(pet);
						pet.shift();
					}
					break;
				*/
			}
			
		}
	
		public function locateTarget(xTarget: Number, yTarget: Number): void {
			// task 1: orient the pet toward its targetL food or toy
			var xDist: Number = xTarget - this.x;
			var yDist: Number = yTarget - this.y;
			var angle: Number = Math.atan2(yDist, xDist);
			this.rotation = angle * 180  / Math.PI + 90;
			
			// task 2: move to the target
			this.x += (xTarget - this.x) / easingVelocity;
			this.y += (yTarget - this.y) / easingVelocity;
		}

	}
	
}



			
			// TASK 1: BURN CALORIES (Decrement currentStomachLevel)
			// TASK 2: LOCATE AND PLAY WITH TOY
			// TASK 3: CHECK IF STOMACH IS EMPTY
			
			
			// TASK 1: LOOK FOR FOOD
			// TASK 2: CHECK IF PET HAS REACHED THE FOOD
			//		   IF TRUE, CHANGE THE STATE TO isEATING
			
			
			// TASK 1: FEED (INCREASE CURRENT STOMACH LEVEL)
			// TASK 2: CHECK IF STOMACH IS FULL IF TRUE, CHANGE STATE