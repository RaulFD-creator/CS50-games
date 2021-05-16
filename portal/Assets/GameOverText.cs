using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using System.Collections;

public class GameOverText : MonoBehaviour
{

	public GameObject Enderbox;
	private Text text;

	void Start()
	{
		text = GetComponent<Text>();
		text.color = new Color(0, 0, 0, 0);
	}
	void Update()
	{
		if (Enderbox == null)
		{
			text.color = new Color(0, 0, 0, 1);
			text.text = "You won!";
		}
	}
}