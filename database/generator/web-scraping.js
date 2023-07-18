const cheerio = require("cheerio");
const axios = require("axios");

const main = async () => {
  for (let index = 0; index < 50; index++) {
    const axiosResponse = await axios.request({
      method: 'GET',
      // https://generadordenombres.online/hombre/
      // https://generadordenombres.online/mujer/
      url: 'https://generadordenombres.online/',
    });
    const $ = cheerio.load(axiosResponse.data);
    console.log($('#resultadoGenerado').text());
  }
};

main();
/*
Olatz Puerto
Raúl Avila
Neus Villar
Rachid Ubeda
Claudio Leon
Manel Cardona
Catalina Guevara
Aurea Lazaro
Gumersindo Moro
Josefa Robledo
Eladio Peiro
Alain Grande
Marcial García
Izaskun Sanchez
Montse Cantero
Sagrario Moyano
Zaida Cuadrado
Cayetano Estrada
Iris Marin
Francisco-Javier Gaspar
Iryna Fernández
Noel Mosquera
Hilario Alcantara
Florin Beltran
German Rivera
Unax Verdu
Unai Hidalgo
Fabian Quiroga
Maria-Francisca Cabanillas
Narciso Reyes
Anibal Garrido
Jeronima Tirado
Segundo Martin
Julia Yañez
Leire Martorell
Estibaliz Iglesias
Rachida Ojeda
Alexandra Felipe
Angelica Palacios
Markel Maroto
Marcelina Megias
Alberto Marques
Roger Barrientos
Alina Trujillo
Ismail Valero
Ioan Cardona
Enzo San-Juan
Gertrudis Miranda
Nelson Herranz
Maria-Gracia Conde
*/