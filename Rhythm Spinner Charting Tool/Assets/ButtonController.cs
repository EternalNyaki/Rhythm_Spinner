using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ButtonController : MonoBehaviour
{
    public Color offColor;
    public Color onColor;

    private bool isOn = false;
    
    public GameObject chartManager;

    private Image image;
    private ChartController chartController;

    public void Start()
    {
        image = GetComponent<Image>();
        chartController = chartManager.GetComponent<ChartController>();
    }

    public void onPressed()
    {
        if(isOn)
        {
            image.color = offColor;
            chartController.removeNote(transform);
        } 
        else
        {
            image.color = onColor;
            chartController.addNote(transform);
        }
    }
}