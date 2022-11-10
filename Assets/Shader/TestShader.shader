Shader "Holistic/TestABC" {

	Properties {

		_myDiffuse("Diffuse Texture", 2D) = "white" {}
		_myBump("Bump Texture", 2D) = "bump" {}
		_mySlider("Bump Amount", Range(0, 10)) = 1
		_myScale("Texture Bump Scale", Range( 0.5, 2)) = 1
	}

	SubShader {

		CGPROGRAM
			#pragma surface surf Lambert

			sampler2D _myDiffuse;
			sampler2D _myBump;
			half _mySlider;
			half _myScale;

			struct Input {
			
				float2 uv_myDiffuse;
				float2 uv_myBump;
				float3 worldRefl;
			};


			void surf(Input IN, inout SurfaceOutput o) {

				//o.Albedo = o.Normal;
				o.Albedo = IN.worldRefl;
			}
		ENDCG
	}
	FallBack "Diffuse"
}