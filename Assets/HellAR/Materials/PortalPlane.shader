// (c) 2018 Guidev
// This code is licensed under MIT license (see LICENSE.txt for details)

Shader "Unlit/PortalPlane"
{
    Properties
    {
        [Enum(CullMode)] _CullMode("Cull Mode", Int) =0 // 현실세계와 가상세계를 구분하기 위한 배열
    }
	SubShader
	{
        ZWrite off
        ColorMask 0
        Cull [_CullMode] // equal일때 material감추기 front일때, back일때 설명은 유니티에 잘 나옴;;
        
	    Stencil
        {
            Ref 1
            Pass replace
        }
		Pass
		{
		

			
		}
	}
}
