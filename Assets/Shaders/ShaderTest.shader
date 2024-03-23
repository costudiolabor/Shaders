Shader "Unlit/ShaderTest" {
    Properties {
        _Value ("Value", float) = 1.0
        _Color ("_Color", Color) = (1, 1, 1, 1)
        _ColorA ("_ColorA", Color) = (1,1,1,1)
        _ColorB ("_ColorB", Color) = (1,1,1,1)
    }
    SubShader {
        Tags { 
               "RenderType"="Opaque"
            
//               "RenderType"="Transporent"
//               "Queue" = "Transporent" 
            }

        Pass {
            
//            Cull Off      // способ отображения обьекта выкл(Будет отображаться Перед и зад)
//            Cull Back     // Будет отображаться только перед
//            Cull Front    // Будет отображаться только зад
            
            
            // ZTest LEqual   - значение по умолчанию
            // ZTest Always - рисует всегда даже поверх других обьектов (не учитывает буфер глубины)
            // ZTest GEqual - рисует только если находится за другим обьектом
            
            // ZWrite off               //  Откл буфер глубины (Не будет записываться в буфер глубины) 
            // Blend One One          // (additive добавление) Смешивание цветов
            // Blend DstColor Zero    // (mulpiply умножение) 
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"

            float _Value;
            float4 _Color;
            float4 _ColorA;
            float4 _ColorB;

            // default appdata
            // Автоматически заполняется в UNITY
            struct meshdata {                // Данные сетки для каждой вершины
                float4 vertex : POSITION;    // Положение вершины
                float3 normals : NORMAL;      // Нормаль вершины(напрвление, куда смотрит вершина)
                float2 uv0 : TEXCOORD0;       // UV координаты, могут использоваться для чего угодно.  TEXCOORD0 - нулевой канал UV координат
                //float4 color : COLOR;       // Цвет вершины
                //float4 tangent : TANGENT;   // вектор касательной
            };

            // default v2f
            // FragInput
            struct Interpolators {                     // Данные которые передаются из вершинного в фрагментный шейдер 
                float4 vertex : SV_POSITION;           // SV_POSITION - позиция вершины в пространстве клипа
                float3 normal : TEXCOORD0;
                float2 uv : TEXCOORD1;
            };

            Interpolators vert (meshdata v) {
                Interpolators o;
                o.vertex = UnityObjectToClipPos(v.vertex);  // преобразует локальное пространство пространство клипа
                o.normal = UnityObjectToWorldNormal(v.normals); //v.normals;
                o.uv = v.uv0;
                return o;
            }

            fixed4 frag (Interpolators i) : SV_Target // SV_Target - выводит шедер в буфер кадров
            {
                //return float4(UnityObjectToWorldNormal(i.normal), 1);  // преобразует нормали обьекта в мировые нормали 
                // return float4(i.uv, 0.0, 1.0);
                //return _Color;

                float4 outColor = lerp(_ColorA, _ColorB, i.uv.x);
                
                return outColor;
            }
            ENDCG
        }
    }
}


 // выведет оттенки серого
// fixed4 frag (Interpolators i) : SV_Target { 
//                float4 myValue;
//                float2 otherValue = myValue.xxxx;  
//                return float4 (otherValue, otherValue, otherValue, 1 );
//            }


// Выводит изображение сферы на экран. Приклеивание к камере. Рендерит в пространство клипа
//  Interpolators vert (meshdata v) {
//                Interpolators o;
//                //o.vertex = UnityObjectToClipPos(v.vertex);  // преобразует локальное пространство пространство клипа
//                o.vertex = v.vertex;
//                return o;
//            }


// градиент вращается вместе с обьектом
// fixed4 frag (Interpolators i) : SV_Target // SV_Target - выводит шедер в буфер кадров
//            {
//                return float4((i.normal), 1);   // выводит цвет согласно нормалям вершин
//            }

// градиент не вращается вместе с обьектом, остается на месте с обьектом
// fixed4 frag (Interpolators i) : SV_Target // SV_Target - выводит шедер в буфер кадров
//            {
//                return float4(UnityObjectToWorldNormal(i.normal), 1);  // преобразует нормали обьекта в мировые нормали 
//            }


// (градиент) выводит цвет на основании UV координат. Например для дебага 
// fixed4 frag (Interpolators i) : SV_Target // SV_Target - выводит шедер в буфер кадров
//            {
//                return float4(i.uv, 0.0, 1.0);
//            }

// выводит цвет Ч/Б на основании UV координат. По координате X
// fixed4 frag (Interpolators i) : SV_Target // SV_Target - выводит шедер в буфер кадров
//            {
//                return float4(i.uv.xxx, 0.0, 1.0);
//            }

// выводит цвет Ч/Б на основании UV координат. По координате Y
// fixed4 frag (Interpolators i) : SV_Target // SV_Target - выводит шедер в буфер кадров
//            {
//                return float4(i.uv.yyy, 0.0, 1.0);
//            }

// Заполняет пиксели линейно цветом от цвета _ColorA до цвета _ColorB по X
//   fixed4 frag (Interpolators i) : SV_Target // SV_Target - выводит шедер в буфер кадров
//            {
//                float4 outColor = lerp(_ColorA, _ColorB, i.uv.x);
//                return outColor;
//            }

// ограничивает переменную от 0 до 1
// float t = frac(t) - интервал от 0 - 1; 

// ограничивает переменную от 0 до 1
// float t = saturate(t) - интервал от 0 - 1; 


// Pass {
//            
//            //Blend One One       // (additive добавление) Смешивание цветов
//            //Blend DstColor Zero   // (mulpiply умножение) 

//ZWrite off               //  Откл буфер глубины (Не будет записываться в буфер глубины)


// Порядок РЕНДЕРИНГА
// SubShader {
  //      Tags { 
    //          "RenderType"="Opaque"
            
    //          "RenderType"="Transporent"
    //          "Queue" = "Transporent" 
    //         }


            // ZTest LEqual   - значение по умолчанию
            // ZTest Always - рисует всегда даже поверх других обьектов (не учитывает буфер глубины)
            // ZTest GEqual - рисует только если находится за другим обьектом


//            Cull Off      // способ отображения обьекта выкл(Будет отображаться Перед и зад)
//            Cull Back     // Будет отображаться только перед
//            Cull Front    // Будет отображаться только зад