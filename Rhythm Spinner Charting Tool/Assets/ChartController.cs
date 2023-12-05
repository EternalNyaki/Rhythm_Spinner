using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class ChartController : MonoBehaviour
{
    private List<Note> notes;
    public Vector2 origin;
    public Vector2 size;

    public ButtonController[,] buttons;

    public void Awake()
    {
        notes = new List<Note>();
        buttons = new ButtonController[1680, 8];
        for(int i = 0; i < buttons.GetLength(0); i++)
        {
            for(int j = 0; j < buttons.GetLength(1);  j++)
            {
                buttons[i, j] = gameObject.GetComponentsInChildren<ButtonController>()[i * 8 + j];
            }
        }
    }

    public void addNote(int row, int column)
    {
        int lane = row;
        float beat = (float)column / 4;
        notes.Add(new Note(lane, beat));
        Debug.Log(lane + ", " + beat);
    }

    public void removeNote(int row, int column)
    {
        int lane = row;
        float beat = (float)column / 4;
        foreach (Note note in notes)
        {
            if(note.lane == lane && note.beat == beat)
            {
                notes.Remove(note);
                Debug.Log(note.lane + ", " + note.beat);
                break;
            }
        }
    }
}

public class Note
{
    public int lane;
    public float beat;

    public Note(int lane, float beat)
    {
        this.lane = lane;
        this.beat = beat;
    }
}