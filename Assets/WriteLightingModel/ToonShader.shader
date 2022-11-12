Shader "Holistic/ToonShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _RampTex("Ramp Texture", 2D )="white" {}
        _Texture("Texture", 2D )="white" {}
        _Slide("pow", Range(0,10))=1
    }
    SubShader
    {
        CGPROGRAM
        
        #pragma surface surf Toon
        sampler2D _RampTex;
        sampler2D _Texture;
        fixed4 _Color;
        float _Slide;


        struct Input
        {
            float2 uv_Texture;
            float3 viewDir;
        };


        float4 LightingToon (SurfaceOutput s, fixed3 lightDir, fixed atten){
            float diff = dot(s.Normal, lightDir);
            float h = diff * 0.5 + 0.5;

            if(h<0.6){
                
              h = h * 0.5;
            }
            else{
              h = h*2;
            }
            float rh = h;
            float3 ramp = tex2D(_RampTex,rh).rgb;
            float4 c;
            c.rgb = s.Albedo * _LightColor0.rgb *(ramp);
            c.a = s.Alpha;
            return c;
        }


        
        void surf (Input IN, inout SurfaceOutput o)
        {
            /*float diff = dot(o.Normal, IN.viewDir);
            float h = diff * 0.5 + 0.5;
            float rh = h;
            float3 ramp = tex2D(_RampTex,rh).rgb;*/
                

            o.Albedo = tex2D(_Texture,IN.uv_Texture).rgb;


            if(dot(o.Normal,IN.viewDir)<0.2){
                o.Albedo =(0,0,0);
            }
            //o.Albedo = ramp;
            //o.Albedo = _Color;
            
        }
        ENDCG
    }
    FallBack "Diffuse"
}
