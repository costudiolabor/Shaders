Shader "Hidden/FogFilter"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _NearColor("NearColor", Color) = (0.75, 0.33, 0, 1)
        _FarColor("FarColor", Color) = (1, 1, 1, 1)
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

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
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
            sampler2D _CameraDepthTexture;
            float4 _NearColor;
            float4 _FarColor;

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 colTex = tex2D(_MainTex, i.uv);
                fixed4 col = tex2D(_CameraDepthTexture, i.uv);
                float depth = UNITY_SAMPLE_DEPTH(col);   // расчет глубины на основании цвета из библиотеки  #include "UnityCG.cginc"
                depth = Linear01Depth(depth);            // приводит к линейным значениям  из библиотеки  #include "UnityCG.cginc"
                return  lerp(colTex, _FarColor, depth);
            }
            ENDCG
        }
    }
}
