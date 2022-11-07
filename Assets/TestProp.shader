Shader "Holistic/TestProp"{
	Properties{
		
		_myColour("Exemple Colour", Color) = (1,1,1,1)
		_myRange("Exemple Range", Range(0,5)) = 1
		_myTex("Example Texture", 2D) ="while"{}
		_myCube("Example Cube", CUBE) = ""{}
		_myFloat("Example Float", Float) = 0.5
		_myVector ("Example Vector", Vector) = (0.5,1,1,1)
	} 

	SubShader{ //shader processing code
		CGPROGRAM// bat dau cua subshader


			#pragma surface surf Lambert
			struct Input{
				float2 uv_myTex; // folow by the name of the texture
				float3 woldRefl;
			};

			fixed4 _myColour;
			half _myRange;
			sampler2D _myTex;
			samplerCUBE _myCube;
			float _myFloat;
			float4 _myVector;

			void surf(Input IN, inout SurfaceOutput o) {
				o.Albedo = tex2D(_myTex,IN.uv_myTex).rgb;
				
				
			}

		ENDCG// ket thuc cua subshader

	}
	
	FallBack "Diffuse" //fallback function
}