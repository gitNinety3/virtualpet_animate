package  {
import flash.display.*;	
	
	public class Animal extends MovieClip {
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
		private var currentStomachLevel: int;
		private var stomachCapacity: int;
		private const EMPTY: int = 0;
		
		// SPEED ATTRIBUTES
		private var easingVelocity: int;

		public function Animal() {
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
			switch(myState) {
				
				case isPLAYING:
					currentStomachLevel--;
					locateTarget(toy.x, toy.y);
					if (currentStomachLevel < 10) {
						myState = isLOOKING_FOR_FOOD;
					}
					break;
				
				case isLOOKING_FOR_FOOD:
					findFood(food);
					break;	
				
				case isEATING:
					currentStomachLevel++;
					if (currentStomachLevel >= stomachCapacity) {
						doneEating();
						myState = isPLAYING;
					}
					break;
			}
		}
	
		public function locateTarget(xTarget: Number, yTarget: Number): void {
			var xDist: Number = xTarget - this.x;
			var yDist: Number = yTarget - this.y;
			var angle: Number = Math.atan2(yDist, xDist);
			this.rotation = angle * 180  / Math.PI + 90;
			
			this.x += (xTarget - this.x) / easingVelocity;
			this.y += (yTarget - this.y) / easingVelocity;
		}
	
		public function findFood(food): void {
			locateTarget(food[0].x, food[0].y);
			if (food[0].hitTestPoint(this.x, this.y, true)) {
				myState = isEATING;
			}
		}
	
		public function doneEating(): void {
			//removeChild(food);
			//food.shift();
			//food.splice(i, 1);
		}

	}	
}
