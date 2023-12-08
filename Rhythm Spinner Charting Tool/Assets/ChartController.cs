using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Net.Http.Headers;
using UnityEngine;

public class ChartController : MonoBehaviour
{
    public List<Note> notes;
    public Vector2 origin;
    public Vector2 size;

    public string chartName;
    public string fileName;
    public string filePath;

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

        Debug.Log(Application.dataPath);
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

    public void setName(string name)
    {
        chartName = name;
    }

    public void setFile(string file)
    {
        fileName = file;
    }

    public void setPath(string path)
    {
        filePath = path;
    }

    public void save()
    {
        Chart chart = new Chart(notes.ToArray());
        string json = JsonUtility.ToJson(chart);
        File.WriteAllText(filePath + "/" + chartName + ".json", json);
    }

    public void load()
    {
        if(File.Exists(filePath + "/" + fileName + ".txt"))
        {
            string loadedChart = File.ReadAllText(filePath + "/" + fileName + ".json");
            Chart chart = JsonUtility.FromJson<Chart>(loadedChart);
            notes.Clear();
            foreach(Note note in chart.chart)
            {
                notes.Add(note);
            }
        }
    }
}

[Serializable]
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

[Serializable]
public class Chart
{
    public Note[] chart;

    public Chart(Note[] chart)
    {
        this.chart = chart;
        Array.Sort(this.chart, new ChartComparer());
    }
}

class ChartComparer : IComparer
{
    public int Compare(object x, object y)
    {
        return (new CaseInsensitiveComparer()).Compare(((Note)x).beat, ((Note)y).beat);
    }
}