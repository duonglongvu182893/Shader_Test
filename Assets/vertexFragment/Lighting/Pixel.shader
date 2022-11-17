Shader "Holistic/Pixel"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _pixels("Resolution", int) = 512
        _pw("Pixel Width", float) =64
        _ph("Pixel Height", float) = 64

    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100


        //Cull Off ZWrite Off ZTest Always
        Pass
        {

            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdbase nolightmap nodirlightmap nodynlightmap novertexlight
            #include "UnityCG.cginc"
            #include "UnityLightingCommon.cginc"
            #include "Lighting.cginc"
            #include "AutoLight.cginc"


            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;
    
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                fixed4 diff : COLOR0; // gi tri duoc tinh toan
    
                float4 pos : SV_POSITION;

            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _ph;
            float _pw;
            float _pixels;

            float _dx;
            float _dy;

            
            v2f vert (appdata v)
            {
                v2f o;
                o.uv = v.texcoord;
                o.pos = UnityObjectToClipPos(v.vertex);
                half3 worldNormal = UnityObjectToWorldNormal(v.normal);
                float checkBorder =max(0, dot(worldNormal,_WorldSpaceLightPos0.xyz));
                o.diff = checkBorder;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col ;
               
                // sample the texture
                if(i.diff.r <0.3 ){
                   col.rgb = 0;
                }
               else{
                    col = tex2D(_MainTex, i.uv );
                }
                
                // apply fog
                
                return col;
            }
            ENDCG
        }
    }
}
