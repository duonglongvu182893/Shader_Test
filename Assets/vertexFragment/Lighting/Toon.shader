Shader "Holistic/VFDiffuse"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}

        _Color("Color",Color)=(1,1,1,1)

        _myBright("Brightness",Range(0,10))=1
    }
    SubShader
    {
        
        Pass
        {
            Tags {"LightMode" = "ForwardBase"}
    
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdbase nolightmap nodirlightmap nodynlightmap novertexlight
            #include "UnityCG.cginc"
            #include "UnityLightingCommon.cginc"
            //include de su dung cac properties cua light
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

                
                SHADOW_COORDS(1)
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            fixed4 _Color;
            float _myBright;

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord;

                //chuyen normail tu local sang world space 
                half3 worldNormal = UnityObjectToWorldNormal(v.normal);

                //tinh toan intensity cua anh sang bang tinh vo huong giua normal va light direction, lay max
                half nl = max(0, dot(worldNormal,_WorldSpaceLightPos0.xyz));
                
                o.diff = nl;
                
                TRANSFER_SHADOW(o)
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                
                fixed4 col = tex2D(_MainTex, i.uv);
                 if (col.r < 0.2){
                    col = col * _myBright;
                }
                fixed shadow = SHADOW_ATTENUATION(i);
                if(i.diff.r<0.5 ){
                    if(i.diff.r>0.1){
                        col = col * 0.5f;
                    }
                    else{
                        col.rgb = 0;
                    }
                    
                }
                else{
                    col = col ;
                }
               
                
                
                return col;
            }
            ENDCG
        }

        //do bong
        Pass{
            Tags{"LightMode" = "ShadowCaster"}
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            //su dung khi muon them shadow 
            #pragma multi_compile_shadowcaster
            #include "UnityCG.cginc"

            struct appdata{
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;
            };

            struct v2f {
                //dau ra se la mot bong››
                V2F_SHADOW_CASTER;
            };
            v2f vert(appdata v){
                v2f o;
                //tao du lieu ve bong cua vat the 
                TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
                return o;
            }
            float4 frag(v2f i) :SV_Target
            {
                //frag se dua ra mau lien quan den pixel cu the do
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG 
        }
    }
}
