using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityStandardAssets.Characters.FirstPerson;

public class Enderbox : MonoBehaviour
{
    private void Update()
    {
        transform.Rotate(0, 2f, 0, Space.World);
    }

    void OnTriggerEnter(Collider other)
    {
        Destroy(gameObject);
    }
}
