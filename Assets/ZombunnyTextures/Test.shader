Shader "Holistic/Test"{
	Properties{
		
		_myColour("Exemple Colour", Color) = (1,1,1,1)
		_myRange("Exemple Range", Range(0,5)) = 1
		_myTex("Example Texture", 2D) ="while"{}
		_myEmission("Example Emission", 2D) ="while"{}
		_myCube("Example Cube", CUBE) = ""{}
		_myFloat("Example Float", Float) = 1
		_myVector ("Example Vector", Vector) = (0.5,1,1,1)
	} 

	SubShader{ //shader processing code
		CGPROGRAM// bat dau cua subshader


			#pragma surface surf Lambert
			struct Input{
				float2 uv_myTex; 
				float2 uv_myEmission;
				float3 worldRefl;
				float3 viewDir;
			};

			fixed4 _myColour;
			half _myRange;
			sampler2D _myTex;
			sampler2D _myEmission;	
			samplerCUBE _myCube;
			float _myFloat;
			float4 _myVector;

			void surf(Input IN, inout SurfaceOutput o) {
				
				o.Albedo.rgb = tex2D(_myTex,IN.uv_myTex).rgb;
				o.Emission  = IN.viewDir.rgb;
				//o.Emission = tex2D(_myEmission,IN.uv_myEmission).rgb; 
				
			}

		ENDCG// ket thuc cua subshader

	}
	
	FallBack "Diffuse" //fallback function
}