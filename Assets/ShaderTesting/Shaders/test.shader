Shader "ShaderTest/test"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
        _SecondTex("Second Texture", 2D) = "white" {}
        _Color("Color", Color) = (1, 1, 1, 1)
        _Tween("Tween", Range(0, 1)) = 0
        
    }
        SubShader
    {   
        Tags
        {
            "Queue" = "Transparent"
        }
        Pass
        {
            Blend SrcAlpha OneMinusSrcAlpha
            
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
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }
            sampler2D _MainTex;
            sampler2D _SecondTex;
            float _Tween;
            float4 _Color;
            float4 frag (v2f i) : SV_Target
            {
                float4 color = tex2D(_MainTex, i.uv * 1);
                
                // Combination of tinting and grayScale
                //float lumin = color.x * 0.3 + color.y * 0.59 + color.z * 0.11;
                //color = float4(lumin,lumin,lumin,1);
                //color = color * _Color;
                
                // Combination of repeating and coloring things
                //float4 color = tex2D(_MainTex, i.uv * 2);
                //color = color * float4(i.uv.x, i.uv.y, 0.5, 1);
                
                // To make sprites repeat x, for example 2 times
                //float4 color = tex2D(_MainTex, i.uv * 2);
                
                // To make transition between 2 images
                //float4 color2 = tex2D (_SecondTex, i.uv);
                //float4 result = color2 * _Tween + color * (1-_Tween);
                //float4 result2 = lerp(color, color2, _Tween);
                
                // To make your image look like gradient UV
                //color = color * float4(i.uv.x, i.uv.y, 0, 1);
                
                // To make your image tinting effect
                color = color * _Color;
                return color;
            }
            ENDCG
        }
    }
}
