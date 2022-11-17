Shader "Holistic/VF"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
           
            #include "UnityCG.cginc"
            sampler2D _MainTex;
            float4 _MainTex_ST;

            struct appdata
            {
                float4 vertex: POSITION;
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;
            };

            struct v2f
            {
              
                float2 uv : TEXCOORD0;
                fixed4 diff : COLOR0;
                float4 pos : SV_POSITION;
                
            };
           
            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord;
                o.diff.r = o.uv.x;
                return o;
            }
            fixed4 frag (v2f i) : SV_Target
            {
                
                fixed4 col = tex2D(_MainTex, i.uv);
       
                return col * i.diff;
            }
            ENDCG
        }

    }
}
