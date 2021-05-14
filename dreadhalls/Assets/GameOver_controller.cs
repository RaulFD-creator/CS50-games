using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class GameOver_controller : MonoBehaviour
{
    private CharacterController m_CharacterController;
    public int death_limit;

    // Start is called before the first frame update
    private void Start()
    {
        m_CharacterController = GetComponent<CharacterController>();

    }

    // Update is called once per frame
    void Update()
    {
        if (m_CharacterController.transform.localPosition.y < death_limit)
        {
            SceneManager.LoadScene("GameOver");
             if (DontDestroy.instance)
             {
                 DontDestroy.instance.GetComponents<AudioSource>()[0].Stop();
                 DontDestroy.instance = null;
            }
        }

    }
}
