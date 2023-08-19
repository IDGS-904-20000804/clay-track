using System;
using System.Collections.Generic;
using Microsoft.AspNet.Identity;

namespace PasswordHashingExample
{
    class Program
    {
        static void Main(string[] args)
        {
            var passwords = new List<string>
            {
	"eL3eB5cB",
	"nC1hQ3bR",
	"eO1fN1mC",
	"tH4pB1cE",
	"zC7cU1iE",
	"iB1hB4jL",
	"qB3kF5cH",
	"cS2bD6dI",
	"pJ2hJ3rD",
	"bB4bB5rM",
	"cB8eC4bL",
	"cH1dI2dS",
	"cD5hP1kN",
	"vB2wC2oL",
	"cE2eL2lR",
	"cE7eM2cG",
	"kE2pF3iI",
	"iC5hB1q2",
	"gE5iJ1mN",
	"eC1dC1xE",
	"dV2eF4bJ",
	"b1mB4eP1",
	"gM3bB2lQ",
	"iM1jB1qO",
	"nI1bL2bP",
	"dO2dM2gB",
	"cI1jG5cE",
	"eP3mD1G1",
	"eI2bB5hB",
	"lQ1nR1cL",
	"mU1dD3cL",
	"hJ5hD7vF",
	"bL2hB6bI",
	"uN4bH4bE",
	"eW4lF4hB"
            };

            var passwordHasher = new PasswordHasher();

            foreach (var password in passwords)
            {
                string hashedPassword = passwordHasher.HashPassword(password);
                Console.WriteLine($"Password: {password}, Hash: {hashedPassword}");
            }
        }
    }
}



// Password: eL3eB5cB, Hash: AMmAWUeqhXPmdD97QBTn5GmGnDrwAoaEym8sk5niig8SIoF/FTKQHn/EHYX3te0KwQ==
// Password: nC1hQ3bR, Hash: ABwI89M9WSSdxmFZnY6bWwq4IaDERWRJVs8z7M0jj5EcKhjBFHFxvRaELfbFzzLjvA==
// Password: eO1fN1mC, Hash: AB0qjBdQ2lNe1Lhp/5N//edUiqK7sATmo3Bv+9YqAPY+IY/XwHIcjSmQt8/5dijLDQ==
// Password: tH4pB1cE, Hash: AL+Me//qUmC3vdccx5gIlAoMJO3pJlvTI7bUK1Ztx/z75cOROFWwWAT+WzrE+NYy+w==
// Password: zC7cU1iE, Hash: ALk6z9zy3ZJrPVeXQmLz+cu3nlNJS549gYnqcxS14v6Hjl6gh8KaJU11vFIcm+8/YA==
// Password: iB1hB4jL, Hash: AM6MXii+5IVIX2RFQtnO6gJbRQaBxT6nQ4A2DEyP3ughjk7o2CSO2m8sPaRdYYw1Xw==
// Password: qB3kF5cH, Hash: AFlCWIYpCz2EiJLcJvxBjh+K9nxZOY/qNJGR0sdbScHIEhkAfIfmMdhZjOo8z4rBIg==
// Password: cS2bD6dI, Hash: AN+hXbArLloy4xzbdROIjQUq4+BNbCwGNieCdF93X78xYg2qdrsDwMSaeTxnkYcJDw==
// Password: pJ2hJ3rD, Hash: AA9eMWHV7zHpwhXq7vcQHvnaDB/qyct0+Bvc8x0Fg+UufoG3IWJuuyD+30uSOhrIbw==
// Password: bB4bB5rM, Hash: ABc53ZVxy/XqMTm5NKBP9URi4jN1VlR5hikrDc59l71CM8UP525KWWuS7Qk0SIzxxA==
// Password: cB8eC4bL, Hash: AJlGIzWVgYsa4G/rSxp5MUtBsf8Wc5FneCma8sGTigpIPcS1NQcEOviHqkZDgIrcqg==
// Password: cH1dI2dS, Hash: AGWtyK6neuTgLSOS4mlp3MIk64nztwwg1BE0bOpK2lkLXZWQQAzlx360I6l63Ndqhg==
// Password: cD5hP1kN, Hash: AJN0lP8bw/3lildKNNeL7hAsn94jWqGIypucdzJH8bUJ7RJ754UjeKands/mWjDLnQ==
// Password: vB2wC2oL, Hash: ALk0N4KysLM7UYI+96wI3pNMSiUzcEJ7GvE09ZAZGoD4wWQEB3Qf3ol+mD71ob0atw==
// Password: cE2eL2lR, Hash: AFhvWm5rSZjg26q3rWm+n/sLtWN0mXGUQkhPVMZrWM/Srgd6276xcNZ0xL2VPo2PdQ==
// Password: cE7eM2cG, Hash: AEImwHapXb7Lv+3yTzQuz+GpfbNJ/U0s7A/Y7S6fZ9VkcXq4N+nc5LXJhiZCDlIkww==
// Password: kE2pF3iI, Hash: APH/afT0AT3OTrarF5GJgdFdio8qg9j0CbYsyl/kbYZXdfkXs761SyeUDGeezwMGeg==
// Password: iC5hB1q2, Hash: AFRx494nOFzHt4RY3W2Q1dJVxD6GYcMZ3j/erYCI4+6FKs0VXCImrDWDF7ym1iGWqA==
// Password: gE5iJ1mN, Hash: ADMcD5v2Xf/XQtBrLy4h79GnK0UK9AGvAx/xSa2p7DPa/V1j4wowzyaJ+7+SO81ETQ==
// Password: eC1dC1xE, Hash: AFRp5PihLF+zbkFYSn2lCmkaSJlnGNHgIwQj70U5UsOQAlKmYx4IoB/jrYb1uISheQ==
// Password: dV2eF4bJ, Hash: AOuXcTvE4W3XUzHP8WsaxeB12vH4pihsWlrZa+s0/jHR2/Ky3H8l7Y1cBJc3Un/ZIg==
// Password: b1mB4eP1, Hash: AK0vlKnYG7RNKFvdUDzCd8YXqPqOagCqnNRh4blq5iwtz7vRBdMgpZi49syKN6YowA==
// Password: gM3bB2lQ, Hash: AHGS02kkUtEVSQ4H7qX/l8ChLOWL4Uup++PknLQpUzHcLFuVH9CJ9O1EMK4m1iR8jQ==
// Password: iM1jB1qO, Hash: AH30onoKyaLQq6VowD/XbGQ9a0TxGI9oyipt7vbXoyYyGSWZx6RX4x6f2trXG+szOQ==
// Password: nI1bL2bP, Hash: AAdI08V8pYYaYV7XZlfMJpN73OCU6FSoVsQ2ZWZkQiqfqjN4vbwQZETbWdiOcbRDWA==
// Password: dO2dM2gB, Hash: AHWcqK4XojxArAMOBGR35TeIj//S8Z3vj3C7AUquJ6SPMjWil39Jzc99EcbQ7i3KxA==
// Password: cI1jG5cE, Hash: ADeasR6iUctuUigaDIH2cyV7RjnmzVCQou5iYqNp2lBIFfIGYuZVizM/rlsr2A7umg==
// Password: eP3mD1G1, Hash: AMZwzhLgcaVrH+dNCBGZZI8edfSM9CW0jZovkdxYbJ0GOAHIVjQHu2S25iID+1L0Dg==
// Password: eI2bB5hB, Hash: AGRNuWVkRjSCzMTfJ8P5qceS7qeLeC+vcPpGx3qN4nNadbhaKZnUb7/BfOEJjTJluA==
// Password: lQ1nR1cL, Hash: ALkCjnsMLkV1ZHMONXaUuDK10TMC9H6y6zya0CJt5Xwincm/iWXGeiSe8Sci6Fj81g==
// Password: mU1dD3cL, Hash: AIL8ZQEXO7dDDDSi+N8ZxQqSFfP0oy9U0ILfWZNNVwnCVLKsVuxRRi/1BJyYdZxn/Q==
// Password: hJ5hD7vF, Hash: ALzmsEtdqlnekV58XM6l0Ck2PeG0XHcMfmTioyoutom+QfqbEGIKNUS0IFXztC3C7Q==
// Password: bL2hB6bI, Hash: AKJdPFzt3K8+dBSEv3tk+bgO71/f1+zCkoUd7mCYHhtDA+rBSHatqkLwgxVxeA4HrA==
// Password: uN4bH4bE, Hash: APGBsDf8cG8jqpaTAzLSNZo5eEOfIFrS23dHaSs0CC5/Ajp7Ev1CyTt5VheijgZjxg==
// Password: eW4lF4hB, Hash: ALZfSozQTvxBrrx95ScdN43fcJcn+sE/LbIfYI/hCwpjsm1mE89URU2gAwQVCUpsWQ==