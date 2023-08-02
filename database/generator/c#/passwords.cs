
using System;
using System.Web.Helpers;
public class Program
{
	public static void Main()
	{
		string plainPassword = "MiContraseña123";
		string hashedPassword = Crypto.HashPassword(plainPassword);
		Console.WriteLine(hashedPassword);
		}
	}
}