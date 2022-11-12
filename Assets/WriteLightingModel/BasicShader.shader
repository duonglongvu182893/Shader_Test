Shader "Holistic/BasicShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        
    }
    SubShader
    {
        //Tags { "RenderType"="Opaque" }
      

        CGPROGRAM
        
        #pragma surface surf CustomLighting


        half4 LightingCustomLighting (SurfaceOutput s,half3 lightDir,half atten){
            half4 NdotL = dot(s.Normal , lightDir );
            half4 c;
            c.rgb = s.Albedo * _LightColor0.rgb *( NdotL*atten);
            c.a = s.Alpha;
            return c;

        }


        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        fixed4 _Color;

        void surf (Input IN, inout SurfaceOutput o)
        {
            
            o.Albedo = _Color;
            
        }
        ENDCG
    }
    FallBack "Diffuse"
}
