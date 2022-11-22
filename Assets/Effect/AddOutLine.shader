Shader "AdvancedEffects/AddOutLine"
{
    Properties
    {
        _OutlineColor ("Outline Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        
        _OutLine ("Outline Width", Range(0.002,0.1)) = 0.05
    }
    SubShader
    {
        CGPROGRAM
         #pragma surface surf Lambert
       
            
            sampler2D _MainTex;
            struct Input
            {
                float2 uv_MainTex;
            };
        
           

            void surf (Input IN, inout SurfaceOutput o)
            {
                o.Albedo = tex2D(_MainTex,IN.uv_MainTex).rgb;
               
            }

        ENDCG

        Pass{
            Cull front
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fog

            #include "UnityCG.cginc"
            struct appdata{
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct v2f{
                float4 pos : SV_POSITION;
                fixed4 color : COLOR;
            };

            float _OutLine;
            float3 _OutlineColor;

            v2f vert(appdata v){
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);

                //chuyen normal cua vertex tu local space sng worl space 
                float3 norm = normalize(mul((float3x3)UNITY_MATRIX_IT_MV,v.normal));

                //offset duoc tinh bang cach lay 2 thanh phan xy cua normarl
                float2 offset = TransformViewToProjection(norm.xy);

                
                //pos z giong 1 loai intensity ->z chi do gan xa cua vertex voi cam
                //->nhan z se the hien duc do lon hay nho cua outline
                o.pos.xy += offset * o.pos.z *_OutLine;
                o.color.rgb = _OutlineColor;
                return o;
            }
            fixed4 frag(v2f i) :SV_Target{
                return i.color;
            }
        
        ENDCG
}
     }
    FallBack "Diffuse"
}
