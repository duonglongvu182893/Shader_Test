Shader "Holistic/BlinnPhong"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _SpecColor("Specular Color",Color)=(1,1,1,1)// mau sac cua reflection
        _Spec("Specular", Range(0,1))=0.5 // specular size
        _Gloss("Gloss", Range(0,1)) = 0.5 // power cua specular

        _Texture("Texture", 2D)="white" {}
        
    }
    SubShader
    {
        //Tags { "Queue"="Geometry" }
        
        CGPROGRAM
       
        #pragma surface surf BlinnPhong


        struct Input
        {
            float2 uv_Texture;
            float3 worldPos;


            //Test

            float3 viewDir;
        };

        //half  _SpecColor;
        fixed _Spec;
        fixed _Gloss;
        fixed4 _Color;
        sampler2D _Texture;

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Color.rgb;
            o.Specular = _Spec;
            o.Gloss = _Gloss;


            //Test
            
           
            
        }
        ENDCG
    }
    FallBack "Diffuse"
}
