const main = async () => {
  const url = 'http://api.generadordni.es/v2';
  const response = await fetch(`${url}/`);
  const movies = await response.json();
}

main();