Shader "AdvancedEffects/vertexModify"
{
    Properties
    {
        
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Scale("Scale", Range(0,10)) = 1
       
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Lambert vertex:vert
        //#pragma fragment : frag

        
        
        sampler2D _MainTex;
        float _Scale;

        struct Input
        {
            float2 uv_MainTex;
        };
        struct appdata{
            float4 vertex: POSITION;
            float3 normal: NORMAL;
            float4 texcoord: TEXCOORD0;
        };
        void vert(inout appdata v){
            v.vertex.xyz += v.normal * _Scale;
        }

        
        void surf (Input IN, inout SurfaceOutput o)
        {
           o.Albedo = tex2D(_MainTex,IN.uv_MainTex).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
