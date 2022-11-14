Shader "Custom/Leaves"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Alpha ("Alpha", Range(0,1))=1
      
    }
    SubShader
    {
        Tags { "Queue"= "Transparent" }

        CGPROGRAM
        
        #pragma surface surf Lambert alpha:fade

        sampler2D _MainTex;
        half _Alpha;

        struct Input
        {
            float2 uv_MainTex;
        };

        
        void surf (Input IN, inout SurfaceOutput o)
        {
            
            fixed4 c = tex2D(_MainTex,IN.uv_MainTex);
            o.Alpha = c.a;  
            o.Albedo = c.rgb;
            
            //c.a = _Alpha;
            
        }
        ENDCG
    }
    FallBack "Diffuse"
}
