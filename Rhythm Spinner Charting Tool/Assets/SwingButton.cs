using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class SwingButton : MonoBehaviour
{
    public TMP_Text text;
    public bool on;

    public GameObject chartManager;

    private ChartController chartController;

    public void Awake()
    {
        chartController = chartManager.GetComponent<ChartController>();
    }

    public void onPressed()
    {
        if(on)
        {
            text.text = "Swing: Off";
            on = false;
            chartController.swing = false;
        } 
        else
        {
            text.text = "Swing: On";
            on = true;
            chartController.swing = true;
        }
    }
}
