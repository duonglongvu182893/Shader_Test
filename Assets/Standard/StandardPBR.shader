Shader "Holistic/StandardSpecPBR"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MetallicTex("Metallic (R)",2D)="white"{}
        _SpecColor ("Specular Color", Color) = (1,1,1,1)
        _Spec("Specular", Range(0,10))=0.5 // specular size
    }
    SubShader
    {
        
        CGPROGRAM
        
        #pragma surface surf StandardSpecular

        struct Input
        {
            float2 uv_MetallicTex;
        };

        sampler2D _MetallicTex;
        fixed _Spec;
        fixed4 _Color;

        
        void surf (Input IN, inout SurfaceOutputStandardSpecular o)
        {
          o.Albedo = _Color.rgb;
          o.Smoothness =0.9 - tex2D(_MetallicTex,IN.uv_MetallicTex).r;
          //o.Specular = _Spec;
          o.Specular = _SpecColor;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
