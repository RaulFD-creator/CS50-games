using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class LevelOutput : MonoBehaviour
{
    public Text text;

    void start()
    {

    }

    // Update is called once per frame
    void Update()
    {
        text.text = string.Format("Level:   {0}", Initialise_level.Level);
    }
}
