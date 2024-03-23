using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SimpleFilter : MonoBehaviour
{
   [SerializeField] private Shader _shader;

   protected Material _material;
   private bool useFilter = true;

   private void Awake()
   {
      _material = new Material(_shader);
      
   }

   private void Update()
   {
      if (Input.GetKeyUp(KeyCode.F))
      {
         useFilter = !useFilter;
      }
      OnUpdate();
   }

   protected virtual void OnUpdate() {
      
   }

   private void OnRenderImage(RenderTexture src, RenderTexture dest)
   {

      if (useFilter)
      {
         Graphics.Blit(src, dest,_material);
      }
      else
      {
         Graphics.Blit(src, dest);
      }
   }
}
