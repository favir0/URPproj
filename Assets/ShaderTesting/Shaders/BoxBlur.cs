using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BoxBlur : MonoBehaviour
{
    public Material blurMaterial;
    [Range(0, 10)] public int iterations;
    [Range(0, 4)] public int DownRes;
    void OnRenderImage(RenderTexture src, RenderTexture dst)
    {
        int width = src.width >> DownRes;
        int height = src.height >> DownRes;
        
        RenderTexture rt = RenderTexture.GetTemporary(width, height);
        Graphics.Blit(src, rt);

        for (int i = 0; i < iterations; i++)
        {
            RenderTexture rt2 = RenderTexture.GetTemporary(width, height);
            Graphics.Blit(rt, rt2, blurMaterial);
            RenderTexture.ReleaseTemporary(rt);
            rt = rt2;
            Debug.Log("123");
        }

        Graphics.Blit(rt, dst);
        RenderTexture.ReleaseTemporary(rt);
    }
}
