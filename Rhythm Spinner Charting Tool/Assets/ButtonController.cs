using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.UI;

public class ButtonController : MonoBehaviour
{
    public Color offColor;
    public Color onColor;

    private int row;
    private int column;

    private bool isOn = false;

    private RectTransform rectTransform;
    private Vector2 position;
    private Image image;
    private ChartController chartController;

    public void Start()
    {
        rectTransform = GetComponent<RectTransform>();
        image = GetComponent<Image>();
        chartController = gameObject.GetComponentInParent<ChartController>();

        for(int i = 0; i < chartController.buttons.GetLength(0); i++)
        {
            for(int j = 0; j < chartController.buttons.GetLength(1); j++)
            {
                if (chartController.buttons[i, j] == gameObject.GetComponent<ButtonController>())
                {
                    row = j;
                    column = i; 
                    break;
                }
            }
        }
    }

    public void onPressed()
    {
        if(isOn)
        {
            image.color = offColor;
            chartController.removeNote(row, column);
        } 
        else
        {
            image.color = onColor;
            chartController.addNote(row, column);
        }
    }
}