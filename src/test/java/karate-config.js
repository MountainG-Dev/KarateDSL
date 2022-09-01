function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
/* IMPORTANTE DESCOMENTAR SOLO EL AMBIENTE A UTILIZAR PARA DEBUG */
//    env = 'local'; // a custom 'intelligent' default
//    env = 'conduit'; // a custom 'intelligent' default
    env = 'restful'; // a custom 'intelligent' default
  }
  var config = {
    env: env,
    myVarName: 'someValue'
  }

  // VARIABLES DE AMBIENTE
  if (env == 'conduit') {
        config.apiURLConduit= 'https://api.realworld.io/api/';
        config.userEmail= "karate30@test.com";
        config.userPassword= "karate30";
  } else if (env == 'restful') {
        config.apiURLRestful= 'https://restful-booker.herokuapp.com/';
        config.userUsername= "admin";
        config.userPassword= "password123";
  }

  // VALIDACIONES DE AMBIENTES
    if (env == 'conduit') {
        var accessTokenConduit = karate.callSingle('classpath:apiAutomation/helpers/conduit-token.feature', config).authTokenConduit;
        karate.configure('headers', {Authorization: 'Token ' + accessTokenConduit});
    } else if (env == 'restful') {
        var accessTokenRestful = karate.callSingle('classpath:apiAutomation/helpers/restful-token.feature', config).authTokenRestful;
        karate.configure('headers', {Cookie: 'token=' + accessTokenRestful});
    } else if (env == 'e2e') {

    }

   // don't waste time waiting for a connection or if servers don't respond within 5 seconds
   karate.configure('connectTimeout', 5000);
   karate.configure('readTimeout', 5000);

  return config;
}