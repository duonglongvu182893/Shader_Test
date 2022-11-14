Shader "Holistic/Wall"
{
   
    Properties
    {
        
        _MainTex ("Diffuse", 2D) = "white" {}
      
    }
    SubShader
    {
        Tags { "RenderType"="Geometry" }
        LOD 200

        Stencil{
            Ref 1
            Comp notequal // neu stacill khong bang 1 => da co trong stencil
            Pass keep // neu da ton tai se giu lại pixel nay
        }
        

        CGPROGRAM
      
        #pragma surface surf Lambert

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
             fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
           
        }
        ENDCG
    }
    FallBack "Diffuse"
  
}
