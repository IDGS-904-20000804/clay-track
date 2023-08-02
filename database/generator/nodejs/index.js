const main = async () => {
  const url = 'http://api.generadordni.es/v2/person/password';
  // const url = 'http://api.generadordni.es/v2';
  const response = await fetch(`${url}/`);
  const data = await response.json();
  console.log(data);
}

main();