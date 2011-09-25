package ru.gotoandstop.cube.geom{
	public class Matrix3D{
		public var v11:Number;
		public var v12:Number;
		public var v13:Number;
		public var v14:Number;
		public var v21:Number;
		public var v22:Number;
		public var v23:Number;
		public var v24:Number;
		public var v31:Number;
		public var v32:Number;
		public var v33:Number;
		public var v34:Number;
		public var v41:Number;
		public var v42:Number;
		public var v43:Number;
		public var v44:Number;
		
		public function Matrix3D(
			v11:Number=1, v12:Number=0, v13:Number=0, v14:Number=0,
			v21:Number=0, v22:Number=1, v23:Number=0, v24:Number=0,
			v31:Number=0, v32:Number=0, v33:Number=1, v34:Number=0,
			v41:Number=0, v42:Number=0, v43:Number=0, v44:Number=1
		){
			this.v11 = v11; this.v12 = v12; this.v13 = v13; this.v14 = v14;
			this.v21 = v21; this.v22 = v22; this.v23 = v23; this.v24 = v24;
			this.v31 = v31; this.v32 = v32; this.v33 = v33; this.v34 = v34;
			this.v41 = v41; this.v42 = v42; this.v43 = v43; this.v44 = v44;
		}
		
		public function identity():void{
			this.v11=1; this.v12=0; this.v13=0; this.v14=0;
			this.v21=0; this.v22=1; this.v23=0; this.v24=0;
			this.v31=0; this.v32=0; this.v33=1; this.v34=0;
			this.v41=0; this.v42=0; this.v43=0; this.v44=1;
		}
		
		public function multiply(m:Matrix3D):void{
			var t11:Number = this.v11 * m.v11 + this.v12 * m.v21 + this.v13 * m.v31 + this.v14 * m.v41;
			var t12:Number = this.v11 * m.v12 + this.v12 * m.v22 + this.v13 * m.v32 + this.v14 * m.v42;
			var t13:Number = this.v11 * m.v13 + this.v12 * m.v23 + this.v13 * m.v33 + this.v14 * m.v43;
			var t14:Number = this.v11 * m.v14 + this.v12 * m.v24 + this.v13 * m.v34 + this.v14 * m.v44;
			
			var t21:Number = this.v21 * m.v11 + this.v22 * m.v21 + this.v23 * m.v31 + this.v24 * m.v41;
			var t22:Number = this.v21 * m.v12 + this.v22 * m.v22 + this.v23 * m.v32 + this.v24 * m.v42;
			var t23:Number = this.v21 * m.v13 + this.v22 * m.v23 + this.v23 * m.v33 + this.v24 * m.v43;
			var t24:Number = this.v21 * m.v14 + this.v22 * m.v24 + this.v23 * m.v34 + this.v24 * m.v44;
			
			var t31:Number = this.v31 * m.v11 + this.v32 * m.v21 + this.v33 * m.v31 + this.v34 * m.v41;
			var t32:Number = this.v31 * m.v12 + this.v32 * m.v22 + this.v33 * m.v32 + this.v34 * m.v42;
			var t33:Number = this.v31 * m.v13 + this.v32 * m.v23 + this.v33 * m.v33 + this.v34 * m.v43;
			var t34:Number = this.v31 * m.v14 + this.v32 * m.v24 + this.v33 * m.v34 + this.v34 * m.v44;
			
			var t41:Number = this.v41 * m.v11 + this.v42 * m.v21 + this.v43 * m.v31 + this.v44 * m.v41;
			var t42:Number = this.v41 * m.v12 + this.v42 * m.v22 + this.v43 * m.v32 + this.v44 * m.v42;
			var t43:Number = this.v41 * m.v13 + this.v42 * m.v23 + this.v43 * m.v33 + this.v44 * m.v43;
			var t44:Number = this.v41 * m.v14 + this.v42 * m.v24 + this.v43 * m.v34 + this.v44 * m.v44;
			
			this.v11 = t11; this.v12 = t12; this.v13 = t13; this.v14 = t14;
			this.v21 = t21; this.v22 = t22; this.v23 = t23; this.v24 = t24;
			this.v31 = t31; this.v32 = t32; this.v33 = t33; this.v34 = t34;
			this.v41 = t41; this.v42 = t42; this.v43 = t43; this.v44 = t44;
		}
		
		private function calculateMultiply(
			n11:Number, n12:Number, n13:Number, n14:Number,
			n21:Number, n22:Number, n23:Number, n24:Number,
			n31:Number, n32:Number, n33:Number, n34:Number,
			n41:Number, n42:Number, n43:Number, n44:Number
		):void{
			var t11:Number = this.v11 * n11 + this.v12 * n21 + this.v13 * n31 + this.v14 * n41;
			var t12:Number = this.v11 * n12 + this.v12 * n22 + this.v13 * n32 + this.v14 * n42;
			var t13:Number = this.v11 * n13 + this.v12 * n23 + this.v13 * n33 + this.v14 * n43;
			var t14:Number = this.v11 * n14 + this.v12 * n24 + this.v13 * n34 + this.v14 * n44;
			
			var t21:Number = this.v21 * n11 + this.v22 * n21 + this.v23 * n31 + this.v24 * n41;
			var t22:Number = this.v21 * n12 + this.v22 * n22 + this.v23 * n32 + this.v24 * n42;
			var t23:Number = this.v21 * n13 + this.v22 * n23 + this.v23 * n33 + this.v24 * n43;
			var t24:Number = this.v21 * n14 + this.v22 * n24 + this.v23 * n34 + this.v24 * n44;
			
			var t31:Number = this.v31 * n11 + this.v32 * n21 + this.v33 * n31 + this.v34 * n41;
			var t32:Number = this.v31 * n12 + this.v32 * n22 + this.v33 * n32 + this.v34 * n42;
			var t33:Number = this.v31 * n13 + this.v32 * n23 + this.v33 * n33 + this.v34 * n43;
			var t34:Number = this.v31 * n14 + this.v32 * n24 + this.v33 * n34 + this.v34 * n44;
			
			var t41:Number = this.v41 * n11 + this.v42 * n21 + this.v43 * n31 + this.v44 * n41;
			var t42:Number = this.v41 * n12 + this.v42 * n22 + this.v43 * n32 + this.v44 * n42;
			var t43:Number = this.v41 * n13 + this.v42 * n23 + this.v43 * n33 + this.v44 * n43;
			var t44:Number = this.v41 * n14 + this.v42 * n24 + this.v43 * n34 + this.v44 * n44;
			
			this.v11 = t11; this.v12 = t12; this.v13 = t13; this.v14 = t14;
			this.v21 = t21; this.v22 = t22; this.v23 = t23; this.v24 = t24;
			this.v31 = t31; this.v32 = t32; this.v33 = t33; this.v34 = t34;
			this.v41 = t41; this.v42 = t42; this.v43 = t43; this.v44 = t44;
		}
		
		public function translate(dx:Number, dy:Number, dz:Number):void{
			this.calculateMultiply(
				 1,  0,  0, 0,
				 0,  1,  0, 0,
				 0,  0,  1, 0,
				dx, dy, dz, 1
			);
		}
		
		public function scale(sx:Number, sy:Number, sz:Number):void{
			this.calculateMultiply(
				sx,  0,  0, 0,
				 0, sy,  0, 0,
				 0,  0, sz, 0,
				 0,  0,  0, 1
			);
		}
		
		public function rotate(angleX:Number, angleY:Number, angleZ:Number):void{
			if(angleX != 0) this.rotateX(angleX);
			if(angleY != 0) this.rotateY(angleY);
			if(angleZ != 0) this.rotateZ(angleZ);
		}
		
		public function rotateX(angle:Number):void{
			var sin:Number = Math.sin(angle);
			var cos:Number = Math.cos(angle);
			this.calculateMultiply(
				1,    0,   0, 0,
				0,  cos, sin, 0,
				0, -sin, cos, 0,
				0,     0,  0, 1
			);
		}
		
		public function rotateY(angle:Number):void{
			var sin:Number = Math.sin(angle);
			var cos:Number = Math.cos(angle);
			this.calculateMultiply(
				cos, 0, -sin, 0,
				  0, 1,    0, 0,
				sin, 0,  cos, 0,
				  0, 0,    0, 1
			);
		}
		
		public function rotateZ(angle:Number):void{
			var sin:Number = Math.sin(angle);
			var cos:Number = Math.cos(angle);
			this.calculateMultiply(
				 cos, sin, 0, 0,
				-sin, cos, 0, 0,
				   0,   0, 1, 0,
				   0,   0, 0, 1
			);
		}
		
		public function invert():void{
			var t12:Number = this.v12;
			var t13:Number = this.v13;
			var t21:Number = this.v21;
			var t23:Number = this.v23;
			var t31:Number = this.v31;
			var t32:Number = this.v32;
			
			                this.v12 = t21; this.v13 = t31; this.v14 = 0;
			this.v21 = t12;                 this.v23 = t32; this.v24 = 0;
			this.v31 = t13; this.v32 = t23;                 this.v34 = 0;
			this.v41 = 0;   this.v42 = 0;   this.v43 = 0;   this.v44 = 1;
		}
		
		public function copy(m:Matrix3D):void{
			this.v11 = m.v11; this.v12 = m.v12; this.v13 = m.v13; this.v14 = m.v14;
			this.v21 = m.v21; this.v22 = m.v22; this.v23 = m.v23; this.v24 = m.v24;
			this.v31 = m.v31; this.v32 = m.v32; this.v33 = m.v33; this.v14 = m.v34;
			this.v41 = m.v41; this.v42 = m.v42; this.v43 = m.v43; this.v44 = m.v44;
		}
		
		public function transform(v:IVector3D):Vector3D{
			var vx:Number = v.x;
			var vy:Number = v.y;
			var vz:Number = v.z;
			
			return new Vector3D(			
				this.v11 * vx + this.v21 * vy + this.v31 * vz + this.v41,
				this.v12 * vx + this.v22 * vy + this.v32 * vz + this.v42,
				this.v13 * vx + this.v23 * vy + this.v33 * vz + this.v43
			);
		}
		
		public function clone():Matrix3D{
			return new Matrix3D(
				this.v11, this.v12, this.v13, this.v14,
				this.v21, this.v22, this.v23, this.v24,
				this.v31, this.v32, this.v33, this.v34,
				this.v41, this.v42, this.v43, this.v44
			);
		}
		
		public function toArray():Array{
			return [
				this.v11, this.v12, this.v13, this.v14,
				this.v21, this.v22, this.v23, this.v24,
				this.v31, this.v32, this.v33, this.v34,
				this.v41, this.v42, this.v43, this.v44
			];
		}
		
		public function toString():String{
			return "[object Matrix3D {\n" +
				"\t" + this.v11 + ", " + this.v12 + ", " + this.v13 + ", " + this.v14 + "\n" +
				"\t" + this.v21 + ", " + this.v22 + ", " + this.v23 + ", " + this.v24 + "\n" +
				"\t" + this.v31 + ", " + this.v32 + ", " + this.v33 + ", " + this.v34 + "\n" +
				"\t" + this.v41 + ", " + this.v42 + ", " + this.v43 + ", " + this.v44 + "\n" +
			"}]";
		}
	}
}