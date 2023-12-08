using System.Collections;
using System.Collections.Generic;
using System.Numerics;
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

    private Image image;
    private ChartController chartController;

    public void Start()
    {
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

    public void Update()
    {
        isOn = false;
        image.color = offColor;
        foreach (Note note in chartController.notes)
        {
            if (note.lane == row && note.beat == ((float)column / 4))
            {
                isOn = true;
                image.color = onColor;
                break;
            }
        }

    }

    public void onPressed()
    {
        if(isOn)
        {
            chartController.removeNote(row, column);
        } 
        else
        {
            chartController.addNote(row, column);
        }
    }
}