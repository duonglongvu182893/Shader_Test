Shader "Holistic/BlenTest"
{
    Properties
    {
        
        _MainTex ("Albedo (RGB)", 2D) = "Black" {}
        
    }
    SubShader
    {
        Tags { "Queue"="Transparent" }
        Blend DstColor Zero
        Pass{
            SetTexture [_MainTex] { combine texture}
        }
    }
    FallBack "Diffuse"
}
