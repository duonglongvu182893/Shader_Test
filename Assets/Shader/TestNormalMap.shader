Shader "Holistic/TestNormalmap"{
	Properties{
		
		_myDiffuse("Diffuse Texture",2D)="while"{}
		_myBump("Bump Texture",2D)="Bump"{}
		_mySlider("Bump Amount",Range(0,10))=1
		_textureSlider("Texture Bump Scale",Range(0,2))=1
	} 

	SubShader{ //shader processing code
		CGPROGRAM// bat dau cua subshader


			#pragma surface surf Lambert
			struct Input{
				float2 uv_myDiffuse;
				float2 uv_myBump;
			};

			sampler2D _myDiffuse;
			sampler2D _myBump;
			half _mySlider;
			half _textureSlider;

			void surf(Input IN, inout SurfaceOutput o) {
				
				o.Albedo = tex2D(_myDiffuse,IN.uv_myDiffuse*_textureSlider).rgb; //multiple with texturesliderx - > scale texture 
				o.Normal = UnpackNormal(tex2D(_myBump,IN.uv_myBump));
				o.Normal *= float3(_mySlider,_mySlider,1);
				
			}

		ENDCG// ket thuc cua subshader

	}
	
	FallBack "Diffuse" //fallback function
}