    Shader "Custom/RimLighting"
{
    Properties
    {
        _RimColor("Rim Color", Color) = (0,0.5,0.5,0)
        _RimPower("Rim Power",Range(0.5,8.0))=3
        _StriperSize("Striper Size",Range(0,20))=10
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        float4 _RimColor;
        float _RimPower;
        float  _StriperSize;
        struct Input
        {
           float3 viewDir;
           float3 worldPos;
        };

        
        void surf (Input IN, inout SurfaceOutput o)
        {
            half rim = 1 - saturate(dot(normalize(IN.viewDir),o.Normal));
            o.Emission =frac(IN.worldPos.y *_StriperSize* 0.5)> 0.4? float3(0,1,0)*rim : float3(1,0,0)*rim;
            
        }
        ENDCG
    }
    FallBack "Diffuse"
}
