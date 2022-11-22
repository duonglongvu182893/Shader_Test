Shader "Custom/Outline"
{
    Properties
    {
        _OutlineColor ("Outline Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        
        _OutLine ("Outline Width", Range(0.002,0.1)) = 0.05
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200
        
        ZWrite off 
        CGPROGRAM
         #pragma surface surf Lambert vertex:vert
            
            sampler2D _MainTex;
            struct Input
            {
                float2 uv_MainTex;
            };
            float _OutLine;
            float4 _OutlineColor;

            struct appdata{
                float4 vertex: POSITION;
                float3 normal: NORMAL;
                float4 texcoord: TEXCOORD0;
            };
            void vert(inout appdata v){
               // v.vertex.w = -10;
                v.vertex.xyz += v.normal *_OutLine;
            }
           
            void surf (Input IN, inout SurfaceOutput o)
            {
                o.Emission = _OutlineColor.rgb;
               
            }
        ENDCG

       ZWrite on
        CGPROGRAM
         #pragma surface surf Lambert
       
            
            sampler2D _MainTex;
            struct Input
            {
                float2 uv_MainTex;
            };
        
           

            void surf (Input IN, inout SurfaceOutput o)
            {
                o.Albedo = tex2D(_MainTex,IN.uv_MainTex).rgb;
               
            }

        ENDCG

    }
    FallBack "Diffuse"
}
