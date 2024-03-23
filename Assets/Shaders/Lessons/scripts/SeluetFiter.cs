using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SeluetFiter : SimpleFilter
{
    [SerializeField] private Color nearColor;
    [SerializeField] private Color farColor;

    protected override void OnUpdate() {
        _material.SetColor("_NearColor", nearColor);
        _material.SetColor("_FarColor", farColor);
    }
    
}


