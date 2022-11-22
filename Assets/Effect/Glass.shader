Shader "AdvancedEffects/Glass"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _BumpMAp ("Normalmap", 2D) ="bump" {}
        _ScaleUV("Scale", Range(1,20)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        GrabPass{}
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 uvgrab : TEXCOORD1;
                float4 uvbump : TEXCOORD2;
                float4 vertex : SV_POSITION;
            };

            sampler2D _GrabTexture;
            sampler2D _MainTex;
            float4 _MainTex_ST;
            //size cua pixel
            float4 _GrabTexture_TexelSize;
            float _ScaleUV;

            v2f vert (appdata v)
            {
                v2f o;
                //chuyen vertext tu world space sang clip space (toa do camera)
                o.vertex = UnityObjectToClipPos(v.vertex);

                //dua vao vi tri cua no o tron screen space, no tinh toan duoc
                //uv se duoc (hoc tuong duong voi uv yeu cau) cho grab texture
                o.uvgrab.xy = ((float2(o.vertex.x,o.vertex.y)+o.vertex.w)*0.5);
                o.uvgrab.zw = o.vertex.zw;
                o.uv = TRANSFORM_TEX(v.uv,_MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(i.uvgrab));
                fixed4 tint = tex2D(_MainTex,i.uv);
                col *=tint;
                
                return col;
            }
            ENDCG
        }
    }
}
