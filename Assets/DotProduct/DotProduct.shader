Shader "Holistic/DotProduct"
{
    Properties
    {
        
    }
    SubShader
    {
        CGPROGRAM
            #pragma surface surf Lambert
            struct Input{
              float3 viewDir; //vector huong ve phia nguoi nhin  
            };

            void surf(Input IN, inout SurfaceOutput o){
              half dotp = dot(IN.viewDir,o.Normal);
              
                o.Albedo = float3(dotp,1,1-dotp); 

              
              
            }
       
        ENDCG
    }
    FallBack "Diffuse"
}
