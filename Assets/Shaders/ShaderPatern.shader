Shader "Unlit/ShaderPatern" {
    Properties {
        _Value ("Value", float) = 1.0
    }
    SubShader {
        Tags { "RenderType"="Opaque" }

        Pass         {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"

            float _Value;

            // default appdata
            // Автоматически заполняется в UNITY
            struct meshdata {                // Данные сетки для каждой вершины
                float4 vertex : POSITION;    // Положение вершины
                float2 uv : TEXCOORD0;       // UV координаты, могут использоваться для чего угодно.  TEXCOORD0 - нулевой канал UV координат
                //float2 uv1 : TEXCOORD1;    // UV координаты, могут использоваться для чего угодно.  TEXCOORD0 - нулевой канал UV координат
                //float3 normals : NORMAL;   // Нормаль вершины(напрвление, куда смотрит вершина)
                //float4 color : COLOR;      // Цвет вершины
                //float4 tangent : TANGENT;  // вектор касательной
            };

            // default v2f
            // FragInput
            struct Interpolators {                     // Данные которые передаются из вершинного в фрагментный шейдер 
                float4 vertex : SV_POSITION;           // SV_POSITION - позиция вершины в пространстве клипа
                //float2 uv : TEXCOORD0;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            Interpolators vert (meshdata v) {
                Interpolators o;
                o.vertex = UnityObjectToClipPos(v.vertex);  // преобразует локальное пространство в свое пространство для размещения клипов
                return o;
            }

            fixed4 frag (Interpolators i) : SV_Target // SV_Target - выводит шедер в буфер кадров
            {
                return float4(1.0, 0, 0, 1 ); // red
            }
            ENDCG
        }
    }
}
