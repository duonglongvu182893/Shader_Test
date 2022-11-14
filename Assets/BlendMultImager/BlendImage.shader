Shader "Holistic/BlendImage"
{
    Properties
    {
        
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _DecalTex ("Albedo (RGB)", 2D) = "white" {}
        [Toggle] _ShowDecal ("Show Decal? ",float) = 0 
       
    }
    SubShader
    {
        Tags { "RenderType"="Geometry" }
       CGPROGRAM
        #pragma surface surf Lambert

       
        sampler2D _MainTex;
        sampler2D _DecalTex;
        float _ShowDecal;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_DecalTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
           fixed4 tex = tex2D(_MainTex,IN.uv_MainTex);
           
           fixed4 decal = tex2D(_DecalTex,IN.uv_DecalTex) * _ShowDecal;

           o.Albedo =decal.r > 0.9 ? decal.rgb : tex.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
