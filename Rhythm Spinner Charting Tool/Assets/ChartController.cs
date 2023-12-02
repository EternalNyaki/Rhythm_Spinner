using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChartController : MonoBehaviour
{
    private List<Note> notes = new List<Note>();
    public Vector2 origin;
    public Vector2 size;

    public void addNote(Transform transform)
    {
        int lane = (int)((transform.position.x - origin.x) / size.x);
        float beat = (transform.position.y - origin.y) / size.y;
        notes.Add(new Note(lane, beat));
    }

    public void removeNote(Transform transform)
    {
        int lane = (int)((transform.position.x - origin.x) / size.x);
        float beat = (transform.position.y - origin.y) / size.y;
        foreach (Note note in notes)
        {
            if(note.lane == lane && note.beat == beat)
            {
                notes.Remove(note);
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