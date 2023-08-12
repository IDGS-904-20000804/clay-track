const bcrypt = require('bcrypt');
const saltRounds = 10;
const passwords = [
  'eL3eB5cB',
  'nC1hQ3bR',
  'eO1fN1mC',
  'tH4pB1cE',
  'zC7cU1iE',
  'iB1hB4jL',
  'qB3kF5cH',
  'cS2bD6dI',
  'pJ2hJ3rD',
  'bB4bB5rM',
  'cB8eC4bL',
  'cH1dI2dS',
  'cD5hP1kN',
  'vB2wC2oL',
  'cE2eL2lR',
  'cE7eM2cG',
  'kE2pF3iI',
  'iC5hB1q2',
  'gE5iJ1mN',
  'eC1dC1xE',
  'dV2eF4bJ',
  'b1mB4eP1',
  'gM3bB2lQ',
  'iM1jB1qO',
  'nI1bL2bP',
  'dO2dM2gB',
  'cI1jG5cE',
  'eP3mD1G1',
  'eI2bB5hB',
  'lQ1nR1cL',
  'mU1dD3cL',
  'hJ5hD7vF',
  'bL2hB6bI',
  'uN4bH4bE',
  'eW4lF4hB'
];

async function generateBcryptHash(password) {
  const hashedPassword = await bcrypt.hash(password, saltRounds);
  return hashedPassword;
}
async function hashPasswords(passwords) {
  const hashedPasswords = await Promise.all(passwords.map(password => generateBcryptHash(password)));
  return hashedPasswords;
}
hashPasswords(passwords)
  .then(hashedPasswords => {
    console.log('Hashed Passwords:', hashedPasswords);
  })
  .catch(error => {
    console.error('Error:', error);
  });



  // $2b$10$58HrmwT28WjFc0FJdqtAPOWP90vkMd5FYwRH3tPAGEteKSsBvZLAO
  // $2b$10$Z64JbfYZCgrMBf54I207T.lpeyMqAhTRRptu24x7p8P8McFoj/Eqq
  // $2b$10$TvDAnqf7d2XYV/GsAuUYrO0uLyqAQre1awSNIW8BWubf5FFuv7ium
  // $2b$10$VlIvRNeqMTn5jfmnZ.Ng1enjjpip071XbFDjornGyUkCciw..7imG
  // $2b$10$bks1Kkx4UZBiZaU8DX6vQe1t.cCEbIk26xYVouKSpvjqYEq/vPXvO
  // $2b$10$yAJ3g6yF/H1g3ghmiNdosOqj23uIWwKEHhRnVwa7EsrYalxsJWR8C
  // $2b$10$w88R3H2L0kAr8tDKdZXMw.hWIX9.3MTmWSQB6PNBL5vg4Lm/m9TrW
  // $2b$10$9tc3Th1s/djlRv3pSOb75u4AQ6RYcbaLqxQg1BrL7BBH/X14CMFeC
  // $2b$10$OqXp1hjpn4rQns8zTnKC0ui1cZJ1tfWNkUTmKsatpPNF5UuVbd7X2
  // $2b$10$blBwgTL/M6voLiiAHXP7AeZM0nX7GHCgT/Ww7WFj3mrctQXaQTVwS
  // $2b$10$Mu0czpjfLKKAQCgsWuoM4uj4QzEpIKH1t8SiFBHG6Z2o7xF6LrtpO
  // $2b$10$VwQZl.VO9XXz4jtFmq18qO/CqM4lkYcBjHvI6mkkMHP165d9WHYJG
  // $2b$10$81GaizwO/.06BGFHJk.o1O3ShUC84fd1qvxohPCYUzi9aMqPDR.L.
  // $2b$10$p4w21WQ4K75axPE6p03y1uMIuLpeDr/ScparlB9ZjrJzqEbiyIMlK
  // $2b$10$8Kz/q5G6JeeCvr1S4s89JuCG9V.n2xfR3njsEyg6D4ELj7kf8bZcW
  // $2b$10$6VuTjSlJl79ERfF816FzEuxVZxRhMwCpFDj8.KWZGtkURXJNe8LAC
  // $2b$10$fR3qpRA9vkBCRuQvrhKNieR3ep4jT7v4RTIBY0trbY1FE2w/QJwt2
  // $2b$10$m7PmEaBf7F06.VlryMTKQ.1RzXrsignThFOxjL9UKQbE66GcNtox2
  // $2b$10$h9t7UyzjsGtQpSqUhBYaY.I2/TxySAwfpEeEN1m2gkh5SXtpPVZb.
  // $2b$10$6sDizF4lLMwruij.U7r8setsG0h9TqOfTo.B5pPoPwZe/jmQQjjTi
  // $2b$10$UqHridXIyChrri7jkPBBFOhJDR1vlCaMh1QdgbLYyPbFL2jHwUm/K
  // $2b$10$snlDlWAYjnBtoGRqnRy0i.1BVBDmbzX252Pv04cewe9aOrKBboErG
  // $2b$10$ZTXpjraoI781HhQWhwxyfey2BNohuZXZEFQXREQgbczcj9bzHYg72
  // $2b$10$sk21ijGDaP5AuMF51agHS.9W7lt9cTzMRo0OgwB9q5jQ0Ax35W0.K
  // $2b$10$ztWzaEqurzSwQ5021smkr.54RmK9j/NkcgjXw1/O0QCH5yGMybbLC
  // $2b$10$xsO0AEtDJPZm0NJoTdS.duXRw6yejUw5Tur7jhOQPZEQTH4L3jo2W
  // $2b$10$.AZXMnAlgB8S9bZXs1GvPOcAXi6c4xAS8SsEQPZE92E0RiDN93ZI2
  // $2b$10$gOdE73tmMyGYVKo8qEoFxOhLx6uMxX6TaIrDOFMi7ikn.LRAtltPi
  // $2b$10$8bo/h6HgDF7Osdtde3FVS.n5XHfH9A4gZ0dToLkrQjBuTAGweFzt.
  // $2b$10$C8fS7oE2UxUg4r8yd/5Nb.F9eI7P82TiDCToCunzzY3BKVfG/9qRS
  // $2b$10$Um0XAulI/bPK3oFiM5EUL.HRRiwzX7HMMJGnt5hADojTUKR9eRM2.
  // $2b$10$wVbm7mrxl5Fu94l04MOpLOEx/e47JCu9NeUkM3wYYwjSnYjhmsiBG
  // $2b$10$udwTEtvTtUTAV25hcX85RuOXcmpZWjZtMkOeYPIJPPvg5NFxQ4dgG
  // $2b$10$Y9f2Qxs.GZOOmamDA3GgVO9B9Gklt1gQROhypffOXhLV85A8CjuT2
  // $2b$10$Ut0qaZnu55da3fl7D3WV8OYRLdSzGZCkJlJOQnH/cKqy6S59rITrm