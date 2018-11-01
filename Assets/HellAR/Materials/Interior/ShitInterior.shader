// (c) 2018 Guidev
// This code is licensed under MIT license (see LICENSE.txt for details)

Shader "Unlit/ShitInteriorShader"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
        [Enum(Equal,3,NotEqual,6)] _StencilTest("Stencil Test",int) =6 // 집에대한 모든 material이 stenciltest를 적용하기 위한 배열
	}
	SubShader
	{
        
		Tags { "RenderType"="Opaque" }
		LOD 100
        Stencil{
            Ref 1
            Comp [_StencilTest] // equl일때 안보이고 always일때 보이고 등등...
        }
       
		Pass
		{
         
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float4 normal: NORMAL;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float3 normal: TEXCOORD1;
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.normal = normalize(mul(v.normal, unity_WorldToObject));
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				float3 normal = normalize(i.normal);
				float3 lightDir = normalize(float3(0.0, 10.0, 10.0));
				float l = max(dot(lightDir, normal), 0.0);
				float4 texCol = tex2D(_MainTex, i.uv);
				fixed4 col = texCol * l + texCol * 0.4f;
				return col;
			}
			ENDCG
		}
        
	}
}
