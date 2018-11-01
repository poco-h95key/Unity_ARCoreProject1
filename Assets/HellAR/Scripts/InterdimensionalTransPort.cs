using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

public class InterdimensionalTransPort : MonoBehaviour {


    public Material[] materials;
    private Material PortalPlaneMaterial;

	// Use this for initialization
	void Start () 
    {
        //현실세계와 ar상의 material을 구별하기 위해 추가하는 메터리얼
        PortalPlaneMaterial = GetComponent<Renderer>().sharedMaterial;

        //material 보이기
        foreach (var mat in materials)
        {
            mat.SetInt("_StencilTest", (int)CompareFunction.Equal);
        }
    }

    private void OnTriggerStay(Collider other)
    {
        //메인 카메라가 아닐 시 리턴
        if (other.name != "Main Camera")
            return;
            

        // 포탈 안으로 들어갔을 때,
        if (transform.position.z > other.transform.position.z)
        {
            // 포탈 안에서 문쪽을 바라봤을 때 현실세계가 보이게끔 하는 if문
            if (transform.position.z < 0.0f)
            {
                Debug.Log("Outside of other world");
                foreach (var mat in materials)
                {
                    mat.SetInt("_StencilTest", (int)CompareFunction.NotEqual);
                }
                PortalPlaneMaterial.SetInt("_CullMode", (int)CullMode.Front);
            }
            // 포탈 안에서 활동할 때 material이 유지되게 하는 else문
            else
            {
                Debug.Log("Outside of other world");
                foreach (var mat in materials)
                {
                    mat.SetInt("_StencilTest", (int)CompareFunction.Always);
                }
                PortalPlaneMaterial.SetInt("_CullMode", (int)CullMode.Off);
            }
        }
        // 포탈 밖에서 봤을 때 material을 감추기 위한 else 문 **line34의 else임**
        else
            {
            Debug.Log("Inside of other world");
            foreach (var mat in materials)
            {
                mat.SetInt("_StencilTest", (int)CompareFunction.Equal);
            }
            PortalPlaneMaterial.SetInt("_CullMode", (int)CullMode.Back);
        }
          

    }
    // 실행도중 껐을 때의 함수
    void OnDestroy()
    {
        foreach (var mat in materials)
        {
            mat.SetInt("_StencilTest", (int)CompareFunction.Always);
        }
        PortalPlaneMaterial.SetInt("_CullMode", (int)CullMode.Off);
    }
    // Update is called once per frame
    void Update () {
		
	}
}
