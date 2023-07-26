const cheerio = require("cheerio");
const axios = require("axios");

const objectNames = {
  url: 'https://generadordenombres.online/hombre',
  // url: 'https://generadordenombres.online/mujer',
  // url: 'https://generadordenombres.online/',
  query: '#resultadoGenerado',
}

const objectPassword = {
  url: 'https://www.dashlane.com/es/personal-password-manager/password-generator',
  query: 'div div div div output',
}


const main = async () => {
  const obj = objectPassword;
  for (let index = 0; index < 50; index++) {
    const axiosResponse = await axios.request({
      method: 'GET',
      url: obj.url,
    });
    const $ = cheerio.load(axiosResponse.data);
    console.log($(obj.query).text());
  }
};
main();
