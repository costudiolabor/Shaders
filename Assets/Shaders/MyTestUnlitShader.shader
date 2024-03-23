Shader "Unlit/MyTestUnlitShader" {
    Properties {
        _MainTex ("Texture", 2D) = "white" {}
        _SecondTex ("Texture", 2D) = "white" {}
        _Color ("Color", Color) = (1,1,1,1)
    }
    SubShader {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass         {
            CGPROGRAM
            
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            sampler2D _SecondTex;
            float4 __SecondTex_ST;
            float4 _Color;

            v2f vert (appdata v) {
                v2f o;
                 o.vertex = UnityObjectToClipPos(v.vertex);
                 //float2 posVertex = o.vertex;
                 //o.vertex = v.vertex;
                 o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                 o.uv = lerp(o.uv, _Color,  o.vertex.y);
                 //o.uv =  o.vertex;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target {
                float heght = 100;
                fixed4 finalColor;
                fixed4 secondColor;
                //float2 UV = UnityObjectToClipPos(i.vertex);;

                finalColor = tex2D(_MainTex, i.uv);
                //finalColor = float4(UV.xxx, 1.0);
                //finalColor = lerp(finalColor, _Color, 1 - UV.y);
                              
                return finalColor;
            }
            
            ENDCG
        }
    }
}
